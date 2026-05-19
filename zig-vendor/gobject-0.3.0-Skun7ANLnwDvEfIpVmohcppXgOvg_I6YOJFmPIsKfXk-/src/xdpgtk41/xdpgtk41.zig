pub const ext = @import("ext.zig");
const xdpgtk4 = @This();

const std = @import("std");
const compat = @import("compat");
const xdp = @import("xdp1");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const gtk = @import("gtk4");
const gsk = @import("gsk4");
const graphene = @import("graphene1");
const gdk = @import("gdk4");
const cairo = @import("cairo1");
const pangocairo = @import("pangocairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gdkpixbuf = @import("gdkpixbuf2");
/// Creates a new `Parent` from `window`.
extern fn xdp_parent_new_gtk(p_window: *gtk.Window) *xdp.Parent_;
pub const parentNewGtk = xdp_parent_new_gtk;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
