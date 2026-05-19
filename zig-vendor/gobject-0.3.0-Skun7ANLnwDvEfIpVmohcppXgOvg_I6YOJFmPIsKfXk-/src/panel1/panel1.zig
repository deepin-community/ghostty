pub const ext = @import("ext.zig");
const panel = @This();

const std = @import("std");
const compat = @import("compat");
const gtk = @import("gtk4");
const gsk = @import("gsk4");
const graphene = @import("graphene1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gdk = @import("gdk4");
const cairo = @import("cairo1");
const pangocairo = @import("pangocairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
const adw = @import("adw1");
pub const ActionMuxer = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ActionGroup};
    pub const Class = panel.ActionMuxerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn panel_action_muxer_new() *panel.ActionMuxer;
    pub const new = panel_action_muxer_new;

    /// Locates the `gio.ActionGroup` inserted as `prefix`.
    ///
    /// If no group was found matching `group`, `NULL` is returned.
    extern fn panel_action_muxer_get_action_group(p_self: *ActionMuxer, p_prefix: [*:0]const u8) ?*gio.ActionGroup;
    pub const getActionGroup = panel_action_muxer_get_action_group;

    extern fn panel_action_muxer_insert_action_group(p_self: *ActionMuxer, p_prefix: [*:0]const u8, p_action_group: *gio.ActionGroup) void;
    pub const insertActionGroup = panel_action_muxer_insert_action_group;

    /// Gets a list of group names in the muxer.
    extern fn panel_action_muxer_list_groups(p_self: *ActionMuxer) [*][*:0]u8;
    pub const listGroups = panel_action_muxer_list_groups;

    extern fn panel_action_muxer_remove_action_group(p_self: *ActionMuxer, p_prefix: [*:0]const u8) void;
    pub const removeActionGroup = panel_action_muxer_remove_action_group;

    extern fn panel_action_muxer_remove_all(p_self: *ActionMuxer) void;
    pub const removeAll = panel_action_muxer_remove_all;

    extern fn panel_action_muxer_get_type() usize;
    pub const getGObjectType = panel_action_muxer_get_type;

    extern fn g_object_ref(p_self: *panel.ActionMuxer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.ActionMuxer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ActionMuxer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Application = extern struct {
    pub const Parent = adw.Application;
    pub const Implements = [_]type{ gio.ActionGroup, gio.ActionMap };
    pub const Class = panel.ApplicationClass;
    f_parent_instance: adw.Application,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn panel_application_new(p_application_id: [*:0]const u8, p_flags: gio.ApplicationFlags) *panel.Application;
    pub const new = panel_application_new;

    extern fn panel_application_get_type() usize;
    pub const getGObjectType = panel_application_get_type;

    extern fn g_object_ref(p_self: *panel.Application) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Application) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Application, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ChangesDialog = opaque {
    pub const Parent = adw.AlertDialog;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.ShortcutManager };
    pub const Class = panel.ChangesDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// This property requests that the widget close after saving.
        pub const close_after_save = struct {
            pub const name = "close-after-save";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Create a new `panel.ChangesDialog`.
    extern fn panel_changes_dialog_new() *panel.ChangesDialog;
    pub const new = panel_changes_dialog_new;

    extern fn panel_changes_dialog_add_delegate(p_self: *ChangesDialog, p_delegate: *panel.SaveDelegate) void;
    pub const addDelegate = panel_changes_dialog_add_delegate;

    extern fn panel_changes_dialog_get_close_after_save(p_self: *ChangesDialog) c_int;
    pub const getCloseAfterSave = panel_changes_dialog_get_close_after_save;

    extern fn panel_changes_dialog_run_async(p_self: *ChangesDialog, p_parent: *gtk.Widget, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const runAsync = panel_changes_dialog_run_async;

    extern fn panel_changes_dialog_run_finish(p_self: *ChangesDialog, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const runFinish = panel_changes_dialog_run_finish;

    extern fn panel_changes_dialog_set_close_after_save(p_self: *ChangesDialog, p_close_after_save: c_int) void;
    pub const setCloseAfterSave = panel_changes_dialog_set_close_after_save;

    extern fn panel_changes_dialog_get_type() usize;
    pub const getGObjectType = panel_changes_dialog_get_type;

    extern fn g_object_ref(p_self: *panel.ChangesDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.ChangesDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ChangesDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `panel.Dock` is a widget designed to contain widgets that can be
/// docked. Use the `panel.Dock` as the top widget of your dockable UI.
///
/// A `panel.Dock` is divided in 5 areas: `PANEL_AREA_TOP`,
/// `PANEL_AREA_BOTTOM`, `PANEL_AREA_START`, `PANEL_AREA_END` represent
/// the surrounding areas that can revealed. `PANEL_AREA_CENTER`
/// represent the main area, that is always displayed and resized
/// depending on the reveal state of the surrounding areas.
///
/// It will contain a `PanelDockChild` for each of the areas in use,
/// albeit this is done by the widget.
pub const Dock = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.DockClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {
        pub const panel_drag_begin = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) void {
                return gobject.ext.as(Dock.Class, p_class).f_panel_drag_begin.?(gobject.ext.as(Dock, p_self), p_widget);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) callconv(.c) void) void {
                gobject.ext.as(Dock.Class, p_class).f_panel_drag_begin = @ptrCast(p_implementation);
            }
        };

        pub const panel_drag_end = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) void {
                return gobject.ext.as(Dock.Class, p_class).f_panel_drag_end.?(gobject.ext.as(Dock, p_self), p_widget);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) callconv(.c) void) void {
                gobject.ext.as(Dock.Class, p_class).f_panel_drag_end = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const bottom_height = struct {
            pub const name = "bottom-height";

            pub const Type = c_int;
        };

        pub const can_reveal_bottom = struct {
            pub const name = "can-reveal-bottom";

            pub const Type = c_int;
        };

        pub const can_reveal_end = struct {
            pub const name = "can-reveal-end";

            pub const Type = c_int;
        };

        pub const can_reveal_start = struct {
            pub const name = "can-reveal-start";

            pub const Type = c_int;
        };

        pub const can_reveal_top = struct {
            pub const name = "can-reveal-top";

            pub const Type = c_int;
        };

        pub const end_width = struct {
            pub const name = "end-width";

            pub const Type = c_int;
        };

        pub const reveal_bottom = struct {
            pub const name = "reveal-bottom";

            pub const Type = c_int;
        };

        pub const reveal_end = struct {
            pub const name = "reveal-end";

            pub const Type = c_int;
        };

        pub const reveal_start = struct {
            pub const name = "reveal-start";

            pub const Type = c_int;
        };

        pub const reveal_top = struct {
            pub const name = "reveal-top";

            pub const Type = c_int;
        };

        pub const start_width = struct {
            pub const name = "start-width";

            pub const Type = c_int;
        };

        pub const top_height = struct {
            pub const name = "top-height";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Signal is emitted when a widget is requesting to be added via a
        /// drag-n-drop event.
        ///
        /// This is generally propagated via `panel.Frame.signals.adopt`-widget to the
        /// dock so that applications do not need to attach signal handlers
        /// to every `panel.Frame`.
        pub const adopt_widget = struct {
            pub const name = "adopt-widget";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_widget: *panel.Widget, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Dock, p_instance))),
                    gobject.signalLookup("adopt-widget", Dock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when a new frame is needed.
        pub const create_frame = struct {
            pub const name = "create-frame";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_position: *panel.Position, P_Data) callconv(.c) *panel.Frame, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Dock, p_instance))),
                    gobject.signalLookup("create-frame", Dock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when dragging of a panel begins.
        pub const panel_drag_begin = struct {
            pub const name = "panel-drag-begin";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_panel: *panel.Widget, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Dock, p_instance))),
                    gobject.signalLookup("panel-drag-begin", Dock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when dragging of a panel either
        /// completes or was cancelled.
        pub const panel_drag_end = struct {
            pub const name = "panel-drag-end";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_panel: *panel.Widget, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Dock, p_instance))),
                    gobject.signalLookup("panel-drag-end", Dock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new `panel.Dock`.
    extern fn panel_dock_new() *panel.Dock;
    pub const new = panel_dock_new;

    /// Invokes a callback for each frame in the dock.
    extern fn panel_dock_foreach_frame(p_self: *Dock, p_callback: panel.FrameCallback, p_user_data: ?*anyopaque) void;
    pub const foreachFrame = panel_dock_foreach_frame;

    /// Tells if the panel area can be revealed.
    extern fn panel_dock_get_can_reveal_area(p_self: *Dock, p_area: panel.Area) c_int;
    pub const getCanRevealArea = panel_dock_get_can_reveal_area;

    /// Tells if the bottom panel area can be revealed.
    extern fn panel_dock_get_can_reveal_bottom(p_self: *Dock) c_int;
    pub const getCanRevealBottom = panel_dock_get_can_reveal_bottom;

    /// Tells if the end panel area can be revealed.
    extern fn panel_dock_get_can_reveal_end(p_self: *Dock) c_int;
    pub const getCanRevealEnd = panel_dock_get_can_reveal_end;

    /// Tells if the start panel area can be revealed.
    extern fn panel_dock_get_can_reveal_start(p_self: *Dock) c_int;
    pub const getCanRevealStart = panel_dock_get_can_reveal_start;

    /// Tells if the top panel area can be revealed.
    extern fn panel_dock_get_can_reveal_top(p_self: *Dock) c_int;
    pub const getCanRevealTop = panel_dock_get_can_reveal_top;

    /// Tells if an area if revealed.
    extern fn panel_dock_get_reveal_area(p_self: *Dock, p_area: panel.Area) c_int;
    pub const getRevealArea = panel_dock_get_reveal_area;

    /// Tells if the bottom area is revealed.
    extern fn panel_dock_get_reveal_bottom(p_self: *Dock) c_int;
    pub const getRevealBottom = panel_dock_get_reveal_bottom;

    /// Tells if the end area is revealed.
    extern fn panel_dock_get_reveal_end(p_self: *Dock) c_int;
    pub const getRevealEnd = panel_dock_get_reveal_end;

    /// Tells if the start area is revealed.
    extern fn panel_dock_get_reveal_start(p_self: *Dock) c_int;
    pub const getRevealStart = panel_dock_get_reveal_start;

    /// Tells if the top area is revealed.
    extern fn panel_dock_get_reveal_top(p_self: *Dock) c_int;
    pub const getRevealTop = panel_dock_get_reveal_top;

    /// Removes a widget from the dock. If `widget` is not a `DockChild`,
    /// then the closest `DockChild` parent is removed.
    extern fn panel_dock_remove(p_self: *Dock, p_widget: *gtk.Widget) void;
    pub const remove = panel_dock_remove;

    /// Set the height of the bottom area.
    extern fn panel_dock_set_bottom_height(p_self: *Dock, p_height: c_int) void;
    pub const setBottomHeight = panel_dock_set_bottom_height;

    /// Set the width of the end area.
    extern fn panel_dock_set_end_width(p_self: *Dock, p_width: c_int) void;
    pub const setEndWidth = panel_dock_set_end_width;

    /// Sets the reveal status of the area.
    extern fn panel_dock_set_reveal_area(p_self: *Dock, p_area: panel.Area, p_reveal: c_int) void;
    pub const setRevealArea = panel_dock_set_reveal_area;

    /// Sets the reveal status of the bottom area.
    extern fn panel_dock_set_reveal_bottom(p_self: *Dock, p_reveal_bottom: c_int) void;
    pub const setRevealBottom = panel_dock_set_reveal_bottom;

    /// Sets the reveal status of the end area.
    extern fn panel_dock_set_reveal_end(p_self: *Dock, p_reveal_end: c_int) void;
    pub const setRevealEnd = panel_dock_set_reveal_end;

    /// Sets the reveal status of the start area.
    extern fn panel_dock_set_reveal_start(p_self: *Dock, p_reveal_start: c_int) void;
    pub const setRevealStart = panel_dock_set_reveal_start;

    /// Sets the reveal status of the top area.
    extern fn panel_dock_set_reveal_top(p_self: *Dock, p_reveal_top: c_int) void;
    pub const setRevealTop = panel_dock_set_reveal_top;

    /// Set the width of the start area.
    extern fn panel_dock_set_start_width(p_self: *Dock, p_width: c_int) void;
    pub const setStartWidth = panel_dock_set_start_width;

    /// Set the height of the top area.
    extern fn panel_dock_set_top_height(p_self: *Dock, p_height: c_int) void;
    pub const setTopHeight = panel_dock_set_top_height;

    extern fn panel_dock_get_type() usize;
    pub const getGObjectType = panel_dock_get_type;

    extern fn g_object_ref(p_self: *panel.Dock) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Dock) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Dock, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DocumentWorkspace = extern struct {
    pub const Parent = panel.Workspace;
    pub const Implements = [_]type{ gio.ActionGroup, gio.ActionMap, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = panel.DocumentWorkspaceClass;
    f_parent_instance: panel.Workspace,

    pub const virtual_methods = struct {
        /// Requests the workspace add `widget` to the dock at `position`.
        pub const add_widget = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget, p_position: ?*panel.Position) c_int {
                return gobject.ext.as(DocumentWorkspace.Class, p_class).f_add_widget.?(gobject.ext.as(DocumentWorkspace, p_self), p_widget, p_position);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget, p_position: ?*panel.Position) callconv(.c) c_int) void {
                gobject.ext.as(DocumentWorkspace.Class, p_class).f_add_widget = @ptrCast(p_implementation);
            }
        };

        pub const create_frame = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_position: *panel.Position) *panel.Frame {
                return gobject.ext.as(DocumentWorkspace.Class, p_class).f_create_frame.?(gobject.ext.as(DocumentWorkspace, p_self), p_position);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_position: *panel.Position) callconv(.c) *panel.Frame) void {
                gobject.ext.as(DocumentWorkspace.Class, p_class).f_create_frame = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const dock = struct {
            pub const name = "dock";

            pub const Type = ?*panel.Dock;
        };

        pub const grid = struct {
            pub const name = "grid";

            pub const Type = ?*panel.Grid;
        };

        pub const statusbar = struct {
            pub const name = "statusbar";

            pub const Type = ?*panel.Statusbar;
        };
    };

    pub const signals = struct {
        /// This signal is used to add a `panel.Widget` to the document workspace,
        /// generally in the document grid.
        pub const add_widget = struct {
            pub const name = "add-widget";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_widget: *panel.Widget, p_position: *panel.Position, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DocumentWorkspace, p_instance))),
                    gobject.signalLookup("add-widget", DocumentWorkspace.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Creates a new `panel.Frame` to be added to the document grid.
        pub const create_frame = struct {
            pub const name = "create-frame";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_position: *panel.Position, P_Data) callconv(.c) *panel.Frame, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DocumentWorkspace, p_instance))),
                    gobject.signalLookup("create-frame", DocumentWorkspace.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `panel.DocumentWorkspace`.
    extern fn panel_document_workspace_new() *panel.DocumentWorkspace;
    pub const new = panel_document_workspace_new;

    /// Requests the workspace add `widget` to the dock at `position`.
    extern fn panel_document_workspace_add_widget(p_self: *DocumentWorkspace, p_widget: *panel.Widget, p_position: ?*panel.Position) c_int;
    pub const addWidget = panel_document_workspace_add_widget;

    /// Get the `panel.Dock` for the workspace.
    extern fn panel_document_workspace_get_dock(p_self: *DocumentWorkspace) *panel.Dock;
    pub const getDock = panel_document_workspace_get_dock;

    /// Get the document grid for the workspace.
    extern fn panel_document_workspace_get_grid(p_self: *DocumentWorkspace) *panel.Grid;
    pub const getGrid = panel_document_workspace_get_grid;

    /// Gets the statusbar for the workspace.
    extern fn panel_document_workspace_get_statusbar(p_self: *DocumentWorkspace) ?*panel.Statusbar;
    pub const getStatusbar = panel_document_workspace_get_statusbar;

    /// Gets the titlebar for the workspace.
    extern fn panel_document_workspace_get_titlebar(p_self: *DocumentWorkspace) ?*gtk.Widget;
    pub const getTitlebar = panel_document_workspace_get_titlebar;

    extern fn panel_document_workspace_set_titlebar(p_self: *DocumentWorkspace, p_titlebar: *gtk.Widget) void;
    pub const setTitlebar = panel_document_workspace_set_titlebar;

    extern fn panel_document_workspace_get_type() usize;
    pub const getGObjectType = panel_document_workspace_get_type;

    extern fn g_object_ref(p_self: *panel.DocumentWorkspace) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.DocumentWorkspace) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DocumentWorkspace, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `panel.Frame` is a widget containing panels to display in an
/// area. The widgets are added internally in an `adw.TabView` to
/// display them one at a time like in a stack.
///
/// A `panel.Frame` can also have a header widget that will be displayed
/// above the panels.
pub const Frame = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = panel.FrameClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {
        pub const adopt_widget = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) c_int {
                return gobject.ext.as(Frame.Class, p_class).f_adopt_widget.?(gobject.ext.as(Frame, p_self), p_widget);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) callconv(.c) c_int) void {
                gobject.ext.as(Frame.Class, p_class).f_adopt_widget = @ptrCast(p_implementation);
            }
        };

        pub const page_closed = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) void {
                return gobject.ext.as(Frame.Class, p_class).f_page_closed.?(gobject.ext.as(Frame, p_self), p_widget);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) callconv(.c) void) void {
                gobject.ext.as(Frame.Class, p_class).f_page_closed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const closeable = struct {
            pub const name = "closeable";

            pub const Type = c_int;
        };

        pub const empty = struct {
            pub const name = "empty";

            pub const Type = c_int;
        };

        pub const placeholder = struct {
            pub const name = "placeholder";

            pub const Type = ?*gtk.Widget;
        };

        pub const visible_child = struct {
            pub const name = "visible-child";

            pub const Type = ?*panel.Widget;
        };
    };

    pub const signals = struct {
        /// This signal is emitted when the frame should decide if it can adopt
        /// a `panel.Widget` dropped on the frame.
        ///
        /// If `GDK_EVENT_STOP` is returned, then the widget will not be adopted.
        pub const adopt_widget = struct {
            pub const name = "adopt-widget";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_widget: *panel.Widget, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Frame, p_instance))),
                    gobject.signalLookup("adopt-widget", Frame.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when the page widget will be closed.
        pub const page_closed = struct {
            pub const name = "page-closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_widget: *panel.Widget, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Frame, p_instance))),
                    gobject.signalLookup("page-closed", Frame.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new `panel.Frame`.
    extern fn panel_frame_new() *panel.Frame;
    pub const new = panel_frame_new;

    /// Adds a widget to the frame.
    extern fn panel_frame_add(p_self: *Frame, p_panel: *panel.Widget) void;
    pub const add = panel_frame_add;

    /// Add `panel` before `sibling` in the `panel.Frame`.
    extern fn panel_frame_add_before(p_self: *Frame, p_panel: *panel.Widget, p_sibling: *panel.Widget) void;
    pub const addBefore = panel_frame_add_before;

    /// Tells if the panel frame is closeable.
    extern fn panel_frame_get_closeable(p_self: *Frame) c_int;
    pub const getCloseable = panel_frame_get_closeable;

    /// Tells if the panel frame is empty.
    extern fn panel_frame_get_empty(p_self: *Frame) c_int;
    pub const getEmpty = panel_frame_get_empty;

    /// Gets the header for the frame.
    extern fn panel_frame_get_header(p_self: *Frame) ?*panel.FrameHeader;
    pub const getHeader = panel_frame_get_header;

    /// Gets the number of pages in the panel frame.
    extern fn panel_frame_get_n_pages(p_self: *Frame) c_uint;
    pub const getNPages = panel_frame_get_n_pages;

    /// Gets the page with the given index, if any.
    extern fn panel_frame_get_page(p_self: *Frame, p_n: c_uint) ?*panel.Widget;
    pub const getPage = panel_frame_get_page;

    /// Get the pages for the frame.
    extern fn panel_frame_get_pages(p_self: *Frame) *gtk.SelectionModel;
    pub const getPages = panel_frame_get_pages;

    /// Gets the placeholder widget, if any.
    extern fn panel_frame_get_placeholder(p_self: *Frame) ?*gtk.Widget;
    pub const getPlaceholder = panel_frame_get_placeholder;

    /// Gets the `panel.Position` for the frame.
    extern fn panel_frame_get_position(p_self: *Frame) *panel.Position;
    pub const getPosition = panel_frame_get_position;

    /// Gets the requested size for the panel frame.
    extern fn panel_frame_get_requested_size(p_self: *Frame) c_int;
    pub const getRequestedSize = panel_frame_get_requested_size;

    /// Gets the widget of the currently visible child.
    extern fn panel_frame_get_visible_child(p_self: *Frame) ?*panel.Widget;
    pub const getVisibleChild = panel_frame_get_visible_child;

    /// Removes a widget from the frame.
    extern fn panel_frame_remove(p_self: *Frame, p_panel: *panel.Widget) void;
    pub const remove = panel_frame_remove;

    /// Set pinned state of `child`.
    extern fn panel_frame_set_child_pinned(p_self: *Frame, p_child: *panel.Widget, p_pinned: c_int) void;
    pub const setChildPinned = panel_frame_set_child_pinned;

    /// Sets the header for the frame, such as a `panel.FrameSwitcher`.
    extern fn panel_frame_set_header(p_self: *Frame, p_header: ?*panel.FrameHeader) void;
    pub const setHeader = panel_frame_set_header;

    /// Sets the placeholder widget for the frame.
    ///
    /// The placeholder widget is displayed when there are no pages
    /// to display in the frame.
    extern fn panel_frame_set_placeholder(p_self: *Frame, p_placeholder: ?*gtk.Widget) void;
    pub const setPlaceholder = panel_frame_set_placeholder;

    /// Sets the requested size for the panel frame.
    extern fn panel_frame_set_requested_size(p_self: *Frame, p_requested_size: c_int) void;
    pub const setRequestedSize = panel_frame_set_requested_size;

    /// Sets the current page to the child specified in `widget`.
    extern fn panel_frame_set_visible_child(p_self: *Frame, p_widget: *panel.Widget) void;
    pub const setVisibleChild = panel_frame_set_visible_child;

    extern fn panel_frame_get_type() usize;
    pub const getGObjectType = panel_frame_get_type;

    extern fn g_object_ref(p_self: *panel.Frame) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Frame) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Frame, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A header bar for `panel.Frame`. It can optionally show an icon, it
/// can have a popover to be displace, and it can also have prefix and
/// suffix widgets.
///
/// It is an implementation of `panel.FrameHeader`
pub const FrameHeaderBar = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, panel.FrameHeader };
    pub const Class = panel.FrameHeaderBarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to show the icon or not.
        pub const show_icon = struct {
            pub const name = "show-icon";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Create a new `panel.FrameHeaderBar`.
    extern fn panel_frame_header_bar_new() *panel.FrameHeaderBar;
    pub const new = panel_frame_header_bar_new;

    /// Gets the menu popover attached to this menubar.
    extern fn panel_frame_header_bar_get_menu_popover(p_self: *FrameHeaderBar) *gtk.PopoverMenu;
    pub const getMenuPopover = panel_frame_header_bar_get_menu_popover;

    /// Tell whether it show the icon or not.
    extern fn panel_frame_header_bar_get_show_icon(p_self: *FrameHeaderBar) c_int;
    pub const getShowIcon = panel_frame_header_bar_get_show_icon;

    /// Set whether to show the icon or not.
    extern fn panel_frame_header_bar_set_show_icon(p_self: *FrameHeaderBar, p_show_icon: c_int) void;
    pub const setShowIcon = panel_frame_header_bar_set_show_icon;

    extern fn panel_frame_header_bar_get_type() usize;
    pub const getGObjectType = panel_frame_header_bar_get_type;

    extern fn g_object_ref(p_self: *panel.FrameHeaderBar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.FrameHeaderBar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FrameHeaderBar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `panel.FrameSwitcher` is a `panel.FrameHeader` that shows a row of
/// buttons to switch between `gtk.Stack` pages, not disimilar to a
/// `gtk.StackSwitcher`.
pub const FrameSwitcher = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable, panel.FrameHeader };
    pub const Class = panel.FrameSwitcherClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `PanelFrameSwitcher`.
    extern fn panel_frame_switcher_new() *panel.FrameSwitcher;
    pub const new = panel_frame_switcher_new;

    extern fn panel_frame_switcher_get_type() usize;
    pub const getGObjectType = panel_frame_switcher_get_type;

    extern fn g_object_ref(p_self: *panel.FrameSwitcher) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.FrameSwitcher) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FrameSwitcher, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `panel.FrameHeader` that implements switching between tab views in
/// a `panel.Frame`.
pub const FrameTabBar = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, panel.FrameHeader };
    pub const Class = panel.FrameTabBarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the tabs automatically hide.
        pub const autohide = struct {
            pub const name = "autohide";

            pub const Type = c_int;
        };

        /// Whether tabs expand to full width.
        pub const expand_tabs = struct {
            pub const name = "expand-tabs";

            pub const Type = c_int;
        };

        /// Whether tabs use inverted layout.
        pub const inverted = struct {
            pub const name = "inverted";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Create a new `panel.FrameTabBar`.
    extern fn panel_frame_tab_bar_new() *panel.FrameTabBar;
    pub const new = panel_frame_tab_bar_new;

    /// Gets whether the tabs automatically hide.
    extern fn panel_frame_tab_bar_get_autohide(p_self: *FrameTabBar) c_int;
    pub const getAutohide = panel_frame_tab_bar_get_autohide;

    /// Gets whether tabs expand to full width.
    extern fn panel_frame_tab_bar_get_expand_tabs(p_self: *FrameTabBar) c_int;
    pub const getExpandTabs = panel_frame_tab_bar_get_expand_tabs;

    /// Gets whether tabs use inverted layout.
    extern fn panel_frame_tab_bar_get_inverted(p_self: *FrameTabBar) c_int;
    pub const getInverted = panel_frame_tab_bar_get_inverted;

    /// Sets whether the tabs automatically hide.
    extern fn panel_frame_tab_bar_set_autohide(p_self: *FrameTabBar, p_autohide: c_int) void;
    pub const setAutohide = panel_frame_tab_bar_set_autohide;

    /// Sets whether tabs expand to full width.
    extern fn panel_frame_tab_bar_set_expand_tabs(p_self: *FrameTabBar, p_expand_tabs: c_int) void;
    pub const setExpandTabs = panel_frame_tab_bar_set_expand_tabs;

    /// Sets whether tabs tabs use inverted layout.
    extern fn panel_frame_tab_bar_set_inverted(p_self: *FrameTabBar, p_inverted: c_int) void;
    pub const setInverted = panel_frame_tab_bar_set_inverted;

    extern fn panel_frame_tab_bar_get_type() usize;
    pub const getGObjectType = panel_frame_tab_bar_get_type;

    extern fn g_object_ref(p_self: *panel.FrameTabBar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.FrameTabBar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FrameTabBar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GSettingsActionGroup = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ActionGroup};
    pub const Class = panel.GSettingsActionGroupClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const settings = struct {
            pub const name = "settings";

            pub const Type = ?*gio.Settings;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gio.ActionGroup` that exports `settings`.
    extern fn panel_gsettings_action_group_new(p_settings: *gio.Settings) *gio.ActionGroup;
    pub const new = panel_gsettings_action_group_new;

    extern fn panel_gsettings_action_group_get_type() usize;
    pub const getGObjectType = panel_gsettings_action_group_get_type;

    extern fn g_object_ref(p_self: *panel.GSettingsActionGroup) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.GSettingsActionGroup) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GSettingsActionGroup, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `panel.Grid` is a widget used to layout the dock item in the
/// center area.
pub const Grid = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.GridClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {
        pub const create_frame = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *panel.Frame {
                return gobject.ext.as(Grid.Class, p_class).f_create_frame.?(gobject.ext.as(Grid, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *panel.Frame) void {
                gobject.ext.as(Grid.Class, p_class).f_create_frame = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The "create-frame" signal is used to create a new frame within
        /// the grid.
        ///
        /// Consumers of this signal are required to return an unrooted
        /// `panel.Frame` from this signal. The first signal handler wins.
        pub const create_frame = struct {
            pub const name = "create-frame";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) *panel.Frame, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Grid, p_instance))),
                    gobject.signalLookup("create-frame", Grid.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `panel.Grid`.
    extern fn panel_grid_new() *panel.Grid;
    pub const new = panel_grid_new;

    /// Add a `panel.Widget` to the grid.
    extern fn panel_grid_add(p_self: *Grid, p_widget: *panel.Widget) void;
    pub const add = panel_grid_add;

    /// Request to close, asynchronously. This will display the save dialog.
    extern fn panel_grid_agree_to_close_async(p_self: *Grid, p_cancellable: ?*gio.Cancellable, p_callback: gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const agreeToCloseAsync = panel_grid_agree_to_close_async;

    extern fn panel_grid_agree_to_close_finish(p_self: *Grid, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const agreeToCloseFinish = panel_grid_agree_to_close_finish;

    /// Calls `callback` for each `panel.Frame` within `grid`.
    extern fn panel_grid_foreach_frame(p_self: *Grid, p_callback: panel.FrameCallback, p_user_data: ?*anyopaque) void;
    pub const foreachFrame = panel_grid_foreach_frame;

    /// Gets the `panel.GridColumn` for a column index.
    extern fn panel_grid_get_column(p_self: *Grid, p_column: c_uint) *panel.GridColumn;
    pub const getColumn = panel_grid_get_column;

    /// Gets the most recently acive column on a grid.
    extern fn panel_grid_get_most_recent_column(p_self: *Grid) *panel.GridColumn;
    pub const getMostRecentColumn = panel_grid_get_most_recent_column;

    /// Gets the most recently acive frame on a grid.
    extern fn panel_grid_get_most_recent_frame(p_self: *Grid) *panel.Frame;
    pub const getMostRecentFrame = panel_grid_get_most_recent_frame;

    /// Gets the number of columns in the grid.
    extern fn panel_grid_get_n_columns(p_self: *Grid) c_uint;
    pub const getNColumns = panel_grid_get_n_columns;

    /// Inserts a column at `position`.
    extern fn panel_grid_insert_column(p_self: *Grid, p_position: c_uint) void;
    pub const insertColumn = panel_grid_insert_column;

    extern fn panel_grid_get_type() usize;
    pub const getGObjectType = panel_grid_get_type;

    extern fn g_object_ref(p_self: *panel.Grid) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Grid) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Grid, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GridColumn = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.GridColumnClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn panel_grid_column_new() *panel.GridColumn;
    pub const new = panel_grid_column_new;

    /// Invokes a callback for each frame in the grid column.
    extern fn panel_grid_column_foreach_frame(p_self: *GridColumn, p_callback: panel.FrameCallback, p_user_data: ?*anyopaque) void;
    pub const foreachFrame = panel_grid_column_foreach_frame;

    extern fn panel_grid_column_get_empty(p_self: *GridColumn) c_int;
    pub const getEmpty = panel_grid_column_get_empty;

    /// Gets the most recently acive frame on a grid column.
    extern fn panel_grid_column_get_most_recent_frame(p_self: *GridColumn) *panel.Frame;
    pub const getMostRecentFrame = panel_grid_column_get_most_recent_frame;

    extern fn panel_grid_column_get_n_rows(p_self: *GridColumn) c_uint;
    pub const getNRows = panel_grid_column_get_n_rows;

    /// Gets the frame corresponding to a row index.
    extern fn panel_grid_column_get_row(p_self: *GridColumn, p_row: c_uint) *panel.Frame;
    pub const getRow = panel_grid_column_get_row;

    extern fn panel_grid_column_get_type() usize;
    pub const getGObjectType = panel_grid_column_get_type;

    extern fn g_object_ref(p_self: *panel.GridColumn) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.GridColumn) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GridColumn, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Inhibitor = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = panel.InhibitorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn panel_inhibitor_uninhibit(p_self: *Inhibitor) void;
    pub const uninhibit = panel_inhibitor_uninhibit;

    extern fn panel_inhibitor_get_type() usize;
    pub const getGObjectType = panel_inhibitor_get_type;

    extern fn g_object_ref(p_self: *panel.Inhibitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Inhibitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Inhibitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayeredSettings = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = panel.LayeredSettingsClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const path = struct {
            pub const name = "path";

            pub const Type = ?[*:0]u8;
        };

        pub const schema_id = struct {
            pub const name = "schema-id";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(LayeredSettings, p_instance))),
                    gobject.signalLookup("changed", LayeredSettings.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn panel_layered_settings_new(p_schema_id: [*:0]const u8, p_path: [*:0]const u8) *panel.LayeredSettings;
    pub const new = panel_layered_settings_new;

    extern fn panel_layered_settings_append(p_self: *LayeredSettings, p_settings: *gio.Settings) void;
    pub const append = panel_layered_settings_append;

    extern fn panel_layered_settings_bind(p_self: *LayeredSettings, p_key: [*:0]const u8, p_object: ?*anyopaque, p_property: [*:0]const u8, p_flags: gio.SettingsBindFlags) void;
    pub const bind = panel_layered_settings_bind;

    /// Creates a new binding similar to `gio.Settings.bindWithMapping` but applying
    /// from the resolved value via the layered settings.
    extern fn panel_layered_settings_bind_with_mapping(p_self: *LayeredSettings, p_key: [*:0]const u8, p_object: ?*anyopaque, p_property: [*:0]const u8, p_flags: gio.SettingsBindFlags, p_get_mapping: gio.SettingsBindGetMapping, p_set_mapping: gio.SettingsBindSetMapping, p_user_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const bindWithMapping = panel_layered_settings_bind_with_mapping;

    extern fn panel_layered_settings_get_boolean(p_self: *LayeredSettings, p_key: [*:0]const u8) c_int;
    pub const getBoolean = panel_layered_settings_get_boolean;

    extern fn panel_layered_settings_get_default_value(p_self: *LayeredSettings, p_key: [*:0]const u8) *glib.Variant;
    pub const getDefaultValue = panel_layered_settings_get_default_value;

    extern fn panel_layered_settings_get_double(p_self: *LayeredSettings, p_key: [*:0]const u8) f64;
    pub const getDouble = panel_layered_settings_get_double;

    extern fn panel_layered_settings_get_int(p_self: *LayeredSettings, p_key: [*:0]const u8) c_int;
    pub const getInt = panel_layered_settings_get_int;

    /// Gets the `gio.SettingsSchemaKey` denoted by `key`.
    ///
    /// It is a programming error to call this with a key that does not exist.
    extern fn panel_layered_settings_get_key(p_self: *LayeredSettings, p_key: [*:0]const u8) *gio.SettingsSchemaKey;
    pub const getKey = panel_layered_settings_get_key;

    extern fn panel_layered_settings_get_string(p_self: *LayeredSettings, p_key: [*:0]const u8) [*:0]u8;
    pub const getString = panel_layered_settings_get_string;

    extern fn panel_layered_settings_get_uint(p_self: *LayeredSettings, p_key: [*:0]const u8) c_uint;
    pub const getUint = panel_layered_settings_get_uint;

    extern fn panel_layered_settings_get_user_value(p_self: *LayeredSettings, p_key: [*:0]const u8) ?*glib.Variant;
    pub const getUserValue = panel_layered_settings_get_user_value;

    /// Gets the value of `key` from the first layer that is modified.
    extern fn panel_layered_settings_get_value(p_self: *LayeredSettings, p_key: [*:0]const u8) *glib.Variant;
    pub const getValue = panel_layered_settings_get_value;

    /// Lists the available keys.
    extern fn panel_layered_settings_list_keys(p_self: *LayeredSettings) [*][*:0]u8;
    pub const listKeys = panel_layered_settings_list_keys;

    extern fn panel_layered_settings_set_boolean(p_self: *LayeredSettings, p_key: [*:0]const u8, p_val: c_int) void;
    pub const setBoolean = panel_layered_settings_set_boolean;

    extern fn panel_layered_settings_set_double(p_self: *LayeredSettings, p_key: [*:0]const u8, p_val: f64) void;
    pub const setDouble = panel_layered_settings_set_double;

    extern fn panel_layered_settings_set_int(p_self: *LayeredSettings, p_key: [*:0]const u8, p_val: c_int) void;
    pub const setInt = panel_layered_settings_set_int;

    extern fn panel_layered_settings_set_string(p_self: *LayeredSettings, p_key: [*:0]const u8, p_val: [*:0]const u8) void;
    pub const setString = panel_layered_settings_set_string;

    extern fn panel_layered_settings_set_uint(p_self: *LayeredSettings, p_key: [*:0]const u8, p_val: c_uint) void;
    pub const setUint = panel_layered_settings_set_uint;

    extern fn panel_layered_settings_set_value(p_self: *LayeredSettings, p_key: [*:0]const u8, p_value: *glib.Variant) void;
    pub const setValue = panel_layered_settings_set_value;

    extern fn panel_layered_settings_unbind(p_self: *LayeredSettings, p_property: [*:0]const u8) void;
    pub const unbind = panel_layered_settings_unbind;

    extern fn panel_layered_settings_get_type() usize;
    pub const getGObjectType = panel_layered_settings_get_type;

    extern fn g_object_ref(p_self: *panel.LayeredSettings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.LayeredSettings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LayeredSettings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The goal of `panel.MenuManager` is to simplify the process of merging multiple
/// GtkBuilder .ui files containing menus into a single representation of the
/// application menus. Additionally, it provides the ability to "unmerge"
/// previously merged menus.
///
/// This allows for an application to have plugins which seemlessly extends
/// the core application menus.
///
/// Implementation notes:
///
/// To make this work, we don't use the GMenu instances created by a GtkBuilder
/// instance. Instead, we create the menus ourself and recreate section and
/// submenu links. This allows the `panel.MenuManager` to be in full control of
/// the generated menus.
///
/// `panel.MenuManager.getMenuById` will always return a `gio.Menu`, however
/// that menu may contain no children until something has extended it later
/// on during the application process.
pub const MenuManager = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = panel.MenuManagerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn panel_menu_manager_new() *panel.MenuManager;
    pub const new = panel_menu_manager_new;

    extern fn panel_menu_manager_add_filename(p_self: *MenuManager, p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_uint;
    pub const addFilename = panel_menu_manager_add_filename;

    extern fn panel_menu_manager_add_resource(p_self: *MenuManager, p_resource: [*:0]const u8, p_error: ?*?*glib.Error) c_uint;
    pub const addResource = panel_menu_manager_add_resource;

    /// Locates a menu item that matches `id` and sets the position within
    /// the resulting `gio.Menu` to `position`.
    ///
    /// If no match is found, `NULL` is returned.
    extern fn panel_menu_manager_find_item_by_id(p_self: *MenuManager, p_id: [*:0]const u8, p_position: *c_uint) ?*gio.Menu;
    pub const findItemById = panel_menu_manager_find_item_by_id;

    extern fn panel_menu_manager_get_menu_by_id(p_self: *MenuManager, p_menu_id: [*:0]const u8) *gio.Menu;
    pub const getMenuById = panel_menu_manager_get_menu_by_id;

    /// Gets the known menu ids as a string array.
    extern fn panel_menu_manager_get_menu_ids(p_self: *MenuManager) [*]const [*:0]const u8;
    pub const getMenuIds = panel_menu_manager_get_menu_ids;

    /// Note that `menu_model` is not retained, a copy of it is made.
    extern fn panel_menu_manager_merge(p_self: *MenuManager, p_menu_id: [*:0]const u8, p_menu_model: *gio.MenuModel) c_uint;
    pub const merge = panel_menu_manager_merge;

    /// This removes items from menus that were added as part of a previous
    /// menu merge. Use the value returned from `panel.MenuManager.merge` as
    /// the `merge_id`.
    extern fn panel_menu_manager_remove(p_self: *MenuManager, p_merge_id: c_uint) void;
    pub const remove = panel_menu_manager_remove;

    /// Overwrites an attribute for a menu that was created by
    /// `panel.MenuManager`.
    ///
    /// This can be useful when you want to update an attribute such as
    /// "accel" when an accelerator has changed due to user mappings.
    extern fn panel_menu_manager_set_attribute_string(p_self: *MenuManager, p_menu: *gio.Menu, p_position: c_uint, p_attribute: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const setAttributeString = panel_menu_manager_set_attribute_string;

    extern fn panel_menu_manager_get_type() usize;
    pub const getGObjectType = panel_menu_manager_get_type;

    extern fn g_object_ref(p_self: *panel.MenuManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.MenuManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MenuManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A multi-use widget for user interaction in the window header bar.
/// You can add widgets, a popover to provide action items, an icon,
/// updates on progress and pulse the main widget.
///
/// There is also a prefix and suffix area that can contain more
/// widgets.
///
/// <picture>
///   <source srcset="omni-bar-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="omni-bar.png" alt="omni-bar">
/// </picture>
pub const OmniBar = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Actionable, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.OmniBarClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The tooltip for the action.
        pub const action_tooltip = struct {
            pub const name = "action-tooltip";

            pub const Type = ?[*:0]u8;
        };

        /// The name of the icon to use.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The menu model of the omni bar menu.
        pub const menu_model = struct {
            pub const name = "menu-model";

            pub const Type = ?*gio.MenuModel;
        };

        /// The popover to show.
        pub const popover = struct {
            pub const name = "popover";

            pub const Type = ?*gtk.Popover;
        };

        /// The current progress value.
        pub const progress = struct {
            pub const name = "progress";

            pub const Type = f64;
        };
    };

    pub const signals = struct {};

    /// Create a new `panel.OmniBar`.
    extern fn panel_omni_bar_new() *panel.OmniBar;
    pub const new = panel_omni_bar_new;

    /// Add a widget at the start of the container, ordered by priority.
    /// The highest the priority, the closest to the start.
    extern fn panel_omni_bar_add_prefix(p_self: *OmniBar, p_priority: c_int, p_widget: *gtk.Widget) void;
    pub const addPrefix = panel_omni_bar_add_prefix;

    /// Add a widget towards the end of the container, ordered by priority.
    /// The highest the priority, the closest to the start.
    extern fn panel_omni_bar_add_suffix(p_self: *OmniBar, p_priority: c_int, p_widget: *gtk.Widget) void;
    pub const addSuffix = panel_omni_bar_add_suffix;

    /// Gets the current popover or `NULL` if none is setup.
    extern fn panel_omni_bar_get_popover(p_self: *OmniBar) ?*gtk.Popover;
    pub const getPopover = panel_omni_bar_get_popover;

    /// Gets the progress value displayed in the omni bar.
    extern fn panel_omni_bar_get_progress(p_self: *OmniBar) f64;
    pub const getProgress = panel_omni_bar_get_progress;

    /// Removes a widget from the omni bar. Currently only prefix or suffix
    /// widgets are supported.
    extern fn panel_omni_bar_remove(p_self: *OmniBar, p_widget: *gtk.Widget) void;
    pub const remove = panel_omni_bar_remove;

    /// Sets the omnibar popover, that will appear when clicking on the omni bar.
    extern fn panel_omni_bar_set_popover(p_self: *OmniBar, p_popover: ?*gtk.Popover) void;
    pub const setPopover = panel_omni_bar_set_popover;

    /// Sets the progress value displayed in the omni bar.
    extern fn panel_omni_bar_set_progress(p_self: *OmniBar, p_progress: f64) void;
    pub const setProgress = panel_omni_bar_set_progress;

    /// Starts pulsing the omni bar. Use
    /// `panel_omni_bar_stop_pulsing` to stop.
    extern fn panel_omni_bar_start_pulsing(p_self: *OmniBar) void;
    pub const startPulsing = panel_omni_bar_start_pulsing;

    /// Stops pulsing the omni bar, that was started with
    /// `panel_omni_bar_start_pulsing`.
    extern fn panel_omni_bar_stop_pulsing(p_self: *OmniBar) void;
    pub const stopPulsing = panel_omni_bar_stop_pulsing;

    extern fn panel_omni_bar_get_type() usize;
    pub const getGObjectType = panel_omni_bar_get_type;

    extern fn g_object_ref(p_self: *panel.OmniBar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.OmniBar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OmniBar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `panel.Paned` is the concrete widget for a panel area.
pub const Paned = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Orientable };
    pub const Class = panel.PanedClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `panel.Paned`.
    extern fn panel_paned_new() *panel.Paned;
    pub const new = panel_paned_new;

    /// Append a widget in the paned.
    extern fn panel_paned_append(p_self: *Paned, p_child: *gtk.Widget) void;
    pub const append = panel_paned_append;

    /// Gets the number of children in the paned.
    extern fn panel_paned_get_n_children(p_self: *Paned) c_uint;
    pub const getNChildren = panel_paned_get_n_children;

    /// Gets the child at position `nth`.
    extern fn panel_paned_get_nth_child(p_self: *Paned, p_nth: c_uint) ?*gtk.Widget;
    pub const getNthChild = panel_paned_get_nth_child;

    /// Inserts a widget at position in the paned.
    extern fn panel_paned_insert(p_self: *Paned, p_position: c_int, p_child: *gtk.Widget) void;
    pub const insert = panel_paned_insert;

    /// Inserts a widget afer `sibling` in the paned.
    extern fn panel_paned_insert_after(p_self: *Paned, p_child: *gtk.Widget, p_sibling: *gtk.Widget) void;
    pub const insertAfter = panel_paned_insert_after;

    /// Prepends a widget in the paned.
    extern fn panel_paned_prepend(p_self: *Paned, p_child: *gtk.Widget) void;
    pub const prepend = panel_paned_prepend;

    /// Removes a widget from the paned.
    extern fn panel_paned_remove(p_self: *Paned, p_child: *gtk.Widget) void;
    pub const remove = panel_paned_remove;

    extern fn panel_paned_get_type() usize;
    pub const getGObjectType = panel_paned_get_type;

    extern fn g_object_ref(p_self: *panel.Paned) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Paned) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Paned, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies a position in the dock. You receive a `panel.Position` in the
/// handler to `PanelDock.signals.create_frame`.
pub const Position = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = panel.PositionClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The area.
        pub const area = struct {
            pub const name = "area";

            pub const Type = panel.Area;
        };

        /// The area is set.
        pub const area_set = struct {
            pub const name = "area-set";

            pub const Type = c_int;
        };

        /// The column in the position.
        pub const column = struct {
            pub const name = "column";

            pub const Type = c_uint;
        };

        /// The column is set.
        pub const column_set = struct {
            pub const name = "column-set";

            pub const Type = c_int;
        };

        pub const depth = struct {
            pub const name = "depth";

            pub const Type = c_uint;
        };

        pub const depth_set = struct {
            pub const name = "depth-set";

            pub const Type = c_int;
        };

        pub const row = struct {
            pub const name = "row";

            pub const Type = c_uint;
        };

        pub const row_set = struct {
            pub const name = "row-set";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Create a position.
    extern fn panel_position_new() *panel.Position;
    pub const new = panel_position_new;

    /// Create a `panel.Position` from a `glib.Variant`.
    extern fn panel_position_new_from_variant(p_variant: *glib.Variant) ?*panel.Position;
    pub const newFromVariant = panel_position_new_from_variant;

    /// Compares two `panel.Position`.
    extern fn panel_position_equal(p_a: *Position, p_b: *panel.Position) c_int;
    pub const equal = panel_position_equal;

    /// Gets the area.
    extern fn panel_position_get_area(p_self: *Position) panel.Area;
    pub const getArea = panel_position_get_area;

    /// Gets wether the area is set.
    extern fn panel_position_get_area_set(p_self: *Position) c_int;
    pub const getAreaSet = panel_position_get_area_set;

    extern fn panel_position_get_column(p_self: *Position) c_uint;
    pub const getColumn = panel_position_get_column;

    extern fn panel_position_get_column_set(p_self: *Position) c_int;
    pub const getColumnSet = panel_position_get_column_set;

    extern fn panel_position_get_depth(p_self: *Position) c_uint;
    pub const getDepth = panel_position_get_depth;

    extern fn panel_position_get_depth_set(p_self: *Position) c_int;
    pub const getDepthSet = panel_position_get_depth_set;

    extern fn panel_position_get_row(p_self: *Position) c_uint;
    pub const getRow = panel_position_get_row;

    extern fn panel_position_get_row_set(p_self: *Position) c_int;
    pub const getRowSet = panel_position_get_row_set;

    /// Tells is the position is indeterminate.
    extern fn panel_position_is_indeterminate(p_self: *Position) c_int;
    pub const isIndeterminate = panel_position_is_indeterminate;

    /// Sets the area.
    extern fn panel_position_set_area(p_self: *Position, p_area: panel.Area) void;
    pub const setArea = panel_position_set_area;

    /// Sets whether the area is set.
    extern fn panel_position_set_area_set(p_self: *Position, p_area_set: c_int) void;
    pub const setAreaSet = panel_position_set_area_set;

    extern fn panel_position_set_column(p_self: *Position, p_column: c_uint) void;
    pub const setColumn = panel_position_set_column;

    extern fn panel_position_set_column_set(p_self: *Position, p_column_set: c_int) void;
    pub const setColumnSet = panel_position_set_column_set;

    extern fn panel_position_set_depth(p_self: *Position, p_depth: c_uint) void;
    pub const setDepth = panel_position_set_depth;

    extern fn panel_position_set_depth_set(p_self: *Position, p_depth_set: c_int) void;
    pub const setDepthSet = panel_position_set_depth_set;

    extern fn panel_position_set_row(p_self: *Position, p_row: c_uint) void;
    pub const setRow = panel_position_set_row;

    extern fn panel_position_set_row_set(p_self: *Position, p_row_set: c_int) void;
    pub const setRowSet = panel_position_set_row_set;

    /// Convert a `panel.Position` to a `glib.Variant`.
    extern fn panel_position_to_variant(p_self: *Position) ?*glib.Variant;
    pub const toVariant = panel_position_to_variant;

    extern fn panel_position_get_type() usize;
    pub const getGObjectType = panel_position_get_type;

    extern fn g_object_ref(p_self: *panel.Position) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Position) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Position, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaveDelegate = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = panel.SaveDelegateClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const close = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(SaveDelegate.Class, p_class).f_close.?(gobject.ext.as(SaveDelegate, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(SaveDelegate.Class, p_class).f_close = @ptrCast(p_implementation);
            }
        };

        pub const discard = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(SaveDelegate.Class, p_class).f_discard.?(gobject.ext.as(SaveDelegate, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(SaveDelegate.Class, p_class).f_discard = @ptrCast(p_implementation);
            }
        };

        pub const save = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_task: *gio.Task) c_int {
                return gobject.ext.as(SaveDelegate.Class, p_class).f_save.?(gobject.ext.as(SaveDelegate, p_self), p_task);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_task: *gio.Task) callconv(.c) c_int) void {
                gobject.ext.as(SaveDelegate.Class, p_class).f_save = @ptrCast(p_implementation);
            }
        };

        pub const save_async = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(SaveDelegate.Class, p_class).f_save_async.?(gobject.ext.as(SaveDelegate, p_self), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(SaveDelegate.Class, p_class).f_save_async = @ptrCast(p_implementation);
            }
        };

        pub const save_finish = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(SaveDelegate.Class, p_class).f_save_finish.?(gobject.ext.as(SaveDelegate, p_self), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(SaveDelegate.Class, p_class).f_save_finish = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The "icon" property contains a `gio.Icon` that describes the save
        /// operation. Generally, this should be the symbolic icon of the
        /// document class you are saving.
        ///
        /// Alternatively, you can use `panel.SaveDelegate.properties.icon`-name for a
        /// named icon.
        pub const icon = struct {
            pub const name = "icon";

            pub const Type = ?*gio.Icon;
        };

        /// The "icon-name" property contains the name of an icon to use when
        /// showing information about the save operation in UI such as a save
        /// dialog.
        ///
        /// You can also use `panel.SaveDelegate.properties.icon` to set a `gio.Icon` instead of
        /// an icon name.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// The "is-draft" property indicates that the document represented by the
        /// delegate is a draft and might be lost of not saved.
        pub const is_draft = struct {
            pub const name = "is-draft";

            pub const Type = c_int;
        };

        /// The "progress" property contains progress between 0.0 and 1.0 and
        /// should be updated by the delegate implementation as saving progresses.
        pub const progress = struct {
            pub const name = "progress";

            pub const Type = f64;
        };

        /// The "subtitle" property contains additional information that may
        /// not make sense to put in the title. This might include the directory
        /// that the file will be saved within.
        pub const subtitle = struct {
            pub const name = "subtitle";

            pub const Type = ?[*:0]u8;
        };

        /// The "title" property contains the title of the document being saved.
        /// Generally, this should be the base name of the document such as
        /// `file.txt`.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// This signal is emitted when the save delegate should close
        /// the widget it is related to. This can happen after saving as
        /// part of a close request and it is now save for the delegate to
        /// close.
        ///
        /// Implementations are encouraged to connect to this signal (or
        /// implement the virtual method) and call `panel.Widget.forceClose`.
        pub const close = struct {
            pub const name = "close";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SaveDelegate, p_instance))),
                    gobject.signalLookup("close", SaveDelegate.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when the user has requested that the
        /// delegate discard the changes instead of saving them.
        ///
        /// Implementations are encouraged to connect to this signal (or
        /// implement the virtual method) and revert the document to the
        /// last saved state and/or close the document.
        pub const discard = struct {
            pub const name = "discard";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SaveDelegate, p_instance))),
                    gobject.signalLookup("discard", SaveDelegate.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal can be used when subclassing `panel.SaveDelegate` is not
        /// possible or cumbersome. The default implementation of
        /// `panel.SaveDelegateClass.virtual_methods.save_async` will emit this signal to allow
        /// the consumer to implement asynchronous save in a flexible manner.
        ///
        /// The caller is expected to complete `task` with a boolean when the
        /// save operation has completed.
        pub const save = struct {
            pub const name = "save";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_task: *gio.Task, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SaveDelegate, p_instance))),
                    gobject.signalLookup("save", SaveDelegate.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new `panel.SaveDelegate`.
    extern fn panel_save_delegate_new() *panel.SaveDelegate;
    pub const new = panel_save_delegate_new;

    extern fn panel_save_delegate_close(p_self: *SaveDelegate) void;
    pub const close = panel_save_delegate_close;

    extern fn panel_save_delegate_discard(p_self: *SaveDelegate) void;
    pub const discard = panel_save_delegate_discard;

    /// Gets the `gio.Icon` for the save delegate, or `NULL` if unset.
    extern fn panel_save_delegate_get_icon(p_self: *SaveDelegate) ?*gio.Icon;
    pub const getIcon = panel_save_delegate_get_icon;

    /// Gets the icon name for the save delegate.
    extern fn panel_save_delegate_get_icon_name(p_self: *SaveDelegate) ?[*:0]const u8;
    pub const getIconName = panel_save_delegate_get_icon_name;

    extern fn panel_save_delegate_get_is_draft(p_self: *SaveDelegate) c_int;
    pub const getIsDraft = panel_save_delegate_get_is_draft;

    extern fn panel_save_delegate_get_progress(p_self: *SaveDelegate) f64;
    pub const getProgress = panel_save_delegate_get_progress;

    /// Gets the subtitle for the save delegate.
    extern fn panel_save_delegate_get_subtitle(p_self: *SaveDelegate) ?[*:0]const u8;
    pub const getSubtitle = panel_save_delegate_get_subtitle;

    /// Gets the title for the save delegate.
    extern fn panel_save_delegate_get_title(p_self: *SaveDelegate) ?[*:0]const u8;
    pub const getTitle = panel_save_delegate_get_title;

    extern fn panel_save_delegate_save_async(p_self: *SaveDelegate, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const saveAsync = panel_save_delegate_save_async;

    extern fn panel_save_delegate_save_finish(p_self: *SaveDelegate, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const saveFinish = panel_save_delegate_save_finish;

    /// Sets the `gio.Icon` for the save delegate. Pass `NULL` to unset.
    extern fn panel_save_delegate_set_icon(p_self: *SaveDelegate, p_icon: ?*gio.Icon) void;
    pub const setIcon = panel_save_delegate_set_icon;

    /// Sets the icon name for the save delegate. Pass `NULL` to unset.
    extern fn panel_save_delegate_set_icon_name(p_self: *SaveDelegate, p_icon: ?[*:0]const u8) void;
    pub const setIconName = panel_save_delegate_set_icon_name;

    extern fn panel_save_delegate_set_is_draft(p_self: *SaveDelegate, p_is_draft: c_int) void;
    pub const setIsDraft = panel_save_delegate_set_is_draft;

    extern fn panel_save_delegate_set_progress(p_self: *SaveDelegate, p_progress: f64) void;
    pub const setProgress = panel_save_delegate_set_progress;

    /// Sets the subtitle for the save delegate. Pass `NULL` to unset.
    extern fn panel_save_delegate_set_subtitle(p_self: *SaveDelegate, p_subtitle: ?[*:0]const u8) void;
    pub const setSubtitle = panel_save_delegate_set_subtitle;

    /// Sets the title for the save delegate. Pass `NULL` to unset.
    extern fn panel_save_delegate_set_title(p_self: *SaveDelegate, p_title: ?[*:0]const u8) void;
    pub const setTitle = panel_save_delegate_set_title;

    extern fn panel_save_delegate_get_type() usize;
    pub const getGObjectType = panel_save_delegate_get_type;

    extern fn g_object_ref(p_self: *panel.SaveDelegate) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.SaveDelegate) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaveDelegate, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaveDialog = opaque {
    pub const Parent = adw.MessageDialog;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = panel.SaveDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// This property requests that the widget close after saving.
        pub const close_after_save = struct {
            pub const name = "close-after-save";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Create a new `panel.SaveDialog`.
    extern fn panel_save_dialog_new() *panel.SaveDialog;
    pub const new = panel_save_dialog_new;

    extern fn panel_save_dialog_add_delegate(p_self: *SaveDialog, p_delegate: *panel.SaveDelegate) void;
    pub const addDelegate = panel_save_dialog_add_delegate;

    extern fn panel_save_dialog_get_close_after_save(p_self: *SaveDialog) c_int;
    pub const getCloseAfterSave = panel_save_dialog_get_close_after_save;

    extern fn panel_save_dialog_run_async(p_self: *SaveDialog, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const runAsync = panel_save_dialog_run_async;

    extern fn panel_save_dialog_run_finish(p_self: *SaveDialog, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const runFinish = panel_save_dialog_run_finish;

    extern fn panel_save_dialog_set_close_after_save(p_self: *SaveDialog, p_close_after_save: c_int) void;
    pub const setCloseAfterSave = panel_save_dialog_set_close_after_save;

    extern fn panel_save_dialog_get_type() usize;
    pub const getGObjectType = panel_save_dialog_get_type;

    extern fn g_object_ref(p_self: *panel.SaveDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.SaveDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SaveDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Session = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = panel.SessionClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn panel_session_new() *panel.Session;
    pub const new = panel_session_new;

    /// Creates a new `panel.Session` from a `glib.Variant`.
    ///
    /// This creates a new `panel.Session` instance from a previous session
    /// which had been serialized to `variant`.
    extern fn panel_session_new_from_variant(p_variant: *glib.Variant, p_error: ?*?*glib.Error) ?*panel.Session;
    pub const newFromVariant = panel_session_new_from_variant;

    extern fn panel_session_append(p_self: *Session, p_item: *panel.SessionItem) void;
    pub const append = panel_session_append;

    /// Gets the item at `position`.
    extern fn panel_session_get_item(p_self: *Session, p_position: c_uint) ?*panel.SessionItem;
    pub const getItem = panel_session_get_item;

    extern fn panel_session_get_n_items(p_self: *Session) c_uint;
    pub const getNItems = panel_session_get_n_items;

    extern fn panel_session_insert(p_self: *Session, p_position: c_uint, p_item: *panel.SessionItem) void;
    pub const insert = panel_session_insert;

    /// Gets a session item matching `id`.
    extern fn panel_session_lookup_by_id(p_self: *Session, p_id: [*:0]const u8) ?*panel.SessionItem;
    pub const lookupById = panel_session_lookup_by_id;

    extern fn panel_session_prepend(p_self: *Session, p_item: *panel.SessionItem) void;
    pub const prepend = panel_session_prepend;

    extern fn panel_session_remove(p_self: *Session, p_item: *panel.SessionItem) void;
    pub const remove = panel_session_remove;

    extern fn panel_session_remove_at(p_self: *Session, p_position: c_uint) void;
    pub const removeAt = panel_session_remove_at;

    /// Serializes a `panel.Session` as a `glib.Variant`
    ///
    /// The result of this function may be passed to
    /// `panel.Session.newFromVariant` to recreate a `panel.Session`.
    ///
    /// The resulting variant will not be floating.
    extern fn panel_session_to_variant(p_self: *Session) *glib.Variant;
    pub const toVariant = panel_session_to_variant;

    extern fn panel_session_get_type() usize;
    pub const getGObjectType = panel_session_get_type;

    extern fn g_object_ref(p_self: *panel.Session) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Session) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Session, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionItem = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = panel.SessionItemClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };

        pub const module_name = struct {
            pub const name = "module-name";

            pub const Type = ?[*:0]u8;
        };

        pub const position = struct {
            pub const name = "position";

            pub const Type = ?*panel.Position;
        };

        pub const type_hint = struct {
            pub const name = "type-hint";

            pub const Type = ?[*:0]u8;
        };

        pub const workspace = struct {
            pub const name = "workspace";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn panel_session_item_new() *panel.SessionItem;
    pub const new = panel_session_item_new;

    /// Gets the id for the session item, if any.
    extern fn panel_session_item_get_id(p_self: *SessionItem) ?[*:0]const u8;
    pub const getId = panel_session_item_get_id;

    /// Extract a metadata value matching `format`.
    ///
    /// `format` must not reference the `glib.Variant`, which means you need to make
    /// copies of data, such as "s" instead of "&s".
    extern fn panel_session_item_get_metadata(p_self: *SessionItem, p_key: [*:0]const u8, p_format: [*:0]const u8, ...) c_int;
    pub const getMetadata = panel_session_item_get_metadata;

    /// Retrieves the metadata value for `key`.
    ///
    /// If `expected_type` is non-`NULL`, any non-`NULL` value returned from this
    /// function will match `expected_type`.
    extern fn panel_session_item_get_metadata_value(p_self: *SessionItem, p_key: [*:0]const u8, p_expected_type: ?*const glib.VariantType) ?*glib.Variant;
    pub const getMetadataValue = panel_session_item_get_metadata_value;

    /// Gets the module-name that created an item.
    extern fn panel_session_item_get_module_name(p_self: *SessionItem) ?[*:0]const u8;
    pub const getModuleName = panel_session_item_get_module_name;

    /// Gets the `panel.Position` for the item.
    extern fn panel_session_item_get_position(p_self: *SessionItem) ?*panel.Position;
    pub const getPosition = panel_session_item_get_position;

    /// Gets the type hint for an item.
    extern fn panel_session_item_get_type_hint(p_self: *SessionItem) ?[*:0]const u8;
    pub const getTypeHint = panel_session_item_get_type_hint;

    /// Gets the workspace id for the item.
    extern fn panel_session_item_get_workspace(p_self: *SessionItem) ?[*:0]const u8;
    pub const getWorkspace = panel_session_item_get_workspace;

    /// If the item contains a metadata value for `key`.
    ///
    /// Checks if a value exists for a metadata key and retrieves the `glib.VariantType`
    /// for that key.
    extern fn panel_session_item_has_metadata(p_self: *SessionItem, p_key: [*:0]const u8, p_value_type: ?**const glib.VariantType) c_int;
    pub const hasMetadata = panel_session_item_has_metadata;

    /// Checks if the item contains metadata `key` with `expected_type`.
    extern fn panel_session_item_has_metadata_with_type(p_self: *SessionItem, p_key: [*:0]const u8, p_expected_type: *const glib.VariantType) c_int;
    pub const hasMetadataWithType = panel_session_item_has_metadata_with_type;

    /// Sets the identifier for the item.
    ///
    /// The identifier should generally be global to the session as it would
    /// not be expected to come across multiple items with the same id.
    extern fn panel_session_item_set_id(p_self: *SessionItem, p_id: ?[*:0]const u8) void;
    pub const setId = panel_session_item_set_id;

    /// A variadic helper to set metadata.
    ///
    /// The format should be identical to `glib.Variant.new`.
    extern fn panel_session_item_set_metadata(p_self: *SessionItem, p_key: [*:0]const u8, p_format: [*:0]const u8, ...) void;
    pub const setMetadata = panel_session_item_set_metadata;

    /// Sets the value for metadata `key`.
    ///
    /// If `value` is `NULL`, the metadata key is unset.
    extern fn panel_session_item_set_metadata_value(p_self: *SessionItem, p_key: [*:0]const u8, p_value: ?*glib.Variant) void;
    pub const setMetadataValue = panel_session_item_set_metadata_value;

    /// Sets the module-name for the session item.
    ///
    /// This is generally used to help determine which plugin created
    /// the item when decoding them at project load time.
    extern fn panel_session_item_set_module_name(p_self: *SessionItem, p_module_name: ?[*:0]const u8) void;
    pub const setModuleName = panel_session_item_set_module_name;

    /// Sets the position for `self`, if any.
    extern fn panel_session_item_set_position(p_self: *SessionItem, p_position: ?*panel.Position) void;
    pub const setPosition = panel_session_item_set_position;

    /// Sets the type-hint value for the item.
    ///
    /// This is generally used to help inflate the right version of
    /// an object when loading session items.
    extern fn panel_session_item_set_type_hint(p_self: *SessionItem, p_type_hint: ?[*:0]const u8) void;
    pub const setTypeHint = panel_session_item_set_type_hint;

    /// Sets the workspace id for the item.
    ///
    /// This is generally used to tie an item to a specific workspace.
    extern fn panel_session_item_set_workspace(p_self: *SessionItem, p_workspace: ?[*:0]const u8) void;
    pub const setWorkspace = panel_session_item_set_workspace;

    extern fn panel_session_item_get_type() usize;
    pub const getGObjectType = panel_session_item_get_type;

    extern fn g_object_ref(p_self: *panel.SessionItem) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.SessionItem) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SessionItem, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Settings = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ActionGroup};
    pub const Class = panel.SettingsClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The "identifier" property is used to make unique paths.
        ///
        /// This might be a unique "project-id" for example, in an IDE.
        pub const identifier = struct {
            pub const name = "identifier";

            pub const Type = ?[*:0]u8;
        };

        pub const path = struct {
            pub const name = "path";

            pub const Type = ?[*:0]u8;
        };

        pub const path_prefix = struct {
            pub const name = "path-prefix";

            pub const Type = ?[*:0]u8;
        };

        pub const path_suffix = struct {
            pub const name = "path-suffix";

            pub const Type = ?[*:0]u8;
        };

        pub const schema_id = struct {
            pub const name = "schema-id";

            pub const Type = ?[*:0]u8;
        };

        pub const schema_id_prefix = struct {
            pub const name = "schema-id-prefix";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Settings, p_instance))),
                    gobject.signalLookup("changed", Settings.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn panel_settings_resolve_schema_path(p_schema_id_prefix: [*:0]const u8, p_schema_id: [*:0]const u8, p_identifier: [*:0]const u8, p_path_prefix: [*:0]const u8, p_path_suffix: [*:0]const u8) [*:0]u8;
    pub const resolveSchemaPath = panel_settings_resolve_schema_path;

    extern fn panel_settings_new(p_identifier: [*:0]const u8, p_schema_id: [*:0]const u8) *panel.Settings;
    pub const new = panel_settings_new;

    extern fn panel_settings_new_relocatable(p_identifier: [*:0]const u8, p_schema_id: [*:0]const u8, p_schema_id_prefix: [*:0]const u8, p_path_prefix: [*:0]const u8, p_path_suffix: [*:0]const u8) *panel.Settings;
    pub const newRelocatable = panel_settings_new_relocatable;

    extern fn panel_settings_new_with_path(p_identifier: [*:0]const u8, p_schema_id: [*:0]const u8, p_path: [*:0]const u8) *panel.Settings;
    pub const newWithPath = panel_settings_new_with_path;

    extern fn panel_settings_bind(p_self: *Settings, p_key: [*:0]const u8, p_object: ?*anyopaque, p_property: [*:0]const u8, p_flags: gio.SettingsBindFlags) void;
    pub const bind = panel_settings_bind;

    /// Like `panel.Settings.bind` but allows transforming to and from settings storage using
    /// `get_mapping` and `set_mapping` transformation functions.
    ///
    /// Call `panel.Settings.unbind` to unbind the mapping.
    extern fn panel_settings_bind_with_mapping(p_self: *Settings, p_key: [*:0]const u8, p_object: ?*anyopaque, p_property: [*:0]const u8, p_flags: gio.SettingsBindFlags, p_get_mapping: ?gio.SettingsBindGetMapping, p_set_mapping: ?gio.SettingsBindSetMapping, p_user_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const bindWithMapping = panel_settings_bind_with_mapping;

    extern fn panel_settings_get_boolean(p_self: *Settings, p_key: [*:0]const u8) c_int;
    pub const getBoolean = panel_settings_get_boolean;

    extern fn panel_settings_get_default_value(p_self: *Settings, p_key: [*:0]const u8) *glib.Variant;
    pub const getDefaultValue = panel_settings_get_default_value;

    extern fn panel_settings_get_double(p_self: *Settings, p_key: [*:0]const u8) f64;
    pub const getDouble = panel_settings_get_double;

    extern fn panel_settings_get_int(p_self: *Settings, p_key: [*:0]const u8) c_int;
    pub const getInt = panel_settings_get_int;

    extern fn panel_settings_get_schema_id(p_self: *Settings) [*:0]const u8;
    pub const getSchemaId = panel_settings_get_schema_id;

    extern fn panel_settings_get_string(p_self: *Settings, p_key: [*:0]const u8) [*:0]u8;
    pub const getString = panel_settings_get_string;

    extern fn panel_settings_get_uint(p_self: *Settings, p_key: [*:0]const u8) c_uint;
    pub const getUint = panel_settings_get_uint;

    extern fn panel_settings_get_user_value(p_self: *Settings, p_key: [*:0]const u8) ?*glib.Variant;
    pub const getUserValue = panel_settings_get_user_value;

    extern fn panel_settings_get_value(p_self: *Settings, p_key: [*:0]const u8) *glib.Variant;
    pub const getValue = panel_settings_get_value;

    extern fn panel_settings_set_boolean(p_self: *Settings, p_key: [*:0]const u8, p_val: c_int) void;
    pub const setBoolean = panel_settings_set_boolean;

    extern fn panel_settings_set_double(p_self: *Settings, p_key: [*:0]const u8, p_val: f64) void;
    pub const setDouble = panel_settings_set_double;

    extern fn panel_settings_set_int(p_self: *Settings, p_key: [*:0]const u8, p_val: c_int) void;
    pub const setInt = panel_settings_set_int;

    extern fn panel_settings_set_string(p_self: *Settings, p_key: [*:0]const u8, p_val: [*:0]const u8) void;
    pub const setString = panel_settings_set_string;

    extern fn panel_settings_set_uint(p_self: *Settings, p_key: [*:0]const u8, p_val: c_uint) void;
    pub const setUint = panel_settings_set_uint;

    extern fn panel_settings_set_value(p_self: *Settings, p_key: [*:0]const u8, p_value: *glib.Variant) void;
    pub const setValue = panel_settings_set_value;

    extern fn panel_settings_unbind(p_self: *Settings, p_property: [*:0]const u8) void;
    pub const unbind = panel_settings_unbind;

    extern fn panel_settings_get_type() usize;
    pub const getGObjectType = panel_settings_get_type;

    extern fn g_object_ref(p_self: *panel.Settings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Settings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Settings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A panel status bar is meant to be displayed at the bottom of the
/// window. It can contain widgets in the prefix and in the suffix.
pub const Statusbar = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.StatusbarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `panel.Statusbar`.
    extern fn panel_statusbar_new() *panel.Statusbar;
    pub const new = panel_statusbar_new;

    /// Adds a widget into the prefix with `priority`. The higher the
    /// priority the closer to the start the widget will be added.
    extern fn panel_statusbar_add_prefix(p_self: *Statusbar, p_priority: c_int, p_widget: *gtk.Widget) void;
    pub const addPrefix = panel_statusbar_add_prefix;

    /// Adds a widget into the suffix with `priority`. The higher the
    /// priority the closer to the start the widget will be added.
    extern fn panel_statusbar_add_suffix(p_self: *Statusbar, p_priority: c_int, p_widget: *gtk.Widget) void;
    pub const addSuffix = panel_statusbar_add_suffix;

    /// Removes `widget` from the `panel.Statusbar`.
    extern fn panel_statusbar_remove(p_self: *Statusbar, p_widget: *gtk.Widget) void;
    pub const remove = panel_statusbar_remove;

    extern fn panel_statusbar_get_type() usize;
    pub const getGObjectType = panel_statusbar_get_type;

    extern fn g_object_ref(p_self: *panel.Statusbar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Statusbar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Statusbar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget that allow selecting theme preference between "dark",
/// "light" and "follow" the system preference.
///
/// <picture>
///   <source srcset="theme-selector-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="theme-selector.png" alt="theme-selector">
/// </picture>
///
/// Upon activation it will activate the named action in
/// `panel.ThemeSelector.properties.action`-name.
pub const ThemeSelector = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.ThemeSelectorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The name of the action activated on activation.
        pub const action_name = struct {
            pub const name = "action-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Create a new `ThemeSelector`.
    extern fn panel_theme_selector_new() *panel.ThemeSelector;
    pub const new = panel_theme_selector_new;

    /// Gets the name of the action that will be activated.
    extern fn panel_theme_selector_get_action_name(p_self: *ThemeSelector) [*:0]const u8;
    pub const getActionName = panel_theme_selector_get_action_name;

    /// Sets the name of the action that will be activated.
    extern fn panel_theme_selector_set_action_name(p_self: *ThemeSelector, p_action_name: [*:0]const u8) void;
    pub const setActionName = panel_theme_selector_set_action_name;

    extern fn panel_theme_selector_get_type() usize;
    pub const getGObjectType = panel_theme_selector_get_type;

    extern fn g_object_ref(p_self: *panel.ThemeSelector) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.ThemeSelector) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ThemeSelector, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PanelToggleButton` is a button used to toggle the visibility
/// of a `panel.Dock` area.
///
/// <picture>
///   <source srcset="toggle-button-dark.png" media="(prefers-color-scheme: dark)">
///   <img src="toggle-button.png" alt="toggle-button">
/// </picture>
///
/// It will automatically reveal or hide the specified area from
/// `panel.ToggleButton.properties.dock`.
pub const ToggleButton = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.ToggleButtonClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The area this button will reveal.
        pub const area = struct {
            pub const name = "area";

            pub const Type = panel.Area;
        };

        /// The associated `panel.Dock`
        pub const dock = struct {
            pub const name = "dock";

            pub const Type = ?*panel.Dock;
        };
    };

    pub const signals = struct {};

    /// Creates a new `panel.ToggleButton` to hide the `dock` in the `area`.
    extern fn panel_toggle_button_new(p_dock: *panel.Dock, p_area: panel.Area) *panel.ToggleButton;
    pub const new = panel_toggle_button_new;

    extern fn panel_toggle_button_get_type() usize;
    pub const getGObjectType = panel_toggle_button_get_type;

    extern fn g_object_ref(p_self: *panel.ToggleButton) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.ToggleButton) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ToggleButton, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// PanelWidget is the base widget class for widgets added to a
/// `panel.Frame`. It can be use as-is or you can subclass it.
pub const Widget = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget };
    pub const Class = panel.WidgetClass;
    f_parent_instance: gtk.Widget,

    pub const virtual_methods = struct {
        /// Discovers the widget that should be focused as the default widget
        /// for the `panel.Widget`.
        ///
        /// For example, if you want to focus a text editor by default, you might
        /// return the `gtk.TextView` inside your widgetry.
        pub const get_default_focus = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*gtk.Widget {
                return gobject.ext.as(Widget.Class, p_class).f_get_default_focus.?(gobject.ext.as(Widget, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*gtk.Widget) void {
                gobject.ext.as(Widget.Class, p_class).f_get_default_focus = @ptrCast(p_implementation);
            }
        };

        pub const presented = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Widget.Class, p_class).f_presented.?(gobject.ext.as(Widget, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Widget.Class, p_class).f_presented = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const busy = struct {
            pub const name = "busy";

            pub const Type = c_int;
        };

        pub const can_maximize = struct {
            pub const name = "can-maximize";

            pub const Type = c_int;
        };

        /// The child inside this widget.
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?*gtk.Widget;
        };

        /// The icon for this widget.
        pub const icon = struct {
            pub const name = "icon";

            pub const Type = ?*gio.Icon;
        };

        /// The icon name for this widget.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };

        pub const kind = struct {
            pub const name = "kind";

            pub const Type = ?[*:0]u8;
        };

        /// A menu model to display additional options for the page to the user via
        /// menus.
        pub const menu_model = struct {
            pub const name = "menu-model";

            pub const Type = ?*gio.MenuModel;
        };

        pub const modified = struct {
            pub const name = "modified";

            pub const Type = c_int;
        };

        pub const needs_attention = struct {
            pub const name = "needs-attention";

            pub const Type = c_int;
        };

        pub const reorderable = struct {
            pub const name = "reorderable";

            pub const Type = c_int;
        };

        /// The save delegate attached to this widget.
        pub const save_delegate = struct {
            pub const name = "save-delegate";

            pub const Type = ?*panel.SaveDelegate;
        };

        /// The title for this widget.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// The tooltip to display in tabs for the widget.
        pub const tooltip = struct {
            pub const name = "tooltip";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Gets the default widget to focus within the `panel.Widget`. The first
        /// handler for this signal is expected to return a widget, or `NULL` if
        /// there is nothing to focus.
        pub const get_default_focus = struct {
            pub const name = "get-default-focus";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) ?*gtk.Widget, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Widget, p_instance))),
                    gobject.signalLookup("get-default-focus", Widget.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "presented" signal is emitted when the widget is brought
        /// to the front of a frame.
        pub const presented = struct {
            pub const name = "presented";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Widget, p_instance))),
                    gobject.signalLookup("presented", Widget.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new `panel.Widget`.
    extern fn panel_widget_new() *panel.Widget;
    pub const new = panel_widget_new;

    extern fn panel_widget_action_set_enabled(p_widget: *Widget, p_action_name: [*:0]const u8, p_enabled: c_int) void;
    pub const actionSetEnabled = panel_widget_action_set_enabled;

    extern fn panel_widget_close(p_self: *Widget) void;
    pub const close = panel_widget_close;

    extern fn panel_widget_focus_default(p_self: *Widget) c_int;
    pub const focusDefault = panel_widget_focus_default;

    /// Closes the widget without any save dialogs.
    extern fn panel_widget_force_close(p_self: *Widget) void;
    pub const forceClose = panel_widget_force_close;

    extern fn panel_widget_get_busy(p_self: *Widget) c_int;
    pub const getBusy = panel_widget_get_busy;

    extern fn panel_widget_get_can_maximize(p_self: *Widget) c_int;
    pub const getCanMaximize = panel_widget_get_can_maximize;

    /// Gets the child widget of the panel.
    extern fn panel_widget_get_child(p_self: *Widget) ?*gtk.Widget;
    pub const getChild = panel_widget_get_child;

    /// Discovers the widget that should be focused as the default widget
    /// for the `panel.Widget`.
    ///
    /// For example, if you want to focus a text editor by default, you might
    /// return the `gtk.TextView` inside your widgetry.
    extern fn panel_widget_get_default_focus(p_self: *Widget) ?*gtk.Widget;
    pub const getDefaultFocus = panel_widget_get_default_focus;

    /// Gets a `gio.Icon` for the widget.
    extern fn panel_widget_get_icon(p_self: *Widget) ?*gio.Icon;
    pub const getIcon = panel_widget_get_icon;

    /// Gets the icon name for the widget.
    extern fn panel_widget_get_icon_name(p_self: *Widget) ?[*:0]const u8;
    pub const getIconName = panel_widget_get_icon_name;

    /// Gets the id of the panel widget.
    extern fn panel_widget_get_id(p_self: *Widget) [*:0]const u8;
    pub const getId = panel_widget_get_id;

    extern fn panel_widget_get_kind(p_self: *Widget) [*:0]const u8;
    pub const getKind = panel_widget_get_kind;

    /// Gets the `gio.MenuModel` for the widget.
    ///
    /// `panel.FrameHeader` may use this model to display additional options
    /// for the page to the user via menus.
    extern fn panel_widget_get_menu_model(p_self: *Widget) ?*gio.MenuModel;
    pub const getMenuModel = panel_widget_get_menu_model;

    /// Gets the modified status of a panel widget
    extern fn panel_widget_get_modified(p_self: *Widget) c_int;
    pub const getModified = panel_widget_get_modified;

    extern fn panel_widget_get_needs_attention(p_self: *Widget) c_int;
    pub const getNeedsAttention = panel_widget_get_needs_attention;

    /// Gets teh position of the widget within the dock.
    extern fn panel_widget_get_position(p_self: *Widget) ?*panel.Position;
    pub const getPosition = panel_widget_get_position;

    extern fn panel_widget_get_reorderable(p_self: *Widget) c_int;
    pub const getReorderable = panel_widget_get_reorderable;

    /// Gets the `panel.Widget.properties.save`-delegate property.
    ///
    /// The save delegate may be used to perform save operations on the
    /// content within the widget.
    ///
    /// Document editors might use this to save the file to disk.
    extern fn panel_widget_get_save_delegate(p_self: *Widget) ?*panel.SaveDelegate;
    pub const getSaveDelegate = panel_widget_get_save_delegate;

    /// Gets the title for the widget.
    extern fn panel_widget_get_title(p_self: *Widget) ?[*:0]const u8;
    pub const getTitle = panel_widget_get_title;

    /// Gets the tooltip for the widget.
    extern fn panel_widget_get_tooltip(p_self: *Widget) ?[*:0]const u8;
    pub const getTooltip = panel_widget_get_tooltip;

    extern fn panel_widget_insert_action_group(p_self: *Widget, p_prefix: [*:0]const u8, p_group: *gio.ActionGroup) void;
    pub const insertActionGroup = panel_widget_insert_action_group;

    extern fn panel_widget_mark_busy(p_self: *Widget) void;
    pub const markBusy = panel_widget_mark_busy;

    extern fn panel_widget_maximize(p_self: *Widget) void;
    pub const maximize = panel_widget_maximize;

    extern fn panel_widget_raise(p_self: *Widget) void;
    pub const raise = panel_widget_raise;

    extern fn panel_widget_set_can_maximize(p_self: *Widget, p_can_maximize: c_int) void;
    pub const setCanMaximize = panel_widget_set_can_maximize;

    /// Sets the child widget of the panel.
    extern fn panel_widget_set_child(p_self: *Widget, p_child: ?*gtk.Widget) void;
    pub const setChild = panel_widget_set_child;

    /// Sets a `gio.Icon` for the widget.
    extern fn panel_widget_set_icon(p_self: *Widget, p_icon: ?*gio.Icon) void;
    pub const setIcon = panel_widget_set_icon;

    /// Sets the icon name for the widget.
    extern fn panel_widget_set_icon_name(p_self: *Widget, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = panel_widget_set_icon_name;

    /// Sets the id of the panel widget.
    extern fn panel_widget_set_id(p_self: *Widget, p_id: [*:0]const u8) void;
    pub const setId = panel_widget_set_id;

    /// Sets the kind of the widget.
    extern fn panel_widget_set_kind(p_self: *Widget, p_kind: ?[*:0]const u8) void;
    pub const setKind = panel_widget_set_kind;

    /// Sets the `gio.MenuModel` for the widget.
    ///
    /// `panel.FrameHeader` may use this model to display additional options
    /// for the page to the user via menus.
    extern fn panel_widget_set_menu_model(p_self: *Widget, p_menu_model: ?*gio.MenuModel) void;
    pub const setMenuModel = panel_widget_set_menu_model;

    /// Sets the modified status of a panel widget.
    extern fn panel_widget_set_modified(p_self: *Widget, p_modified: c_int) void;
    pub const setModified = panel_widget_set_modified;

    extern fn panel_widget_set_needs_attention(p_self: *Widget, p_needs_attention: c_int) void;
    pub const setNeedsAttention = panel_widget_set_needs_attention;

    extern fn panel_widget_set_reorderable(p_self: *Widget, p_reorderable: c_int) void;
    pub const setReorderable = panel_widget_set_reorderable;

    /// Sets the `panel.Widget.properties.save`-delegate property.
    ///
    /// The save delegate may be used to perform save operations on the
    /// content within the widget.
    ///
    /// Document editors might use this to save the file to disk.
    extern fn panel_widget_set_save_delegate(p_self: *Widget, p_save_delegate: ?*panel.SaveDelegate) void;
    pub const setSaveDelegate = panel_widget_set_save_delegate;

    /// Sets the title for the widget.
    extern fn panel_widget_set_title(p_self: *Widget, p_title: ?[*:0]const u8) void;
    pub const setTitle = panel_widget_set_title;

    /// Sets the tooltip for the widget to be displayed in tabs.
    extern fn panel_widget_set_tooltip(p_self: *Widget, p_tooltip: ?[*:0]const u8) void;
    pub const setTooltip = panel_widget_set_tooltip;

    extern fn panel_widget_unmark_busy(p_self: *Widget) void;
    pub const unmarkBusy = panel_widget_unmark_busy;

    extern fn panel_widget_unmaximize(p_self: *Widget) void;
    pub const unmaximize = panel_widget_unmaximize;

    extern fn panel_widget_get_type() usize;
    pub const getGObjectType = panel_widget_get_type;

    extern fn g_object_ref(p_self: *panel.Widget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Widget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Widget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Workbench = extern struct {
    pub const Parent = gtk.WindowGroup;
    pub const Implements = [_]type{};
    pub const Class = panel.WorkbenchClass;
    f_parent_instance: gtk.WindowGroup,

    pub const virtual_methods = struct {
        pub const activate = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Workbench.Class, p_class).f_activate.?(gobject.ext.as(Workbench, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Workbench.Class, p_class).f_activate = @ptrCast(p_implementation);
            }
        };

        pub const unload_async = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Workbench.Class, p_class).f_unload_async.?(gobject.ext.as(Workbench, p_self), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Workbench.Class, p_class).f_unload_async = @ptrCast(p_implementation);
            }
        };

        pub const unload_finish = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Workbench.Class, p_class).f_unload_finish.?(gobject.ext.as(Workbench, p_self), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Workbench.Class, p_class).f_unload_finish = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The "id" of the workbench.
        ///
        /// This is generally used by applications to help destinguish between
        /// projects, so that the project-id matches the workbench-id.
        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const activate = struct {
            pub const name = "activate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Workbench, p_instance))),
                    gobject.signalLookup("activate", Workbench.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Finds the workbench that contains `widget`.
    extern fn panel_workbench_find_from_widget(p_widget: *gtk.Widget) ?*panel.Workbench;
    pub const findFromWidget = panel_workbench_find_from_widget;

    extern fn panel_workbench_new() *panel.Workbench;
    pub const new = panel_workbench_new;

    extern fn panel_workbench_action_set_enabled(p_self: *Workbench, p_action_name: [*:0]const u8, p_enabled: c_int) void;
    pub const actionSetEnabled = panel_workbench_action_set_enabled;

    extern fn panel_workbench_activate(p_self: *Workbench) void;
    pub const activate = panel_workbench_activate;

    extern fn panel_workbench_add_workspace(p_self: *Workbench, p_workspace: *panel.Workspace) void;
    pub const addWorkspace = panel_workbench_add_workspace;

    /// Locates a workspace in `self` with a type matching `type`.
    extern fn panel_workbench_find_workspace_typed(p_self: *Workbench, p_workspace_type: usize) ?*panel.Workspace;
    pub const findWorkspaceTyped = panel_workbench_find_workspace_typed;

    extern fn panel_workbench_focus_workspace(p_self: *Workbench, p_workspace: *panel.Workspace) void;
    pub const focusWorkspace = panel_workbench_focus_workspace;

    /// Calls `foreach_func` for each workspace in the workbench.
    extern fn panel_workbench_foreach_workspace(p_self: *Workbench, p_foreach_func: panel.WorkspaceForeach, p_foreach_func_data: ?*anyopaque) void;
    pub const foreachWorkspace = panel_workbench_foreach_workspace;

    extern fn panel_workbench_get_id(p_self: *Workbench) [*:0]const u8;
    pub const getId = panel_workbench_get_id;

    extern fn panel_workbench_remove_workspace(p_self: *Workbench, p_workspace: *panel.Workspace) void;
    pub const removeWorkspace = panel_workbench_remove_workspace;

    extern fn panel_workbench_set_id(p_self: *Workbench, p_id: [*:0]const u8) void;
    pub const setId = panel_workbench_set_id;

    extern fn panel_workbench_get_type() usize;
    pub const getGObjectType = panel_workbench_get_type;

    extern fn g_object_ref(p_self: *panel.Workbench) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Workbench) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Workbench, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Workspace = extern struct {
    pub const Parent = adw.ApplicationWindow;
    pub const Implements = [_]type{ gio.ActionGroup, gio.ActionMap, gtk.Accessible, gtk.Buildable, gtk.ConstraintTarget, gtk.Native, gtk.Root, gtk.ShortcutManager };
    pub const Class = panel.WorkspaceClass;
    f_parent_instance: adw.ApplicationWindow,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The "id" of the workspace.
        ///
        /// This is generally used by applications to help destinguish between
        /// types of workspaces, particularly when saving session state.
        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Finds the workspace that contains `widget`.
    extern fn panel_workspace_find_from_widget(p_widget: *gtk.Widget) ?*panel.Workspace;
    pub const findFromWidget = panel_workspace_find_from_widget;

    extern fn panel_workspace_action_set_enabled(p_self: *Workspace, p_action_name: [*:0]const u8, p_enabled: c_int) void;
    pub const actionSetEnabled = panel_workspace_action_set_enabled;

    extern fn panel_workspace_get_id(p_self: *Workspace) [*:0]const u8;
    pub const getId = panel_workspace_get_id;

    /// Gets the `panel.Workbench` `self` is a part of.
    extern fn panel_workspace_get_workbench(p_self: *Workspace) ?*panel.Workbench;
    pub const getWorkbench = panel_workspace_get_workbench;

    /// Inhibits one or more particular actions in the session.
    ///
    /// When the resulting `panel.Inhibitor` releases it's last reference
    /// the inhibitor will be dismissed. Alternatively, you may force the
    /// release of the inhibit using `panel.Inhibitor.uninhibit`.
    extern fn panel_workspace_inhibit(p_self: *Workspace, p_flags: gtk.ApplicationInhibitFlags, p_reason: [*:0]const u8) ?*panel.Inhibitor;
    pub const inhibit = panel_workspace_inhibit;

    extern fn panel_workspace_set_id(p_self: *Workspace, p_id: [*:0]const u8) void;
    pub const setId = panel_workspace_set_id;

    extern fn panel_workspace_get_type() usize;
    pub const getGObjectType = panel_workspace_get_type;

    extern fn g_object_ref(p_self: *panel.Workspace) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.Workspace) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Workspace, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface implemented by the header of a `panel.Frame`.
pub const FrameHeader = opaque {
    pub const Prerequisites = [_]type{gtk.Widget};
    pub const Iface = panel.FrameHeaderInterface;
    pub const virtual_methods = struct {
        /// Add a widget into a the prefix area with a priority. The highest
        /// the priority the closest to the start.
        pub const add_prefix = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_priority: c_int, p_child: *gtk.Widget) void {
                return gobject.ext.as(FrameHeader.Iface, p_class).f_add_prefix.?(gobject.ext.as(FrameHeader, p_self), p_priority, p_child);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_priority: c_int, p_child: *gtk.Widget) callconv(.c) void) void {
                gobject.ext.as(FrameHeader.Iface, p_class).f_add_prefix = @ptrCast(p_implementation);
            }
        };

        /// Add a widget into a the suffix area with a priority. The highest
        /// the priority the closest to the start.
        pub const add_suffix = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_priority: c_int, p_child: *gtk.Widget) void {
                return gobject.ext.as(FrameHeader.Iface, p_class).f_add_suffix.?(gobject.ext.as(FrameHeader, p_self), p_priority, p_child);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_priority: c_int, p_child: *gtk.Widget) callconv(.c) void) void {
                gobject.ext.as(FrameHeader.Iface, p_class).f_add_suffix = @ptrCast(p_implementation);
            }
        };

        /// Tells if the panel widget can be drop onto the panel frame.
        pub const can_drop = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) c_int {
                return gobject.ext.as(FrameHeader.Iface, p_class).f_can_drop.?(gobject.ext.as(FrameHeader, p_self), p_widget);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *panel.Widget) callconv(.c) c_int) void {
                gobject.ext.as(FrameHeader.Iface, p_class).f_can_drop = @ptrCast(p_implementation);
            }
        };

        /// Notifies the header that the visible page has changed.
        pub const page_changed = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: ?*panel.Widget) void {
                return gobject.ext.as(FrameHeader.Iface, p_class).f_page_changed.?(gobject.ext.as(FrameHeader, p_self), p_widget);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: ?*panel.Widget) callconv(.c) void) void {
                gobject.ext.as(FrameHeader.Iface, p_class).f_page_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The frame the header is attached to, or `NULL`.
        pub const frame = struct {
            pub const name = "frame";

            pub const Type = ?*panel.Frame;
        };
    };

    pub const signals = struct {};

    /// Add a widget into a the prefix area with a priority. The highest
    /// the priority the closest to the start.
    extern fn panel_frame_header_add_prefix(p_self: *FrameHeader, p_priority: c_int, p_child: *gtk.Widget) void;
    pub const addPrefix = panel_frame_header_add_prefix;

    /// Add a widget into a the suffix area with a priority. The highest
    /// the priority the closest to the start.
    extern fn panel_frame_header_add_suffix(p_self: *FrameHeader, p_priority: c_int, p_child: *gtk.Widget) void;
    pub const addSuffix = panel_frame_header_add_suffix;

    /// Tells if the panel widget can be drop onto the panel frame.
    extern fn panel_frame_header_can_drop(p_self: *FrameHeader, p_widget: *panel.Widget) c_int;
    pub const canDrop = panel_frame_header_can_drop;

    /// Gets the frame the header is attached to.
    extern fn panel_frame_header_get_frame(p_self: *FrameHeader) ?*panel.Frame;
    pub const getFrame = panel_frame_header_get_frame;

    /// Notifies the header that the visible page has changed.
    extern fn panel_frame_header_page_changed(p_self: *FrameHeader, p_widget: ?*panel.Widget) void;
    pub const pageChanged = panel_frame_header_page_changed;

    /// Sets the frame the header is attached to.
    extern fn panel_frame_header_set_frame(p_self: *FrameHeader, p_frame: ?*panel.Frame) void;
    pub const setFrame = panel_frame_header_set_frame;

    extern fn panel_frame_header_get_type() usize;
    pub const getGObjectType = panel_frame_header_get_type;

    extern fn g_object_ref(p_self: *panel.FrameHeader) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *panel.FrameHeader) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FrameHeader, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Action = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ActionMuxerClass = extern struct {
    pub const Instance = panel.ActionMuxer;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ActionMuxerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationClass = extern struct {
    pub const Instance = panel.Application;

    f_parent_class: adw.ApplicationClass,
    f__reserved: [8]*anyopaque,

    pub fn as(p_instance: *ApplicationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ChangesDialogClass = extern struct {
    pub const Instance = panel.ChangesDialog;

    f_parent_class: adw.AlertDialogClass,

    pub fn as(p_instance: *ChangesDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DockClass = extern struct {
    pub const Instance = panel.Dock;

    f_parent_class: gtk.WidgetClass,
    f_panel_drag_begin: ?*const fn (p_self: *panel.Dock, p_widget: *panel.Widget) callconv(.c) void,
    f_panel_drag_end: ?*const fn (p_self: *panel.Dock, p_widget: *panel.Widget) callconv(.c) void,

    pub fn as(p_instance: *DockClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DocumentWorkspaceClass = extern struct {
    pub const Instance = panel.DocumentWorkspace;

    f_parent_class: panel.WorkspaceClass,
    f_create_frame: ?*const fn (p_self: *panel.DocumentWorkspace, p_position: *panel.Position) callconv(.c) *panel.Frame,
    f_add_widget: ?*const fn (p_self: *panel.DocumentWorkspace, p_widget: *panel.Widget, p_position: ?*panel.Position) callconv(.c) c_int,
    f__reserved: [16]*anyopaque,

    pub fn as(p_instance: *DocumentWorkspaceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameClass = extern struct {
    pub const Instance = panel.Frame;

    f_parent_class: gtk.WidgetClass,
    f_page_closed: ?*const fn (p_self: *panel.Frame, p_widget: *panel.Widget) callconv(.c) void,
    f_adopt_widget: ?*const fn (p_self: *panel.Frame, p_widget: *panel.Widget) callconv(.c) c_int,
    f__reserved: [6]*anyopaque,

    pub fn as(p_instance: *FrameClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameHeaderBarClass = extern struct {
    pub const Instance = panel.FrameHeaderBar;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *FrameHeaderBarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameHeaderInterface = extern struct {
    pub const Instance = panel.FrameHeader;

    f_parent_iface: gobject.TypeInterface,
    f_page_changed: ?*const fn (p_self: *panel.FrameHeader, p_widget: ?*panel.Widget) callconv(.c) void,
    f_can_drop: ?*const fn (p_self: *panel.FrameHeader, p_widget: *panel.Widget) callconv(.c) c_int,
    f_add_prefix: ?*const fn (p_self: *panel.FrameHeader, p_priority: c_int, p_child: *gtk.Widget) callconv(.c) void,
    f_add_suffix: ?*const fn (p_self: *panel.FrameHeader, p_priority: c_int, p_child: *gtk.Widget) callconv(.c) void,

    pub fn as(p_instance: *FrameHeaderInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameSwitcherClass = extern struct {
    pub const Instance = panel.FrameSwitcher;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *FrameSwitcherClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameTabBarClass = extern struct {
    pub const Instance = panel.FrameTabBar;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *FrameTabBarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GSettingsActionGroupClass = extern struct {
    pub const Instance = panel.GSettingsActionGroup;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *GSettingsActionGroupClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GridClass = extern struct {
    pub const Instance = panel.Grid;

    f_parent_class: gtk.WidgetClass,
    f_create_frame: ?*const fn (p_self: *panel.Grid) callconv(.c) *panel.Frame,
    f__reserved: [12]*anyopaque,

    pub fn as(p_instance: *GridClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GridColumnClass = extern struct {
    pub const Instance = panel.GridColumn;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *GridColumnClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InhibitorClass = extern struct {
    pub const Instance = panel.Inhibitor;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *InhibitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayeredSettingsClass = extern struct {
    pub const Instance = panel.LayeredSettings;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *LayeredSettingsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MenuManagerClass = extern struct {
    pub const Instance = panel.MenuManager;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MenuManagerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OmniBarClass = extern struct {
    pub const Instance = panel.OmniBar;

    f_parent_class: gtk.WidgetClass,
    f__reserved: [8]*anyopaque,

    pub fn as(p_instance: *OmniBarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PanedClass = extern struct {
    pub const Instance = panel.Paned;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *PanedClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PositionClass = extern struct {
    pub const Instance = panel.Position;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PositionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaveDelegateClass = extern struct {
    pub const Instance = panel.SaveDelegate;

    f_parent_class: gobject.ObjectClass,
    f_save_async: ?*const fn (p_self: *panel.SaveDelegate, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_save_finish: ?*const fn (p_self: *panel.SaveDelegate, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_save: ?*const fn (p_self: *panel.SaveDelegate, p_task: *gio.Task) callconv(.c) c_int,
    f_discard: ?*const fn (p_self: *panel.SaveDelegate) callconv(.c) void,
    f_close: ?*const fn (p_self: *panel.SaveDelegate) callconv(.c) void,
    f__reserved: [8]*anyopaque,

    pub fn as(p_instance: *SaveDelegateClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaveDialogClass = extern struct {
    pub const Instance = panel.SaveDialog;

    f_parent_class: adw.MessageDialogClass,

    pub fn as(p_instance: *SaveDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionClass = extern struct {
    pub const Instance = panel.Session;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionItemClass = extern struct {
    pub const Instance = panel.SessionItem;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SessionItemClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SettingsClass = extern struct {
    pub const Instance = panel.Settings;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SettingsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StatusbarClass = extern struct {
    pub const Instance = panel.Statusbar;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *StatusbarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ThemeSelectorClass = extern struct {
    pub const Instance = panel.ThemeSelector;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ThemeSelectorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ToggleButtonClass = extern struct {
    pub const Instance = panel.ToggleButton;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *ToggleButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WidgetClass = extern struct {
    pub const Instance = panel.Widget;

    f_parent_instance: gtk.WidgetClass,
    f_get_default_focus: ?*const fn (p_self: *panel.Widget) callconv(.c) ?*gtk.Widget,
    f_presented: ?*const fn (p_self: *panel.Widget) callconv(.c) void,
    f__reserved: [8]*anyopaque,

    /// This should be called at class initialization time to specify
    /// actions to be added for all instances of this class.
    ///
    /// Actions installed by this function are stateless. The only state
    /// they have is whether they are enabled or not.
    extern fn panel_widget_class_install_action(p_widget_class: *WidgetClass, p_action_name: [*:0]const u8, p_parameter_type: ?[*:0]const u8, p_activate: gtk.WidgetActionActivateFunc) void;
    pub const installAction = panel_widget_class_install_action;

    /// Installs an action called `action_name` on `widget_class` and
    /// binds its state to the value of the `property_name` property.
    ///
    /// This function will perform a few santity checks on the property selected
    /// via `property_name`. Namely, the property must exist, must be readable,
    /// writable and must not be construct-only. There are also restrictions
    /// on the type of the given property, it must be boolean, int, unsigned int,
    /// double or string. If any of these conditions are not met, a critical
    /// warning will be printed and no action will be added.
    ///
    /// The state type of the action matches the property type.
    ///
    /// If the property is boolean, the action will have no parameter and
    /// toggle the property value. Otherwise, the action will have a parameter
    /// of the same type as the property.
    extern fn panel_widget_class_install_property_action(p_widget_class: *WidgetClass, p_action_name: [*:0]const u8, p_property_name: [*:0]const u8) void;
    pub const installPropertyAction = panel_widget_class_install_property_action;

    pub fn as(p_instance: *WidgetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WorkbenchClass = extern struct {
    pub const Instance = panel.Workbench;

    f_parent_class: gtk.WindowGroupClass,
    f_activate: ?*const fn (p_self: *panel.Workbench) callconv(.c) void,
    f_unload_async: ?*const fn (p_self: *panel.Workbench, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_unload_finish: ?*const fn (p_self: *panel.Workbench, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f__reserved: [8]*anyopaque,

    /// This should be called at class initialization time to specify
    /// actions to be added for all instances of this class.
    ///
    /// Actions installed by this function are stateless. The only state
    /// they have is whether they are enabled or not.
    extern fn panel_workbench_class_install_action(p_workbench_class: *WorkbenchClass, p_action_name: [*:0]const u8, p_parameter_type: ?[*:0]const u8, p_activate: panel.ActionActivateFunc) void;
    pub const installAction = panel_workbench_class_install_action;

    /// Installs an action called `action_name` on `workbench_class` and
    /// binds its state to the value of the `property_name` property.
    ///
    /// This function will perform a few santity checks on the property selected
    /// via `property_name`. Namely, the property must exist, must be readable,
    /// writable and must not be construct-only. There are also restrictions
    /// on the type of the given property, it must be boolean, int, unsigned int,
    /// double or string. If any of these conditions are not met, a critical
    /// warning will be printed and no action will be added.
    ///
    /// The state type of the action matches the property type.
    ///
    /// If the property is boolean, the action will have no parameter and
    /// toggle the property value. Otherwise, the action will have a parameter
    /// of the same type as the property.
    extern fn panel_workbench_class_install_property_action(p_workbench_class: *WorkbenchClass, p_action_name: [*:0]const u8, p_property_name: [*:0]const u8) void;
    pub const installPropertyAction = panel_workbench_class_install_property_action;

    pub fn as(p_instance: *WorkbenchClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WorkspaceClass = extern struct {
    pub const Instance = panel.Workspace;

    f_parent_class: adw.ApplicationWindowClass,
    f__reserved: [8]*anyopaque,

    /// This should be called at class initialization time to specify
    /// actions to be added for all instances of this class.
    ///
    /// Actions installed by this function are stateless. The only state
    /// they have is whether they are enabled or not.
    extern fn panel_workspace_class_install_action(p_workspace_class: *WorkspaceClass, p_action_name: [*:0]const u8, p_parameter_type: ?[*:0]const u8, p_activate: panel.ActionActivateFunc) void;
    pub const installAction = panel_workspace_class_install_action;

    /// Installs an action called `action_name` on `workspace_class` and
    /// binds its state to the value of the `property_name` property.
    ///
    /// This function will perform a few santity checks on the property selected
    /// via `property_name`. Namely, the property must exist, must be readable,
    /// writable and must not be construct-only. There are also restrictions
    /// on the type of the given property, it must be boolean, int, unsigned int,
    /// double or string. If any of these conditions are not met, a critical
    /// warning will be printed and no action will be added.
    ///
    /// The state type of the action matches the property type.
    ///
    /// If the property is boolean, the action will have no parameter and
    /// toggle the property value. Otherwise, the action will have a parameter
    /// of the same type as the property.
    extern fn panel_workspace_class_install_property_action(p_workspace_class: *WorkspaceClass, p_action_name: [*:0]const u8, p_property_name: [*:0]const u8) void;
    pub const installPropertyAction = panel_workspace_class_install_property_action;

    pub fn as(p_instance: *WorkspaceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The area of the panel.
pub const Area = enum(c_int) {
    start = 0,
    end = 1,
    top = 2,
    bottom = 3,
    center = 4,
    _,

    extern fn panel_area_get_type() usize;
    pub const getGObjectType = panel_area_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn panel_check_version(p_major: c_uint, p_minor: c_uint, p_micro: c_uint) c_int;
pub const checkVersion = panel_check_version;

extern fn panel_finalize() void;
pub const finalize = panel_finalize;

extern fn panel_get_major_version() c_uint;
pub const getMajorVersion = panel_get_major_version;

extern fn panel_get_micro_version() c_uint;
pub const getMicroVersion = panel_get_micro_version;

extern fn panel_get_minor_version() c_uint;
pub const getMinorVersion = panel_get_minor_version;

extern fn panel_get_resource() *gio.Resource;
pub const getResource = panel_get_resource;

extern fn panel_init() void;
pub const init = panel_init;

extern fn panel_marshal_BOOLEAN__OBJECT_OBJECT(p_closure: *gobject.Closure, p_return_value: *gobject.Value, p_n_param_values: c_uint, p_param_values: *const gobject.Value, p_invocation_hint: ?*anyopaque, p_marshal_data: ?*anyopaque) void;
pub const marshalBOOLEANOBJECTOBJECT = panel_marshal_BOOLEAN__OBJECT_OBJECT;

extern fn panel_marshal_BOOLEAN__OBJECT_OBJECTv(p_closure: *gobject.Closure, p_return_value: *gobject.Value, p_instance: ?*anyopaque, p_args: std.builtin.VaList, p_marshal_data: ?*anyopaque, p_n_params: c_int, p_param_types: *usize) void;
pub const marshalBOOLEANOBJECTOBJECTv = panel_marshal_BOOLEAN__OBJECT_OBJECTv;

extern fn panel_marshal_OBJECT__OBJECT(p_closure: *gobject.Closure, p_return_value: *gobject.Value, p_n_param_values: c_uint, p_param_values: *const gobject.Value, p_invocation_hint: ?*anyopaque, p_marshal_data: ?*anyopaque) void;
pub const marshalOBJECTOBJECT = panel_marshal_OBJECT__OBJECT;

extern fn panel_marshal_OBJECT__OBJECTv(p_closure: *gobject.Closure, p_return_value: *gobject.Value, p_instance: ?*anyopaque, p_args: std.builtin.VaList, p_marshal_data: ?*anyopaque, p_n_params: c_int, p_param_types: *usize) void;
pub const marshalOBJECTOBJECTv = panel_marshal_OBJECT__OBJECTv;

pub const ActionActivateFunc = *const fn (p_instance: ?*anyopaque, p_action_name: [*:0]const u8, p_param: *glib.Variant) callconv(.c) void;

/// Callback passed to "foreach frame" functions.
pub const FrameCallback = *const fn (p_frame: *panel.Frame, p_user_data: ?*anyopaque) callconv(.c) void;

/// This function is called for each workspace window within a `panel.Workbench`
/// when using `panel.Workbench.foreachWorkspace`.
pub const WorkspaceForeach = *const fn (p_workspace: *panel.Workspace, p_user_data: ?*anyopaque) callconv(.c) void;

/// libpanel major version component (e.g. 1 if `PANEL_VERSION` is 1.2.3)
pub const MAJOR_VERSION = 1;
/// libpanel micro version component (e.g. 3 if `PANEL_VERSION` is 1.2.3)
pub const MICRO_VERSION = 2;
/// libpanel minor version component (e.g. 2 if `PANEL_VERSION` is 1.2.3)
pub const MINOR_VERSION = 10;
/// libpanel version, encoded as a string, useful for printing and
/// concatenation.
pub const VERSION_S = "1.10.2";
pub const WIDGET_KIND_ANY = "*";
pub const WIDGET_KIND_DOCUMENT = "document";
pub const WIDGET_KIND_UNKNOWN = "unknown";
pub const WIDGET_KIND_UTILITY = "utility";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
