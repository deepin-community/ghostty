pub const ext = @import("ext.zig");
const rsvg = @This();

const std = @import("std");
const compat = @import("compat");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
/// `rsvg.Handle` loads an SVG document into memory.
///
/// This is the main entry point into the librsvg library.  An `rsvg.Handle` is an
/// object that represents SVG data in memory.  Your program creates an
/// `rsvg.Handle` from an SVG file, or from a memory buffer that contains SVG data,
/// or in the most general form, from a `GInputStream` that will provide SVG data.
///
/// Librsvg can load SVG images and render them to Cairo surfaces,
/// using a mixture of SVG's [static mode] and [secure static mode].
/// Librsvg does not do animation nor scripting, and can load
/// references to external data only in some situations; see below.
///
/// Librsvg supports reading [SVG 1.1](https://www.w3.org/TR/SVG11/) data, and is gradually
/// adding support for features in [SVG 2](https://www.w3.org/TR/SVG2/).  Librsvg also
/// supports SVGZ files, which are just an SVG stream compressed with the GZIP algorithm.
///
/// [static mode]: https://www.w3.org/TR/SVG2/conform.html`static`-mode
/// [secure static mode]: https://www.w3.org/TR/SVG2/conform.html`secure`-static-mode
///
/// # The "base file" and resolving references to external files
///
/// When you load an SVG, librsvg needs to know the location of the "base file"
/// for it.  This is so that librsvg can determine the location of referenced
/// entities.  For example, say you have an SVG in `/foo/bar/foo.svg`
/// and that it has an image element like this:
///
/// ```
/// <image href="resources/foo.png" .../>
/// ```
///
/// In this case, librsvg needs to know the location of the toplevel
/// `/foo/bar/foo.svg` so that it can generate the appropriate
/// reference to `/foo/bar/resources/foo.png`.
///
/// ## Security and locations of referenced files
///
/// When processing an SVG, librsvg will only load referenced files if they are
/// in the same directory as the base file, or in a subdirectory of it.  That is,
/// if the base file is `/foo/bar/baz.svg`, then librsvg will
/// only try to load referenced files (from SVG's
/// `<image>` element, for example, or from content
/// included through XML entities) if those files are in `/foo/bar/<anything>` or in `/foo/bar/<anything>\/.../<anything>`.
/// This is so that malicious SVG files cannot include files that are in a directory above.
///
/// The full set of rules for deciding which URLs may be loaded is as follows;
/// they are applied in order.  A referenced URL will not be loaded as soon as
/// one of these rules fails:
///
/// 1. All `data:` URLs may be loaded.  These are sometimes used
///    to include raster image data, encoded as base-64, directly in an SVG file.
///
/// 2. URLs with queries ("?") or fragment identifiers ("#") are not allowed.
///
/// 3. All URL schemes other than data: in references require a base URL.  For
///    example, this means that if you load an SVG with
///    `rsvg.Handle.newFromData` without calling `rsvg.Handle.setBaseUri`,
///    then any referenced files will not be allowed (e.g. raster images to be
///    loaded from other files will not work).
///
/// 4. If referenced URLs are absolute, rather than relative, then they must
///    have the same scheme as the base URL.  For example, if the base URL has a
///    `file` scheme, then all URL references inside the SVG must
///    also have the `file` scheme, or be relative references which
///    will be resolved against the base URL.
///
/// 5. If referenced URLs have a `resource` scheme, that is,
///    if they are included into your binary program with GLib's resource
///    mechanism, they are allowed to be loaded (provided that the base URL is
///    also a `resource`, per the previous rule).
///
/// 6. Otherwise, non-`file` schemes are not allowed.  For
///    example, librsvg will not load `http` resources, to keep
///    malicious SVG data from "phoning home".
///
/// 7. A relative URL must resolve to the same directory as the base URL, or to
///    one of its subdirectories.  Librsvg will canonicalize filenames, by
///    removing ".." path components and resolving symbolic links, to decide whether
///    files meet these conditions.
///
/// # Loading an SVG with GIO
///
/// This is the easiest and most resource-efficient way of loading SVG data into
/// an `rsvg.Handle`.
///
/// If you have a `GFile` that stands for an SVG file, you can simply call
/// `rsvg.Handle.newFromGfileSync` to load an `rsvg.Handle` from it.
///
/// Alternatively, if you have a `GInputStream`, you can use
/// `rsvg.Handle.newFromStreamSync`.
///
/// Both of those methods allow specifying a `GCancellable`, so the loading
/// process can be cancelled from another thread.
///
/// ## Loading an SVG from memory
///
/// If you already have SVG data in a byte buffer in memory, you can create a
/// memory input stream with `gio.MemoryInputStream.newFromData` and feed that
/// to `rsvg.Handle.newFromStreamSync`.
///
/// Note that in this case, it is important that you specify the base_file for
/// the in-memory SVG data.  Librsvg uses the base_file to resolve links to
/// external content, like raster images.
///
/// # Loading an SVG without GIO
///
/// You can load an `rsvg.Handle` from a simple filename or URI with
/// `rsvg.Handle.newFromFile`.  Note that this is a blocking operation; there
/// is no way to cancel it if loading a remote URI takes a long time.  Also, note that
/// this method does not let you specify `rsvg.HandleFlags`.
///
/// Otherwise, loading an SVG without GIO is not recommended, since librsvg will
/// need to buffer your entire data internally before actually being able to
/// parse it.  The deprecated way of doing this is by creating a handle with
/// `rsvg.Handle.new` or `rsvg.Handle.newWithFlags`, and then using
/// `rsvg.Handle.write` and `rsvg.Handle.close` to feed the handle with SVG data.
/// Still, please try to use the GIO stream functions instead.
///
/// # Resolution of the rendered image (dots per inch, or DPI)
///
/// SVG images can contain dimensions like "`5cm`" or
/// "`2pt`" that must be converted from physical units into
/// device units.  To do this, librsvg needs to know the actual dots per inch
/// (DPI) of your target device.  You can call `rsvg.Handle.setDpi` or
/// `rsvg.Handle.setDpiXY` on an `rsvg.Handle` to set the DPI before rendering
/// it.
///
/// For historical reasons, the default DPI is 90.  Current CSS assumes a default DPI of 96, so
/// you may want to set the DPI of a `rsvg.Handle` immediately after creating it with
/// `rsvg.Handle.setDpi`.
///
/// # Rendering
///
/// The preferred way to render a whole SVG document is to use
/// `rsvg.Handle.renderDocument`.  Please see its documentation for
/// details.
///
/// # API ordering
///
/// Due to the way the librsvg API evolved over time, an `rsvg.Handle` object is available
/// for use as soon as it is constructed.  However, not all of its methods can be
/// called at any time.  For example, an `rsvg.Handle` just constructed with `rsvg.Handle.new`
/// is not loaded yet, and it does not make sense to call `rsvg.Handle.renderDocument` on it
/// just at that point.
///
/// The documentation for the available methods in `rsvg.Handle` may mention that a particular
/// method is only callable on a "fully loaded handle".  This means either:
///
/// * The handle was loaded with `rsvg.Handle.write` and `rsvg.Handle.close`, and
///   those functions returned no errors.
///
/// * The handle was loaded with `rsvg.Handle.readStreamSync` and that function
///   returned no errors.
///
/// Before librsvg 2.46, the library did not fully verify that a handle was in a
/// fully loaded state for the methods that require it.  To preserve
/// compatibility with old code which inadvertently called the API without
/// checking for errors, or which called some methods outside of the expected
/// order, librsvg will just emit a ``g_critical`` message in those cases.
///
/// New methods introduced in librsvg 2.46 and later will check for the correct
/// ordering, and panic if they are called out of order.  This will abort
/// the program as if it had a failed assertion.
pub const Handle = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = rsvg.HandleClass;
    f_parent: gobject.Object,
    f__abi_padding: [16]*anyopaque,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Base URI, to be used to resolve relative references for resources.  See the section
        /// "Security and locations of referenced files" for details.
        pub const base_uri = struct {
            pub const name = "base-uri";

            pub const Type = ?[*:0]u8;
        };

        /// SVG's description.
        pub const desc = struct {
            pub const name = "desc";

            pub const Type = ?[*:0]u8;
        };

        /// Horizontal resolution in dots per inch.
        ///
        /// The default is 90.  Note that current CSS assumes a default of 96,
        /// so you may want to set it to `96.0` before rendering the handle.
        pub const dpi_x = struct {
            pub const name = "dpi-x";

            pub const Type = f64;
        };

        /// Horizontal resolution in dots per inch.
        ///
        /// The default is 90.  Note that current CSS assumes a default of 96,
        /// so you may want to set it to `96.0` before rendering the handle.
        pub const dpi_y = struct {
            pub const name = "dpi-y";

            pub const Type = f64;
        };

        /// Exact width, in pixels, of the rendered SVG before calling the size callback
        /// as specified by `rsvg.Handle.setSizeCallback`.
        pub const em = struct {
            pub const name = "em";

            pub const Type = f64;
        };

        /// Exact height, in pixels, of the rendered SVG before calling the size callback
        /// as specified by `rsvg.Handle.setSizeCallback`.
        pub const ex = struct {
            pub const name = "ex";

            pub const Type = f64;
        };

        /// Flags from `rsvg.HandleFlags`.
        pub const flags = struct {
            pub const name = "flags";

            pub const Type = rsvg.HandleFlags;
        };

        /// Height, in pixels, of the rendered SVG after calling the size callback
        /// as specified by `rsvg.Handle.setSizeCallback`.
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        /// SVG's metadata
        pub const metadata = struct {
            pub const name = "metadata";

            pub const Type = ?[*:0]u8;
        };

        /// SVG's title.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Width, in pixels, of the rendered SVG after calling the size callback
        /// as specified by `rsvg.Handle.setSizeCallback`.
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns a new rsvg handle.  Must be freed with `gobject.Object.unref`.  This
    /// handle can be used to load an image.
    ///
    /// The preferred way of loading SVG data into the returned `rsvg.Handle` is with
    /// `rsvg.Handle.readStreamSync`.
    ///
    /// The deprecated way of loading SVG data is with `rsvg.Handle.write` and
    /// `rsvg.Handle.close`; note that these require buffering the entire file
    /// internally, and for this reason it is better to use the stream functions:
    /// `rsvg.Handle.newFromStreamSync`, `rsvg.Handle.readStreamSync`, or
    /// `rsvg.Handle.newFromGfileSync`.
    ///
    /// After loading the `rsvg.Handle` with data, you can render it using Cairo or get
    /// a GdkPixbuf from it. When finished, free the handle with `gobject.Object.unref`. No
    /// more than one image can be loaded with one handle.
    ///
    /// Note that this function creates an `rsvg.Handle` with no flags set.  If you
    /// require any of `rsvg.HandleFlags` to be set, use any of
    /// `rsvg.Handle.newWithFlags`, `rsvg.Handle.newFromStreamSync`, or
    /// `rsvg.Handle.newFromGfileSync`.
    extern fn rsvg_handle_new() *rsvg.Handle;
    pub const new = rsvg_handle_new;

    /// Loads the SVG specified by `data`.  Note that this function creates an
    /// `rsvg.Handle` without a base URL, and without any `rsvg.HandleFlags`.  If you
    /// need these, use `rsvg.Handle.newFromStreamSync` instead by creating
    /// a `gio.MemoryInputStream` from your data.
    extern fn rsvg_handle_new_from_data(p_data: [*]const u8, p_data_len: usize, p_error: ?*?*glib.Error) ?*rsvg.Handle;
    pub const newFromData = rsvg_handle_new_from_data;

    /// Loads the SVG specified by `file_name`.  Note that this function, like
    /// `rsvg.Handle.new`, does not specify any loading flags for the resulting
    /// handle.  If you require the use of `rsvg.HandleFlags`, use
    /// `rsvg.Handle.newFromGfileSync`.
    extern fn rsvg_handle_new_from_file(p_filename: [*:0]const u8, p_error: ?*?*glib.Error) ?*rsvg.Handle;
    pub const newFromFile = rsvg_handle_new_from_file;

    /// Creates a new `rsvg.Handle` for `file`.
    ///
    /// This function sets the "base file" of the handle to be `file` itself, so SVG
    /// elements like `<image>` which reference external
    /// resources will be resolved relative to the location of `file`.
    ///
    /// If `cancellable` is not `NULL`, then the operation can be cancelled by
    /// triggering the cancellable object from another thread. If the
    /// operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
    /// returned in `error`.
    extern fn rsvg_handle_new_from_gfile_sync(p_file: *gio.File, p_flags: rsvg.HandleFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*rsvg.Handle;
    pub const newFromGfileSync = rsvg_handle_new_from_gfile_sync;

    /// Creates a new `rsvg.Handle` for `stream`.
    ///
    /// This function sets the "base file" of the handle to be `base_file` if
    /// provided.  SVG elements like `<image>` which reference
    /// external resources will be resolved relative to the location of `base_file`.
    ///
    /// If `cancellable` is not `NULL`, then the operation can be cancelled by
    /// triggering the cancellable object from another thread. If the
    /// operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
    /// returned in `error`.
    extern fn rsvg_handle_new_from_stream_sync(p_input_stream: *gio.InputStream, p_base_file: ?*gio.File, p_flags: rsvg.HandleFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*rsvg.Handle;
    pub const newFromStreamSync = rsvg_handle_new_from_stream_sync;

    /// Creates a new `rsvg.Handle` with flags `flags`.  After calling this function,
    /// you can feed the resulting handle with SVG data by using
    /// `rsvg.Handle.readStreamSync`.
    extern fn rsvg_handle_new_with_flags(p_flags: rsvg.HandleFlags) *rsvg.Handle;
    pub const newWithFlags = rsvg_handle_new_with_flags;

    /// This is used after calling `rsvg.Handle.write` to indicate that there is no more data
    /// to consume, and to start the actual parsing of the SVG document.  The only reason to
    /// call this function is if you use use `rsvg.Handle.write` to feed data into the `handle`;
    /// if you use the other methods like `rsvg.Handle.newFromFile` or
    /// `rsvg.Handle.readStreamSync`, then you do not need to call this function.
    ///
    /// This will return `TRUE` if the loader closed successfully and the
    /// SVG data was parsed correctly.  Note that `handle` isn't freed until
    /// `gobject.Object.unref` is called.
    extern fn rsvg_handle_close(p_handle: *Handle, p_error: ?*?*glib.Error) c_int;
    pub const close = rsvg_handle_close;

    /// Frees `handle`.
    extern fn rsvg_handle_free(p_handle: *Handle) void;
    pub const free = rsvg_handle_free;

    /// Gets the base uri for this `rsvg.Handle`.
    extern fn rsvg_handle_get_base_uri(p_handle: *Handle) [*:0]const u8;
    pub const getBaseUri = rsvg_handle_get_base_uri;

    extern fn rsvg_handle_get_desc(p_handle: *Handle) ?[*:0]const u8;
    pub const getDesc = rsvg_handle_get_desc;

    /// Get the SVG's size. Do not call from within the size_func callback, because
    /// an infinite loop will occur.
    ///
    /// This function depends on the `rsvg.Handle`'s DPI to compute dimensions in
    /// pixels, so you should call `rsvg.Handle.setDpi` beforehand.
    extern fn rsvg_handle_get_dimensions(p_handle: *Handle, p_dimension_data: *rsvg.DimensionData) void;
    pub const getDimensions = rsvg_handle_get_dimensions;

    /// Get the size of a subelement of the SVG file. Do not call from within the
    /// size_func callback, because an infinite loop will occur.
    ///
    /// This function depends on the `rsvg.Handle`'s DPI to compute dimensions in
    /// pixels, so you should call `rsvg.Handle.setDpi` beforehand.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    extern fn rsvg_handle_get_dimensions_sub(p_handle: *Handle, p_dimension_data: *rsvg.DimensionData, p_id: ?[*:0]const u8) c_int;
    pub const getDimensionsSub = rsvg_handle_get_dimensions_sub;

    /// Computes the ink rectangle and logical rectangle of a single SVG element.
    ///
    /// While `rsvg_handle_get_geometry_for_layer` computes the geometry of an SVG element subtree with
    /// its transformation matrix, this other function will compute the element's geometry
    /// as if it were being rendered under an identity transformation by itself.  That is,
    /// the resulting geometry is as if the element got extracted by itself from the SVG.
    ///
    /// This function is the counterpart to `rsvg_handle_render_element`.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    ///
    /// The "ink rectangle" is the bounding box that would be painted
    /// for fully- stroked and filled elements.
    ///
    /// The "logical rectangle" just takes into account the unstroked
    /// paths and text outlines.
    ///
    /// Note that these bounds are not minimum bounds; for example,
    /// clipping paths are not taken into account.
    ///
    /// You can pass `NULL` for the `id` if you want to measure all
    /// the elements in the SVG, i.e. to measure everything from the
    /// root element.
    ///
    /// This operation is not constant-time, as it involves going through all
    /// the child elements.
    extern fn rsvg_handle_get_geometry_for_element(p_handle: *Handle, p_id: ?[*:0]const u8, p_out_ink_rect: ?*rsvg.Rectangle, p_out_logical_rect: ?*rsvg.Rectangle, p_error: ?*?*glib.Error) c_int;
    pub const getGeometryForElement = rsvg_handle_get_geometry_for_element;

    /// Computes the ink rectangle and logical rectangle of an SVG element, or the
    /// whole SVG, as if the whole SVG were rendered to a specific viewport.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    ///
    /// The "ink rectangle" is the bounding box that would be painted
    /// for fully-stroked and filled elements.
    ///
    /// The "logical rectangle" just takes into account the unstroked
    /// paths and text outlines.
    ///
    /// Note that these bounds are not minimum bounds; for example,
    /// clipping paths are not taken into account.
    ///
    /// You can pass `NULL` for the `id` if you want to measure all
    /// the elements in the SVG, i.e. to measure everything from the
    /// root element.
    ///
    /// This operation is not constant-time, as it involves going through all
    /// the child elements.
    extern fn rsvg_handle_get_geometry_for_layer(p_handle: *Handle, p_id: ?[*:0]const u8, p_viewport: *const rsvg.Rectangle, p_out_ink_rect: ?*rsvg.Rectangle, p_out_logical_rect: ?*rsvg.Rectangle, p_error: ?*?*glib.Error) c_int;
    pub const getGeometryForLayer = rsvg_handle_get_geometry_for_layer;

    /// In simple terms, queries the `width`, `height`, and `viewBox` attributes in an SVG document.
    ///
    /// If you are calling this function to compute a scaling factor to render the SVG,
    /// consider simply using `rsvg.Handle.renderDocument` instead; it will do the
    /// scaling computations automatically.
    ///
    /// Before librsvg 2.54.0, the `out_has_width` and `out_has_height` arguments would be set to true or false
    /// depending on whether the SVG document actually had `width` and `height` attributes, respectively.
    ///
    /// However, since librsvg 2.54.0, `width` and `height` are now [geometry
    /// properties](https://www.w3.org/TR/SVG2/geometry.html) per the SVG2 specification; they
    /// are not plain attributes.  SVG2 made it so that the initial value of those properties
    /// is `auto`, which is equivalent to specifing a value of `100%`.  In this sense, even SVG
    /// documents which lack `width` or `height` attributes semantically have to make them
    /// default to `100%`.  This is why since librsvg 2.54.0, `out_has_width` and
    /// `out_has_heigth` are always returned as `TRUE`, since with SVG2 all documents *have* a
    /// default width and height of `100%`.
    ///
    /// As an example, the following SVG element has a `width` of 100 pixels and a `height` of 400 pixels, but no `viewBox`.  This
    /// function will return those sizes in `out_width` and `out_height`, and set `out_has_viewbox` to `FALSE`.
    ///
    /// ```
    /// <svg xmlns="http://www.w3.org/2000/svg" width="100" height="400">
    /// ```
    ///
    /// Conversely, the following element has a `viewBox`, but no `width` or `height`.  This function will
    /// set `out_has_viewbox` to `TRUE`, and it will also set `out_has_width` and `out_has_height` to `TRUE` but
    /// return both length values as `100%`.
    ///
    /// ```
    /// <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 400">
    /// ```
    ///
    /// Note that the `RsvgLength` return values have `RsvgUnits` in them; you should
    /// not assume that they are always in pixels.  For example, the following SVG element
    /// will return width and height values whose `units` fields are `RSVG_UNIT_MM`.
    ///
    /// ```
    /// <svg xmlns="http://www.w3.org/2000/svg" width="210mm" height="297mm">
    /// ```
    ///
    /// API ordering: This function must be called on a fully-loaded `handle`.  See
    /// the section "[API ordering](class.Handle.html`api`-ordering)" for details.
    ///
    /// Panics: this function will panic if the `handle` is not fully-loaded.
    extern fn rsvg_handle_get_intrinsic_dimensions(p_handle: *Handle, p_out_has_width: ?*c_int, p_out_width: ?*rsvg.Length, p_out_has_height: ?*c_int, p_out_height: ?*rsvg.Length, p_out_has_viewbox: ?*c_int, p_out_viewbox: ?*rsvg.Rectangle) void;
    pub const getIntrinsicDimensions = rsvg_handle_get_intrinsic_dimensions;

    /// Converts an SVG document's intrinsic dimensions to pixels, and returns the result.
    ///
    /// This function is able to extract the size in pixels from an SVG document if the
    /// document has both `width` and `height` attributes
    /// with physical units (px, in, cm, mm, pt, pc) or font-based units (em, ex).  For
    /// physical units, the dimensions are normalized to pixels using the dots-per-inch (DPI)
    /// value set previously with `rsvg.Handle.setDpi`.  For font-based units, this function
    /// uses the computed value of the `font-size` property for the toplevel
    /// `<svg>` element.  In those cases, this function returns `TRUE`.
    ///
    /// For historical reasons, the default DPI is 90.  Current CSS assumes a default DPI of 96, so
    /// you may want to set the DPI of a `rsvg.Handle` immediately after creating it with
    /// `rsvg.Handle.setDpi`.
    ///
    /// This function is not able to extract the size in pixels directly from the intrinsic
    /// dimensions of the SVG document if the `width` or
    /// `height` are in percentage units (or if they do not exist, in which
    /// case the SVG spec mandates that they default to 100%), as these require a
    /// <firstterm>viewport</firstterm> to be resolved to a final size.  In this case, the
    /// function returns `FALSE`.
    ///
    /// For example, the following document fragment has intrinsic dimensions that will resolve
    /// to 20x30 pixels.
    ///
    /// ```
    /// <svg xmlns="http://www.w3.org/2000/svg" width="20" height="30"/>
    /// ```
    ///
    /// Similarly, if the DPI is set to 96, this document will resolve to 192×288 pixels (i.e. 96×2 × 96×3).
    ///
    /// ```
    /// <svg xmlns="http://www.w3.org/2000/svg" width="2in" height="3in"/>
    /// ```
    ///
    /// The dimensions of the following documents cannot be resolved to pixels directly, and
    /// this function would return `FALSE` for them:
    ///
    /// ```
    /// <!-- Needs a viewport against which to compute the percentages. -->
    /// <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%"/>
    ///
    /// <!-- Does not have intrinsic width/height, just a 1:2 aspect ratio which
    ///      needs to be fitted within a viewport. -->
    /// <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 200"/>
    /// ```
    ///
    /// Instead of querying an SVG document's size, applications are encouraged to render SVG
    /// documents to a size chosen by the application, by passing a suitably-sized viewport to
    /// `rsvg.Handle.renderDocument`.
    extern fn rsvg_handle_get_intrinsic_size_in_pixels(p_handle: *Handle, p_out_width: ?*f64, p_out_height: ?*f64) c_int;
    pub const getIntrinsicSizeInPixels = rsvg_handle_get_intrinsic_size_in_pixels;

    extern fn rsvg_handle_get_metadata(p_handle: *Handle) ?[*:0]const u8;
    pub const getMetadata = rsvg_handle_get_metadata;

    /// Returns the pixbuf loaded by `handle`.  The pixbuf returned will be reffed, so
    /// the caller of this function must assume that ref.
    ///
    /// API ordering: This function must be called on a fully-loaded `handle`.  See
    /// the section "[API ordering](class.Handle.html`api`-ordering)" for details.
    ///
    /// This function depends on the `rsvg.Handle`'s dots-per-inch value (DPI) to compute the
    /// "natural size" of the document in pixels, so you should call `rsvg.Handle.setDpi`
    /// beforehand.
    extern fn rsvg_handle_get_pixbuf(p_handle: *Handle) ?*gdkpixbuf.Pixbuf;
    pub const getPixbuf = rsvg_handle_get_pixbuf;

    /// Returns the pixbuf loaded by `handle`.  The pixbuf returned will be reffed, so
    /// the caller of this function must assume that ref.
    ///
    /// API ordering: This function must be called on a fully-loaded `handle`.  See
    /// the section "[API ordering](class.Handle.html`api`-ordering)" for details.
    ///
    /// This function depends on the `rsvg.Handle`'s dots-per-inch value (DPI) to compute the
    /// "natural size" of the document in pixels, so you should call `rsvg.Handle.setDpi`
    /// beforehand.
    extern fn rsvg_handle_get_pixbuf_and_error(p_handle: *Handle, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const getPixbufAndError = rsvg_handle_get_pixbuf_and_error;

    /// Creates a `GdkPixbuf` the same size as the entire SVG loaded into `handle`, but
    /// only renders the sub-element that has the specified `id` (and all its
    /// sub-sub-elements recursively).  If `id` is `NULL`, this function renders the
    /// whole SVG.
    ///
    /// This function depends on the `rsvg.Handle`'s dots-per-inch value (DPI) to compute the
    /// "natural size" of the document in pixels, so you should call `rsvg.Handle.setDpi`
    /// beforehand.
    ///
    /// If you need to render an image which is only big enough to fit a particular
    /// sub-element of the SVG, consider using `rsvg.Handle.renderElement`.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    ///
    /// API ordering: This function must be called on a fully-loaded `handle`.  See
    /// the section "[API ordering](class.Handle.html`api`-ordering)" for details.
    extern fn rsvg_handle_get_pixbuf_sub(p_handle: *Handle, p_id: ?[*:0]const u8) ?*gdkpixbuf.Pixbuf;
    pub const getPixbufSub = rsvg_handle_get_pixbuf_sub;

    /// Get the position of a subelement of the SVG file. Do not call from within
    /// the size_func callback, because an infinite loop will occur.
    ///
    /// This function depends on the `rsvg.Handle`'s DPI to compute dimensions in
    /// pixels, so you should call `rsvg.Handle.setDpi` beforehand.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    extern fn rsvg_handle_get_position_sub(p_handle: *Handle, p_position_data: *rsvg.PositionData, p_id: ?[*:0]const u8) c_int;
    pub const getPositionSub = rsvg_handle_get_position_sub;

    extern fn rsvg_handle_get_title(p_handle: *Handle) ?[*:0]const u8;
    pub const getTitle = rsvg_handle_get_title;

    /// Checks whether the element `id` exists in the SVG document.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    extern fn rsvg_handle_has_sub(p_handle: *Handle, p_id: [*:0]const u8) c_int;
    pub const hasSub = rsvg_handle_has_sub;

    /// Do not call this function.  This is intended for librsvg's internal
    /// test suite only.
    extern fn rsvg_handle_internal_set_testing(p_handle: *Handle, p_testing: c_int) void;
    pub const internalSetTesting = rsvg_handle_internal_set_testing;

    /// Reads `stream` and writes the data from it to `handle`.
    ///
    /// Before calling this function, you may need to call `rsvg.Handle.setBaseUri`
    /// or `rsvg.Handle.setBaseGfile` to set the "base file" for resolving
    /// references to external resources.  SVG elements like
    /// `<image>` which reference external resources will be
    /// resolved relative to the location you specify with those functions.
    ///
    /// If `cancellable` is not `NULL`, then the operation can be cancelled by
    /// triggering the cancellable object from another thread. If the
    /// operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
    /// returned.
    extern fn rsvg_handle_read_stream_sync(p_handle: *Handle, p_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const readStreamSync = rsvg_handle_read_stream_sync;

    /// Draws a loaded SVG handle to a Cairo context.  Please try to use
    /// `rsvg.Handle.renderDocument` instead, which allows you to pick the size
    /// at which the document will be rendered.
    ///
    /// Historically this function has picked a size by itself, based on the following rules:
    ///
    /// * If the SVG document has both `width` and `height`
    ///   attributes with physical units (px, in, cm, mm, pt, pc) or font-based units (em,
    ///   ex), the function computes the size directly based on the dots-per-inch (DPI) you
    ///   have configured with `rsvg.Handle.setDpi`.  This is the same approach as
    ///   `rsvg.Handle.getIntrinsicSizeInPixels`.
    ///
    /// * Otherwise, if there is a `viewBox` attribute and both
    ///   `width` and `height` are set to
    ///   `100%` (or if they don't exist at all and thus default to 100%),
    ///   the function uses the width and height of the `viewBox` as a pixel size.  This
    ///   produces a rendered document with the correct aspect ratio.
    ///
    /// * Otherwise, this function computes the extents of every graphical object in the SVG
    ///   document to find the total extents.  This is moderately expensive, but no more expensive
    ///   than rendering the whole document, for example.
    ///
    /// * This function cannot deal with percentage-based units for `width`
    ///   and `height` because there is no viewport against which they could
    ///   be resolved; that is why it will compute the extents of objects in that case.  This
    ///   is why we recommend that you use `rsvg.Handle.renderDocument` instead, which takes
    ///   in a viewport and follows the sizing policy from the web platform.
    ///
    /// Drawing will occur with respect to the `cr`'s current transformation: for example, if
    /// the `cr` has a rotated current transformation matrix, the whole SVG will be rotated in
    /// the rendered version.
    ///
    /// This function depends on the `rsvg.Handle`'s DPI to compute dimensions in
    /// pixels, so you should call `rsvg.Handle.setDpi` beforehand.
    ///
    /// Note that `cr` must be a Cairo context that is not in an error state, that is,
    /// ``cairo_status`` must return `CAIRO_STATUS_SUCCESS` for it.  Cairo can set a
    /// context to be in an error state in various situations, for example, if it was
    /// passed an invalid matrix or if it was created for an invalid surface.
    extern fn rsvg_handle_render_cairo(p_handle: *Handle, p_cr: *cairo.Context) c_int;
    pub const renderCairo = rsvg_handle_render_cairo;

    /// Renders a single SVG element in the same place as for a whole SVG document (a "subset"
    /// of the document).  Please try to use `rsvg.Handle.renderLayer` instead, which allows
    /// you to pick the size at which the document with the layer will be rendered.
    ///
    /// This is equivalent to `rsvg.Handle.renderCairo`, but it renders only a single
    /// element and its children, as if they composed an individual layer in the SVG.
    ///
    /// Historically this function has picked a size for the whole document by itself, based
    /// on the following rules:
    ///
    /// * If the SVG document has both `width` and `height`
    ///   attributes with physical units (px, in, cm, mm, pt, pc) or font-based units (em,
    ///   ex), the function computes the size directly based on the dots-per-inch (DPI) you
    ///   have configured with `rsvg.Handle.setDpi`.  This is the same approach as
    ///   `rsvg.Handle.getIntrinsicSizeInPixels`.
    ///
    /// * Otherwise, if there is a `viewBox` attribute and both
    ///   `width` and `height` are set to
    ///   `100%` (or if they don't exist at all and thus default to 100%),
    ///   the function uses the width and height of the `viewBox` as a pixel size.  This
    ///   produces a rendered document with the correct aspect ratio.
    ///
    /// * Otherwise, this function computes the extents of every graphical object in the SVG
    ///   document to find the total extents.  This is moderately expensive, but no more expensive
    ///   than rendering the whole document, for example.
    ///
    /// * This function cannot deal with percentage-based units for `width`
    ///   and `height` because there is no viewport against which they could
    ///   be resolved; that is why it will compute the extents of objects in that case.  This
    ///   is why we recommend that you use `rsvg.Handle.renderLayer` instead, which takes
    ///   in a viewport and follows the sizing policy from the web platform.
    ///
    /// Drawing will occur with respect to the `cr`'s current transformation: for example, if
    /// the `cr` has a rotated current transformation matrix, the whole SVG will be rotated in
    /// the rendered version.
    ///
    /// This function depends on the `rsvg.Handle`'s DPI to compute dimensions in
    /// pixels, so you should call `rsvg.Handle.setDpi` beforehand.
    ///
    /// Note that `cr` must be a Cairo context that is not in an error state, that is,
    /// ``cairo_status`` must return `CAIRO_STATUS_SUCCESS` for it.  Cairo can set a
    /// context to be in an error state in various situations, for example, if it was
    /// passed an invalid matrix or if it was created for an invalid surface.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    extern fn rsvg_handle_render_cairo_sub(p_handle: *Handle, p_cr: *cairo.Context, p_id: ?[*:0]const u8) c_int;
    pub const renderCairoSub = rsvg_handle_render_cairo_sub;

    /// Renders the whole SVG document fitted to a viewport.
    ///
    /// The `viewport` gives the position and size at which the whole SVG document will be
    /// rendered.  The document is scaled proportionally to fit into this viewport.
    ///
    /// The `cr` must be in a `CAIRO_STATUS_SUCCESS` state, or this function will not
    /// render anything, and instead will return an error.
    extern fn rsvg_handle_render_document(p_handle: *Handle, p_cr: *cairo.Context, p_viewport: *const rsvg.Rectangle, p_error: ?*?*glib.Error) c_int;
    pub const renderDocument = rsvg_handle_render_document;

    /// Renders a single SVG element to a given viewport.
    ///
    /// This function can be used to extract individual element subtrees and render them,
    /// scaled to a given `element_viewport`.  This is useful for applications which have
    /// reusable objects in an SVG and want to render them individually; for example, an
    /// SVG full of icons that are meant to be be rendered independently of each other.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    ///
    /// You can pass `NULL` for the `id` if you want to render all
    /// the elements in the SVG, i.e. to render everything from the
    /// root element.
    ///
    /// The `element_viewport` gives the position and size at which the named element will
    /// be rendered.  FIXME: mention proportional scaling.
    extern fn rsvg_handle_render_element(p_handle: *Handle, p_cr: *cairo.Context, p_id: ?[*:0]const u8, p_element_viewport: *const rsvg.Rectangle, p_error: ?*?*glib.Error) c_int;
    pub const renderElement = rsvg_handle_render_element;

    /// Renders a single SVG element in the same place as for a whole SVG document.
    ///
    /// The `viewport` gives the position and size at which the whole SVG document would be
    /// rendered.  The document is scaled proportionally to fit into this viewport; hence the
    /// individual layer may be smaller than this.
    ///
    /// This is equivalent to `rsvg.Handle.renderDocument`, but it renders only a
    /// single element and its children, as if they composed an individual layer in
    /// the SVG.  The element is rendered with the same transformation matrix as it
    /// has within the whole SVG document.  Applications can use this to re-render a
    /// single element and repaint it on top of a previously-rendered document, for
    /// example.
    ///
    /// Element IDs should look like an URL fragment identifier; for example, pass
    /// ``foo`` (hash `foo`) to get the geometry of the element that
    /// has an `id="foo"` attribute.
    ///
    /// You can pass `NULL` for the `id` if you want to render all
    /// the elements in the SVG, i.e. to render everything from the
    /// root element.
    extern fn rsvg_handle_render_layer(p_handle: *Handle, p_cr: *cairo.Context, p_id: ?[*:0]const u8, p_viewport: *const rsvg.Rectangle, p_error: ?*?*glib.Error) c_int;
    pub const renderLayer = rsvg_handle_render_layer;

    /// Set the base URI for `handle` from `file`.
    ///
    /// Note: This function may only be called before `rsvg.Handle.write` or
    /// `rsvg.Handle.readStreamSync` have been called.
    extern fn rsvg_handle_set_base_gfile(p_handle: *Handle, p_base_file: *gio.File) void;
    pub const setBaseGfile = rsvg_handle_set_base_gfile;

    /// Set the base URI for this SVG.
    ///
    /// Note: This function may only be called before `rsvg.Handle.write` or
    /// `rsvg.Handle.readStreamSync` have been called.
    extern fn rsvg_handle_set_base_uri(p_handle: *Handle, p_base_uri: [*:0]const u8) void;
    pub const setBaseUri = rsvg_handle_set_base_uri;

    /// Sets a cancellable object that can be used to interrupt rendering
    /// while the handle is being rendered in another thread.  For example,
    /// you can set a cancellable from your main thread, spawn a thread to
    /// do the rendering, and interrupt the rendering from the main thread
    /// by calling `gio.Cancellable.cancel`.
    ///
    /// If rendering is interrupted, the corresponding call to
    /// `rsvg.Handle.renderDocument` (or any of the other rendering
    /// functions) will return an error with domain `G_IO_ERROR`, and code
    /// `G_IO_ERROR_CANCELLED`.
    extern fn rsvg_handle_set_cancellable_for_rendering(p_handle: *Handle, p_cancellable: ?*gio.Cancellable) void;
    pub const setCancellableForRendering = rsvg_handle_set_cancellable_for_rendering;

    /// Sets the DPI at which the `handle` will be rendered. Common values are
    /// 75, 90, and 300 DPI.
    ///
    /// Passing a number <= 0 to `dpi` will reset the DPI to whatever the default
    /// value happens to be, but since `rsvg.setDefaultDpi` is deprecated, please
    /// do not pass values <= 0 to this function.
    extern fn rsvg_handle_set_dpi(p_handle: *Handle, p_dpi: f64) void;
    pub const setDpi = rsvg_handle_set_dpi;

    /// Sets the DPI at which the `handle` will be rendered. Common values are
    /// 75, 90, and 300 DPI.
    ///
    /// Passing a number <= 0 to `dpi` will reset the DPI to whatever the default
    /// value happens to be, but since `rsvg.setDefaultDpiXY` is deprecated,
    /// please do not pass values <= 0 to this function.
    extern fn rsvg_handle_set_dpi_x_y(p_handle: *Handle, p_dpi_x: f64, p_dpi_y: f64) void;
    pub const setDpiXY = rsvg_handle_set_dpi_x_y;

    /// Sets the sizing function for the `handle`, which can be used to override the
    /// size that librsvg computes for SVG images.  The `size_func` is called from the
    /// following functions:
    ///
    /// * `rsvg.Handle.getDimensions`
    /// * `rsvg.Handle.getDimensionsSub`
    /// * `rsvg.Handle.getPositionSub`
    /// * `rsvg.Handle.renderCairo`
    /// * `rsvg.Handle.renderCairoSub`
    ///
    /// Librsvg computes the size of the SVG being rendered, and passes it to the
    /// `size_func`, which may then modify these values to set the final size of the
    /// generated image.
    extern fn rsvg_handle_set_size_callback(p_handle: *Handle, p_size_func: ?rsvg.SizeFunc, p_user_data: ?*anyopaque, p_user_data_destroy: ?glib.DestroyNotify) void;
    pub const setSizeCallback = rsvg_handle_set_size_callback;

    /// Sets a CSS stylesheet to use for an SVG document.
    ///
    /// The `css_len` argument is mandatory; this function will not compute the length
    /// of the `css` string.  This is because a provided stylesheet, which the calling
    /// program could read from a file, can have nul characters in it.
    ///
    /// During the CSS cascade, the specified stylesheet will be used with a "User"
    /// [origin](https://drafts.csswg.org/css-cascade-3/`cascading`-origins).
    ///
    /// Note that ``import`` rules will not be resolved, except for `data:` URLs.
    extern fn rsvg_handle_set_stylesheet(p_handle: *Handle, p_css: [*]const u8, p_css_len: usize, p_error: ?*?*glib.Error) c_int;
    pub const setStylesheet = rsvg_handle_set_stylesheet;

    /// Loads the next `count` bytes of the image.  You can call this function multiple
    /// times until the whole document is consumed; then you must call `rsvg.Handle.close`
    /// to actually parse the document.
    ///
    /// Before calling this function for the first time, you may need to call
    /// `rsvg.Handle.setBaseUri` or `rsvg.Handle.setBaseGfile` to set the "base
    /// file" for resolving references to external resources.  SVG elements like
    /// `<image>` which reference external resources will be
    /// resolved relative to the location you specify with those functions.
    extern fn rsvg_handle_write(p_handle: *Handle, p_buf: [*]const u8, p_count: usize, p_error: ?*?*glib.Error) c_int;
    pub const write = rsvg_handle_write;

    extern fn rsvg_handle_get_type() usize;
    pub const getGObjectType = rsvg_handle_get_type;

    extern fn g_object_ref(p_self: *rsvg.Handle) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *rsvg.Handle) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Handle, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Dimensions of an SVG image from `rsvg.Handle.getDimensions`, or an
/// individual element from `rsvg.Handle.getDimensionsSub`.  Please see
/// the deprecation documentation for those functions.
pub const DimensionData = extern struct {
    /// SVG's width, in pixels
    f_width: c_int,
    /// SVG's height, in pixels
    f_height: c_int,
    /// SVG's original width, unmodified by `RsvgSizeFunc`
    f_em: f64,
    /// SVG's original height, unmodified by `RsvgSizeFunc`
    f_ex: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for `rsvg.Handle`.
pub const HandleClass = extern struct {
    pub const Instance = rsvg.Handle;

    /// parent class
    f_parent: gobject.ObjectClass,
    f__abi_padding: [15]*anyopaque,

    pub fn as(p_instance: *HandleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `RsvgLength` values are used in `rsvg.Handle.getIntrinsicDimensions`, for
/// example, to return the CSS length values of the `width` and
/// `height` attributes of an `<svg>` element.
///
/// This is equivalent to [CSS lengths](https://www.w3.org/TR/CSS21/syndata.html`length`-units).
///
/// It is up to the calling application to convert lengths in non-pixel units
/// (i.e. those where the `unit` field is not `RSVG_UNIT_PX`) into something
/// meaningful to the application.  For example, if your application knows the
/// dots-per-inch (DPI) it is using, it can convert lengths with `unit` in
/// `RSVG_UNIT_IN` or other physical units.
pub const Length = extern struct {
    /// numeric part of the length
    f_length: f64,
    /// unit part of the length
    f_unit: rsvg.Unit,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Position of an SVG fragment from `rsvg.Handle.getPositionSub`.  Please
/// the deprecation documentation for that function.
pub const PositionData = extern struct {
    /// position on the x axis
    f_x: c_int,
    /// position on the y axis
    f_y: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A data structure for holding a rectangle.
pub const Rectangle = extern struct {
    /// X coordinate of the left side of the rectangle
    f_x: f64,
    /// Y coordinate of the the top side of the rectangle
    f_y: f64,
    /// width of the rectangle
    f_width: f64,
    /// height of the rectangle
    f_height: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration representing possible errors
pub const Error = enum(c_int) {
    failed = 0,
    _,

    /// The error domain for RSVG
    extern fn rsvg_error_quark() glib.Quark;
    pub const quark = rsvg_error_quark;

    extern fn rsvg_error_get_type() usize;
    pub const getGObjectType = rsvg_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Units for the `RsvgLength` struct.  These have the same meaning as [CSS length
/// units](https://www.w3.org/TR/CSS21/syndata.html`length`-units).
///
/// If you test for the values of this enum, please note that librsvg may add other units in the future
/// as its support for CSS improves.  Please make your code handle unknown units gracefully (e.g. with
/// a `default` case in a ``@"switch"`` statement).
pub const Unit = enum(c_int) {
    percent = 0,
    px = 1,
    em = 2,
    ex = 3,
    in = 4,
    cm = 5,
    mm = 6,
    pt = 7,
    pc = 8,
    ch = 9,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Configuration flags for an `rsvg.Handle`.  Note that not all of `rsvg.Handle`'s
/// constructors let you specify flags.  For this reason, `rsvg.Handle.newFromGfileSync`
/// and `rsvg.Handle.newFromStreamSync` are the preferred ways to create a handle.
pub const HandleFlags = packed struct(c_uint) {
    flag_unlimited: bool = false,
    flag_keep_image_data: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_flags_none: HandleFlags = @bitCast(@as(c_uint, 0));
    pub const flags_flag_unlimited: HandleFlags = @bitCast(@as(c_uint, 1));
    pub const flags_flag_keep_image_data: HandleFlags = @bitCast(@as(c_uint, 2));
    extern fn rsvg_handle_flags_get_type() usize;
    pub const getGObjectType = rsvg_handle_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This function does nothing.
extern fn rsvg_cleanup() void;
pub const cleanup = rsvg_cleanup;

/// This function does nothing.
extern fn rsvg_init() void;
pub const init = rsvg_init;

/// Loads a new `GdkPixbuf` from `filename` and returns it.  The caller must
/// assume the reference to the reurned pixbuf. If an error occurred, `error` is
/// set and `NULL` is returned.
extern fn rsvg_pixbuf_from_file(p_filename: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
pub const pixbufFromFile = rsvg_pixbuf_from_file;

/// Loads a new `GdkPixbuf` from `filename` and returns it.  This pixbuf is uniformly
/// scaled so that the it fits into a rectangle of size `max_width * max_height`. The
/// caller must assume the reference to the returned pixbuf. If an error occurred,
/// `error` is set and `NULL` is returned.
extern fn rsvg_pixbuf_from_file_at_max_size(p_filename: [*:0]const u8, p_max_width: c_int, p_max_height: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
pub const pixbufFromFileAtMaxSize = rsvg_pixbuf_from_file_at_max_size;

/// Loads a new `GdkPixbuf` from `filename` and returns it.  This pixbuf is scaled
/// from the size indicated to the new size indicated by `width` and `height`.  If
/// both of these are -1, then the default size of the image being loaded is
/// used.  The caller must assume the reference to the returned pixbuf. If an
/// error occurred, `error` is set and `NULL` is returned.
extern fn rsvg_pixbuf_from_file_at_size(p_filename: [*:0]const u8, p_width: c_int, p_height: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
pub const pixbufFromFileAtSize = rsvg_pixbuf_from_file_at_size;

/// Loads a new `GdkPixbuf` from `filename` and returns it.  This pixbuf is scaled
/// from the size indicated by the file by a factor of `x_zoom` and `y_zoom`.  The
/// caller must assume the reference to the returned pixbuf. If an error
/// occurred, `error` is set and `NULL` is returned.
extern fn rsvg_pixbuf_from_file_at_zoom(p_filename: [*:0]const u8, p_x_zoom: f64, p_y_zoom: f64, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
pub const pixbufFromFileAtZoom = rsvg_pixbuf_from_file_at_zoom;

/// Loads a new `GdkPixbuf` from `filename` and returns it.  This pixbuf is scaled
/// from the size indicated by the file by a factor of `x_zoom` and `y_zoom`. If the
/// resulting pixbuf would be larger than max_width/max_heigh it is uniformly scaled
/// down to fit in that rectangle. The caller must assume the reference to the
/// returned pixbuf. If an error occurred, `error` is set and `NULL` is returned.
extern fn rsvg_pixbuf_from_file_at_zoom_with_max(p_filename: [*:0]const u8, p_x_zoom: f64, p_y_zoom: f64, p_max_width: c_int, p_max_height: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
pub const pixbufFromFileAtZoomWithMax = rsvg_pixbuf_from_file_at_zoom_with_max;

/// Do not use this function.  Create an `rsvg.Handle` and call
/// `rsvg.Handle.setDpi` on it instead.
extern fn rsvg_set_default_dpi(p_dpi: f64) void;
pub const setDefaultDpi = rsvg_set_default_dpi;

/// Do not use this function.  Create an `rsvg.Handle` and call
/// `rsvg.Handle.setDpiXY` on it instead.
extern fn rsvg_set_default_dpi_x_y(p_dpi_x: f64, p_dpi_y: f64) void;
pub const setDefaultDpiXY = rsvg_set_default_dpi_x_y;

/// This function does nothing.
extern fn rsvg_term() void;
pub const term = rsvg_term;

/// Function to let a user of the library specify the SVG's dimensions
///
/// See the documentation for `rsvg.Handle.setSizeCallback` for an example, and
/// for the reasons for deprecation.
pub const SizeFunc = *const fn (p_width: *c_int, p_height: *c_int, p_user_data: ?*anyopaque) callconv(.c) void;

pub const HAVE_CSS = true;
pub const HAVE_PIXBUF = 1;
pub const HAVE_SVGZ = true;
/// This is a C macro that expands to a number with the major version
/// of librsvg against which your program is compiled.
///
/// For example, for librsvg-2.3.4, the major version is 2.
///
/// C programs can use this as a compile-time check for the required
/// version, but note that generally it is a better idea to do
/// compile-time checks by calling [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
/// in your build scripts.
///
/// Note: for a run-time check on the version of librsvg that your
/// program is running with (e.g. the version which the linker used for
/// your program), or for programs not written in C, use
/// `rsvg_major_version` instead.
pub const MAJOR_VERSION = 2;
/// This is a C macro that expands to a number with the micro version
/// of librsvg against which your program is compiled.
///
/// For example, for librsvg-2.3.4, the micro version is 4.
///
/// C programs can use this as a compile-time check for the required
/// version, but note that generally it is a better idea to do
/// compile-time checks by calling [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
/// in your build scripts.
///
/// Note: for a run-time check on the version of librsvg that your
/// program is running with (e.g. the version which the linker used for
/// your program), or for programs not written in C, use
/// `rsvg_micro_version` instead.
pub const MICRO_VERSION = 2;
/// This is a C macro that expands to a number with the minor version
/// of librsvg against which your program is compiled.
///
/// For example, for librsvg-2.3.4, the minor version is 3.
///
/// C programs can use this as a compile-time check for the required
/// version, but note that generally it is a better idea to do
/// compile-time checks by calling [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
/// in your build scripts.
///
/// Note: for a run-time check on the version of librsvg that your
/// program is running with (e.g. the version which the linker used for
/// your program), or for programs not written in C, use
/// `rsvg_minor_version` instead.
pub const MINOR_VERSION = 61;
/// This is a C macro that expands to a string with the version of
/// librsvg against which your program is compiled.
///
/// For example, for librsvg-2.3.4, this macro expands to
/// `"2.3.4"`.
///
/// C programs can use this as a compile-time check for the required
/// version, but note that generally it is a better idea to do
/// compile-time checks by calling [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
/// in your build scripts.
///
/// Note: for a run-time check on the version of librsvg that your
/// program is running with (e.g. the version which the linker used for
/// your program), or for programs not written in C, use
/// `rsvg_version` instead.
pub const VERSION = "2.61.2";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
