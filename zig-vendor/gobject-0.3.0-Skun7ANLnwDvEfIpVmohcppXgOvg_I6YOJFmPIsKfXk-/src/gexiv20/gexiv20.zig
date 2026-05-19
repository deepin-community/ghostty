pub const ext = @import("ext.zig");
const gexiv2 = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// An object holding all the Exiv2 metadata.  Previews, if present, are also available.
///
/// As gexiv2 is only a wrapper around Exiv2, it's better to read its documentation to understand
/// the full scope of what it offers: <ulink url="http://www.exiv2.org/"></ulink>
///
/// In particular, rather than providing a getter/setter method pair for every metadata value
/// available for images (of which there are thousands), Exiv2 uses a dotted addressing scheme.
/// For example, to access a photo's EXIF Orientation field, the caller passes to Exiv2
/// "Exif.Photo.Orientation".  These <emphasis>tags</emphasis> (in Exiv2 parlance) are key to using Exiv2 (and
/// therefore gexiv2) to its fullest.
///
/// A full reference for all supported Exiv2 tags can be found at
/// <ulink url="http://www.exiv2.org/metadata.html"></ulink>
pub const Metadata = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gexiv2.MetadataClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*gexiv2.MetadataPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_get_tag_description(p_tag: [*:0]const u8) ?[*:0]const u8;
    pub const getTagDescription = gexiv2_metadata_get_tag_description;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_get_tag_label(p_tag: [*:0]const u8) ?[*:0]const u8;
    pub const getTagLabel = gexiv2_metadata_get_tag_label;

    /// The names of the various Exiv2 tag types can be found at Exiv2::TypeId,
    /// <ulink url="http://exiv2.org/doc/namespaceExiv2.html`a5153319711f35fe81cbc13f4b852450c`"></ulink>
    ///
    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_get_tag_type(p_tag: [*:0]const u8) ?[*:0]const u8;
    pub const getTagType = gexiv2_metadata_get_tag_type;

    extern fn gexiv2_metadata_get_xmp_namespace_for_tag(p_tag: [*:0]const u8) [*:0]u8;
    pub const getXmpNamespaceForTag = gexiv2_metadata_get_xmp_namespace_for_tag;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_is_exif_tag(p_tag: [*:0]const u8) c_int;
    pub const isExifTag = gexiv2_metadata_is_exif_tag;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_is_iptc_tag(p_tag: [*:0]const u8) c_int;
    pub const isIptcTag = gexiv2_metadata_is_iptc_tag;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_is_xmp_tag(p_tag: [*:0]const u8) c_int;
    pub const isXmpTag = gexiv2_metadata_is_xmp_tag;

    extern fn gexiv2_metadata_register_xmp_namespace(p_name: [*:0]const u8, p_prefix: [*:0]const u8) c_int;
    pub const registerXmpNamespace = gexiv2_metadata_register_xmp_namespace;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_get_tag_description(p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]const u8;
    pub const tryGetTagDescription = gexiv2_metadata_try_get_tag_description;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_get_tag_label(p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]const u8;
    pub const tryGetTagLabel = gexiv2_metadata_try_get_tag_label;

    /// The names of the various Exiv2 tag types can be found at Exiv2::TypeId,
    /// <ulink url="http://exiv2.org/doc/namespaceExiv2.html`a5153319711f35fe81cbc13f4b852450c`"></ulink>
    ///
    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_get_tag_type(p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]const u8;
    pub const tryGetTagType = gexiv2_metadata_try_get_tag_type;

    extern fn gexiv2_metadata_try_get_xmp_namespace_for_tag(p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const tryGetXmpNamespaceForTag = gexiv2_metadata_try_get_xmp_namespace_for_tag;

    extern fn gexiv2_metadata_try_register_xmp_namespace(p_name: [*:0]const u8, p_prefix: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const tryRegisterXmpNamespace = gexiv2_metadata_try_register_xmp_namespace;

    extern fn gexiv2_metadata_try_unregister_all_xmp_namespaces(p_error: ?*?*glib.Error) void;
    pub const tryUnregisterAllXmpNamespaces = gexiv2_metadata_try_unregister_all_xmp_namespaces;

    extern fn gexiv2_metadata_try_unregister_xmp_namespace(p_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const tryUnregisterXmpNamespace = gexiv2_metadata_try_unregister_xmp_namespace;

    extern fn gexiv2_metadata_unregister_all_xmp_namespaces() void;
    pub const unregisterAllXmpNamespaces = gexiv2_metadata_unregister_all_xmp_namespaces;

    extern fn gexiv2_metadata_unregister_xmp_namespace(p_name: [*:0]const u8) c_int;
    pub const unregisterXmpNamespace = gexiv2_metadata_unregister_xmp_namespace;

    extern fn gexiv2_metadata_new() *gexiv2.Metadata;
    pub const new = gexiv2_metadata_new;

    /// Removes all tags for all domains (EXIF, IPTC, and XMP).
    extern fn gexiv2_metadata_clear(p_self: *Metadata) void;
    pub const clear = gexiv2_metadata_clear;

    /// This is a composite clear method that will clear a number of fields.  See
    /// `gexiv2.Metadata.getComment` for more information.
    extern fn gexiv2_metadata_clear_comment(p_self: *Metadata) void;
    pub const clearComment = gexiv2_metadata_clear_comment;

    /// Clears all EXIF metadata from the loaded image.
    extern fn gexiv2_metadata_clear_exif(p_self: *Metadata) void;
    pub const clearExif = gexiv2_metadata_clear_exif;

    /// Clears all IPTC metadata from the loaded image.
    extern fn gexiv2_metadata_clear_iptc(p_self: *Metadata) void;
    pub const clearIptc = gexiv2_metadata_clear_iptc;

    /// Removes the Exiv2 tag from the metadata object.
    ///
    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_clear_tag(p_self: *Metadata, p_tag: [*:0]const u8) c_int;
    pub const clearTag = gexiv2_metadata_clear_tag;

    /// Clears all XMP metadata from the loaded image.
    extern fn gexiv2_metadata_clear_xmp(p_self: *Metadata) void;
    pub const clearXmp = gexiv2_metadata_clear_xmp;

    /// Removes all GPS metadata from the loaded image
    extern fn gexiv2_metadata_delete_gps_info(p_self: *Metadata) void;
    pub const deleteGpsInfo = gexiv2_metadata_delete_gps_info;

    /// Removes the EXIF thumbnail from the loaded image.
    extern fn gexiv2_metadata_erase_exif_thumbnail(p_self: *Metadata) void;
    pub const eraseExifThumbnail = gexiv2_metadata_erase_exif_thumbnail;

    /// Destroys the `gexiv2.Metadata` object and frees all associated memory.
    extern fn gexiv2_metadata_free(p_self: *Metadata) void;
    pub const free = gexiv2_metadata_free;

    /// Load only an EXIF buffer, typically stored in a JPEG's APP1 segment.
    extern fn gexiv2_metadata_from_app1_segment(p_self: *Metadata, p_data: [*]const u8, p_n_data: c_long, p_error: ?*?*glib.Error) c_int;
    pub const fromApp1Segment = gexiv2_metadata_from_app1_segment;

    /// This function does not work and will be removed in a future release.
    extern fn gexiv2_metadata_from_stream(p_self: *Metadata, p_stream: *gio.InputStream, p_error: ?*?*glib.Error) c_int;
    pub const fromStream = gexiv2_metadata_from_stream;

    /// Encode the XMP packet as a `NULL`-terminated string.
    extern fn gexiv2_metadata_generate_xmp_packet(p_self: *Metadata, p_xmp_format_flags: gexiv2.XmpFormatFlags, p_padding: u32) ?[*:0]u8;
    pub const generateXmpPacket = gexiv2_metadata_generate_xmp_packet;

    /// A composite accessor that uses the first available metadata field from a list of well-known
    /// locations to find the photo's comment (or description).
    ///
    /// MWG guidelines refer to these as <emphasis>Description</emphasis>: a textual description of a resource's content.
    ///
    /// These fields are:
    ///
    /// - Exif.Image.ImageDescription  (MWG Guidelines)
    /// - Exif.Photo.UserComment
    /// - Exif.Image.XPComment
    /// - Iptc.Application2.Caption    (MWG Guidelines)
    /// - Xmp.dc.description           (MWG Guidelines)
    /// - Xmp.acdsee.notes             (Commonly requested, read only)
    ///
    /// <note>Note that in the EXIF specification Exif.Image.ImageDescription is
    /// described  as "the title of the image".  Also, it does not support
    /// two-byte character codes for encoding.  However, it's still used here for legacy reasons.
    /// </note>
    ///
    /// For fine-grained control, it's recommended to use Exiv2 tags directly rather than this method,
    /// which is more useful for quick or casual use.
    extern fn gexiv2_metadata_get_comment(p_self: *Metadata) ?[*:0]u8;
    pub const getComment = gexiv2_metadata_get_comment;

    extern fn gexiv2_metadata_get_exif_data(p_self: *Metadata, p_byte_order: gexiv2.ByteOrder, p_error: ?*?*glib.Error) ?*glib.Bytes;
    pub const getExifData = gexiv2_metadata_get_exif_data;

    /// Fetch EXIF `tag` represented by a fraction. `nom` will contain the numerator,
    /// `den` the denominator of the fraction on successful return.
    extern fn gexiv2_metadata_get_exif_tag_rational(p_self: *Metadata, p_tag: [*:0]const u8, p_nom: *c_int, p_den: *c_int) c_int;
    pub const getExifTagRational = gexiv2_metadata_get_exif_tag_rational;

    /// Query `self` for a list of available EXIF tags
    extern fn gexiv2_metadata_get_exif_tags(p_self: *Metadata) [*:null]?[*:0]u8;
    pub const getExifTags = gexiv2_metadata_get_exif_tags;

    /// Get the thumbnail stored in the EXIF data of `self`
    extern fn gexiv2_metadata_get_exif_thumbnail(p_self: *Metadata, p_buffer: *[*]u8, p_size: *c_int) c_int;
    pub const getExifThumbnail = gexiv2_metadata_get_exif_thumbnail;

    /// Returns the exposure time in seconds (shutter speed, <emphasis>not</emphasis> date-time of exposure) as a
    /// rational.  See <ulink url="https://en.wikipedia.org/wiki/Shutter_speed"></ulink> for more information.
    extern fn gexiv2_metadata_get_exposure_time(p_self: *Metadata, p_nom: *c_int, p_den: *c_int) c_int;
    pub const getExposureTime = gexiv2_metadata_get_exposure_time;

    /// See <ulink url="https://en.wikipedia.org/wiki/F-number"></ulink> for more information.
    /// If Exif.Photo.FNumber does not exist, it will fall back to calculating the FNumber from
    /// Exif.Photo.ApertureValue (if available);
    extern fn gexiv2_metadata_get_fnumber(p_self: *Metadata) f64;
    pub const getFnumber = gexiv2_metadata_get_fnumber;

    /// See <ulink url="https://en.wikipedia.org/wiki/Flange_focal_distance"></ulink> for more information.
    extern fn gexiv2_metadata_get_focal_length(p_self: *Metadata) f64;
    pub const getFocalLength = gexiv2_metadata_get_focal_length;

    /// Convenience function to query the altitude stored in the GPS tags of the
    /// image
    extern fn gexiv2_metadata_get_gps_altitude(p_self: *Metadata, p_altitude: *f64) c_int;
    pub const getGpsAltitude = gexiv2_metadata_get_gps_altitude;

    /// Convenience function to query all available GPS information at once.
    extern fn gexiv2_metadata_get_gps_info(p_self: *Metadata, p_longitude: *f64, p_latitude: *f64, p_altitude: *f64) c_int;
    pub const getGpsInfo = gexiv2_metadata_get_gps_info;

    /// Query the latitude stored in the GPS tags of `self`
    extern fn gexiv2_metadata_get_gps_latitude(p_self: *Metadata, p_latitude: *f64) c_int;
    pub const getGpsLatitude = gexiv2_metadata_get_gps_latitude;

    /// Query the longitude stored in the GPS tags of `self`
    extern fn gexiv2_metadata_get_gps_longitude(p_self: *Metadata, p_longitude: *f64) c_int;
    pub const getGpsLongitude = gexiv2_metadata_get_gps_longitude;

    /// Query `self` for a list of available IPTC tags
    extern fn gexiv2_metadata_get_iptc_tags(p_self: *Metadata) [*:null]?[*:0]u8;
    pub const getIptcTags = gexiv2_metadata_get_iptc_tags;

    /// See <ulink url="https://en.wikipedia.org/wiki/Iso_speed"></ulink> for more information.
    extern fn gexiv2_metadata_get_iso_speed(p_self: *Metadata) c_int;
    pub const getIsoSpeed = gexiv2_metadata_get_iso_speed;

    /// Composite accessor to query the pixel with stored in the metadata. This
    /// might differ from the height of image that is available through
    /// `gexiv2.Metadata.getPixelHeight`
    extern fn gexiv2_metadata_get_metadata_pixel_height(p_self: *Metadata) c_int;
    pub const getMetadataPixelHeight = gexiv2_metadata_get_metadata_pixel_height;

    /// Composite accessor to query the pixel with stored in the metadata. This
    /// might differ from the width of image that is available through
    /// `gexiv2.Metadata.getPixelWidth`
    extern fn gexiv2_metadata_get_metadata_pixel_width(p_self: *Metadata) c_int;
    pub const getMetadataPixelWidth = gexiv2_metadata_get_metadata_pixel_width;

    /// Query mime type of currently loaded image.
    extern fn gexiv2_metadata_get_mime_type(p_self: *Metadata) [*:0]const u8;
    pub const getMimeType = gexiv2_metadata_get_mime_type;

    /// The EXIF Orientation field
    extern fn gexiv2_metadata_get_orientation(p_self: *Metadata) gexiv2.Orientation;
    pub const getOrientation = gexiv2_metadata_get_orientation;

    /// Get the <emphasis>actual</emphasis> unoriented display height in pixels of the loaded image.  This may
    /// be different than the height reported by various metadata tags, i.e. "Exif.Photo.PixelYDimension".
    extern fn gexiv2_metadata_get_pixel_height(p_self: *Metadata) c_int;
    pub const getPixelHeight = gexiv2_metadata_get_pixel_height;

    /// Get the <emphasis>actual</emphasis> unoriented display width in pixels of the loaded
    /// image. May be different than the width reported by various metadata tags,
    /// i.e. "Exif.Photo.PixelXDimension".
    extern fn gexiv2_metadata_get_pixel_width(p_self: *Metadata) c_int;
    pub const getPixelWidth = gexiv2_metadata_get_pixel_width;

    extern fn gexiv2_metadata_get_preview_image(p_self: *Metadata, p_props: *gexiv2.PreviewProperties) *gexiv2.PreviewImage;
    pub const getPreviewImage = gexiv2_metadata_get_preview_image;

    /// An image may have stored one or more previews, often of different qualities, sometimes of
    /// different image formats than the containing image.  This call returns the properties of all
    /// previews Exiv2 finds within the loaded image.  Use `gexiv2.Metadata.getPreviewImage` to
    /// load a particular preview into memory.
    extern fn gexiv2_metadata_get_preview_properties(p_self: *Metadata) ?[*]*gexiv2.PreviewProperties;
    pub const getPreviewProperties = gexiv2_metadata_get_preview_properties;

    /// Query `self` whether it supports writing EXIF metadata.
    extern fn gexiv2_metadata_get_supports_exif(p_self: *Metadata) c_int;
    pub const getSupportsExif = gexiv2_metadata_get_supports_exif;

    /// Query `self` whether it supports writing IPTC metadata.
    extern fn gexiv2_metadata_get_supports_iptc(p_self: *Metadata) c_int;
    pub const getSupportsIptc = gexiv2_metadata_get_supports_iptc;

    /// Query `self` whether it supports writing XMP metadata.
    extern fn gexiv2_metadata_get_supports_xmp(p_self: *Metadata) c_int;
    pub const getSupportsXmp = gexiv2_metadata_get_supports_xmp;

    /// An interpreted string is one fit for user display.  It may display units or use formatting
    /// appropriate to the type of data the tag holds.
    ///
    /// Tags that support multiple values are returned as a single string, with elements separated by ", ".
    ///
    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_get_tag_interpreted_string(p_self: *Metadata, p_tag: [*:0]const u8) ?[*:0]u8;
    pub const getTagInterpretedString = gexiv2_metadata_get_tag_interpreted_string;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_get_tag_long(p_self: *Metadata, p_tag: [*:0]const u8) c_long;
    pub const getTagLong = gexiv2_metadata_get_tag_long;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// In case of error, a GLib warning will be logged. Use instead
    /// `gexiv2.Metadata.tryGetTagMultiple` if you want to avoid this and
    /// control if and how the error is outputted.
    extern fn gexiv2_metadata_get_tag_multiple(p_self: *Metadata, p_tag: [*:0]const u8) ?[*:null]?[*:0]u8;
    pub const getTagMultiple = gexiv2_metadata_get_tag_multiple;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// Tags that support multiple values may bereturned as a single byte array, with records separated
    /// by 4x INFORMATION SEPARATOR FOUR (ASCII 0x1c)
    extern fn gexiv2_metadata_get_tag_raw(p_self: *Metadata, p_tag: [*:0]const u8) ?*glib.Bytes;
    pub const getTagRaw = gexiv2_metadata_get_tag_raw;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// Tags that support multiple values are returned as a single string, with elements separated by ", ".
    ///
    /// In case of error, a GLib warning will be logged. Use instead
    /// `gexiv2.Metadata.tryGetTagString` if you want to avoid this and
    /// control if and how the error is outputted.
    extern fn gexiv2_metadata_get_tag_string(p_self: *Metadata, p_tag: [*:0]const u8) ?[*:0]u8;
    pub const getTagString = gexiv2_metadata_get_tag_string;

    extern fn gexiv2_metadata_get_xmp_packet(p_self: *Metadata) ?[*:0]u8;
    pub const getXmpPacket = gexiv2_metadata_get_xmp_packet;

    extern fn gexiv2_metadata_get_xmp_tags(p_self: *Metadata) [*:null]?[*:0]u8;
    pub const getXmpTags = gexiv2_metadata_get_xmp_tags;

    extern fn gexiv2_metadata_has_exif(p_self: *Metadata) c_int;
    pub const hasExif = gexiv2_metadata_has_exif;

    extern fn gexiv2_metadata_has_iptc(p_self: *Metadata) c_int;
    pub const hasIptc = gexiv2_metadata_has_iptc;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_has_tag(p_self: *Metadata, p_tag: [*:0]const u8) c_int;
    pub const hasTag = gexiv2_metadata_has_tag;

    extern fn gexiv2_metadata_has_xmp(p_self: *Metadata) c_int;
    pub const hasXmp = gexiv2_metadata_has_xmp;

    /// The buffer must be an image format supported by Exiv2.
    ///
    /// When called on an already filled meta-data object (i.e. one that has already
    /// been filled by a previous call of `gexiv2.Metadata.openPath`) and the
    /// opening of the new path fails, the object will not revert to its previous
    /// state but be in a similar state after calling `gexiv2.Metadata.new`.
    extern fn gexiv2_metadata_open_buf(p_self: *Metadata, p_data: [*]const u8, p_n_data: c_long, p_error: ?*?*glib.Error) c_int;
    pub const openBuf = gexiv2_metadata_open_buf;

    /// The file must be an image format supported by Exiv2.
    extern fn gexiv2_metadata_open_path(p_self: *Metadata, p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const openPath = gexiv2_metadata_open_path;

    /// The stream must be an image format supported by Exiv2.
    extern fn gexiv2_metadata_open_stream(p_self: *Metadata, p_cb: *anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const openStream = gexiv2_metadata_open_stream;

    /// Saves the metadata to the specified using an XMP sidecar file.
    extern fn gexiv2_metadata_save_external(p_self: *Metadata, p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const saveExternal = gexiv2_metadata_save_external;

    /// Saves the metadata to the specified file by reading the file into memory,copying this object's
    /// metadata into the image, then writing the image back out.
    extern fn gexiv2_metadata_save_file(p_self: *Metadata, p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const saveFile = gexiv2_metadata_save_file;

    /// Saves the metadata to the stream by reading the stream into memory,copying this object's
    /// metadata into the image, then writing the image as a stream back out.
    extern fn gexiv2_metadata_save_stream(p_self: *Metadata, p_cb: *anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const saveStream = gexiv2_metadata_save_stream;

    /// This is a composite setter that will set a number of fields to the supplied value.  See
    /// `gexiv2.Metadata.getComment` for more information.
    extern fn gexiv2_metadata_set_comment(p_self: *Metadata, p_comment: [*:0]const u8) void;
    pub const setComment = gexiv2_metadata_set_comment;

    /// Set EXIF `tag` represented by a fraction, with `nom` being the numerator,
    /// `den` the denominator of the fraction.
    extern fn gexiv2_metadata_set_exif_tag_rational(p_self: *Metadata, p_tag: [*:0]const u8, p_nom: c_int, p_den: c_int) c_int;
    pub const setExifTagRational = gexiv2_metadata_set_exif_tag_rational;

    extern fn gexiv2_metadata_set_exif_thumbnail_from_buffer(p_self: *Metadata, p_buffer: [*]const u8, p_size: c_int) void;
    pub const setExifThumbnailFromBuffer = gexiv2_metadata_set_exif_thumbnail_from_buffer;

    /// Sets or replaces the EXIF thumbnail with the image in the file
    extern fn gexiv2_metadata_set_exif_thumbnail_from_file(p_self: *Metadata, p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const setExifThumbnailFromFile = gexiv2_metadata_set_exif_thumbnail_from_file;

    /// Convenience function to create a new set of simple GPS data. Warning: Will remove any other
    /// GPS information that is currently set. See `gexiv2.Metadata.updateGpsInfo` for
    /// just modifying the GPS data.
    extern fn gexiv2_metadata_set_gps_info(p_self: *Metadata, p_longitude: f64, p_latitude: f64, p_altitude: f64) c_int;
    pub const setGpsInfo = gexiv2_metadata_set_gps_info;

    /// Update the image's metadata with `height`
    extern fn gexiv2_metadata_set_metadata_pixel_height(p_self: *Metadata, p_height: c_int) void;
    pub const setMetadataPixelHeight = gexiv2_metadata_set_metadata_pixel_height;

    /// Composite setter to update the image's metadata with `width`
    extern fn gexiv2_metadata_set_metadata_pixel_width(p_self: *Metadata, p_width: c_int) void;
    pub const setMetadataPixelWidth = gexiv2_metadata_set_metadata_pixel_width;

    /// The orientation must be valid and cannot be `GEXIV2_ORIENTATION_UNSPECIFIED`.
    extern fn gexiv2_metadata_set_orientation(p_self: *Metadata, p_orientation: gexiv2.Orientation) void;
    pub const setOrientation = gexiv2_metadata_set_orientation;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_set_tag_long(p_self: *Metadata, p_tag: [*:0]const u8, p_value: c_long) c_int;
    pub const setTagLong = gexiv2_metadata_set_tag_long;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// All previous `tag` values are erased. For multiple value tags, each of the non `NULL`
    /// entries in `values` is stored. For single value tags, only the last non `NULL` value
    /// is assigned.
    ///
    /// In case of error, a GLib warning will be logged. Use instead
    /// `gexiv2.Metadata.trySetTagMultiple` if you want to avoid this and
    /// control if and how the error is outputted.
    extern fn gexiv2_metadata_set_tag_multiple(p_self: *Metadata, p_tag: [*:0]const u8, p_values: [*][*:0]const u8) c_int;
    pub const setTagMultiple = gexiv2_metadata_set_tag_multiple;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// If a tag supports multiple values, then `value` is added to any existing values. For single
    /// value tags, `value` replaces the value.
    ///
    /// In case of error, a GLib warning will be logged. Use instead
    /// `gexiv2.Metadata.trySetTagString` if you want to avoid this and
    /// control if and how the error is outputted.
    extern fn gexiv2_metadata_set_tag_string(p_self: *Metadata, p_tag: [*:0]const u8, p_value: [*:0]const u8) c_int;
    pub const setTagString = gexiv2_metadata_set_tag_string;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_set_xmp_tag_struct(p_self: *Metadata, p_tag: [*:0]const u8, p_type: gexiv2.StructureType) c_int;
    pub const setXmpTagStruct = gexiv2_metadata_set_xmp_tag_struct;

    /// Removes the Exiv2 tag from the metadata object.
    ///
    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_clear_tag(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const tryClearTag = gexiv2_metadata_try_clear_tag;

    /// Removes all GPS metadata from the loaded image
    extern fn gexiv2_metadata_try_delete_gps_info(p_self: *Metadata, p_error: ?*?*glib.Error) void;
    pub const tryDeleteGpsInfo = gexiv2_metadata_try_delete_gps_info;

    /// Removes the EXIF thumbnail from the loaded image.
    extern fn gexiv2_metadata_try_erase_exif_thumbnail(p_self: *Metadata, p_error: ?*?*glib.Error) void;
    pub const tryEraseExifThumbnail = gexiv2_metadata_try_erase_exif_thumbnail;

    /// Encode the XMP packet as a `NULL`-terminated string.
    extern fn gexiv2_metadata_try_generate_xmp_packet(p_self: *Metadata, p_xmp_format_flags: gexiv2.XmpFormatFlags, p_padding: u32, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const tryGenerateXmpPacket = gexiv2_metadata_try_generate_xmp_packet;

    /// A composite accessor that uses the first available metadata field from a list of well-known
    /// locations to find the photo's comment (or description).
    ///
    /// MWG guidelines refer to these as <emphasis>Description</emphasis>: a textual description of a resource's content.
    ///
    /// These fields are:
    ///
    /// - Exif.Image.ImageDescription  (MWG Guidelines)
    /// - Exif.Photo.UserComment
    /// - Exif.Image.XPComment
    /// - Iptc.Application2.Caption    (MWG Guidelines)
    /// - Xmp.dc.description           (MWG Guidelines)
    /// - Xmp.acdsee.notes             (Commonly requested, read only)
    ///
    /// <note>Note that in the EXIF specification Exif.Image.ImageDescription is
    /// described  as "the title of the image".  Also, it does not support
    /// two-byte character codes for encoding.  However, it's still used here for legacy reasons.
    /// </note>
    ///
    /// For fine-grained control, it's recommended to use Exiv2 tags directly rather than this method,
    /// which is more useful for quick or casual use.
    extern fn gexiv2_metadata_try_get_comment(p_self: *Metadata, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const tryGetComment = gexiv2_metadata_try_get_comment;

    /// Fetch EXIF `tag` represented by a fraction. `nom` will contain the numerator,
    /// `den` the denominator of the fraction on successful return.
    extern fn gexiv2_metadata_try_get_exif_tag_rational(p_self: *Metadata, p_tag: [*:0]const u8, p_nom: *c_int, p_den: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const tryGetExifTagRational = gexiv2_metadata_try_get_exif_tag_rational;

    /// Returns the exposure time in seconds (shutter speed, <emphasis>not</emphasis> date-time of exposure) as a
    /// rational.  See <ulink url="https://en.wikipedia.org/wiki/Shutter_speed"></ulink> for more information.
    extern fn gexiv2_metadata_try_get_exposure_time(p_self: *Metadata, p_nom: *c_int, p_den: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const tryGetExposureTime = gexiv2_metadata_try_get_exposure_time;

    /// See <ulink url="https://en.wikipedia.org/wiki/F-number"></ulink> for more information.
    /// If Exif.Photo.FNumber does not exist, it will fall back to calculating the FNumber from
    /// Exif.Photo.ApertureValue (if available);
    extern fn gexiv2_metadata_try_get_fnumber(p_self: *Metadata, p_error: ?*?*glib.Error) f64;
    pub const tryGetFnumber = gexiv2_metadata_try_get_fnumber;

    /// See <ulink url="https://en.wikipedia.org/wiki/Flange_focal_distance"></ulink> for more information.
    extern fn gexiv2_metadata_try_get_focal_length(p_self: *Metadata, p_error: ?*?*glib.Error) f64;
    pub const tryGetFocalLength = gexiv2_metadata_try_get_focal_length;

    /// Convenience function to query the altitude stored in the GPS tags of the
    /// image
    extern fn gexiv2_metadata_try_get_gps_altitude(p_self: *Metadata, p_altitude: *f64, p_error: ?*?*glib.Error) c_int;
    pub const tryGetGpsAltitude = gexiv2_metadata_try_get_gps_altitude;

    /// Convenience function to query all available GPS information at once.
    extern fn gexiv2_metadata_try_get_gps_info(p_self: *Metadata, p_longitude: *f64, p_latitude: *f64, p_altitude: *f64, p_error: ?*?*glib.Error) c_int;
    pub const tryGetGpsInfo = gexiv2_metadata_try_get_gps_info;

    /// Query the latitude stored in the GPS tags of `self`
    extern fn gexiv2_metadata_try_get_gps_latitude(p_self: *Metadata, p_latitude: *f64, p_error: ?*?*glib.Error) c_int;
    pub const tryGetGpsLatitude = gexiv2_metadata_try_get_gps_latitude;

    /// Query the longitude stored in the GPS tags of `self`
    extern fn gexiv2_metadata_try_get_gps_longitude(p_self: *Metadata, p_longitude: *f64, p_error: ?*?*glib.Error) c_int;
    pub const tryGetGpsLongitude = gexiv2_metadata_try_get_gps_longitude;

    /// See <ulink url="https://en.wikipedia.org/wiki/Iso_speed"></ulink> for more information.
    extern fn gexiv2_metadata_try_get_iso_speed(p_self: *Metadata, p_error: ?*?*glib.Error) c_int;
    pub const tryGetIsoSpeed = gexiv2_metadata_try_get_iso_speed;

    /// Composite accessor to query the pixel with stored in the metadata. This
    /// might differ from the height of image that is available through
    /// `gexiv2.Metadata.getPixelHeight`
    extern fn gexiv2_metadata_try_get_metadata_pixel_height(p_self: *Metadata, p_error: ?*?*glib.Error) c_int;
    pub const tryGetMetadataPixelHeight = gexiv2_metadata_try_get_metadata_pixel_height;

    /// Composite accessor to query the pixel with stored in the metadata. This
    /// might differ from the width of image that is available through
    /// `gexiv2.Metadata.getPixelWidth`
    extern fn gexiv2_metadata_try_get_metadata_pixel_width(p_self: *Metadata, p_error: ?*?*glib.Error) c_int;
    pub const tryGetMetadataPixelWidth = gexiv2_metadata_try_get_metadata_pixel_width;

    /// The EXIF Orientation field
    extern fn gexiv2_metadata_try_get_orientation(p_self: *Metadata, p_error: ?*?*glib.Error) gexiv2.Orientation;
    pub const tryGetOrientation = gexiv2_metadata_try_get_orientation;

    extern fn gexiv2_metadata_try_get_preview_image(p_self: *Metadata, p_props: *gexiv2.PreviewProperties, p_error: ?*?*glib.Error) ?*gexiv2.PreviewImage;
    pub const tryGetPreviewImage = gexiv2_metadata_try_get_preview_image;

    /// An interpreted string is one fit for user display.  It may display units or use formatting
    /// appropriate to the type of data the tag holds.
    ///
    /// Tags that support multiple values are returned as a single string, with elements separated by ", ".
    ///
    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_get_tag_interpreted_string(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const tryGetTagInterpretedString = gexiv2_metadata_try_get_tag_interpreted_string;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_get_tag_long(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) c_long;
    pub const tryGetTagLong = gexiv2_metadata_try_get_tag_long;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_get_tag_multiple(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:null]?[*:0]u8;
    pub const tryGetTagMultiple = gexiv2_metadata_try_get_tag_multiple;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// Tags that support multiple values may be returned as a single byte array, with records separated
    /// by 4x INFORMATION SEPARATOR FOUR (ASCII 0x1c)
    extern fn gexiv2_metadata_try_get_tag_raw(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?*glib.Bytes;
    pub const tryGetTagRaw = gexiv2_metadata_try_get_tag_raw;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// Tags that support multiple values are returned as a single string, with elements separated by ", ".
    extern fn gexiv2_metadata_try_get_tag_string(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const tryGetTagString = gexiv2_metadata_try_get_tag_string;

    extern fn gexiv2_metadata_try_get_xmp_packet(p_self: *Metadata, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const tryGetXmpPacket = gexiv2_metadata_try_get_xmp_packet;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_has_tag(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const tryHasTag = gexiv2_metadata_try_has_tag;

    /// This is a composite setter that will set a number of fields to the supplied value.  See
    /// `gexiv2.Metadata.getComment` for more information.
    extern fn gexiv2_metadata_try_set_comment(p_self: *Metadata, p_comment: [*:0]const u8, p_error: ?*?*glib.Error) void;
    pub const trySetComment = gexiv2_metadata_try_set_comment;

    /// Set EXIF `tag` represented by a fraction, with `nom` being the numerator,
    /// `den` the denominator of the fraction.
    extern fn gexiv2_metadata_try_set_exif_tag_rational(p_self: *Metadata, p_tag: [*:0]const u8, p_nom: c_int, p_den: c_int, p_error: ?*?*glib.Error) c_int;
    pub const trySetExifTagRational = gexiv2_metadata_try_set_exif_tag_rational;

    extern fn gexiv2_metadata_try_set_exif_thumbnail_from_buffer(p_self: *Metadata, p_buffer: [*]const u8, p_size: c_int, p_error: ?*?*glib.Error) void;
    pub const trySetExifThumbnailFromBuffer = gexiv2_metadata_try_set_exif_thumbnail_from_buffer;

    /// Convenience function to create a new set of simple GPS data. Warning: Will remove any other
    /// GPS information that is currently set. See `gexiv2.Metadata.updateGpsInfo` for
    /// just modifying the GPS data.
    extern fn gexiv2_metadata_try_set_gps_info(p_self: *Metadata, p_longitude: f64, p_latitude: f64, p_altitude: f64, p_error: ?*?*glib.Error) c_int;
    pub const trySetGpsInfo = gexiv2_metadata_try_set_gps_info;

    /// Update the image's metadata with `height`
    extern fn gexiv2_metadata_try_set_metadata_pixel_height(p_self: *Metadata, p_height: c_int, p_error: ?*?*glib.Error) void;
    pub const trySetMetadataPixelHeight = gexiv2_metadata_try_set_metadata_pixel_height;

    /// Composite setter to update the image's metadata with `width`
    extern fn gexiv2_metadata_try_set_metadata_pixel_width(p_self: *Metadata, p_width: c_int, p_error: ?*?*glib.Error) void;
    pub const trySetMetadataPixelWidth = gexiv2_metadata_try_set_metadata_pixel_width;

    /// The orientation must be valid and cannot be `GEXIV2_ORIENTATION_UNSPECIFIED`.
    extern fn gexiv2_metadata_try_set_orientation(p_self: *Metadata, p_orientation: gexiv2.Orientation, p_error: ?*?*glib.Error) void;
    pub const trySetOrientation = gexiv2_metadata_try_set_orientation;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_set_tag_long(p_self: *Metadata, p_tag: [*:0]const u8, p_value: c_long, p_error: ?*?*glib.Error) c_int;
    pub const trySetTagLong = gexiv2_metadata_try_set_tag_long;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    ///
    /// All previous `tag` values are erased. For multiple value tags, each of the non `NULL`
    /// entries in `values` is stored. For single value tags, only the last non `NULL` value
    /// is assigned.
    extern fn gexiv2_metadata_try_set_tag_multiple(p_self: *Metadata, p_tag: [*:0]const u8, p_values: [*][*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const trySetTagMultiple = gexiv2_metadata_try_set_tag_multiple;

    /// If a tag supports multiple values, then `value` is added to any existing values. For single
    /// tags, `value` replaces the value.
    ///
    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_set_tag_string(p_self: *Metadata, p_tag: [*:0]const u8, p_value: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const trySetTagString = gexiv2_metadata_try_set_tag_string;

    /// The Exiv2 Tag Reference can be found at <ulink url="http://exiv2.org/metadata.html"></ulink>
    extern fn gexiv2_metadata_try_set_xmp_tag_struct(p_self: *Metadata, p_tag: [*:0]const u8, p_type: gexiv2.StructureType, p_error: ?*?*glib.Error) c_int;
    pub const trySetXmpTagStruct = gexiv2_metadata_try_set_xmp_tag_struct;

    /// The Exiv2 Tag Reference can be found at <ulink url="https://www.exiv2.org/metadata.html"></ulink>
    ///
    /// Multiple value tags are Xmp tags of type "XmpAlt", "XmpBag", "XmpSeq" or "LangAlt", or Iptc
    /// tags marked as Repeatable (which can be of any Iptc type). There are no multiple value Exif
    /// tags.
    extern fn gexiv2_metadata_try_tag_supports_multiple_values(p_self: *Metadata, p_tag: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const tryTagSupportsMultipleValues = gexiv2_metadata_try_tag_supports_multiple_values;

    /// Convenience function to update longitude, latitude and altitude at once.
    extern fn gexiv2_metadata_try_update_gps_info(p_self: *Metadata, p_longitude: f64, p_latitude: f64, p_altitude: f64, p_error: ?*?*glib.Error) c_int;
    pub const tryUpdateGpsInfo = gexiv2_metadata_try_update_gps_info;

    /// Convenience function to update longitude, latitude and altitude at once.
    extern fn gexiv2_metadata_update_gps_info(p_self: *Metadata, p_longitude: f64, p_latitude: f64, p_altitude: f64) c_int;
    pub const updateGpsInfo = gexiv2_metadata_update_gps_info;

    extern fn gexiv2_metadata_get_type() usize;
    pub const getGObjectType = gexiv2_metadata_get_type;

    extern fn g_object_ref(p_self: *gexiv2.Metadata) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gexiv2.Metadata) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Metadata, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewImage = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gexiv2.PreviewImageClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*gexiv2.PreviewImagePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Releases the preview image and all associated memory.
    extern fn gexiv2_preview_image_free(p_self: *PreviewImage) void;
    pub const free = gexiv2_preview_image_free;

    extern fn gexiv2_preview_image_get_data(p_self: *PreviewImage, p_size: *u32) [*]const u8;
    pub const getData = gexiv2_preview_image_get_data;

    extern fn gexiv2_preview_image_get_extension(p_self: *PreviewImage) [*:0]const u8;
    pub const getExtension = gexiv2_preview_image_get_extension;

    extern fn gexiv2_preview_image_get_height(p_self: *PreviewImage) u32;
    pub const getHeight = gexiv2_preview_image_get_height;

    extern fn gexiv2_preview_image_get_mime_type(p_self: *PreviewImage) [*:0]const u8;
    pub const getMimeType = gexiv2_preview_image_get_mime_type;

    extern fn gexiv2_preview_image_get_width(p_self: *PreviewImage) u32;
    pub const getWidth = gexiv2_preview_image_get_width;

    extern fn gexiv2_preview_image_try_write_file(p_self: *PreviewImage, p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_long;
    pub const tryWriteFile = gexiv2_preview_image_try_write_file;

    extern fn gexiv2_preview_image_write_file(p_self: *PreviewImage, p_path: [*:0]const u8) c_long;
    pub const writeFile = gexiv2_preview_image_write_file;

    extern fn gexiv2_preview_image_get_type() usize;
    pub const getGObjectType = gexiv2_preview_image_get_type;

    extern fn g_object_ref(p_self: *gexiv2.PreviewImage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gexiv2.PreviewImage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreviewImage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewProperties = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gexiv2.PreviewPropertiesClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*gexiv2.PreviewPropertiesPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gexiv2_preview_properties_get_extension(p_self: *PreviewProperties) [*:0]const u8;
    pub const getExtension = gexiv2_preview_properties_get_extension;

    extern fn gexiv2_preview_properties_get_height(p_self: *PreviewProperties) u32;
    pub const getHeight = gexiv2_preview_properties_get_height;

    extern fn gexiv2_preview_properties_get_mime_type(p_self: *PreviewProperties) [*:0]const u8;
    pub const getMimeType = gexiv2_preview_properties_get_mime_type;

    extern fn gexiv2_preview_properties_get_size(p_self: *PreviewProperties) u32;
    pub const getSize = gexiv2_preview_properties_get_size;

    extern fn gexiv2_preview_properties_get_width(p_self: *PreviewProperties) u32;
    pub const getWidth = gexiv2_preview_properties_get_width;

    extern fn gexiv2_preview_properties_get_type() usize;
    pub const getGObjectType = gexiv2_preview_properties_get_type;

    extern fn g_object_ref(p_self: *gexiv2.PreviewProperties) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gexiv2.PreviewProperties) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreviewProperties, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MetadataClass = extern struct {
    pub const Instance = gexiv2.Metadata;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MetadataClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MetadataPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewImageClass = extern struct {
    pub const Instance = gexiv2.PreviewImage;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PreviewImageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewImagePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewPropertiesClass = extern struct {
    pub const Instance = gexiv2.PreviewProperties;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PreviewPropertiesClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewPropertiesPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options to control the byte order of binary EXIF data exports
pub const ByteOrder = enum(c_int) {
    little = 0,
    big = 1,
    _,

    extern fn gexiv2_gexiv2_byte_order_get_type() usize;
    pub const getGObjectType = gexiv2_gexiv2_byte_order_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// GExiv2 log levels
pub const LogLevel = enum(c_int) {
    debug = 0,
    info = 1,
    warn = 2,
    @"error" = 3,
    mute = 4,
    _,

    extern fn gexiv2_gexiv2_log_level_get_type() usize;
    pub const getGObjectType = gexiv2_gexiv2_log_level_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The orientation of an image is defined as the location of it's x,y origin.  More than rotation,
/// orientation allows for every variation of rotation, flips, and mirroring to be described in
/// 3 bits of data.
///
/// A handy primer to orientation can be found at
/// <ulink url="http://jpegclub.org/exif_orientation.html"></ulink>
pub const Orientation = enum(c_int) {
    unspecified = 0,
    normal = 1,
    hflip = 2,
    rot_180 = 3,
    vflip = 4,
    rot_90_hflip = 5,
    rot_90 = 6,
    rot_90_vflip = 7,
    rot_270 = 8,
    _,

    extern fn gexiv2_gexiv2_orientation_get_type() usize;
    pub const getGObjectType = gexiv2_gexiv2_orientation_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used in `gexiv2.Metadata.setXmpTagStruct` to determine the array type
pub const StructureType = enum(c_int) {
    none = 0,
    alt = 20,
    bag = 21,
    seq = 22,
    lang = 23,
    _,

    extern fn gexiv2_gexiv2_structure_type_get_type() usize;
    pub const getGObjectType = gexiv2_gexiv2_structure_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options to control the format of the serialized XMP packet
/// Taken from: exiv2/src/xmp.hpp
pub const XmpFormatFlags = packed struct(c_uint) {
    _padding0: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    omit_packet_wrapper: bool = false,
    read_only_packet: bool = false,
    use_compact_format: bool = false,
    _padding7: bool = false,
    include_thumbnail_pad: bool = false,
    exact_packet_length: bool = false,
    write_alias_comments: bool = false,
    omit_all_formatting: bool = false,
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

    pub const flags_omit_packet_wrapper: XmpFormatFlags = @bitCast(@as(c_uint, 16));
    pub const flags_read_only_packet: XmpFormatFlags = @bitCast(@as(c_uint, 32));
    pub const flags_use_compact_format: XmpFormatFlags = @bitCast(@as(c_uint, 64));
    pub const flags_include_thumbnail_pad: XmpFormatFlags = @bitCast(@as(c_uint, 256));
    pub const flags_exact_packet_length: XmpFormatFlags = @bitCast(@as(c_uint, 512));
    pub const flags_write_alias_comments: XmpFormatFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_omit_all_formatting: XmpFormatFlags = @bitCast(@as(c_uint, 2048));
    extern fn gexiv2_gexiv2_xmp_format_flags_get_type() usize;
    pub const getGObjectType = gexiv2_gexiv2_xmp_format_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn gexiv2_get_version() c_int;
pub const getVersion = gexiv2_get_version;

/// gexiv2 requires initialization before its methods are used.  In particular, this call must be
/// made in a thread-safe fashion.  Best practice is to call from the application's main thread and
/// not to use any Gexiv2 code until it has returned.
extern fn gexiv2_initialize() c_int;
pub const initialize = gexiv2_initialize;

extern fn gexiv2_log_get_default_handler() gexiv2.LogHandler;
pub const logGetDefaultHandler = gexiv2_log_get_default_handler;

extern fn gexiv2_log_get_handler() gexiv2.LogHandler;
pub const logGetHandler = gexiv2_log_get_handler;

extern fn gexiv2_log_get_level() gexiv2.LogLevel;
pub const logGetLevel = gexiv2_log_get_level;

/// This method is not thread-safe.  It's best to set this before beginning to use gexiv2.
extern fn gexiv2_log_set_handler(p_handler: gexiv2.LogHandler) void;
pub const logSetHandler = gexiv2_log_set_handler;

/// Log messages below this level will not be logged.
extern fn gexiv2_log_set_level(p_level: gexiv2.LogLevel) void;
pub const logSetLevel = gexiv2_log_set_level;

/// When called, gexiv2 will install it's own `gexiv2.LogHandler` which redirects all Exiv2 and gexiv2
/// log messages to GLib's logging calls (`g_debug`, `g_message`, `g_warning`, and `g_critical` for the
/// respective `gexiv2.LogLevel` value).  `GEXIV2_LOG_LEVEL_MUTE` logs are dropped.
///
/// One advantage to using this is that GLib's logging control and handlers can be used rather than
/// GExiv2's ad hoc scheme.  It also means an application can use GLib logging and have all its
/// messages routed through the same calls.
extern fn gexiv2_log_use_glib_logging() void;
pub const logUseGlibLogging = gexiv2_log_use_glib_logging;

/// The log handler can be set by `gexiv2.logSetHandler`.  When set, the log handler will receive
/// all log messages emitted by Exiv2 and gexiv2.  It's up to the handler to decide where (and if)
/// the images are displayed or stored.
pub const LogHandler = *const fn (p_level: gexiv2.LogLevel, p_msg: [*:0]const u8) callconv(.c) void;

pub const MAJOR_VERSION = 0;
pub const MICRO_VERSION = 6;
pub const MINOR_VERSION = 14;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
