hl.env("LC_MESSAGES", "en_US.UTF-8")
hl.env("LANG", "pt_BR.UTF-8")
hl.env("LC_ALL", "pt_BR.UTF-8")
hl.env("XKB_DEFAULT_LAYOUT", "br")
hl.env("XKB_DEFAULT_MODEL", "abnt2")

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
    leaf = "global",
    enabled = false,
    speed = 1,
    bezier = "default",
})
hl.animation({
    leaf = "windowsIn",
    enabled = false,
    speed = 4.1,
    bezier = "easeOutQuint",
    style = "popin 87%",
})
hl.animation({
    leaf = "windowsOut",
    enabled = false,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    bezier = "almostLinear",
})

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        -- disable_hyprland_qtutils_check = true
    },
    input = {
        kb_layout = "br,us",
        kb_variant = ",altgr-intl",
        kb_model = "pc105", -- abnt2 
        kb_options = "lv3:ralt_switch,compose:lctrl-altgr,grp:alt_space_toggle,grp:alt_shift_toggle",
        kb_rules = "",
        numlock_by_default = true,
    },
    animations = {
        enabled = true,
        --        NAME,           X0,   Y0,   X1,   Y1
        -- Default animations, see https://wiki.hypr.land/Configuring/Animations/
        --           NAME,          ONOFF, SPEED, CURVE,        [STYLE]
    },
})

hl.on("hyprland.start", function()
    hl.exec_cmd("regreet; hyprctl dispatch exit")
end)


