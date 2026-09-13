-- Windows and Workspaces
-- ref: https://wiki.hypr.land/Configuring/Workspace-Rules/

hl.workspace_rule({
    workspace = "1",
    border_size = 1,
    layout = "scrolling",
})

hl.workspace_rule({
    workspace = "6",
    layout = "scrolling",
})

-- ref: https://wiki.hypr.land/Configuring/Window-Rules/
--windowrule = float on,match:class ^(kitty)$,match:title ^(kitty)$

--# Floats
hl.window_rule({
    match = {
        class = "ibus-extension-gtk3",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "(^Open files$)|(^Abrir arquivos$)|(^Envio de arquivos$)|(^Select Document$)|(^Renomear.*$)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "thunar",
        title = "(^Andamento.*$)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(^satty$)|(^org.pulseaudio.pavucontrol$)|(^blueman-.*$)|(^nm-connection-editor$)|(^com.network.manager$)|(^nmtui$)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "firefox",
        title = "(Biblioteca)|(Bitwarden)|(Extensão)|(Extension)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "firefox",
        title = "Biblioteca",
    },
    persistent_size = true,
})

hl.window_rule({
    match = {
        class = "(.*[Tt]hunderbird)",
        initial_title = "()|(Editar item)|(Lembretes da agenda)",
    },
    float = true,
})

--# Steam apps
hl.window_rule({
    match = {
        class = "^(steam)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "^Steam$",
        class = "^steam$",
        initial_class = "^steam$",
        initial_title = "^Steam$",
    },
    float = false,
})

-- windowrule = maximize on, match:title ^Steam$, match:class ^steam$, match:initial_class ^steam$, match:initial_title ^Steam$
hl.window_rule({
    match = {
        class = "^(steam_app_.*)$",
    },
    rounding = 0,
    pseudo = true,
    border_size = 0,
})

-- windowrule = fullscreenstate 2 2, match:class ^(steam_app_.*)$

--# Waybar 'overlays'
hl.window_rule({
    match = {
        class = "(^org.pulseaudio.pavucontrol$)|(^nmtui$)",
    },
    move = "monitor_w-window_w-20 40",
})

hl.window_rule({
    match = {
        class = "(^blueman-.*$)|(^nm-connection-editor$)|(^com.network.manager$)",
    },
    move = "monitor_w-window_w-4 40",
})

hl.window_rule({
    match = {
        class = "(^org.pulseaudio.pavucontrol$)|(^blueman-manager$)|(^nm-connection-editor$)|(^nmtui$)",
    },
    size = "monitor_w*0.4 monitor_h*0.6",
})

hl.window_rule({
    match = {
        class = "(^com.network.manager$)",
    },
    size = "monitor_w*0.2 monitor_h*0.4",
})

hl.window_rule({
    match = {
        class = "(^org.pulseaudio.pavucontrol$)|(^blueman-.*$)|(^com.network.manager$)|(^nm-connection-editor$)|(^nmtui$)",
    },
    pin = true,
})

hl.window_rule({
    match = {
        class = "(^org.pulseaudio.pavucontrol$)|(^blueman-.*$)|(^nm-connection-editor$)|(^com.network.manager$)",
    },
    animation = "slide top",
})

-- Orbolay
hl.window_rule({
	match = { class = "^(orbolay)$" },
	no_initial_focus = true,
	suppress_event = "activatefocus",
	float = true,
	pin = true,
	center = true,
	no_blur = true,
	no_dim = true,
	no_follow_mouse = true,
	no_shadow = true,
	border_size = 0,
	no_focus = true,
	move = { "monitor_w", "monitor_h" },
	size = { "monitor_w - 5", "monitor_h - 5" }
})

--# Always maximize
-- windowrule = maximize on, match:class firefox, match:initial_title (Mozilla Firefox)
-- windowrule = maximize on, match:class .*[Tt]hunderbird, match:initial_title (Mozilla Thunderbird)

--# Move windows
hl.window_rule({
    match = {
        class = "(^firefox$)|(^.*[Tt]hunderbird$)",
    },
    workspace = "1",
})

hl.window_rule({
    match = {
        class = "(^neovide$)",
    },
    workspace = "4",
})

hl.window_rule({
    match = {
        class = "(^discord$)|(^com\\.rtosta\\.zapzap$)|(^org\\.telegram\\.desktop$)|(^Spotify$)|(^Mattermost$)|(^mattermost-desktop$)",
    },
    workspace = "5",
})

hl.window_rule({
    match = {
        class = "(^steam_app_.*$)|(^steam$)",
    },
    workspace = "6",
})

--# Ignore maximize requests from apps.
-- windowrule = suppressevent maximize on, match:class .*

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    -- Fix some dragging issues with XWayland
    no_focus = true,
})

--# "Smart gaps" / "No gaps when only"
hl.workspace_rule({
    workspace = "w[tv1]",
    gaps_out = 0,
    gaps_in = 0,
})

hl.workspace_rule({
    workspace = "f[1]",
    gaps_out = 0,
    gaps_in = 0,
})

hl.window_rule({
    match = {
        float = false,
        workspace = "w[tv1]",
    },
    border_size = 0,
    rounding = 0,
})

hl.window_rule({
    match = {
        float = false,
        workspace = "f[1]",
    },
    border_size = 0,
    rounding = 0,
})

--# showmethekey overlay
hl.window_rule({
    match = {
        class = "(^one.alynx.showmethekey$)|(^showmethekey-gtk$)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(showmethekey-gtk)$",
    },
    pin = true,
})

hl.window_rule({
    match = {
        title = "^(Floating Window - Show Me The Key)$",
    },
    move = "monitor_w-window_w monitor_h-window_h",
    border_size = 0,
})

--# Firefox Picture-in-Picture
hl.window_rule({
    match = {
        title = "^(Picture-in-Picture)$",
    },
    float = true,
    pin = true,
})

--# Screenshot tool
hl.window_rule({
    match = {
        class = "^(com.gabm.satty)$",
    },
    fullscreen = true,
})

