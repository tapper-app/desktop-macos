export enum AndroidSettingsKey {
    DEVELOPER_OPTIONS = "development_settings_enabled",
    USB_DEBUGGING_V2 = "adb_enabled_toggleable",
    STRICT_MODE = "package_verifier_enable",
    FORCE_RTL = "debug.force_rtl",
    GPU_RENDERING = "debug.hwui.renderer",
    SHOW_TOUCHES = "show_touches",
    HARDWARE_ACCELERATION = "debug.hwui.render_dirty_regions",
    LAYOUT_BOUNDS = "debug.layout",
    GPU_OVERDRAW = " shell setprop debug.hwui.overdraw",
    SHOW_POINTER_LOCATION = "pointer_location",
    VIEW_UPDATES = "debug.hwui.show_dirty_regions"
}
