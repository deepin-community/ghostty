pub const ext = @import("ext.zig");
const nautilus = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// List view column descriptor object.
///
/// `NautilusColumn` is an object that describes a column in the file manager
/// list view. Extensions can provide `NautilusColumn` by registering a
/// `ColumnProvider` and returning them from
/// `ColumnProvider.getColumns`, which will be called by the main
/// application when creating a view.
pub const Column = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = nautilus.ColumnClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The file attribute to be displayed in the column.
        pub const attribute = struct {
            pub const name = "attribute";

            pub const Type = ?[*:0]u8;
        };

        pub const attribute_q = struct {
            pub const name = "attribute-q";

            pub const Type = c_uint;
        };

        /// The enum values of GtkSortType
        ///
        /// Uses enum because we don't want extensions to depend on Gtk. This property
        /// is not meant to be used by extensions.
        pub const default_sort_order = struct {
            pub const name = "default-sort-order";

            pub const Type = c_int;
        };

        /// The user-visible description of the column.
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// The label to display in the column.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// The identifier for the column.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether to show the NautilusColumn in a ColumnChooser.
        ///
        /// This is not meant to be used by extensions. The value may be changed
        /// over the life of the NautilusColumn.
        pub const visible = struct {
            pub const name = "visible";

            pub const Type = c_int;
        };

        /// The x-alignment of the column.
        pub const xalign = struct {
            pub const name = "xalign";

            pub const Type = f32;
        };
    };

    pub const signals = struct {};

    /// Creates a new `Column` object.
    extern fn nautilus_column_new(p_name: [*:0]const u8, p_attribute: [*:0]const u8, p_label: [*:0]const u8, p_description: [*:0]const u8) *nautilus.Column;
    pub const new = nautilus_column_new;

    extern fn nautilus_column_get_type() usize;
    pub const getGObjectType = nautilus_column_get_type;

    extern fn g_object_ref(p_self: *nautilus.Column) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.Column) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Column, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A submenu linked to a `NautilusMenuItem`.
///
/// `NautilusMenu` is an object that describes a submenu in a file manager
/// menu. Extensions can provide `NautilusMenu` objects by attaching them to
/// `NautilusMenuItem` objects, using `NautilusMenuItem.setSubmenu`.
pub const Menu = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = nautilus.MenuClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `NautilusMenu`
    extern fn nautilus_menu_new() *nautilus.Menu;
    pub const new = nautilus_menu_new;

    /// Append a `NautilusMenuItem` to the current `NautilusMenu`.
    extern fn nautilus_menu_append_item(p_menu: *Menu, p_item: *nautilus.MenuItem) void;
    pub const appendItem = nautilus_menu_append_item;

    /// Get a list of `NautilusMenuItem` for the current `NautilusMenu`.
    extern fn nautilus_menu_get_items(p_menu: *Menu) ?*glib.List;
    pub const getItems = nautilus_menu_get_items;

    extern fn nautilus_menu_get_type() usize;
    pub const getGObjectType = nautilus_menu_get_type;

    extern fn g_object_ref(p_self: *nautilus.Menu) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.Menu) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Menu, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An individual item with a Nautilus context menu.
///
/// `NautilusMenuItem` is an object that describes an item in a file manager
/// menu. Extensions can provide `NautilusMenuItem` objects by registering a
/// `NautilusMenuProvider` and returning them from
/// `NautilusMenuProvider.getFileItems`, or
/// `NautilusMenuProvider.getBackgroundItems`, which will be called by the
/// main application when creating menus.
pub const MenuItem = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = nautilus.MenuItemClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Emits `nautilus.MenuItem.signals.activate`.
        pub const activate = struct {
            pub fn call(p_class: anytype, p_item: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(MenuItem.Class, p_class).f_activate.?(gobject.ext.as(MenuItem, p_item));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_item: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(MenuItem.Class, p_class).f_activate = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// This property has no effect.
        pub const icon = struct {
            pub const name = "icon";

            pub const Type = ?[*:0]u8;
        };

        /// A user visible string describing the `NautilusMenuItem`.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// A submenu for the current `NautilusMenuItem`.
        pub const menu = struct {
            pub const name = "menu";

            pub const Type = ?*nautilus.Menu;
        };

        /// A unique identifier for the `NautilusMenuItem`.  This is not user visible.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// This property has no effect.
        pub const priority = struct {
            pub const name = "priority";

            pub const Type = c_int;
        };

        /// Whether the `NautilusMenuItem` should be sensitive (i.e. clickable).
        pub const sensitive = struct {
            pub const name = "sensitive";

            pub const Type = c_int;
        };

        /// This property has no effect.
        pub const tip = struct {
            pub const name = "tip";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Signals that the user has activated this menu item.
        pub const activate = struct {
            pub const name = "activate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MenuItem, p_instance))),
                    gobject.signalLookup("activate", MenuItem.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Deep frees a list of `NautilusMenuItem`.
    extern fn nautilus_menu_item_list_free(p_item_list: *glib.List) void;
    pub const listFree = nautilus_menu_item_list_free;

    /// Creates a new menu item that can be added to the toolbar or to a contextual menu.
    extern fn nautilus_menu_item_new(p_name: [*:0]const u8, p_label: [*:0]const u8, p_tip: ?[*:0]const u8, p_icon: ?[*:0]const u8) *nautilus.MenuItem;
    pub const new = nautilus_menu_item_new;

    /// Emits `nautilus.MenuItem.signals.activate`.
    extern fn nautilus_menu_item_activate(p_item: *MenuItem) void;
    pub const activate = nautilus_menu_item_activate;

    /// Attaches a menu to the given `nautilus.MenuItem`.
    extern fn nautilus_menu_item_set_submenu(p_item: *MenuItem, p_menu: *nautilus.Menu) void;
    pub const setSubmenu = nautilus_menu_item_set_submenu;

    extern fn nautilus_menu_item_get_type() usize;
    pub const getGObjectType = nautilus_menu_item_get_type;

    extern fn g_object_ref(p_self: *nautilus.MenuItem) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.MenuItem) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MenuItem, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A single element in a file's properties.
///
/// A file's properties will consist of one or more `NautilusPropertiesItem`.
/// Each item is a name/value pair.  Items are added to their corresponding
/// `NautilusPropertiesModel.properties.model`.
pub const PropertiesItem = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = nautilus.PropertiesItemClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The user-visible name.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// The user-visible value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Create a new `NautilusPropertiesItem`
    extern fn nautilus_properties_item_new(p_name: [*:0]const u8, p_value: [*:0]const u8) *nautilus.PropertiesItem;
    pub const new = nautilus_properties_item_new;

    /// Get the name.
    extern fn nautilus_properties_item_get_name(p_self: *PropertiesItem) [*:0]const u8;
    pub const getName = nautilus_properties_item_get_name;

    /// Get the value.
    extern fn nautilus_properties_item_get_value(p_self: *PropertiesItem) [*:0]const u8;
    pub const getValue = nautilus_properties_item_get_value;

    extern fn nautilus_properties_item_get_type() usize;
    pub const getGObjectType = nautilus_properties_item_get_type;

    extern fn g_object_ref(p_self: *nautilus.PropertiesItem) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.PropertiesItem) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PropertiesItem, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A model to implement custom file Properties.
///
/// `NautilusPropertiesModel` is an model that describes a set of file properties.
/// Extensions can provide `NautilusPropertiesModel` objects by registering a
/// `PropertiesModelProvider` and returning them from
/// `PropertiesModelProvider.getModels`, which will be called by
/// the main application when creating file properties.
pub const PropertiesModel = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = nautilus.PropertiesModelClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The item model.
        pub const model = struct {
            pub const name = "model";

            pub const Type = ?*gio.ListModel;
        };

        /// The user visible title
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Create a new `NautilusPropertiesModel`.
    extern fn nautilus_properties_model_new(p_title: [*:0]const u8, p_model: *gio.ListModel) *nautilus.PropertiesModel;
    pub const new = nautilus_properties_model_new;

    /// Gets the properties items provided by this model.
    extern fn nautilus_properties_model_get_model(p_self: *PropertiesModel) *gio.ListModel;
    pub const getModel = nautilus_properties_model_get_model;

    /// Get the user-visible title.
    extern fn nautilus_properties_model_get_title(p_self: *PropertiesModel) [*:0]const u8;
    pub const getTitle = nautilus_properties_model_get_title;

    /// Set a user-visible name for the set of properties in this model.
    ///
    /// It should work both as a window title and as a boxed list row.
    /// Exactly where it is shown in the UI may vary in the future.
    extern fn nautilus_properties_model_set_title(p_self: *PropertiesModel, p_title: [*:0]const u8) void;
    pub const setTitle = nautilus_properties_model_set_title;

    extern fn nautilus_properties_model_get_type() usize;
    pub const getGObjectType = nautilus_properties_model_get_type;

    extern fn g_object_ref(p_self: *nautilus.PropertiesModel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.PropertiesModel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PropertiesModel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interface to provide additional list view columns
///
/// Allows extension to provide additional columns in the file manager list view.
pub const ColumnProvider = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = nautilus.ColumnProviderInterface;
    pub const virtual_methods = struct {
        /// Provide a list of `Column`.
        ///
        /// The `NautilusColumnProvider` only provides the metadata of the columns
        /// (importantly the `Column.properties.attribute`).  You will very likely also
        /// implement `InfoProvider` in order to call `FileInfo.addStringAttribute`
        /// on all necessary files.
        ///
        /// This method should return immediately without any blocking i/o.
        pub const get_columns = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*glib.List {
                return gobject.ext.as(ColumnProvider.Iface, p_class).f_get_columns.?(gobject.ext.as(ColumnProvider, p_provider));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*glib.List) void {
                gobject.ext.as(ColumnProvider.Iface, p_class).f_get_columns = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Provide a list of `Column`.
    ///
    /// The `NautilusColumnProvider` only provides the metadata of the columns
    /// (importantly the `Column.properties.attribute`).  You will very likely also
    /// implement `InfoProvider` in order to call `FileInfo.addStringAttribute`
    /// on all necessary files.
    ///
    /// This method should return immediately without any blocking i/o.
    extern fn nautilus_column_provider_get_columns(p_provider: *ColumnProvider) ?*glib.List;
    pub const getColumns = nautilus_column_provider_get_columns;

    extern fn nautilus_column_provider_get_type() usize;
    pub const getGObjectType = nautilus_column_provider_get_type;

    extern fn g_object_ref(p_self: *nautilus.ColumnProvider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.ColumnProvider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColumnProvider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// File interface for nautilus extensions.
///
/// `NautilusFileInfo` provides methods to get and modify information
/// about file objects in the file manager.
pub const FileInfo = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = nautilus.FileInfoInterface;
    pub const virtual_methods = struct {
        /// Add an emblem.
        pub const add_emblem = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_emblem_name: [*:0]const u8) void {
                return gobject.ext.as(FileInfo.Iface, p_class).f_add_emblem.?(gobject.ext.as(FileInfo, p_file_info), p_emblem_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_emblem_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_add_emblem = @ptrCast(p_implementation);
            }
        };

        /// Set's the attributes value or replacing the existing value (if one exists).
        ///
        /// This function is necessary to set the value of the `NautilusFileInfo`'s
        /// correspond attribute for a `Column.properties.attribute`.
        pub const add_string_attribute = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8, p_value: [*:0]const u8) void {
                return gobject.ext.as(FileInfo.Iface, p_class).f_add_string_attribute.?(gobject.ext.as(FileInfo, p_file_info), p_attribute_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_add_string_attribute = @ptrCast(p_implementation);
            }
        };

        /// Gets whether the `NautilusFileInfo` is writeable.
        pub const can_write = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(FileInfo.Iface, p_class).f_can_write.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_can_write = @ptrCast(p_implementation);
            }
        };

        /// Gets the activation uri.
        ///
        /// The activation uri may differ from the actual URI if e.g. the file is a .desktop
        /// file or a Nautilus XML link file.
        pub const get_activation_uri = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_activation_uri.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_activation_uri = @ptrCast(p_implementation);
            }
        };

        /// Get the cached `gio.FileType`.
        pub const get_file_type = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) gio.FileType {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_file_type.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) gio.FileType) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_file_type = @ptrCast(p_implementation);
            }
        };

        /// Get the corresponding `gio.File`
        pub const get_location = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gio.File {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_location.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gio.File) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_location = @ptrCast(p_implementation);
            }
        };

        /// Get the cached mime_type.
        pub const get_mime_type = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_mime_type.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_mime_type = @ptrCast(p_implementation);
            }
        };

        /// Gets the cached mount.
        ///
        /// This only returns the `gio.Mount` if Nautilus has already cached it.
        /// The return value may be `NULL` even if the `NautilusFileInfo` has a corresponding
        /// mount in which case you can call `gio.File.findEnclosingMountAsync`.
        pub const get_mount = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*gio.Mount {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_mount.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*gio.Mount) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_mount = @ptrCast(p_implementation);
            }
        };

        /// Gets the name.
        pub const get_name = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_name.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_name = @ptrCast(p_implementation);
            }
        };

        /// Get the parent `NautilusFileInfo`.
        ///
        /// It's not safe to call this recursively multiple times, as it works
        /// only for files already cached by Nautilus.
        pub const get_parent_info = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*nautilus.FileInfo {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_parent_info.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*nautilus.FileInfo) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_parent_info = @ptrCast(p_implementation);
            }
        };

        /// Gets the parent location.
        pub const get_parent_location = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*gio.File {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_parent_location.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*gio.File) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_parent_location = @ptrCast(p_implementation);
            }
        };

        /// Get the parent `NautilusFileInfo` uri.
        pub const get_parent_uri = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_parent_uri.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_parent_uri = @ptrCast(p_implementation);
            }
        };

        /// Get the attribute's value.
        pub const get_string_attribute = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8) ?[*:0]u8 {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_string_attribute.?(gobject.ext.as(FileInfo, p_file_info), p_attribute_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_string_attribute = @ptrCast(p_implementation);
            }
        };

        /// Gets the URI.
        pub const get_uri = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_uri.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_uri = @ptrCast(p_implementation);
            }
        };

        /// Get the uri scheme.
        pub const get_uri_scheme = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(FileInfo.Iface, p_class).f_get_uri_scheme.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_get_uri_scheme = @ptrCast(p_implementation);
            }
        };

        /// Invalidate the current extension information.
        ///
        /// This removes any information, such as emblems or or string attributes, that
        /// were added to the `NautilusFileInfo` from any extension.
        pub const invalidate_extension_info = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(FileInfo.Iface, p_class).f_invalidate_extension_info.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_invalidate_extension_info = @ptrCast(p_implementation);
            }
        };

        /// Gets whether the `NautilusFileInfo` is a directory.
        ///
        /// Uses the cached `gio.FileType` matches `G_FILE_TYPE_DIRECTORY` without
        /// doing any blocking i/o.
        pub const is_directory = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(FileInfo.Iface, p_class).f_is_directory.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_is_directory = @ptrCast(p_implementation);
            }
        };

        /// Get whether a `NautilusFileInfo` is gone.
        pub const is_gone = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(FileInfo.Iface, p_class).f_is_gone.?(gobject.ext.as(FileInfo, p_file_info));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_is_gone = @ptrCast(p_implementation);
            }
        };

        /// Gets whether the mime_type of the `NautilusFileInfo` matches the given type.
        pub const is_mime_type = struct {
            pub fn call(p_class: anytype, p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) c_int {
                return gobject.ext.as(FileInfo.Iface, p_class).f_is_mime_type.?(gobject.ext.as(FileInfo, p_file_info), p_mime_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_file_info: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(FileInfo.Iface, p_class).f_is_mime_type = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Get an existing `NautilusFileInfo` (if it exists) or create a new one is it
    /// does not exist.
    extern fn nautilus_file_info_create(p_location: *gio.File) *nautilus.FileInfo;
    pub const create = nautilus_file_info_create;

    /// Get an existing `NautilusFileInfo` (if it exists) or create a new one is it
    /// does not exist.
    extern fn nautilus_file_info_create_for_uri(p_uri: [*:0]const u8) *nautilus.FileInfo;
    pub const createForUri = nautilus_file_info_create_for_uri;

    /// Deep copy a list of `NautilusFileInfo`.
    extern fn nautilus_file_info_list_copy(p_files: *glib.List) *glib.List;
    pub const listCopy = nautilus_file_info_list_copy;

    /// Deep free a list of `NautilusFileInfo`.
    extern fn nautilus_file_info_list_free(p_files: *glib.List) void;
    pub const listFree = nautilus_file_info_list_free;

    /// Get an existing `NautilusFileInfo` or `NULL` if it does not exist in the
    /// application cache.
    extern fn nautilus_file_info_lookup(p_location: *gio.File) ?*nautilus.FileInfo;
    pub const lookup = nautilus_file_info_lookup;

    /// Get an existing `NautilusFileInfo` or `NULL` if it does not exist in the
    /// application cache.
    extern fn nautilus_file_info_lookup_for_uri(p_uri: [*:0]const u8) ?*nautilus.FileInfo;
    pub const lookupForUri = nautilus_file_info_lookup_for_uri;

    /// Add an emblem.
    extern fn nautilus_file_info_add_emblem(p_file_info: *FileInfo, p_emblem_name: [*:0]const u8) void;
    pub const addEmblem = nautilus_file_info_add_emblem;

    /// Set's the attributes value or replacing the existing value (if one exists).
    ///
    /// This function is necessary to set the value of the `NautilusFileInfo`'s
    /// correspond attribute for a `Column.properties.attribute`.
    extern fn nautilus_file_info_add_string_attribute(p_file_info: *FileInfo, p_attribute_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const addStringAttribute = nautilus_file_info_add_string_attribute;

    /// Gets whether the `NautilusFileInfo` is writeable.
    extern fn nautilus_file_info_can_write(p_file_info: *FileInfo) c_int;
    pub const canWrite = nautilus_file_info_can_write;

    /// Gets the activation uri.
    ///
    /// The activation uri may differ from the actual URI if e.g. the file is a .desktop
    /// file or a Nautilus XML link file.
    extern fn nautilus_file_info_get_activation_uri(p_file_info: *FileInfo) [*:0]u8;
    pub const getActivationUri = nautilus_file_info_get_activation_uri;

    /// Get the cached `gio.FileType`.
    extern fn nautilus_file_info_get_file_type(p_file_info: *FileInfo) gio.FileType;
    pub const getFileType = nautilus_file_info_get_file_type;

    /// Get the corresponding `gio.File`
    extern fn nautilus_file_info_get_location(p_file_info: *FileInfo) *gio.File;
    pub const getLocation = nautilus_file_info_get_location;

    /// Get the cached mime_type.
    extern fn nautilus_file_info_get_mime_type(p_file_info: *FileInfo) [*:0]u8;
    pub const getMimeType = nautilus_file_info_get_mime_type;

    /// Gets the cached mount.
    ///
    /// This only returns the `gio.Mount` if Nautilus has already cached it.
    /// The return value may be `NULL` even if the `NautilusFileInfo` has a corresponding
    /// mount in which case you can call `gio.File.findEnclosingMountAsync`.
    extern fn nautilus_file_info_get_mount(p_file_info: *FileInfo) ?*gio.Mount;
    pub const getMount = nautilus_file_info_get_mount;

    /// Gets the name.
    extern fn nautilus_file_info_get_name(p_file_info: *FileInfo) [*:0]u8;
    pub const getName = nautilus_file_info_get_name;

    /// Get the parent `NautilusFileInfo`.
    ///
    /// It's not safe to call this recursively multiple times, as it works
    /// only for files already cached by Nautilus.
    extern fn nautilus_file_info_get_parent_info(p_file_info: *FileInfo) ?*nautilus.FileInfo;
    pub const getParentInfo = nautilus_file_info_get_parent_info;

    /// Gets the parent location.
    extern fn nautilus_file_info_get_parent_location(p_file_info: *FileInfo) ?*gio.File;
    pub const getParentLocation = nautilus_file_info_get_parent_location;

    /// Get the parent `NautilusFileInfo` uri.
    extern fn nautilus_file_info_get_parent_uri(p_file_info: *FileInfo) [*:0]u8;
    pub const getParentUri = nautilus_file_info_get_parent_uri;

    /// Get the attribute's value.
    extern fn nautilus_file_info_get_string_attribute(p_file_info: *FileInfo, p_attribute_name: [*:0]const u8) ?[*:0]u8;
    pub const getStringAttribute = nautilus_file_info_get_string_attribute;

    /// Gets the URI.
    extern fn nautilus_file_info_get_uri(p_file_info: *FileInfo) [*:0]u8;
    pub const getUri = nautilus_file_info_get_uri;

    /// Get the uri scheme.
    extern fn nautilus_file_info_get_uri_scheme(p_file_info: *FileInfo) [*:0]u8;
    pub const getUriScheme = nautilus_file_info_get_uri_scheme;

    /// Invalidate the current extension information.
    ///
    /// This removes any information, such as emblems or or string attributes, that
    /// were added to the `NautilusFileInfo` from any extension.
    extern fn nautilus_file_info_invalidate_extension_info(p_file_info: *FileInfo) void;
    pub const invalidateExtensionInfo = nautilus_file_info_invalidate_extension_info;

    /// Gets whether the `NautilusFileInfo` is a directory.
    ///
    /// Uses the cached `gio.FileType` matches `G_FILE_TYPE_DIRECTORY` without
    /// doing any blocking i/o.
    extern fn nautilus_file_info_is_directory(p_file_info: *FileInfo) c_int;
    pub const isDirectory = nautilus_file_info_is_directory;

    /// Get whether a `NautilusFileInfo` is gone.
    extern fn nautilus_file_info_is_gone(p_file_info: *FileInfo) c_int;
    pub const isGone = nautilus_file_info_is_gone;

    /// Gets whether the mime_type of the `NautilusFileInfo` matches the given type.
    extern fn nautilus_file_info_is_mime_type(p_file_info: *FileInfo, p_mime_type: [*:0]const u8) c_int;
    pub const isMimeType = nautilus_file_info_is_mime_type;

    extern fn nautilus_file_info_get_type() usize;
    pub const getGObjectType = nautilus_file_info_get_type;

    extern fn g_object_ref(p_self: *nautilus.FileInfo) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.FileInfo) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FileInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interface to provide additional information about files
///
/// `NautilusInfoProvider` allows extension to provide additional information about
/// files. When `InfoProvider.updateFileInfo` is called by the application,
/// extensions will know that it's time to add extra information to the provided
/// `FileInfo`.
pub const InfoProvider = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = nautilus.InfoProviderInterface;
    pub const virtual_methods = struct {
        /// Called when the Nautilus application has canceled an update.
        ///
        /// This method is only relevant if `InfoProvider.updateFileInfo` was returned with
        /// `NAUTILUS_OPERATION_IN_PROGRESS`.
        pub const cancel_update = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handle: *nautilus.OperationHandle) void {
                return gobject.ext.as(InfoProvider.Iface, p_class).f_cancel_update.?(gobject.ext.as(InfoProvider, p_provider), p_handle);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handle: *nautilus.OperationHandle) callconv(.c) void) void {
                gobject.ext.as(InfoProvider.Iface, p_class).f_cancel_update = @ptrCast(p_implementation);
            }
        };

        /// Called when the Nautilus application is requesting updated file information.
        pub const update_file_info = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: *nautilus.FileInfo, p_update_complete: *gobject.Closure, p_handle: ?**nautilus.OperationHandle) nautilus.OperationResult {
                return gobject.ext.as(InfoProvider.Iface, p_class).f_update_file_info.?(gobject.ext.as(InfoProvider, p_provider), p_file, p_update_complete, p_handle);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: *nautilus.FileInfo, p_update_complete: *gobject.Closure, p_handle: ?**nautilus.OperationHandle) callconv(.c) nautilus.OperationResult) void {
                gobject.ext.as(InfoProvider.Iface, p_class).f_update_file_info = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Complete an async file info update.
    extern fn nautilus_info_provider_update_complete_invoke(p_update_complete: *gobject.Closure, p_provider: *nautilus.InfoProvider, p_handle: *nautilus.OperationHandle, p_result: nautilus.OperationResult) void;
    pub const updateCompleteInvoke = nautilus_info_provider_update_complete_invoke;

    /// Called when the Nautilus application has canceled an update.
    ///
    /// This method is only relevant if `InfoProvider.updateFileInfo` was returned with
    /// `NAUTILUS_OPERATION_IN_PROGRESS`.
    extern fn nautilus_info_provider_cancel_update(p_provider: *InfoProvider, p_handle: *nautilus.OperationHandle) void;
    pub const cancelUpdate = nautilus_info_provider_cancel_update;

    /// Called when the Nautilus application is requesting updated file information.
    extern fn nautilus_info_provider_update_file_info(p_provider: *InfoProvider, p_file: *nautilus.FileInfo, p_update_complete: *gobject.Closure, p_handle: ?**nautilus.OperationHandle) nautilus.OperationResult;
    pub const updateFileInfo = nautilus_info_provider_update_file_info;

    extern fn nautilus_info_provider_get_type() usize;
    pub const getGObjectType = nautilus_info_provider_get_type;

    extern fn g_object_ref(p_self: *nautilus.InfoProvider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.InfoProvider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *InfoProvider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interface to provide additional menu items.
///
/// `NautilusMenuProvider` allows extensions to provide additional menu items
/// in the file manager menus.
pub const MenuProvider = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = nautilus.MenuProviderInterface;
    pub const virtual_methods = struct {
        /// Called at least once whenever the current view changes.
        pub const get_background_items = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_current_folder: *nautilus.FileInfo) ?*glib.List {
                return gobject.ext.as(MenuProvider.Iface, p_class).f_get_background_items.?(gobject.ext.as(MenuProvider, p_provider), p_current_folder);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_current_folder: *nautilus.FileInfo) callconv(.c) ?*glib.List) void {
                gobject.ext.as(MenuProvider.Iface, p_class).f_get_background_items = @ptrCast(p_implementation);
            }
        };

        /// Called whenever the selected files in a view changes.
        pub const get_file_items = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_files: *glib.List) ?*glib.List {
                return gobject.ext.as(MenuProvider.Iface, p_class).f_get_file_items.?(gobject.ext.as(MenuProvider, p_provider), p_files);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_files: *glib.List) callconv(.c) ?*glib.List) void {
                gobject.ext.as(MenuProvider.Iface, p_class).f_get_file_items = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// A signal to be emitted whenever the extension modifies the list of menu items.
        pub const items_updated = struct {
            pub const name = "items-updated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MenuProvider, p_instance))),
                    gobject.signalLookup("items-updated", MenuProvider.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Emits `MenuProvider.signals.items_updated`.
    extern fn nautilus_menu_provider_emit_items_updated_signal(p_provider: *MenuProvider) void;
    pub const emitItemsUpdatedSignal = nautilus_menu_provider_emit_items_updated_signal;

    /// Called at least once whenever the current view changes.
    extern fn nautilus_menu_provider_get_background_items(p_provider: *MenuProvider, p_current_folder: *nautilus.FileInfo) ?*glib.List;
    pub const getBackgroundItems = nautilus_menu_provider_get_background_items;

    /// Called whenever the selected files in a view changes.
    extern fn nautilus_menu_provider_get_file_items(p_provider: *MenuProvider, p_files: *glib.List) ?*glib.List;
    pub const getFileItems = nautilus_menu_provider_get_file_items;

    extern fn nautilus_menu_provider_get_type() usize;
    pub const getGObjectType = nautilus_menu_provider_get_type;

    extern fn g_object_ref(p_self: *nautilus.MenuProvider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.MenuProvider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MenuProvider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interface to provide additional properties.
///
/// `NautilusPropertiesModelProvider` allows extensions to provide additional
/// information for the file properties.
pub const PropertiesModelProvider = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = nautilus.PropertiesModelProviderInterface;
    pub const virtual_methods = struct {
        /// This function is called by the application when it wants properties models
        /// from the extension.
        ///
        /// This function is called in the main thread before the Properties are shown,
        /// so it should return quickly. The models can be populated and updated
        /// asynchronously.
        pub const get_models = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_files: *glib.List) ?*glib.List {
                return gobject.ext.as(PropertiesModelProvider.Iface, p_class).f_get_models.?(gobject.ext.as(PropertiesModelProvider, p_provider), p_files);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_files: *glib.List) callconv(.c) ?*glib.List) void {
                gobject.ext.as(PropertiesModelProvider.Iface, p_class).f_get_models = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// This function is called by the application when it wants properties models
    /// from the extension.
    ///
    /// This function is called in the main thread before the Properties are shown,
    /// so it should return quickly. The models can be populated and updated
    /// asynchronously.
    extern fn nautilus_properties_model_provider_get_models(p_provider: *PropertiesModelProvider, p_files: *glib.List) ?*glib.List;
    pub const getModels = nautilus_properties_model_provider_get_models;

    extern fn nautilus_properties_model_provider_get_type() usize;
    pub const getGObjectType = nautilus_properties_model_provider_get_type;

    extern fn g_object_ref(p_self: *nautilus.PropertiesModelProvider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *nautilus.PropertiesModelProvider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PropertiesModelProvider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColumnClass = extern struct {
    pub const Instance = nautilus.Column;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ColumnClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColumnProviderInterface = extern struct {
    pub const Instance = nautilus.ColumnProvider;

    f_g_iface: gobject.TypeInterface,
    f_get_columns: ?*const fn (p_provider: *nautilus.ColumnProvider) callconv(.c) ?*glib.List,

    pub fn as(p_instance: *ColumnProviderInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FileInfoInterface = extern struct {
    pub const Instance = nautilus.FileInfo;

    f_g_iface: gobject.TypeInterface,
    f_is_gone: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) c_int,
    f_get_name: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) [*:0]u8,
    f_get_uri: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) [*:0]u8,
    f_get_parent_uri: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) [*:0]u8,
    f_get_uri_scheme: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) [*:0]u8,
    f_get_mime_type: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) [*:0]u8,
    f_is_mime_type: ?*const fn (p_file_info: *nautilus.FileInfo, p_mime_type: [*:0]const u8) callconv(.c) c_int,
    f_is_directory: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) c_int,
    f_add_emblem: ?*const fn (p_file_info: *nautilus.FileInfo, p_emblem_name: [*:0]const u8) callconv(.c) void,
    f_get_string_attribute: ?*const fn (p_file_info: *nautilus.FileInfo, p_attribute_name: [*:0]const u8) callconv(.c) ?[*:0]u8,
    f_add_string_attribute: ?*const fn (p_file_info: *nautilus.FileInfo, p_attribute_name: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void,
    f_invalidate_extension_info: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) void,
    f_get_activation_uri: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) [*:0]u8,
    f_get_file_type: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) gio.FileType,
    f_get_location: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) *gio.File,
    f_get_parent_location: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) ?*gio.File,
    f_get_parent_info: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) ?*nautilus.FileInfo,
    f_get_mount: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) ?*gio.Mount,
    f_can_write: ?*const fn (p_file_info: *nautilus.FileInfo) callconv(.c) c_int,

    pub fn as(p_instance: *FileInfoInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InfoProviderInterface = extern struct {
    pub const Instance = nautilus.InfoProvider;

    f_g_iface: gobject.TypeInterface,
    f_update_file_info: ?*const fn (p_provider: *nautilus.InfoProvider, p_file: *nautilus.FileInfo, p_update_complete: *gobject.Closure, p_handle: ?**nautilus.OperationHandle) callconv(.c) nautilus.OperationResult,
    f_cancel_update: ?*const fn (p_provider: *nautilus.InfoProvider, p_handle: *nautilus.OperationHandle) callconv(.c) void,

    pub fn as(p_instance: *InfoProviderInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MenuClass = extern struct {
    pub const Instance = nautilus.Menu;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MenuClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MenuItemClass = extern struct {
    pub const Instance = nautilus.MenuItem;

    f_parent: gobject.ObjectClass,
    f_activate: ?*const fn (p_item: *nautilus.MenuItem) callconv(.c) void,

    pub fn as(p_instance: *MenuItemClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MenuProviderInterface = extern struct {
    pub const Instance = nautilus.MenuProvider;

    f_g_iface: gobject.TypeInterface,
    f_get_file_items: ?*const fn (p_provider: *nautilus.MenuProvider, p_files: *glib.List) callconv(.c) ?*glib.List,
    f_get_background_items: ?*const fn (p_provider: *nautilus.MenuProvider, p_current_folder: *nautilus.FileInfo) callconv(.c) ?*glib.List,

    pub fn as(p_instance: *MenuProviderInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Handle for asynchronous interfaces.
///
/// These are opaque handles that must be unique within an extension object.
/// These are set by operations that return `NAUTILUS_OPERATION_IN_PROGRESS`.
pub const OperationHandle = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertiesItemClass = extern struct {
    pub const Instance = nautilus.PropertiesItem;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PropertiesItemClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertiesModelClass = extern struct {
    pub const Instance = nautilus.PropertiesModel;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PropertiesModelClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PropertiesModelProviderInterface = extern struct {
    pub const Instance = nautilus.PropertiesModelProvider;

    f_g_iface: gobject.TypeInterface,
    f_get_models: ?*const fn (p_provider: *nautilus.PropertiesModelProvider, p_files: *glib.List) callconv(.c) ?*glib.List,

    pub fn as(p_instance: *PropertiesModelProviderInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Return values for asynchronous operations performed by the extension.
pub const OperationResult = enum(c_int) {
    complete = 0,
    failed = 1,
    in_progress = 2,
    _,

    extern fn nautilus_operation_result_get_type() usize;
    pub const getGObjectType = nautilus_operation_result_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Called when the extension is begin loaded to register the types it exports
/// and to perform other initializations.
extern fn nautilus_module_initialize(p_module: *gobject.TypeModule) void;
pub const moduleInitialize = nautilus_module_initialize;

/// Called after the extension has been initialized and has registered all the
/// types it exports, to load them into Nautilus.
extern fn nautilus_module_list_types(p_types: *[*]const usize, p_num_types: *c_int) void;
pub const moduleListTypes = nautilus_module_list_types;

/// Called when the extension is being unloaded.
extern fn nautilus_module_shutdown() void;
pub const moduleShutdown = nautilus_module_shutdown;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
