-- Environmental Variables

local home = (os.getenv("HOME") or "~")
local config = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")
local path = os.getenv("PATH")
local runtime = os.getenv("XDG_RUNTIME_DIR")

local s = require('lua.settings')

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--# Wayland
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")

--# env
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("NEOVIDE_MULTIGRID", "true")

--# User
hl.env("EDITOR", "nvim")
hl.env("TERMINAL", s.terminal)
hl.env("TerminalEmulator", s.terminal .. " -e")
hl.env("PATH", home .. "/.local/bin:" .. path)
hl.env("WALLPAPERS_DIR", home .. "/Imagens/Papeis-de-Parede")
hl.env("MANGOHUD", "0")
hl.env("NEOVIDE_SOCKET", runtime .. "/neovide-sock")
hl.env("XDG_CONFIG_HOME", config)

--# Theme
hl.env("GTK_THEME", s.gtk_theme)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

--# Input
hl.env("XMODIFIERS@im", "fcitx")

--# ssh-agent socket
--env = SSH_AUTH_SOCK,$XDG_RUNTIME_DIR/ssh-agent.socket
hl.env("SSH_AUTH_SOCK", runtime .. "/gcr/ssh")

--# Nvidia
-- ref: https://wiki.hypr.land/Nvidia/
--env = LIBVA_DRIVER_NAME,nvidia
--env = __GLX_VENDOR_LIBRARY_NAME,nvidia


