const std = @import("std");

/// A library accessible through the generated bindings.
///
/// While the generated bindings are typically used through modules
/// (e.g. `gobject.module("glib-2.0")`), there are cases where it is
/// useful to have additional information about the libraries exposed
/// to the build script. For example, if any files in the root module
/// of the application want to import a library's C headers directly,
/// it will be necessary to link the library directly to the root module
/// using `Library.linkTo` so the include paths will be available.
pub const Library = struct {
    /// System libraries to be linked using pkg-config.
    system_libraries: []const []const u8,

    /// Links `lib` to `module`.
    pub fn linkTo(lib: Library, module: *std.Build.Module) void {
        module.link_libc = true;
        for (lib.system_libraries) |system_lib| {
            module.linkSystemLibrary(system_lib, .{ .use_pkg_config = .force });
        }
    }
};

/// Returns a `std.Build.Module` created by compiling the GResources file at `path`.
///
/// This requires the `glib-compile-resources` system command to be available.
pub fn addCompileResources(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    path: std.Build.LazyPath,
) *std.Build.Module {
    const compile_resources, const module = addCompileResourcesInternal(b, target, path);
    compile_resources.addArg("--sourcedir");
    compile_resources.addDirectoryArg(path.dirname());
    compile_resources.addArg("--dependency-file");
    _ = compile_resources.addDepFileOutputArg("gresources-deps");

    return module;
}

fn addCompileResourcesInternal(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    path: std.Build.LazyPath,
) struct { *std.Build.Step.Run, *std.Build.Module } {
    const compile_resources = b.addSystemCommand(&.{ "glib-compile-resources", "--generate-source" });
    compile_resources.addArg("--target");
    const gresources_c = compile_resources.addOutputFileArg("gresources.c");
    compile_resources.addFileArg(path);

    const module = b.createModule(.{ .target = target });
    module.addCSourceFile(.{ .file = gresources_c });
    @This().libraries.gio2.linkTo(module);
    return .{ compile_resources, module };
}

/// Returns a builder for a compiled GResource bundle.
///
/// Calling `CompileResources.build` on the returned builder requires the
/// `glib-compile-resources` system command to be installed.
pub fn buildCompileResources(gobject_dependency: *std.Build.Dependency) CompileResources {
    return .{ .b = gobject_dependency.builder };
}

/// A builder for a compiled GResource bundle.
pub const CompileResources = struct {
    b: *std.Build,
    groups: std.ArrayListUnmanaged(*Group) = .{},

    var build_gresources_xml_exe: ?*std.Build.Step.Compile = null;

    /// Builds the GResource bundle as a module. The module must be imported
    /// into the compilation for the resources to be loaded.
    pub fn build(cr: CompileResources, target: std.Build.ResolvedTarget) *std.Build.Module {
        const run = cr.b.addRunArtifact(build_gresources_xml_exe orelse exe: {
            const exe = cr.b.addExecutable(.{
                .name = "build-gresources-xml",
                .root_module = cr.b.createModule(.{
                    .root_source_file = cr.b.path("build/build_gresources_xml.zig"),
                    .target = cr.b.graph.host,
                    .optimize = .Debug,
                }),
            });
            build_gresources_xml_exe = exe;
            break :exe exe;
        });

        for (cr.groups.items) |group| {
            run.addArg(cr.b.fmt("--prefix={s}", .{group.prefix}));
            for (group.files.items) |file| {
                run.addArg(cr.b.fmt("--alias={s}", .{file.name}));
                if (file.options.compressed) {
                    run.addArg("--compressed");
                }
                for (file.options.preprocess) |preprocessor| {
                    run.addArg(cr.b.fmt("--preprocess={s}", .{preprocessor.name()}));
                }
                run.addPrefixedFileArg("--path=", file.path);
            }
        }
        const xml = run.addPrefixedOutputFileArg("--output=", "gresources.xml");

        _, const module = addCompileResourcesInternal(cr.b, target, xml);
        return module;
    }

    /// Adds a group of resources showing a common prefix.
    pub fn addGroup(cr: *CompileResources, prefix: []const u8) *Group {
        const group = cr.b.allocator.create(Group) catch @panic("OOM");
        group.* = .{ .owner = cr, .prefix = prefix };
        cr.groups.append(cr.b.allocator, group) catch @panic("OOM");
        return group;
    }

    pub const Group = struct {
        owner: *CompileResources,
        prefix: []const u8,
        files: std.ArrayListUnmanaged(File) = .{},

        /// Adds the file at `path` as a resource named `name` (within the
        /// prefix of the containing group).
        pub fn addFile(g: *Group, name: []const u8, path: std.Build.LazyPath, options: File.Options) void {
            g.files.append(g.owner.b.allocator, .{
                .name = name,
                .path = path,
                .options = options,
            }) catch @panic("OOM");
        }
    };

    pub const File = struct {
        name: []const u8,
        path: std.Build.LazyPath,
        options: Options = .{},

        pub const Options = struct {
            compressed: bool = false,
            preprocess: []const Preprocessor = &.{},
        };

        pub const Preprocessor = union(enum) {
            xml_stripblanks,
            json_stripblanks,
            other: []const u8,

            pub fn name(p: Preprocessor) []const u8 {
                return switch (p) {
                    .xml_stripblanks => "xml-stripblanks",
                    .json_stripblanks => "json-stripblanks",
                    .other => |s| s,
                };
            }
        };
    };
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const docs_step = b.step("docs", "Generate documentation");
    const test_step = b.step("test", "Run tests");

    const compat = b.createModule(.{
        .root_source_file = b.path("src/compat/compat.zig"),
        .target = target,
        .optimize = optimize,
    });

    const xdpgtk41 = b.addModule("xdpgtk41", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xdpgtk41", "xdpgtk41" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xdpgtk41.linkTo(xdpgtk41);
    xdpgtk41.addImport("compat", compat);

    const xdpgtk41_test = b.addTest(.{
        .root_module = xdpgtk41,
    });
    test_step.dependOn(&b.addRunArtifact(xdpgtk41_test).step);

    const xdp1 = b.addModule("xdp1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xdp1", "xdp1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xdp1.linkTo(xdp1);
    xdp1.addImport("compat", compat);

    const xdp1_test = b.addTest(.{
        .root_module = xdp1,
    });
    test_step.dependOn(&b.addRunArtifact(xdp1_test).step);

    const gio2 = b.addModule("gio2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gio2", "gio2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gio2.linkTo(gio2);
    gio2.addImport("compat", compat);

    const gio2_test = b.addTest(.{
        .root_module = gio2,
    });
    test_step.dependOn(&b.addRunArtifact(gio2_test).step);

    const gobject2 = b.addModule("gobject2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gobject2", "gobject2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gobject2.linkTo(gobject2);
    gobject2.addImport("compat", compat);

    const gobject2_test = b.addTest(.{
        .root_module = gobject2,
    });
    test_step.dependOn(&b.addRunArtifact(gobject2_test).step);

    const glib2 = b.addModule("glib2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "glib2", "glib2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.glib2.linkTo(glib2);
    glib2.addImport("compat", compat);

    const glib2_test_mod = b.createModule(.{
        .root_source_file = b.path("src/glib2/glib2.zig"),
        .target = target,
        .optimize = optimize,
    });
    libraries.glib2.linkTo(glib2_test_mod);
    libraries.gobject2.linkTo(glib2_test_mod);
    // Some deprecated thread functions require linking gthread-2.0
    glib2_test_mod.linkSystemLibrary("gthread-2.0", .{ .use_pkg_config = .force });
    glib2_test_mod.addImport("compat", compat);
    glib2_test_mod.addImport("glib2", glib2_test_mod);

    const glib2_test = b.addTest(.{
        .root_module = glib2_test_mod,
    });
    test_step.dependOn(&b.addRunArtifact(glib2_test).step);

    const gmodule2 = b.addModule("gmodule2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gmodule2", "gmodule2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gmodule2.linkTo(gmodule2);
    gmodule2.addImport("compat", compat);

    const gmodule2_test = b.addTest(.{
        .root_module = gmodule2,
    });
    test_step.dependOn(&b.addRunArtifact(gmodule2_test).step);

    const gtk4 = b.addModule("gtk4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gtk4", "gtk4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gtk4.linkTo(gtk4);
    gtk4.addImport("compat", compat);

    const gtk4_test = b.addTest(.{
        .root_module = gtk4,
    });
    test_step.dependOn(&b.addRunArtifact(gtk4_test).step);

    const gsk4 = b.addModule("gsk4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gsk4", "gsk4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gsk4.linkTo(gsk4);
    gsk4.addImport("compat", compat);

    const gsk4_test = b.addTest(.{
        .root_module = gsk4,
    });
    test_step.dependOn(&b.addRunArtifact(gsk4_test).step);

    const graphene1 = b.addModule("graphene1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "graphene1", "graphene1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.graphene1.linkTo(graphene1);
    graphene1.addImport("compat", compat);

    const graphene1_test = b.addTest(.{
        .root_module = graphene1,
    });
    test_step.dependOn(&b.addRunArtifact(graphene1_test).step);

    const gdk4 = b.addModule("gdk4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdk4", "gdk4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdk4.linkTo(gdk4);
    gdk4.addImport("compat", compat);

    const gdk4_test = b.addTest(.{
        .root_module = gdk4,
    });
    test_step.dependOn(&b.addRunArtifact(gdk4_test).step);

    const cairo1 = b.addModule("cairo1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "cairo1", "cairo1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.cairo1.linkTo(cairo1);
    cairo1.addImport("compat", compat);

    const cairo1_test = b.addTest(.{
        .root_module = cairo1,
    });
    test_step.dependOn(&b.addRunArtifact(cairo1_test).step);

    const pangocairo1 = b.addModule("pangocairo1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pangocairo1", "pangocairo1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pangocairo1.linkTo(pangocairo1);
    pangocairo1.addImport("compat", compat);

    const pangocairo1_test = b.addTest(.{
        .root_module = pangocairo1,
    });
    test_step.dependOn(&b.addRunArtifact(pangocairo1_test).step);

    const pango1 = b.addModule("pango1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pango1", "pango1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pango1.linkTo(pango1);
    pango1.addImport("compat", compat);

    const pango1_test = b.addTest(.{
        .root_module = pango1,
    });
    test_step.dependOn(&b.addRunArtifact(pango1_test).step);

    const harfbuzz0 = b.addModule("harfbuzz0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "harfbuzz0", "harfbuzz0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.harfbuzz0.linkTo(harfbuzz0);
    harfbuzz0.addImport("compat", compat);

    const harfbuzz0_test = b.addTest(.{
        .root_module = harfbuzz0,
    });
    test_step.dependOn(&b.addRunArtifact(harfbuzz0_test).step);

    const freetype22 = b.addModule("freetype22", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "freetype22", "freetype22" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.freetype22.linkTo(freetype22);
    freetype22.addImport("compat", compat);

    const freetype22_test = b.addTest(.{
        .root_module = freetype22,
    });
    test_step.dependOn(&b.addRunArtifact(freetype22_test).step);

    const gdkpixbuf2 = b.addModule("gdkpixbuf2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkpixbuf2", "gdkpixbuf2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkpixbuf2.linkTo(gdkpixbuf2);
    gdkpixbuf2.addImport("compat", compat);

    const gdkpixbuf2_test = b.addTest(.{
        .root_module = gdkpixbuf2,
    });
    test_step.dependOn(&b.addRunArtifact(gdkpixbuf2_test).step);

    const rsvg2 = b.addModule("rsvg2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "rsvg2", "rsvg2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.rsvg2.linkTo(rsvg2);
    rsvg2.addImport("compat", compat);

    const rsvg2_test = b.addTest(.{
        .root_module = rsvg2,
    });
    test_step.dependOn(&b.addRunArtifact(rsvg2_test).step);

    const panel1 = b.addModule("panel1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "panel1", "panel1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.panel1.linkTo(panel1);
    panel1.addImport("compat", compat);

    const panel1_test = b.addTest(.{
        .root_module = panel1,
    });
    test_step.dependOn(&b.addRunArtifact(panel1_test).step);

    const adw1 = b.addModule("adw1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "adw1", "adw1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.adw1.linkTo(adw1);
    adw1.addImport("compat", compat);

    const adw1_test = b.addTest(.{
        .root_module = adw1,
    });
    test_step.dependOn(&b.addRunArtifact(adw1_test).step);

    const nautilus4 = b.addModule("nautilus4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "nautilus4", "nautilus4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.nautilus4.linkTo(nautilus4);
    nautilus4.addImport("compat", compat);

    const nautilus4_test = b.addTest(.{
        .root_module = nautilus4,
    });
    test_step.dependOn(&b.addRunArtifact(nautilus4_test).step);

    const gexiv20 = b.addModule("gexiv20", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gexiv20", "gexiv20" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gexiv20.linkTo(gexiv20);
    gexiv20.addImport("compat", compat);

    const gexiv20_test = b.addTest(.{
        .root_module = gexiv20,
    });
    test_step.dependOn(&b.addRunArtifact(gexiv20_test).step);

    const gdkx114 = b.addModule("gdkx114", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkx114", "gdkx114" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkx114.linkTo(gdkx114);
    gdkx114.addImport("compat", compat);

    const gdkx114_test = b.addTest(.{
        .root_module = gdkx114,
    });
    test_step.dependOn(&b.addRunArtifact(gdkx114_test).step);

    const xlib2 = b.addModule("xlib2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xlib2", "xlib2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xlib2.linkTo(xlib2);
    xlib2.addImport("compat", compat);

    const xlib2_test = b.addTest(.{
        .root_module = xlib2,
    });
    test_step.dependOn(&b.addRunArtifact(xlib2_test).step);

    const gdkwayland4 = b.addModule("gdkwayland4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkwayland4", "gdkwayland4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkwayland4.linkTo(gdkwayland4);
    gdkwayland4.addImport("compat", compat);

    const gdkwayland4_test = b.addTest(.{
        .root_module = gdkwayland4,
    });
    test_step.dependOn(&b.addRunArtifact(gdkwayland4_test).step);

    xdpgtk41.addImport("xdp1", xdp1);
    xdpgtk41.addImport("gio2", gio2);
    xdpgtk41.addImport("gobject2", gobject2);
    xdpgtk41.addImport("glib2", glib2);
    xdpgtk41.addImport("gmodule2", gmodule2);
    xdpgtk41.addImport("gtk4", gtk4);
    xdpgtk41.addImport("gsk4", gsk4);
    xdpgtk41.addImport("graphene1", graphene1);
    xdpgtk41.addImport("gdk4", gdk4);
    xdpgtk41.addImport("cairo1", cairo1);
    xdpgtk41.addImport("pangocairo1", pangocairo1);
    xdpgtk41.addImport("pango1", pango1);
    xdpgtk41.addImport("harfbuzz0", harfbuzz0);
    xdpgtk41.addImport("freetype22", freetype22);
    xdpgtk41.addImport("gdkpixbuf2", gdkpixbuf2);
    xdpgtk41.addImport("xdpgtk41", xdpgtk41);
    xdp1.addImport("gio2", gio2);
    xdp1.addImport("gobject2", gobject2);
    xdp1.addImport("glib2", glib2);
    xdp1.addImport("gmodule2", gmodule2);
    xdp1.addImport("xdp1", xdp1);
    gio2.addImport("gobject2", gobject2);
    gio2.addImport("glib2", glib2);
    gio2.addImport("gmodule2", gmodule2);
    gio2.addImport("gio2", gio2);
    gobject2.addImport("glib2", glib2);
    gobject2.addImport("gobject2", gobject2);
    glib2.addImport("glib2", glib2);
    gmodule2.addImport("glib2", glib2);
    gmodule2.addImport("gmodule2", gmodule2);
    gtk4.addImport("gsk4", gsk4);
    gtk4.addImport("graphene1", graphene1);
    gtk4.addImport("gobject2", gobject2);
    gtk4.addImport("glib2", glib2);
    gtk4.addImport("gdk4", gdk4);
    gtk4.addImport("cairo1", cairo1);
    gtk4.addImport("pangocairo1", pangocairo1);
    gtk4.addImport("pango1", pango1);
    gtk4.addImport("harfbuzz0", harfbuzz0);
    gtk4.addImport("freetype22", freetype22);
    gtk4.addImport("gio2", gio2);
    gtk4.addImport("gmodule2", gmodule2);
    gtk4.addImport("gdkpixbuf2", gdkpixbuf2);
    gtk4.addImport("gtk4", gtk4);
    gsk4.addImport("graphene1", graphene1);
    gsk4.addImport("gobject2", gobject2);
    gsk4.addImport("glib2", glib2);
    gsk4.addImport("gdk4", gdk4);
    gsk4.addImport("cairo1", cairo1);
    gsk4.addImport("pangocairo1", pangocairo1);
    gsk4.addImport("pango1", pango1);
    gsk4.addImport("harfbuzz0", harfbuzz0);
    gsk4.addImport("freetype22", freetype22);
    gsk4.addImport("gio2", gio2);
    gsk4.addImport("gmodule2", gmodule2);
    gsk4.addImport("gdkpixbuf2", gdkpixbuf2);
    gsk4.addImport("gsk4", gsk4);
    graphene1.addImport("gobject2", gobject2);
    graphene1.addImport("glib2", glib2);
    graphene1.addImport("graphene1", graphene1);
    gdk4.addImport("cairo1", cairo1);
    gdk4.addImport("gobject2", gobject2);
    gdk4.addImport("glib2", glib2);
    gdk4.addImport("pangocairo1", pangocairo1);
    gdk4.addImport("pango1", pango1);
    gdk4.addImport("harfbuzz0", harfbuzz0);
    gdk4.addImport("freetype22", freetype22);
    gdk4.addImport("gio2", gio2);
    gdk4.addImport("gmodule2", gmodule2);
    gdk4.addImport("gdkpixbuf2", gdkpixbuf2);
    gdk4.addImport("gdk4", gdk4);
    cairo1.addImport("gobject2", gobject2);
    cairo1.addImport("glib2", glib2);
    cairo1.addImport("cairo1", cairo1);
    pangocairo1.addImport("cairo1", cairo1);
    pangocairo1.addImport("gobject2", gobject2);
    pangocairo1.addImport("glib2", glib2);
    pangocairo1.addImport("pango1", pango1);
    pangocairo1.addImport("harfbuzz0", harfbuzz0);
    pangocairo1.addImport("freetype22", freetype22);
    pangocairo1.addImport("gio2", gio2);
    pangocairo1.addImport("gmodule2", gmodule2);
    pangocairo1.addImport("pangocairo1", pangocairo1);
    pango1.addImport("cairo1", cairo1);
    pango1.addImport("gobject2", gobject2);
    pango1.addImport("glib2", glib2);
    pango1.addImport("harfbuzz0", harfbuzz0);
    pango1.addImport("freetype22", freetype22);
    pango1.addImport("gio2", gio2);
    pango1.addImport("gmodule2", gmodule2);
    pango1.addImport("pango1", pango1);
    harfbuzz0.addImport("freetype22", freetype22);
    harfbuzz0.addImport("gobject2", gobject2);
    harfbuzz0.addImport("glib2", glib2);
    harfbuzz0.addImport("harfbuzz0", harfbuzz0);
    freetype22.addImport("freetype22", freetype22);
    gdkpixbuf2.addImport("gio2", gio2);
    gdkpixbuf2.addImport("gobject2", gobject2);
    gdkpixbuf2.addImport("glib2", glib2);
    gdkpixbuf2.addImport("gmodule2", gmodule2);
    gdkpixbuf2.addImport("gdkpixbuf2", gdkpixbuf2);
    rsvg2.addImport("cairo1", cairo1);
    rsvg2.addImport("gobject2", gobject2);
    rsvg2.addImport("glib2", glib2);
    rsvg2.addImport("gio2", gio2);
    rsvg2.addImport("gmodule2", gmodule2);
    rsvg2.addImport("gdkpixbuf2", gdkpixbuf2);
    rsvg2.addImport("rsvg2", rsvg2);
    panel1.addImport("gtk4", gtk4);
    panel1.addImport("gsk4", gsk4);
    panel1.addImport("graphene1", graphene1);
    panel1.addImport("gobject2", gobject2);
    panel1.addImport("glib2", glib2);
    panel1.addImport("gdk4", gdk4);
    panel1.addImport("cairo1", cairo1);
    panel1.addImport("pangocairo1", pangocairo1);
    panel1.addImport("pango1", pango1);
    panel1.addImport("harfbuzz0", harfbuzz0);
    panel1.addImport("freetype22", freetype22);
    panel1.addImport("gio2", gio2);
    panel1.addImport("gmodule2", gmodule2);
    panel1.addImport("gdkpixbuf2", gdkpixbuf2);
    panel1.addImport("adw1", adw1);
    panel1.addImport("panel1", panel1);
    adw1.addImport("gtk4", gtk4);
    adw1.addImport("gsk4", gsk4);
    adw1.addImport("graphene1", graphene1);
    adw1.addImport("gobject2", gobject2);
    adw1.addImport("glib2", glib2);
    adw1.addImport("gdk4", gdk4);
    adw1.addImport("cairo1", cairo1);
    adw1.addImport("pangocairo1", pangocairo1);
    adw1.addImport("pango1", pango1);
    adw1.addImport("harfbuzz0", harfbuzz0);
    adw1.addImport("freetype22", freetype22);
    adw1.addImport("gio2", gio2);
    adw1.addImport("gmodule2", gmodule2);
    adw1.addImport("gdkpixbuf2", gdkpixbuf2);
    adw1.addImport("adw1", adw1);
    nautilus4.addImport("gio2", gio2);
    nautilus4.addImport("gobject2", gobject2);
    nautilus4.addImport("glib2", glib2);
    nautilus4.addImport("gmodule2", gmodule2);
    nautilus4.addImport("nautilus4", nautilus4);
    gexiv20.addImport("gio2", gio2);
    gexiv20.addImport("gobject2", gobject2);
    gexiv20.addImport("glib2", glib2);
    gexiv20.addImport("gmodule2", gmodule2);
    gexiv20.addImport("gexiv20", gexiv20);
    gdkx114.addImport("xlib2", xlib2);
    gdkx114.addImport("gdk4", gdk4);
    gdkx114.addImport("cairo1", cairo1);
    gdkx114.addImport("gobject2", gobject2);
    gdkx114.addImport("glib2", glib2);
    gdkx114.addImport("pangocairo1", pangocairo1);
    gdkx114.addImport("pango1", pango1);
    gdkx114.addImport("harfbuzz0", harfbuzz0);
    gdkx114.addImport("freetype22", freetype22);
    gdkx114.addImport("gio2", gio2);
    gdkx114.addImport("gmodule2", gmodule2);
    gdkx114.addImport("gdkpixbuf2", gdkpixbuf2);
    gdkx114.addImport("gdkx114", gdkx114);
    xlib2.addImport("xlib2", xlib2);
    gdkwayland4.addImport("gdk4", gdk4);
    gdkwayland4.addImport("cairo1", cairo1);
    gdkwayland4.addImport("gobject2", gobject2);
    gdkwayland4.addImport("glib2", glib2);
    gdkwayland4.addImport("pangocairo1", pangocairo1);
    gdkwayland4.addImport("pango1", pango1);
    gdkwayland4.addImport("harfbuzz0", harfbuzz0);
    gdkwayland4.addImport("freetype22", freetype22);
    gdkwayland4.addImport("gio2", gio2);
    gdkwayland4.addImport("gmodule2", gmodule2);
    gdkwayland4.addImport("gdkpixbuf2", gdkpixbuf2);
    gdkwayland4.addImport("gdkwayland4", gdkwayland4);
    const docs_mod = b.createModule(.{
        .root_source_file = b.path("src/root/root.zig"),
        .target = target,
        .optimize = .Debug,
    });
    const docs_obj = b.addObject(.{
        .name = "docs",
        .root_module = docs_mod,
    });
    const install_docs = b.addInstallDirectory(.{
        .source_dir = docs_obj.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });
    docs_step.dependOn(&install_docs.step);
    docs_mod.addImport("xdpgtk41", xdpgtk41);
    docs_mod.addImport("xdp1", xdp1);
    docs_mod.addImport("gio2", gio2);
    docs_mod.addImport("gobject2", gobject2);
    docs_mod.addImport("glib2", glib2);
    docs_mod.addImport("gmodule2", gmodule2);
    docs_mod.addImport("gtk4", gtk4);
    docs_mod.addImport("gsk4", gsk4);
    docs_mod.addImport("graphene1", graphene1);
    docs_mod.addImport("gdk4", gdk4);
    docs_mod.addImport("cairo1", cairo1);
    docs_mod.addImport("pangocairo1", pangocairo1);
    docs_mod.addImport("pango1", pango1);
    docs_mod.addImport("harfbuzz0", harfbuzz0);
    docs_mod.addImport("freetype22", freetype22);
    docs_mod.addImport("gdkpixbuf2", gdkpixbuf2);
    docs_mod.addImport("rsvg2", rsvg2);
    docs_mod.addImport("panel1", panel1);
    docs_mod.addImport("adw1", adw1);
    docs_mod.addImport("nautilus4", nautilus4);
    docs_mod.addImport("gexiv20", gexiv20);
    docs_mod.addImport("gdkx114", gdkx114);
    docs_mod.addImport("xlib2", xlib2);
    docs_mod.addImport("gdkwayland4", gdkwayland4);
}

pub const libraries = struct {
    pub const xdpgtk41: Library = .{
        .system_libraries = &.{"libportal-gtk4"},
    };

    pub const xdp1: Library = .{
        .system_libraries = &.{"libportal"},
    };

    pub const gio2: Library = .{
        .system_libraries = &.{"gio-2.0"},
    };

    pub const gobject2: Library = .{
        .system_libraries = &.{"gobject-2.0"},
    };

    pub const glib2: Library = .{
        .system_libraries = &.{"glib-2.0"},
    };

    pub const gmodule2: Library = .{
        .system_libraries = &.{"gmodule-2.0"},
    };

    pub const gtk4: Library = .{
        .system_libraries = &.{"gtk4"},
    };

    pub const gsk4: Library = .{
        .system_libraries = &.{"gtk4"},
    };

    pub const graphene1: Library = .{
        .system_libraries = &.{"graphene-gobject-1.0"},
    };

    pub const gdk4: Library = .{
        .system_libraries = &.{"gtk4"},
    };

    pub const cairo1: Library = .{
        .system_libraries = &.{"cairo-gobject"},
    };

    pub const pangocairo1: Library = .{
        .system_libraries = &.{"pangocairo"},
    };

    pub const pango1: Library = .{
        .system_libraries = &.{"pango"},
    };

    pub const harfbuzz0: Library = .{
        .system_libraries = &.{ "harfbuzz", "harfbuzz-gobject" },
    };

    pub const freetype22: Library = .{
        .system_libraries = &.{},
    };

    pub const gdkpixbuf2: Library = .{
        .system_libraries = &.{"gdk-pixbuf-2.0"},
    };

    pub const rsvg2: Library = .{
        .system_libraries = &.{"librsvg-2.0"},
    };

    pub const panel1: Library = .{
        .system_libraries = &.{"libpanel-1"},
    };

    pub const adw1: Library = .{
        .system_libraries = &.{"libadwaita-1"},
    };

    pub const nautilus4: Library = .{
        .system_libraries = &.{"libnautilus-extension-4"},
    };

    pub const gexiv20: Library = .{
        .system_libraries = &.{"gexiv2"},
    };

    pub const gdkx114: Library = .{
        .system_libraries = &.{"gtk4-x11"},
    };

    pub const xlib2: Library = .{
        .system_libraries = &.{},
    };

    pub const gdkwayland4: Library = .{
        .system_libraries = &.{"gtk4-wayland"},
    };
};
