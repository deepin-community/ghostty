pub const ext = @import("ext.zig");
const xdp = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// A representation of a pointer barrier on an `InputCaptureZone`.
/// Barriers can be assigned with
/// `InputCaptureSession.setPointerBarriers`, once the Portal
/// interaction is complete the barrier's "is-active" state indicates whether
/// the barrier is active. Barriers can only be used once, subsequent calls to
/// `InputCaptureSession.setPointerBarriers` will invalidate all
/// current barriers.
pub const InputCapturePointerBarrier = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = xdp.InputCapturePointerBarrierClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The caller-assigned unique id of this barrier
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_uint;
        };

        /// A boolean indicating whether this barrier is active. A barrier cannot
        /// become active once it failed to apply, barriers that are not active can
        /// be thus cleaned up by the caller.
        pub const is_active = struct {
            pub const name = "is-active";

            pub const Type = c_int;
        };

        /// The pointer barrier x offset in logical pixels
        pub const x1 = struct {
            pub const name = "x1";

            pub const Type = c_int;
        };

        /// The pointer barrier x offset in logical pixels
        pub const x2 = struct {
            pub const name = "x2";

            pub const Type = c_int;
        };

        /// The pointer barrier y offset in logical pixels
        pub const y1 = struct {
            pub const name = "y1";

            pub const Type = c_int;
        };

        /// The pointer barrier y offset in logical pixels
        pub const y2 = struct {
            pub const name = "y2";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn xdp_input_capture_pointer_barrier_get_type() usize;
    pub const getGObjectType = xdp_input_capture_pointer_barrier_get_type;

    extern fn g_object_ref(p_self: *xdp.InputCapturePointerBarrier) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *xdp.InputCapturePointerBarrier) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *InputCapturePointerBarrier, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A representation of a long-lived input capture portal interaction.
///
/// The `InputCaptureSession` object is used to represent portal
/// interactions with the input capture desktop portal that extend over
/// multiple portal calls. Usually a caller creates an input capture session,
/// requests the available zones and sets up pointer barriers on those zones
/// before enabling the session.
///
/// To find available zones, call `InputCaptureSession.getZones`.
/// These `InputCaptureZone` object represent the accessible desktop area
/// for input capturing. `InputCapturePointerBarrier` objects can be set
/// up on these zones to trigger input capture.
///
/// The `InputCaptureSession` wraps a `Session` object.
pub const InputCaptureSession = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = xdp.InputCaptureSessionClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when an InputCapture session activates and sends events. When this
        /// signal is emitted, events will appear on the transport layer.
        pub const activated = struct {
            pub const name = "activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_activation_id: c_uint, p_options: *glib.Variant, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(InputCaptureSession, p_instance))),
                    gobject.signalLookup("activated", InputCaptureSession.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an InputCapture session deactivates and no longer sends
        /// events.
        pub const deactivated = struct {
            pub const name = "deactivated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_activation_id: c_uint, p_options: *glib.Variant, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(InputCaptureSession, p_instance))),
                    gobject.signalLookup("deactivated", InputCaptureSession.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an InputCapture session is disabled. This signal
        /// is emitted when capturing was disabled by the server.
        pub const disabled = struct {
            pub const name = "disabled";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_options: *glib.Variant, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(InputCaptureSession, p_instance))),
                    gobject.signalLookup("disabled", InputCaptureSession.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an InputCapture session's zones have changed. When this
        /// signal is emitted, all current zones will have their
        /// `InputCaptureZone.properties.is_valid` property set to `FALSE` and all
        /// internal references to those zones have been released. This signal is
        /// sent after libportal has fetched the updated zones, a caller should call
        /// `xdp.InputCaptureSession.getZones` to retrieve the new zones.
        pub const zones_changed = struct {
            pub const name = "zones-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_options: *glib.Variant, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(InputCaptureSession, p_instance))),
                    gobject.signalLookup("zones-changed", InputCaptureSession.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Connect this session to an EIS implementation and return the fd.
    /// This fd can be passed into `ei_setup_backend_fd`. See the libei
    /// documentation for details.
    ///
    /// This is a sync DBus invocation.
    extern fn xdp_input_capture_session_connect_to_eis(p_session: *InputCaptureSession, p_error: ?*?*glib.Error) c_int;
    pub const connectToEis = xdp_input_capture_session_connect_to_eis;

    /// Disables this input capture session.
    extern fn xdp_input_capture_session_disable(p_session: *InputCaptureSession) void;
    pub const disable = xdp_input_capture_session_disable;

    /// Enables this input capture session. In the future, this client may receive
    /// input events.
    extern fn xdp_input_capture_session_enable(p_session: *InputCaptureSession) void;
    pub const enable = xdp_input_capture_session_enable;

    /// Return the `XdpSession` for this InputCapture session.
    extern fn xdp_input_capture_session_get_session(p_session: *InputCaptureSession) *xdp.Session;
    pub const getSession = xdp_input_capture_session_get_session;

    /// Obtains the current set of `InputCaptureZone` objects.
    ///
    /// The returned object is valid until the zones are invalidated by the
    /// `InputCaptureSession.signals.zones_changed` signal.
    ///
    /// Unless the session is active, this function returns `NULL`.
    extern fn xdp_input_capture_session_get_zones(p_session: *InputCaptureSession) *glib.List;
    pub const getZones = xdp_input_capture_session_get_zones;

    /// Releases this input capture session without a suggested cursor position.
    extern fn xdp_input_capture_session_release(p_session: *InputCaptureSession, p_activation_id: c_uint) void;
    pub const release = xdp_input_capture_session_release;

    /// Releases this input capture session with a suggested cursor position.
    /// Note that the implementation is not required to honour this position.
    extern fn xdp_input_capture_session_release_at(p_session: *InputCaptureSession, p_activation_id: c_uint, p_cursor_x_position: f64, p_cursor_y_position: f64) void;
    pub const releaseAt = xdp_input_capture_session_release_at;

    /// Sets the pointer barriers for this session. When the request is done,
    /// `callback` will be called. You can then call
    /// `InputCaptureSession.setPointerBarriersFinish` to
    /// get the results. The result of this request is the list of pointer barriers
    /// that failed to apply - barriers not present in the returned list are active.
    ///
    /// Once the pointer barrier is
    /// applied (i.e. the reply to the DBus Request has been received), the
    /// the `InputCapturePointerBarrier.properties.is_active` property is changed on
    /// that barrier. Failed barriers have the property set to a `FALSE` value.
    extern fn xdp_input_capture_session_set_pointer_barriers(p_session: *InputCaptureSession, p_barriers: *glib.List, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const setPointerBarriers = xdp_input_capture_session_set_pointer_barriers;

    /// Finishes the set-pointer-barriers request, and returns a GList with the pointer
    /// barriers that failed to apply and should be cleaned up by the caller.
    extern fn xdp_input_capture_session_set_pointer_barriers_finish(p_session: *InputCaptureSession, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.List;
    pub const setPointerBarriersFinish = xdp_input_capture_session_set_pointer_barriers_finish;

    extern fn xdp_input_capture_session_get_type() usize;
    pub const getGObjectType = xdp_input_capture_session_get_type;

    extern fn g_object_ref(p_self: *xdp.InputCaptureSession) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *xdp.InputCaptureSession) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *InputCaptureSession, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A representation of a zone that supports input capture.
///
/// The `XdpInputCaptureZone` object is used to represent a zone on the
/// user-visible desktop that may be used to set up
/// `XdpInputCapturePointerBarrier` objects. In most cases, the set of
/// `XdpInputCaptureZone` objects represent the available monitors but the
/// exact implementation is up to the implementation.
pub const InputCaptureZone = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = xdp.InputCaptureZoneClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The height of this zone in logical pixels
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_uint;
        };

        /// A boolean indicating whether this zone is currently valid. Zones are
        /// invalidated by the Portal's ZonesChanged signal, see
        /// `InputCaptureSession.signals.zones_changed`.
        ///
        /// Once invalidated, a Zone can be discarded by the caller, it cannot become
        /// valid again.
        pub const is_valid = struct {
            pub const name = "is-valid";

            pub const Type = c_int;
        };

        /// The width of this zone in logical pixels
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_uint;
        };

        /// The x offset of this zone in logical pixels
        pub const x = struct {
            pub const name = "x";

            pub const Type = c_int;
        };

        /// The x offset of this zone in logical pixels
        pub const y = struct {
            pub const name = "y";

            pub const Type = c_int;
        };

        pub const zone_set = struct {
            pub const name = "zone-set";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    extern fn xdp_input_capture_zone_get_type() usize;
    pub const getGObjectType = xdp_input_capture_zone_get_type;

    extern fn g_object_ref(p_self: *xdp.InputCaptureZone) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *xdp.InputCaptureZone) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *InputCaptureZone, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Context for portal calls.
///
/// The XdpPortal object provides the main context object
/// for the portal operations of libportal.
///
/// Typically, an application will create a single XdpPortal
/// object with `Portal.new` and use it throughout its lifetime.
pub const Portal = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = xdp.PortalClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when location monitoring is enabled and the location changes.
        pub const location_updated = struct {
            pub const name = "location-updated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_latitude: f64, p_longitude: f64, p_altitude: f64, p_accuracy: f64, p_speed: f64, p_heading: f64, p_description: [*:0]u8, p_timestamp_s: i64, p_timestamp_ms: i64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Portal, p_instance))),
                    gobject.signalLookup("location-updated", Portal.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a non-exported action is activated on a notification.
        pub const notification_action_invoked = struct {
            pub const name = "notification-action-invoked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_id: [*:0]u8, p_action: [*:0]u8, p_parameter: ?*glib.Variant, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Portal, p_instance))),
                    gobject.signalLookup("notification-action-invoked", Portal.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when session state monitoring is
        /// enabled and the state of the login session changes or
        /// the screensaver is activated or deactivated.
        pub const session_state_changed = struct {
            pub const name = "session-state-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_screensaver_active: c_int, p_session_state: xdp.LoginSessionState, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Portal, p_instance))),
                    gobject.signalLookup("session-state-changed", Portal.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a process that was spawned with `Portal.spawn` exits.
        pub const spawn_exited = struct {
            pub const name = "spawn-exited";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_pid: c_uint, p_exit_status: c_uint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Portal, p_instance))),
                    gobject.signalLookup("spawn-exited", Portal.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when updates monitoring is enabled
        /// and a new update is available.
        ///
        /// It is only sent once with the same information, but it can be sent many
        /// times if new updates appear.
        pub const update_available = struct {
            pub const name = "update-available";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_running_commit: [*:0]u8, p_local_commit: [*:0]u8, p_remote_commit: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Portal, p_instance))),
                    gobject.signalLookup("update-available", Portal.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted to indicate progress of an update installation.
        ///
        /// It is undefined exactly how often it is sent, but it will be emitted at
        /// least once at the end with a non-zero `status`. For each successful
        /// operation in the update, we're also guaranteed to send exactly one signal
        /// with `progress` 100.
        pub const update_progress = struct {
            pub const name = "update-progress";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_n_ops: c_uint, p_op: c_uint, p_progress: c_uint, p_status: xdp.UpdateStatus, p_error: [*:0]u8, p_error_message: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Portal, p_instance))),
                    gobject.signalLookup("update-progress", Portal.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Detects if running inside of a Flatpak or WebKit sandbox.
    ///
    /// See also: `Portal.runningUnderSandbox`.
    extern fn xdp_portal_running_under_flatpak() c_int;
    pub const runningUnderFlatpak = xdp_portal_running_under_flatpak;

    /// This function tries to determine if the current process is running under a
    /// sandbox that requires the use of portals.
    ///
    /// If you need to check error conditions see `Portal.runningUnderSnap`.
    ///
    /// Note that these functions are all cached and will always return the same result.
    extern fn xdp_portal_running_under_sandbox() c_int;
    pub const runningUnderSandbox = xdp_portal_running_under_sandbox;

    /// Detects if you are running inside of a Snap sandbox.
    ///
    /// See also: `Portal.runningUnderSandbox`.
    extern fn xdp_portal_running_under_snap(p_error: ?*?*glib.Error) c_int;
    pub const runningUnderSnap = xdp_portal_running_under_snap;

    /// Creates a new `Portal` object.
    extern fn xdp_portal_initable_new(p_error: ?*?*glib.Error) ?*xdp.Portal;
    pub const initableNew = xdp_portal_initable_new;

    /// Creates a new `Portal` object. If D-Bus is unavailable this API will abort.
    /// We recommend using `xdp.Portal.initableNew` to safely handle this failure.
    extern fn xdp_portal_new() *xdp.Portal;
    pub const new = xdp_portal_new;

    /// Request access to a camera.
    ///
    /// When the request is done, `callback` will be called.
    /// You can then call `Portal.accessCameraFinish`
    /// to get the results.
    extern fn xdp_portal_access_camera(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_flags: xdp.CameraFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const accessCamera = xdp_portal_access_camera;

    /// Finishes a camera acess request.
    ///
    /// Returns the result as a boolean.
    ///
    /// If the access was granted, you can then call
    /// `Portal.openPipewireRemoteForCamera`
    /// to obtain a pipewire remote.
    extern fn xdp_portal_access_camera_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const accessCameraFinish = xdp_portal_access_camera_finish;

    /// Sends a desktop notification.
    ///
    /// The following keys may be present in `notification`:
    ///
    /// - title `s`: a user-visible string to display as title
    /// - body `s`: a user-visible string to display as body
    /// - markup-body `s`: a user-visible string to display as body with support for markup
    /// - icon `v`: a serialized icon (in the format produced by `gio.Icon.serialize`
    ///   for class`Gio`.ThemedIcon, class`Gio`.FileIcon and class`Gio`.BytesIcon)
    /// - sound `v`: a serialized sound
    /// - priority `s`: "low", "normal", "high" or "urgent"
    /// - default-action `s`: name of an action that
    ///     will be activated when the user clicks on the notification
    /// - default-action-target `v`: target parameter to send along when
    ///     activating the default action.
    /// - buttons `aa{sv}`: array of serialized buttons
    /// - display-hint `as`: An array of display hints.
    /// - category `s`: A category for this notification. [See the spec for supported categories](https://flatpak.github.io/xdg-desktop-portal/docs/doc-org.freedesktop.portal.Notification.html`org`-freedesktop-portal-notification-addnotification)
    ///
    /// The serialized sound consists of a `s` or `sv`:
    /// - default : Play the default sound for the notification.
    /// - silent : Don't ever play a sound for the notification.
    /// - file `s`: A path to a sound file.
    /// - bytes `ay`: An array of bytes.
    ///
    /// The supported sound formats are ogg/opus, ogg/vorbis and wav/pcm.
    ///
    /// Each serialized button is a dictionary with the following supported keys:
    ///
    /// - label `s`: user-visible label for the button. Mandatory without a purpose.
    /// - action `s`: name of an action that will be activated when
    ///     the user clicks on the button. Mandatory
    /// - purpose `s`: information used by the server to style the button specially.
    /// - target `v`: target parameter to send along when activating
    ///     the button
    ///
    /// Actions with a prefix of "app." are assumed to be exported by the
    /// application and will be activated via the org.freedesktop.Application
    /// interface, others are activated by emitting the
    /// `Portal.signals.notification_action_invoked` signal.
    ///
    /// It is the callers responsibility to ensure that the ID is unique
    /// among all notifications.
    ///
    /// To withdraw a notification, use `Portal.removeNotification`.
    extern fn xdp_portal_add_notification(p_portal: *Portal, p_id: [*:0]const u8, p_notification: *glib.Variant, p_flags: xdp.NotificationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const addNotification = xdp_portal_add_notification;

    /// Finishes the notification request.
    ///
    /// Returns the result as a boolean.
    extern fn xdp_portal_add_notification_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const addNotificationFinish = xdp_portal_add_notification_finish;

    /// Presents a window that lets the user compose an email,
    /// with some pre-filled information.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.composeEmailFinish` to get the results.
    extern fn xdp_portal_compose_email(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_addresses: ?[*]const [*:0]const u8, p_cc: ?[*]const [*:0]const u8, p_bcc: ?[*]const [*:0]const u8, p_subject: ?[*:0]const u8, p_body: ?[*:0]const u8, p_attachments: ?[*]const [*:0]const u8, p_flags: xdp.EmailFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const composeEmail = xdp_portal_compose_email;

    /// Finishes the compose-email request.
    extern fn xdp_portal_compose_email_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const composeEmailFinish = xdp_portal_compose_email_finish;

    /// Creates a session for input capture
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.createInputCaptureSessionFinish` to get the results.
    extern fn xdp_portal_create_input_capture_session(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_capabilities: xdp.InputCapability, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const createInputCaptureSession = xdp_portal_create_input_capture_session;

    /// Finishes the InputCapture CreateSession request, and returns a
    /// `InputCaptureSession`. To get to the `Session` within use
    /// `xdp.InputCaptureSession.getSession`.
    extern fn xdp_portal_create_input_capture_session_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*xdp.InputCaptureSession;
    pub const createInputCaptureSessionFinish = xdp_portal_create_input_capture_session_finish;

    /// Creates a session for remote desktop.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.createRemoteDesktopSessionFinish` to get the results.
    extern fn xdp_portal_create_remote_desktop_session(p_portal: *Portal, p_devices: xdp.DeviceType, p_outputs: xdp.OutputType, p_flags: xdp.RemoteDesktopFlags, p_cursor_mode: xdp.CursorMode, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const createRemoteDesktopSession = xdp_portal_create_remote_desktop_session;

    /// Finishes the create-remote-desktop request, and returns a `Session`.
    extern fn xdp_portal_create_remote_desktop_session_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*xdp.Session;
    pub const createRemoteDesktopSessionFinish = xdp_portal_create_remote_desktop_session_finish;

    /// Creates a session for remote desktop.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.createRemoteDesktopSessionFinish` to get the results.
    extern fn xdp_portal_create_remote_desktop_session_full(p_portal: *Portal, p_devices: xdp.DeviceType, p_outputs: xdp.OutputType, p_flags: xdp.RemoteDesktopFlags, p_cursor_mode: xdp.CursorMode, p_persist_mode: xdp.PersistMode, p_restore_token: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const createRemoteDesktopSessionFull = xdp_portal_create_remote_desktop_session_full;

    /// Creates a session for a screencast.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.createScreencastSessionFinish` to get the results.
    extern fn xdp_portal_create_screencast_session(p_portal: *Portal, p_outputs: xdp.OutputType, p_flags: xdp.ScreencastFlags, p_cursor_mode: xdp.CursorMode, p_persist_mode: xdp.PersistMode, p_restore_token: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const createScreencastSession = xdp_portal_create_screencast_session;

    /// Finishes the create-screencast request, and returns a `Session`.
    extern fn xdp_portal_create_screencast_session_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*xdp.Session;
    pub const createScreencastSessionFinish = xdp_portal_create_screencast_session_finish;

    /// This function gets the contents of a .desktop file that was previously
    /// installed by the dynamic launcher portal.
    ///
    /// The `desktop_file_id` must be prefixed with the caller's app ID followed by a
    /// "." and suffixed with ".desktop".
    extern fn xdp_portal_dynamic_launcher_get_desktop_entry(p_portal: *Portal, p_desktop_file_id: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const dynamicLauncherGetDesktopEntry = xdp_portal_dynamic_launcher_get_desktop_entry;

    /// This function gets the icon associated with a .desktop file that was previously
    /// installed by the dynamic launcher portal.
    ///
    /// The `desktop_file_id` must be prefixed with the caller's app ID followed by a
    /// "." and suffixed with ".desktop".
    extern fn xdp_portal_dynamic_launcher_get_icon(p_portal: *Portal, p_desktop_file_id: [*:0]const u8, p_out_icon_format: ?*[*:0]u8, p_out_icon_size: ?*c_uint, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const dynamicLauncherGetIcon = xdp_portal_dynamic_launcher_get_icon;

    /// This function completes installation of a launcher so that the icon and name
    /// given in previous method calls will show up in the desktop environment's menu.
    ///
    /// The `desktop_file_id` must be prefixed with the caller's app ID followed by a
    /// "." and suffixed with ".desktop".
    ///
    /// The `desktop_entry` data need not include Icon= or Name= entries since these
    /// will be added by the portal, and the Exec= entry will be rewritten to call
    /// the application with e.g. "flatpak run" depending on the sandbox status of
    /// the app.
    extern fn xdp_portal_dynamic_launcher_install(p_portal: *Portal, p_token: [*:0]const u8, p_desktop_file_id: [*:0]const u8, p_desktop_entry: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const dynamicLauncherInstall = xdp_portal_dynamic_launcher_install;

    extern fn xdp_portal_dynamic_launcher_launch(p_portal: *Portal, p_desktop_file_id: [*:0]const u8, p_activation_token: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const dynamicLauncherLaunch = xdp_portal_dynamic_launcher_launch;

    /// Presents a dialog to the user so they can confirm they want to install a
    /// launcher to their desktop.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.dynamicLauncherPrepareInstallFinish` to get the results.
    extern fn xdp_portal_dynamic_launcher_prepare_install(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_name: [*:0]const u8, p_icon_v: *glib.Variant, p_launcher_type: xdp.LauncherType, p_target: ?[*:0]const u8, p_editable_name: c_int, p_editable_icon: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const dynamicLauncherPrepareInstall = xdp_portal_dynamic_launcher_prepare_install;

    /// Finishes the prepare-install-launcher request, and returns
    /// `glib.Variant` dictionary with the following information:
    ///
    /// - name s: the name chosen by the user (or the provided name if the
    ///     editable_name option was not set)
    /// - token s: a token that can by used in a `Portal.dynamicLauncherInstall`
    ///     call to complete the installation
    extern fn xdp_portal_dynamic_launcher_prepare_install_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const dynamicLauncherPrepareInstallFinish = xdp_portal_dynamic_launcher_prepare_install_finish;

    /// Requests a token which can be passed to `Portal.dynamicLauncherInstall`
    /// to complete installation of the launcher without user interaction.
    ///
    /// This function only works when the caller's app ID is in the allowlist for
    /// the portal backend being used. It's intended for software centers such as
    /// GNOME Software or KDE Discover.
    extern fn xdp_portal_dynamic_launcher_request_install_token(p_portal: *Portal, p_name: [*:0]const u8, p_icon_v: *glib.Variant, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const dynamicLauncherRequestInstallToken = xdp_portal_dynamic_launcher_request_install_token;

    /// This function uninstalls a launcher that was previously installed using the
    /// dynamic launcher portal, resulting in the .desktop file and icon being deleted.
    ///
    /// The `desktop_file_id` must be prefixed with the caller's app ID followed by a
    /// "." and suffixed with ".desktop".
    extern fn xdp_portal_dynamic_launcher_uninstall(p_portal: *Portal, p_desktop_file_id: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const dynamicLauncherUninstall = xdp_portal_dynamic_launcher_uninstall;

    /// This function returns an object to access settings exposed through
    /// the portal.
    extern fn xdp_portal_get_settings(p_portal: *Portal) *xdp.Settings;
    pub const getSettings = xdp_portal_get_settings;

    extern fn xdp_portal_get_supported_notification_options(p_portal: *Portal, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const getSupportedNotificationOptions = xdp_portal_get_supported_notification_options;

    /// Gets information about the user.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.getUserInformationFinish` to get the results.
    extern fn xdp_portal_get_user_information(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_reason: ?[*:0]const u8, p_flags: xdp.UserInformationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const getUserInformation = xdp_portal_get_user_information;

    /// Finishes the get-user-information request.
    ///
    /// Returns the result in the form of a `glib.Variant` dictionary
    /// containing the following fields:
    ///
    /// - id `s`: the user ID
    /// - name `s`: the users real name
    /// - image `s`: the uri of an image file for the users avatar picture
    extern fn xdp_portal_get_user_information_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const getUserInformationFinish = xdp_portal_get_user_information_finish;

    /// Returns whether any camera are present.
    extern fn xdp_portal_is_camera_present(p_portal: *Portal) c_int;
    pub const isCameraPresent = xdp_portal_is_camera_present;

    /// Makes `XdpPortal` start monitoring location changes.
    ///
    /// When the location changes, the `Portal.signals.location_updated`.
    /// signal is emitted.
    ///
    /// Use `Portal.locationMonitorStop` to stop monitoring.
    ///
    /// Note that `Portal` only maintains a single location monitor
    /// at a time. If you want to change the `distance_threshold`,
    /// `time_threshold` or `accuracy` of the current monitor, you
    /// first have to call `Portal.locationMonitorStop` to
    /// stop monitoring.
    extern fn xdp_portal_location_monitor_start(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_distance_threshold: c_uint, p_time_threshold: c_uint, p_accuracy: xdp.LocationAccuracy, p_flags: xdp.LocationMonitorFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const locationMonitorStart = xdp_portal_location_monitor_start;

    /// Finishes a location-monitor request.
    ///
    /// Returns result in the form of boolean.
    extern fn xdp_portal_location_monitor_start_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const locationMonitorStartFinish = xdp_portal_location_monitor_start_finish;

    /// Stops location monitoring that was started with
    /// `Portal.locationMonitorStart`.
    extern fn xdp_portal_location_monitor_stop(p_portal: *Portal) void;
    pub const locationMonitorStop = xdp_portal_location_monitor_stop;

    /// Opens the directory containing the file specified by the `uri`.
    ///
    /// which must be a file: uri pointing to a file that the application has access
    /// to.
    extern fn xdp_portal_open_directory(p_portal: *Portal, p_parent: *xdp.Parent_, p_uri: [*:0]const u8, p_flags: xdp.OpenUriFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const openDirectory = xdp_portal_open_directory;

    /// Finishes the open-directory request.
    ///
    /// Returns the result in the form of a boolean.
    extern fn xdp_portal_open_directory_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const openDirectoryFinish = xdp_portal_open_directory_finish;

    /// Asks the user to open one or more files.
    ///
    /// The format for the `filters` argument is `a(sa(us))`.
    /// Each item in the array specifies a single filter to offer to the user.
    /// The first string is a user-visible name for the filter. The `a(us)`
    /// specifies a list of filter strings, which can be either a glob pattern
    /// (indicated by 0) or a mimetype (indicated by 1).
    ///
    /// Example: `[('Images', [(0, '*.ico'), (1, 'image/png')]), ('Text', [(0, '*.txt')])]`
    ///
    /// The format for the `choices` argument is `a(ssa(ss)s)`.
    /// For each element, the first string is an ID that will be returned
    /// with the response, te second string is a user-visible label. The
    /// `a(ss)` is the list of choices, each being a is an ID and a
    /// user-visible label. The final string is the initial selection,
    /// or `""`, to let the portal decide which choice will be initially selected.
    /// None of the strings, except for the initial selection, should be empty.
    ///
    /// As a special case, passing an empty array for the list of choices
    /// indicates a boolean choice that is typically displayed as a check
    /// button, using `"true"` and `"false"` as the choices.
    ///
    /// Example: `[('encoding', 'Encoding', [('utf8', 'Unicode (UTF-8)'), ('latin15', 'Western')], 'latin15'), ('reencode', 'Reencode', [], 'false')]`
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.openFileFinish` to get the results.
    extern fn xdp_portal_open_file(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_title: [*:0]const u8, p_filters: ?*glib.Variant, p_current_filter: ?*glib.Variant, p_choices: ?*glib.Variant, p_flags: xdp.OpenFileFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const openFile = xdp_portal_open_file;

    /// Finishes the open-file request
    ///
    /// Returns the result in the form of a `glib.Variant` dictionary
    /// containing the following fields:
    ///
    /// - uris `as`: an array of strings containing the uris of selected files
    /// - choices `a(ss)`: an array of pairs of strings, the first string being the
    ///     ID of a combobox that was passed into this call, the second string
    ///     being the selected option.
    extern fn xdp_portal_open_file_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const openFileFinish = xdp_portal_open_file_finish;

    /// Opens a file descriptor to the pipewire remote where the camera
    /// nodes are available.
    ///
    /// The file descriptor should be used to create a pw_core object, by using
    /// `pw_context_connect_fd`. Only the camera nodes will be available from this
    /// pipewire node.
    extern fn xdp_portal_open_pipewire_remote_for_camera(p_portal: *Portal) c_int;
    pub const openPipewireRemoteForCamera = xdp_portal_open_pipewire_remote_for_camera;

    /// Opens `uri` with an external handler.
    extern fn xdp_portal_open_uri(p_portal: *Portal, p_parent: *xdp.Parent_, p_uri: [*:0]const u8, p_flags: xdp.OpenUriFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const openUri = xdp_portal_open_uri;

    /// Finishes the open-uri request.
    ///
    /// Returns the result in the form of a boolean.
    extern fn xdp_portal_open_uri_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const openUriFinish = xdp_portal_open_uri_finish;

    /// Lets the user pick a color from the screen.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.pickColorFinish` to get the results.
    extern fn xdp_portal_pick_color(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const pickColor = xdp_portal_pick_color;

    /// Finishes a pick-color request.
    ///
    /// Returns the result in the form of a GVariant of the form (ddd), containing
    /// red, green and blue components in the range [0,1].
    extern fn xdp_portal_pick_color_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const pickColorFinish = xdp_portal_pick_color_finish;

    /// Presents a print dialog to the user and returns print settings and page setup.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.preparePrintFinish` to get the results.
    extern fn xdp_portal_prepare_print(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_title: [*:0]const u8, p_settings: ?*glib.Variant, p_page_setup: ?*glib.Variant, p_flags: xdp.PrintFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const preparePrint = xdp_portal_prepare_print;

    /// Finishes the prepare-print request.
    ///
    /// Returns a `glib.Variant` dictionary with the following information:
    ///
    /// - settings `a{sv}`: print settings as set up by the user in the print dialog
    /// - page-setup `a{sv}: page setup as set up by the user in the print dialog
    /// - token u: a token that can by used in a `Portal.printFile` call to
    ///     avoid the print dialog
    extern fn xdp_portal_prepare_print_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const preparePrintFinish = xdp_portal_prepare_print_finish;

    /// Prints a file.
    ///
    /// If a valid token is present in the `options`, then this call will print
    /// with the settings from the Print call that the token refers to. If
    /// no token is present, then a print dialog will be presented to the user.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.printFileFinish` to get the results.
    extern fn xdp_portal_print_file(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_title: [*:0]const u8, p_token: c_uint, p_file: [*:0]const u8, p_flags: xdp.PrintFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const printFile = xdp_portal_print_file;

    /// Finishes the print request.
    extern fn xdp_portal_print_file_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const printFileFinish = xdp_portal_print_file_finish;

    /// Withdraws a desktop notification.
    extern fn xdp_portal_remove_notification(p_portal: *Portal, p_id: [*:0]const u8) void;
    pub const removeNotification = xdp_portal_remove_notification;

    /// Requests background permissions.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.requestBackgroundFinish` to get the results.
    extern fn xdp_portal_request_background(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_reason: ?[*:0]u8, p_commandline: ?*glib.PtrArray, p_flags: xdp.BackgroundFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const requestBackground = xdp_portal_request_background;

    /// Finishes the request.
    ///
    /// Returns `TRUE` if successful.
    extern fn xdp_portal_request_background_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const requestBackgroundFinish = xdp_portal_request_background_finish;

    /// Asks the user for a location to save a file.
    ///
    /// The format for the `filters` argument is the same as for `Portal.openFile`.
    ///
    /// The format for the `choices` argument is the same as for `Portal.openFile`.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.saveFileFinish` to get the results.
    extern fn xdp_portal_save_file(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_title: [*:0]const u8, p_current_name: ?[*:0]const u8, p_current_folder: ?[*:0]const u8, p_current_file: ?[*:0]const u8, p_filters: ?*glib.Variant, p_current_filter: ?*glib.Variant, p_choices: ?*glib.Variant, p_flags: xdp.SaveFileFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const saveFile = xdp_portal_save_file;

    /// Finishes the save-file request.
    ///
    /// Returns the result in the form of a `glib.Variant` dictionary
    /// containing the following fields:
    ///
    /// - uris `(as)`: an array of strings containing the uri of the selected file
    /// - choices `a(ss)`: an array of pairs of strings, the first string being the
    ///   ID of a combobox that was passed into this call, the second string
    ///   being the selected option.
    extern fn xdp_portal_save_file_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const saveFileFinish = xdp_portal_save_file_finish;

    /// Asks for a folder as a location to save one or more files.
    ///
    /// The names of the files will be used as-is and appended to the selected
    /// folder's path in the list of returned files. If the selected folder already
    /// contains a file with one of the given names, the portal may prompt or take
    /// some other action to construct a unique file name and return that instead.
    ///
    /// The format for the `choices` argument is the same as for `Portal.openFile`.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.saveFileFinish` to get the results.
    extern fn xdp_portal_save_files(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_title: [*:0]const u8, p_current_name: ?[*:0]const u8, p_current_folder: ?[*:0]const u8, p_files: *glib.Variant, p_choices: ?*glib.Variant, p_flags: xdp.SaveFileFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const saveFiles = xdp_portal_save_files;

    /// Finishes the save-files request.
    ///
    /// Returns the result in the form of a `glib.Variant` dictionary
    /// containing the following fields:
    ///
    /// - uris `(as)`: an array of strings containing the uri corresponding to each
    ///   file passed to the save-files request, in the same order. Note that the
    ///   file names may have changed, for example if a file with the same name in
    ///   the selected folder already exists.
    /// - choices `a(ss)`: an array of pairs of strings, the first string being the
    ///   ID of a combobox that was passed into this call, the second string
    ///   being the selected option.
    extern fn xdp_portal_save_files_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const saveFilesFinish = xdp_portal_save_files_finish;

    /// Inhibits various session status changes.
    ///
    /// To obtain an ID that can be used to undo the inhibition, use
    /// `Portal.sessionInhibitFinish` in the callback.
    ///
    /// To remove an active inhibitor, call `Portal.sessionUninhibit`
    /// with the same ID.
    extern fn xdp_portal_session_inhibit(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_reason: ?[*:0]const u8, p_flags: xdp.InhibitFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const sessionInhibit = xdp_portal_session_inhibit;

    /// Finishes the inhbit request.
    ///
    /// Returns the ID of the inhibition as a positive integer. The ID can be passed
    /// to `Portal.sessionUninhibit` to undo the inhibition.
    extern fn xdp_portal_session_inhibit_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const sessionInhibitFinish = xdp_portal_session_inhibit_finish;

    /// This method should be called within one second of
    /// receiving a `Portal.signals.session_state_changed` signal
    /// with the 'Query End' state, to acknowledge that they
    /// have handled the state change.
    ///
    /// Possible ways to handle the state change are either
    /// to call `Portal.sessionInhibit` to prevent the
    /// session from ending, or to save your state and get
    /// ready for the session to end.
    extern fn xdp_portal_session_monitor_query_end_response(p_portal: *Portal) void;
    pub const sessionMonitorQueryEndResponse = xdp_portal_session_monitor_query_end_response;

    /// Makes `Portal` start monitoring the login session state.
    ///
    /// When the state changes, the `Portal.signals.session_state_changed`
    /// signal is emitted.
    ///
    /// Use `Portal.sessionMonitorStop` to stop monitoring.
    extern fn xdp_portal_session_monitor_start(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_flags: xdp.SessionMonitorFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const sessionMonitorStart = xdp_portal_session_monitor_start;

    /// Finishes a session-monitor request.
    ///
    /// Returns the result in the form of boolean.
    extern fn xdp_portal_session_monitor_start_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const sessionMonitorStartFinish = xdp_portal_session_monitor_start_finish;

    /// Stops session state monitoring that was started with
    /// `Portal.sessionMonitorStart`.
    extern fn xdp_portal_session_monitor_stop(p_portal: *Portal) void;
    pub const sessionMonitorStop = xdp_portal_session_monitor_stop;

    /// Removes an inhibitor that was created by a call
    /// to `Portal.sessionInhibit`.
    extern fn xdp_portal_session_uninhibit(p_portal: *Portal, p_id: c_int) void;
    pub const sessionUninhibit = xdp_portal_session_uninhibit;

    /// Sets the status information of the application, for when it's running
    /// in background.
    extern fn xdp_portal_set_background_status(p_portal: *Portal, p_status_message: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const setBackgroundStatus = xdp_portal_set_background_status;

    /// Finishes setting the background status of the application.
    extern fn xdp_portal_set_background_status_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const setBackgroundStatusFinish = xdp_portal_set_background_status_finish;

    /// Sets a desktop background image, given by a uri.
    extern fn xdp_portal_set_wallpaper(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_uri: [*:0]const u8, p_flags: xdp.WallpaperFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const setWallpaper = xdp_portal_set_wallpaper;

    /// Finishes the open-uri request.
    ///
    /// Returns the result in the form of a boolean.
    extern fn xdp_portal_set_wallpaper_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const setWallpaperFinish = xdp_portal_set_wallpaper_finish;

    /// Creates a new copy of the applications sandbox, and runs
    /// a process in, with the given arguments.
    ///
    /// The learn when the spawned process exits, connect to the
    /// `Portal.signals.spawn_exited` signal.
    extern fn xdp_portal_spawn(p_portal: *Portal, p_cwd: [*:0]const u8, p_argv: [*]const [*:0]const u8, p_fds: ?[*]c_int, p_map_to: ?[*]c_int, p_n_fds: c_int, p_env: ?[*]const [*:0]const u8, p_flags: xdp.SpawnFlags, p_sandbox_expose: ?[*]const [*:0]const u8, p_sandbox_expose_ro: ?[*]const [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const spawn = xdp_portal_spawn;

    /// Finishes the spawn request.
    ///
    /// Returns the pid of the newly spawned process.
    extern fn xdp_portal_spawn_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) std.posix.pid_t;
    pub const spawnFinish = xdp_portal_spawn_finish;

    /// Sends a Unix signal to a process that has been spawned
    /// by `Portal.spawn`.
    extern fn xdp_portal_spawn_signal(p_portal: *Portal, p_pid: std.posix.pid_t, p_signal: c_int, p_to_process_group: c_int) void;
    pub const spawnSignal = xdp_portal_spawn_signal;

    /// Takes a screenshot.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Portal.takeScreenshotFinish` to get the results.
    extern fn xdp_portal_take_screenshot(p_portal: *Portal, p_parent: ?*xdp.Parent_, p_flags: xdp.ScreenshotFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const takeScreenshot = xdp_portal_take_screenshot;

    /// Finishes a screenshot request.
    ///
    /// Returns the result in the form of a URI pointing to an image file.
    extern fn xdp_portal_take_screenshot_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const takeScreenshotFinish = xdp_portal_take_screenshot_finish;

    /// Sends the file at `path` to the trash can.
    extern fn xdp_portal_trash_file(p_portal: *Portal, p_path: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const trashFile = xdp_portal_trash_file;

    /// Finishes the trash-file request.
    ///
    /// Returns the result in the form of a boolean.
    extern fn xdp_portal_trash_file_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const trashFileFinish = xdp_portal_trash_file_finish;

    /// Installs an available software update.
    ///
    /// This should be called in response to a `Portal.signals.update_available`
    /// signal.
    ///
    /// During the update installation, the `Portal.signals.update_progress`
    /// signal will be emitted to provide progress information.
    extern fn xdp_portal_update_install(p_portal: *Portal, p_parent: *xdp.Parent_, p_flags: xdp.UpdateInstallFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const updateInstall = xdp_portal_update_install;

    /// Finishes an update-installation request.
    ///
    /// Returns the result in the form of boolean.
    ///
    /// Note that the update may not be completely installed
    /// by the time this function is called. You need to
    /// listen to the `Portal.signals.update_progress` signal
    /// to learn when the installation is complete.
    extern fn xdp_portal_update_install_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const updateInstallFinish = xdp_portal_update_install_finish;

    /// Makes `XdpPortal` start monitoring for available software updates.
    ///
    /// When a new update is available, the `Portal.signals.update_available`.
    /// signal is emitted.
    ///
    /// Use `Portal.updateMonitorStop` to stop monitoring.
    extern fn xdp_portal_update_monitor_start(p_portal: *Portal, p_flags: xdp.UpdateMonitorFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const updateMonitorStart = xdp_portal_update_monitor_start;

    /// Finishes an update-monitor request.
    ///
    /// Returns the result in the form of boolean.
    extern fn xdp_portal_update_monitor_start_finish(p_portal: *Portal, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const updateMonitorStartFinish = xdp_portal_update_monitor_start_finish;

    /// Stops update monitoring that was started with
    /// `Portal.updateMonitorStart`.
    extern fn xdp_portal_update_monitor_stop(p_portal: *Portal) void;
    pub const updateMonitorStop = xdp_portal_update_monitor_stop;

    extern fn xdp_portal_get_type() usize;
    pub const getGObjectType = xdp_portal_get_type;

    extern fn g_object_ref(p_self: *xdp.Portal) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *xdp.Portal) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Portal, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A representation of long-lived screencast portal interactions.
///
/// The XdpSession object is used to represent portal interactions with the
/// screencast or remote desktop portals that extend over multiple portal calls.
///
/// To find out what kind of session an XdpSession object represents and whether
/// it is still active, you can use `Session.getSessionType` and
/// `Session.getSessionState`.
///
/// All sessions start in an initial state. They can be made active by calling
/// `Session.start`, and ended by calling `Session.close`.
pub const Session = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = xdp.SessionClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when a session is closed externally.
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Session, p_instance))),
                    gobject.signalLookup("closed", Session.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Closes the session.
    extern fn xdp_session_close(p_session: *Session) void;
    pub const close = xdp_session_close;

    /// Connect this XdpRemoteDesktopSession to an EIS implementation and return the fd.
    /// This fd can be passed into `ei_setup_backend_fd`. See the libei
    /// documentation for details.
    ///
    /// This call must be issued before `xdp.Session.start`. If successful, all input
    /// event emulation must be handled via the EIS connection and calls to
    /// `xdp.Session.pointerMotion` etc. are silently ignored.
    extern fn xdp_session_connect_to_eis(p_session: *Session, p_error: ?*?*glib.Error) c_int;
    pub const connectToEis = xdp_session_connect_to_eis;

    /// Obtains the devices that the user selected.
    ///
    /// Unless the session is active, this function returns `XDP_DEVICE_NONE`.
    extern fn xdp_session_get_devices(p_session: *Session) xdp.DeviceType;
    pub const getDevices = xdp_session_get_devices;

    /// Retrieves the effective persist mode of `session`.
    ///
    /// May only be called after `session` is successfully started, i.e. after
    /// `Session.startFinish`.
    extern fn xdp_session_get_persist_mode(p_session: *Session) xdp.PersistMode;
    pub const getPersistMode = xdp_session_get_persist_mode;

    /// Retrieves the restore token of `session`.
    ///
    /// A restore token will only be available if `XDP_PERSIST_MODE_TRANSIENT`
    /// or `XDP_PERSIST_MODE_PERSISTENT` was passed when creating the screencast
    /// session.
    ///
    /// Remote desktop sessions cannot be restored.
    ///
    /// May only be called after `session` is successfully started, i.e. after
    /// `Session.startFinish`.
    extern fn xdp_session_get_restore_token(p_session: *Session) ?[*:0]u8;
    pub const getRestoreToken = xdp_session_get_restore_token;

    /// Obtains information about the state of the session that is represented
    /// by `session`.
    extern fn xdp_session_get_session_state(p_session: *Session) xdp.SessionState;
    pub const getSessionState = xdp_session_get_session_state;

    /// Obtains information about the type of session that is represented
    /// by `session`.
    extern fn xdp_session_get_session_type(p_session: *Session) xdp.SessionType;
    pub const getSessionType = xdp_session_get_session_type;

    /// Obtains the streams that the user selected.
    ///
    /// The information in the returned `glib.Variant` has the format
    /// `a(ua{sv})`. Each item in the array is describing a stream. The first member
    /// is the pipewire node ID, the second is a dictionary of stream properties,
    /// including:
    ///
    /// - position, `(ii)`: a tuple consisting of the position `(x, y)` in the compositor
    ///     coordinate space. Note that the position may not be equivalent to a
    ///     position in a pixel coordinate space. Only available for monitor streams.
    /// - size, `(ii)`: a tuple consisting of (width, height). The size represents the size
    ///     of the stream as it is displayed in the compositor coordinate space.
    ///     Note that this size may not be equivalent to a size in a pixel coordinate
    ///     space. The size may differ from the size of the stream.
    ///
    /// Unless the session is active, this function returns `NULL`.
    extern fn xdp_session_get_streams(p_session: *Session) *glib.Variant;
    pub const getStreams = xdp_session_get_streams;

    /// Changes the state of the key to `state`.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_KEYBOARD` access.
    extern fn xdp_session_keyboard_key(p_session: *Session, p_keysym: c_int, p_key: c_int, p_state: xdp.KeyState) void;
    pub const keyboardKey = xdp_session_keyboard_key;

    /// Opens a file descriptor to the pipewire remote where the screencast
    /// streams are available.
    ///
    /// The file descriptor should be used to create a pw_remote object, by using
    /// `pw_remote_connect_fd`. Only the screencast stream nodes will be available
    /// from this pipewire node.
    extern fn xdp_session_open_pipewire_remote(p_session: *Session) c_int;
    pub const openPipewireRemote = xdp_session_open_pipewire_remote;

    /// The axis movement from a smooth scroll device, such as a touchpad.
    /// When applicable, the size of the motion delta should be equivalent to
    /// the motion vector of a pointer motion done using the same advice.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_POINTER` access.
    extern fn xdp_session_pointer_axis(p_session: *Session, p_finish: c_int, p_dx: f64, p_dy: f64) void;
    pub const pointerAxis = xdp_session_pointer_axis;

    /// The axis movement from a discrete scroll device.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_POINTER` access.
    extern fn xdp_session_pointer_axis_discrete(p_session: *Session, p_axis: xdp.DiscreteAxis, p_steps: c_int) void;
    pub const pointerAxisDiscrete = xdp_session_pointer_axis_discrete;

    /// Changes the state of the button to `state`.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_POINTER` access.
    extern fn xdp_session_pointer_button(p_session: *Session, p_button: c_int, p_state: xdp.ButtonState) void;
    pub const pointerButton = xdp_session_pointer_button;

    /// Moves the pointer from its current position.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_POINTER` access.
    extern fn xdp_session_pointer_motion(p_session: *Session, p_dx: f64, p_dy: f64) void;
    pub const pointerMotion = xdp_session_pointer_motion;

    /// Moves the pointer to a new position in the given streams logical
    /// coordinate space.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_POINTER` access.
    extern fn xdp_session_pointer_position(p_session: *Session, p_stream: c_uint, p_x: f64, p_y: f64) void;
    pub const pointerPosition = xdp_session_pointer_position;

    /// Starts the session.
    ///
    /// When the request is done, `callback` will be called. You can then
    /// call `Session.startFinish` to get the results.
    extern fn xdp_session_start(p_session: *Session, p_parent: ?*xdp.Parent_, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const start = xdp_session_start;

    /// Finishes the session-start request.
    extern fn xdp_session_start_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const startFinish = xdp_session_start_finish;

    /// Notify about a new touch down event.
    ///
    /// The `(x, y)` position represents the new touch point position in the streams
    /// logical coordinate space.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_TOUCHSCREEN` access.
    extern fn xdp_session_touch_down(p_session: *Session, p_stream: c_uint, p_slot: c_uint, p_x: f64, p_y: f64) void;
    pub const touchDown = xdp_session_touch_down;

    /// Notify about a new touch motion event.
    ///
    /// The `(x, y)` position represents where the touch point position in the
    /// streams logical coordinate space moved.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_TOUCHSCREEN` access.
    extern fn xdp_session_touch_position(p_session: *Session, p_stream: c_uint, p_slot: c_uint, p_x: f64, p_y: f64) void;
    pub const touchPosition = xdp_session_touch_position;

    /// Notify about a new touch up event.
    ///
    /// May only be called on a remote desktop session
    /// with `XDP_DEVICE_TOUCHSCREEN` access.
    extern fn xdp_session_touch_up(p_session: *Session, p_slot: c_uint) void;
    pub const touchUp = xdp_session_touch_up;

    extern fn xdp_session_get_type() usize;
    pub const getGObjectType = xdp_session_get_type;

    extern fn g_object_ref(p_self: *xdp.Session) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *xdp.Session) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Session, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A representation of the settings exposed by the portal.
///
/// The `Settings` object is used to access and observe the settings
/// exposed by xdg-desktop-portal.
///
/// It is obtained from `Portal.getSettings`. Call
/// `Settings.readValue` to read a settings value. Connect to
/// `Settings.signals.changed` to observe value changes.
pub const Settings = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = xdp.SettingsClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when a setting value is changed externally.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_namespace: [*:0]u8, p_key: [*:0]u8, p_value: *glib.Variant, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
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

    /// Read a setting value within `namespace`, with `key`.
    ///
    /// A convenience function that combines `xdp.Settings.readValue` with
    /// `glib.Variant.get`.
    ///
    /// In case of error, if `error` is not NULL, then the error is
    /// returned.
    extern fn xdp_settings_read(p_settings: *Settings, p_namespace: [*:0]const u8, p_key: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: **glib.Error, p_format: [*:0]const u8, ...) void;
    pub const read = xdp_settings_read;

    /// Read all the setting values within `namespace`.
    extern fn xdp_settings_read_all_values(p_settings: *Settings, p_namespaces: *const [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const readAllValues = xdp_settings_read_all_values;

    /// Read a setting value as unsigned int within `namespace`, with `key`.
    extern fn xdp_settings_read_string(p_settings: *Settings, p_namespace: [*:0]const u8, p_key: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const readString = xdp_settings_read_string;

    /// Read a setting value as unsigned int within `namespace`, with `key`.
    extern fn xdp_settings_read_uint(p_settings: *Settings, p_namespace: [*:0]const u8, p_key: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_uint;
    pub const readUint = xdp_settings_read_uint;

    /// Read a setting value within `namespace`, with `key`.
    extern fn xdp_settings_read_value(p_settings: *Settings, p_namespace: [*:0]const u8, p_key: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.Variant;
    pub const readValue = xdp_settings_read_value;

    extern fn xdp_settings_get_type() usize;
    pub const getGObjectType = xdp_settings_get_type;

    extern fn g_object_ref(p_self: *xdp.Settings) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *xdp.Settings) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Settings, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InputCapturePointerBarrierClass = extern struct {
    pub const Instance = xdp.InputCapturePointerBarrier;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *InputCapturePointerBarrierClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InputCaptureSessionClass = extern struct {
    pub const Instance = xdp.InputCaptureSession;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *InputCaptureSessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InputCaptureZoneClass = extern struct {
    pub const Instance = xdp.InputCaptureZone;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *InputCaptureZoneClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Parent window abstraction.
///
/// The `Parent` struct provides an abstract way to represent a window,
/// without introducing a dependency on a toolkit library.
///
/// XdpParent implementations for GTK 3, GTK 4, Qt 5, and Qt 6 are available as
/// separate libraries.
pub const Parent_ = opaque {
    /// Copies `source` into a new `Parent`.
    extern fn xdp_parent_copy(p_source: *Parent_) *xdp.Parent_;
    pub const copy = xdp_parent_copy;

    /// Frees `parent`.
    extern fn xdp_parent_free(p_parent: *Parent_) void;
    pub const free = xdp_parent_free;

    extern fn xdp_parent_get_type() usize;
    pub const getGObjectType = xdp_parent_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PortalClass = extern struct {
    pub const Instance = xdp.Portal;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PortalClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionClass = extern struct {
    pub const Instance = xdp.Session;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SettingsClass = extern struct {
    pub const Instance = xdp.Settings;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *SettingsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The XdpButtonState enumeration is used to describe
/// the state of buttons.
pub const ButtonState = enum(c_int) {
    released = 0,
    pressed = 1,
    _,

    extern fn xdp_button_state_get_type() usize;
    pub const getGObjectType = xdp_button_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CameraFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_camera_flags_get_type() usize;
    pub const getGObjectType = xdp_camera_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `XdpDiscreteAxis` enumeration is used to describe
/// the discrete scroll axes.
pub const DiscreteAxis = enum(c_int) {
    horizontal_scroll = 0,
    vertical_scroll = 1,
    _,

    extern fn xdp_discrete_axis_get_type() usize;
    pub const getGObjectType = xdp_discrete_axis_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EmailFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_email_flags_get_type() usize;
    pub const getGObjectType = xdp_email_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `XdpKeyState` enumeration is used to describe
/// the state of keys.
pub const KeyState = enum(c_int) {
    released = 0,
    pressed = 1,
    _,

    extern fn xdp_key_state_get_type() usize;
    pub const getGObjectType = xdp_key_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The values of this enum indicate the desired level
/// of accuracy for location information.
pub const LocationAccuracy = enum(c_int) {
    none = 0,
    country = 1,
    city = 2,
    neighborhood = 3,
    street = 4,
    exact = 5,
    _,

    extern fn xdp_location_accuracy_get_type() usize;
    pub const getGObjectType = xdp_location_accuracy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LocationMonitorFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_location_monitor_flags_get_type() usize;
    pub const getGObjectType = xdp_location_monitor_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The values of this enum are returned in the `Portal.signals.session_state_changed` signal
/// to indicate the current state of the user session.
pub const LoginSessionState = enum(c_int) {
    running = 1,
    query_end = 2,
    ending = 3,
    _,

    extern fn xdp_login_session_state_get_type() usize;
    pub const getGObjectType = xdp_login_session_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NotificationFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_notification_flags_get_type() usize;
    pub const getGObjectType = xdp_notification_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options for how the screencast session should persist.
pub const PersistMode = enum(c_int) {
    none = 0,
    transient = 1,
    persistent = 2,
    _,

    extern fn xdp_persist_mode_get_type() usize;
    pub const getGObjectType = xdp_persist_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PrintFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_print_flags_get_type() usize;
    pub const getGObjectType = xdp_print_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SaveFileFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_save_file_flags_get_type() usize;
    pub const getGObjectType = xdp_save_file_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionMonitorFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_session_monitor_flags_get_type() usize;
    pub const getGObjectType = xdp_session_monitor_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The state of a session.
pub const SessionState = enum(c_int) {
    initial = 0,
    active = 1,
    closed = 2,
    _,

    extern fn xdp_session_state_get_type() usize;
    pub const getGObjectType = xdp_session_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of a session.
pub const SessionType = enum(c_int) {
    screencast = 0,
    remote_desktop = 1,
    input_capture = 2,
    _,

    extern fn xdp_session_type_get_type() usize;
    pub const getGObjectType = xdp_session_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UpdateInstallFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_update_install_flags_get_type() usize;
    pub const getGObjectType = xdp_update_install_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UpdateMonitorFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_update_monitor_flags_get_type() usize;
    pub const getGObjectType = xdp_update_monitor_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The values of this enum are returned in the
/// `Portal.signals.update_progress` signal to indicate
/// the current progress of an installation.
pub const UpdateStatus = enum(c_int) {
    running = 0,
    empty = 1,
    done = 2,
    failed = 3,
    _,

    extern fn xdp_update_status_get_type() usize;
    pub const getGObjectType = xdp_update_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UserInformationFlags = enum(c_int) {
    none = 0,
    _,

    extern fn xdp_user_information_flags_get_type() usize;
    pub const getGObjectType = xdp_user_information_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options to use when requesting background.
pub const BackgroundFlags = packed struct(c_uint) {
    autostart: bool = false,
    activatable: bool = false,
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

    pub const flags_none: BackgroundFlags = @bitCast(@as(c_uint, 0));
    pub const flags_autostart: BackgroundFlags = @bitCast(@as(c_uint, 1));
    pub const flags_activatable: BackgroundFlags = @bitCast(@as(c_uint, 2));
    extern fn xdp_background_flags_get_type() usize;
    pub const getGObjectType = xdp_background_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options for how the cursor is handled.
pub const CursorMode = packed struct(c_uint) {
    hidden: bool = false,
    embedded: bool = false,
    metadata: bool = false,
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

    pub const flags_hidden: CursorMode = @bitCast(@as(c_uint, 1));
    pub const flags_embedded: CursorMode = @bitCast(@as(c_uint, 2));
    pub const flags_metadata: CursorMode = @bitCast(@as(c_uint, 4));
    extern fn xdp_cursor_mode_get_type() usize;
    pub const getGObjectType = xdp_cursor_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags to specify what input devices to control for a remote desktop session.
pub const DeviceType = packed struct(c_uint) {
    keyboard: bool = false,
    pointer: bool = false,
    touchscreen: bool = false,
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

    pub const flags_none: DeviceType = @bitCast(@as(c_uint, 0));
    pub const flags_keyboard: DeviceType = @bitCast(@as(c_uint, 1));
    pub const flags_pointer: DeviceType = @bitCast(@as(c_uint, 2));
    pub const flags_touchscreen: DeviceType = @bitCast(@as(c_uint, 4));
    extern fn xdp_device_type_get_type() usize;
    pub const getGObjectType = xdp_device_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that determine what session status changes are inhibited.
pub const InhibitFlags = packed struct(c_uint) {
    logout: bool = false,
    user_switch: bool = false,
    @"suspend": bool = false,
    idle: bool = false,
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

    pub const flags_logout: InhibitFlags = @bitCast(@as(c_uint, 1));
    pub const flags_user_switch: InhibitFlags = @bitCast(@as(c_uint, 2));
    pub const flags_suspend: InhibitFlags = @bitCast(@as(c_uint, 4));
    pub const flags_idle: InhibitFlags = @bitCast(@as(c_uint, 8));
    extern fn xdp_inhibit_flags_get_type() usize;
    pub const getGObjectType = xdp_inhibit_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags to specify what input device capabilities should be captured
pub const InputCapability = packed struct(c_uint) {
    keyboard: bool = false,
    pointer: bool = false,
    touchscreen: bool = false,
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

    pub const flags_none: InputCapability = @bitCast(@as(c_uint, 0));
    pub const flags_keyboard: InputCapability = @bitCast(@as(c_uint, 1));
    pub const flags_pointer: InputCapability = @bitCast(@as(c_uint, 2));
    pub const flags_touchscreen: InputCapability = @bitCast(@as(c_uint, 4));
    extern fn xdp_input_capability_get_type() usize;
    pub const getGObjectType = xdp_input_capability_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of a launcher.
pub const LauncherType = packed struct(c_uint) {
    application: bool = false,
    webapp: bool = false,
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

    pub const flags_application: LauncherType = @bitCast(@as(c_uint, 1));
    pub const flags_webapp: LauncherType = @bitCast(@as(c_uint, 2));
    extern fn xdp_launcher_type_get_type() usize;
    pub const getGObjectType = xdp_launcher_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options for opening files.
pub const OpenFileFlags = packed struct(c_uint) {
    multiple: bool = false,
    _padding1: bool = false,
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

    pub const flags_none: OpenFileFlags = @bitCast(@as(c_uint, 0));
    pub const flags_multiple: OpenFileFlags = @bitCast(@as(c_uint, 1));
    extern fn xdp_open_file_flags_get_type() usize;
    pub const getGObjectType = xdp_open_file_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options for opening uris.
pub const OpenUriFlags = packed struct(c_uint) {
    ask: bool = false,
    writable: bool = false,
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

    pub const flags_none: OpenUriFlags = @bitCast(@as(c_uint, 0));
    pub const flags_ask: OpenUriFlags = @bitCast(@as(c_uint, 1));
    pub const flags_writable: OpenUriFlags = @bitCast(@as(c_uint, 2));
    extern fn xdp_open_uri_flags_get_type() usize;
    pub const getGObjectType = xdp_open_uri_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags to specify what kind of sources to offer for a screencast session.
pub const OutputType = packed struct(c_uint) {
    monitor: bool = false,
    window: bool = false,
    virtual: bool = false,
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

    pub const flags_none: OutputType = @bitCast(@as(c_uint, 0));
    pub const flags_monitor: OutputType = @bitCast(@as(c_uint, 1));
    pub const flags_window: OutputType = @bitCast(@as(c_uint, 2));
    pub const flags_virtual: OutputType = @bitCast(@as(c_uint, 4));
    extern fn xdp_output_type_get_type() usize;
    pub const getGObjectType = xdp_output_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options for starting remote desktop sessions.
pub const RemoteDesktopFlags = packed struct(c_uint) {
    multiple: bool = false,
    _padding1: bool = false,
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

    pub const flags_none: RemoteDesktopFlags = @bitCast(@as(c_uint, 0));
    pub const flags_multiple: RemoteDesktopFlags = @bitCast(@as(c_uint, 1));
    extern fn xdp_remote_desktop_flags_get_type() usize;
    pub const getGObjectType = xdp_remote_desktop_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options for starting screen casts.
pub const ScreencastFlags = packed struct(c_uint) {
    multiple: bool = false,
    _padding1: bool = false,
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

    pub const flags_none: ScreencastFlags = @bitCast(@as(c_uint, 0));
    pub const flags_multiple: ScreencastFlags = @bitCast(@as(c_uint, 1));
    extern fn xdp_screencast_flags_get_type() usize;
    pub const getGObjectType = xdp_screencast_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ScreenshotFlags = packed struct(c_uint) {
    interactive: bool = false,
    _padding1: bool = false,
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

    pub const flags_none: ScreenshotFlags = @bitCast(@as(c_uint, 0));
    pub const flags_interactive: ScreenshotFlags = @bitCast(@as(c_uint, 1));
    extern fn xdp_screenshot_flags_get_type() usize;
    pub const getGObjectType = xdp_screenshot_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags influencing the spawn operation and how the
/// new sandbox is created.
pub const SpawnFlags = packed struct(c_uint) {
    clearenv: bool = false,
    latest: bool = false,
    sandbox: bool = false,
    no_network: bool = false,
    watch: bool = false,
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

    pub const flags_none: SpawnFlags = @bitCast(@as(c_uint, 0));
    pub const flags_clearenv: SpawnFlags = @bitCast(@as(c_uint, 1));
    pub const flags_latest: SpawnFlags = @bitCast(@as(c_uint, 2));
    pub const flags_sandbox: SpawnFlags = @bitCast(@as(c_uint, 4));
    pub const flags_no_network: SpawnFlags = @bitCast(@as(c_uint, 8));
    pub const flags_watch: SpawnFlags = @bitCast(@as(c_uint, 16));
    extern fn xdp_spawn_flags_get_type() usize;
    pub const getGObjectType = xdp_spawn_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The values of this enumeration determine where the wallpaper is being set.
pub const WallpaperFlags = packed struct(c_uint) {
    background: bool = false,
    lockscreen: bool = false,
    preview: bool = false,
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

    pub const flags_none: WallpaperFlags = @bitCast(@as(c_uint, 0));
    pub const flags_background: WallpaperFlags = @bitCast(@as(c_uint, 1));
    pub const flags_lockscreen: WallpaperFlags = @bitCast(@as(c_uint, 2));
    pub const flags_preview: WallpaperFlags = @bitCast(@as(c_uint, 4));
    extern fn xdp_wallpaper_flags_get_type() usize;
    pub const getGObjectType = xdp_wallpaper_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WALLPAPER_TARGET_BOTH = 0;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
