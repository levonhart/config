-- vim: foldmethod=marker
-- Includes {{{ --
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
-- local naughty = require("naughty")
local lgi = require("lgi")
local Notify = lgi.require("Notify")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local keys = require("keys")

-- Move indicators and float control
require("collision")()
-- }}} Includes --

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
--     naughty.notify({ preset = naughty.config.presets.critical,
--                      title = "Oops, there were errors during startup!",
--                      text = awesome.startup_errors })
       local error_notify = Notify.Notification.new(
                                "Ocorreu um erro durante a inicialização!",
                                tostring(err),
                                "dialog-information")
       error_notify:show()
end

-- Handle runtime errors after startup
Notify.init("Awesome")
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
--         -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
--
--         naughty.notify({ preset = naughty.config.presets.critical,
--                          title = "Oops, an error happened!",
--                          text = tostring(err) })
        local error_notify = Notify.Notification.new("Ocorreu um erro!", tostring(err), "dialog-information")
        error_notify:show()
        in_error = false
    end)
end
-- }}} Error handling --

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
do
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
                                  os.getenv("HOME"), "materia")
beautiful.init(theme_path)
end

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -x " .. editor
mytags = { "principal", "desenvolvimento", "jogos", "testes", "musica", "voip" }

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Hotkeys Widget
hotkeys_popup.hotkeys = hotkeys_popup.widget.new( { height = 600 } )
hotkeys_popup.hotkeys:add_hotkeys(keys.vim.keys)
hotkeys_popup.hotkeys:add_hotkeys(keys.firefox.keys)
hotkeys_popup.hotkeys:add_hotkeys(keys.tmux.keys)

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- }}} Variable definitions --

-- {{{ Menu --
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}} Menu --

-- {{{ Screen connect callback

awful.screen.connect_for_each_screen(function(s)

    -- Restore tags {{{
    -- https://stackoverflow.com/questions/42056795/awesomewm-how-to-prevent-migration-of-clients-when-screen-disconnected
    -- Check if existing tags belong to this new screen that's being added
    local restored = {}
    local all_tags = root.tags()
    for _, t in pairs(all_tags) do
        if utils.get_screen_id(s) == t.screen_id then
            t.screen = s
            table.insert(restored, t)
        end
    end

    -- Each screen has its own tag table.
    awful.tag({ "principal", "desenvolvimento", "jogos", "testes", "musica", "voip" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    
    -- }}} Restore tags --

    -- Create the popup
    s.mypopup = awful.popup (
                {
                    widget ={
                        layout = wibox.layout.fixed.horizontal,
                        {
                            layout = wibox.layout.fixed.horizontal,
                            s.mypromptbox,
                        } 
                    },
                    ontop = true,
                    opacity = 0.8,
                    type = "dialog",
                    placement = awful.placement.bottom,
                    visibility = false,
                    screen = s,
                })
end)
-- }}} Screen connect callback --

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}} Mouse bindings --

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Shift"   }, "m", function()
            hotkeys_popup.hotkeys:show_help()
    end,
              {description="show help", group="awesome"}),
    awful.key({ "Mod3",           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ "Mod3",           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "'", awful.tag.history.restore,
        {description = "view last", group = "client"}
    ),
    awful.key({ modkey,           }, "j",
        function () awful.client.focus.bydirection("down") end,
        {description = "focus client below", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function () awful.client.focus.bydirection("up") end,
        {description = "focus client above", group = "client"}
    ),
    awful.key({ modkey,           }, "l",
        function () awful.client.focus.bydirection("right") end,
        {description = "focus client on right", group = "client"}
    ),
    awful.key({ modkey,           }, "h",
        function () awful.client.focus.bydirection("left") end,
        {description = "focus client on left", group = "client"}
    ),
    awful.key({ "Mod1",           }, "Tab", function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ "Mod1", "Shift"   }, "Tab", function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    awful.key({ "Mod3",           }, "j", function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ "Mod3",           }, "k", function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ "Mod1",           }, "'",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    -- awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
    --           {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control", "Shift"   }, "F4", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,         }, "Delete",
              function ()
                  local menu_path = string.format("%s/.config/rofi/bin/menu_powermenu",
                                                   os.getenv("HOME"))
                  awful.spawn(menu_path)
              end,
              {description = "open power menu", group = "awesome"}),

    awful.key({ modkey,           }, ".",     function () awful.tag.incmwfact( 0.02)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, ",",     function () awful.tag.incmwfact(-0.02)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),


    awful.key({ modkey, "Control" }, "c",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey ,  "Shift" }, "r",
              function ()
                  awful.screen.focused().mypromptbox:run()
              end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "Return",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ "Mod1",           }, "F4",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "w",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey,           }, "a", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to next screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "c",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey,           }, "r",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey,           }, "d",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

globalkeys = gears.table.join(globalkeys, 
    awful.key({ modkey,             }, "Escape",
          function ()
              if client.focus then
                  local tag = client.focus.first_tag
                  if tag then
                      client.focus:move_to_tag(tag)
                  end
              end
          end,
          {description = "move focused client to its first tag only", group = "tag"})
)

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}} Key bindings --

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     -- shape = function(c)
                     --                return function (cr, w, h)
                     --                    gears.shape.rounded_rect(cr, w, h, 4)
                     --            end
                     --         end,
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Thunderbird",
          "Pavucontrol",
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "Magnus",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Non-floating clients.
    { rule_any = {
            class = {
                "Alacritty",
                "Mate-terminal",
                "Xfce-terminal",
                "Kitty",
                "XTerm",
                "Termite",
                "URxvt",
                "firefox",
                "Chromium",
                "TelegramDesktop",
                "discord",
                "Zathura",
            },
            -- instance = {
            --     "Unity",
            --     "Navigator",
            -- }
        },
        properties = {
            floating = false,
        }
    },

    -- Tag binding rules
    { rule_any = { class = { "discord", "TeamSpeak 3", "Mumble" } },
      properties = { screen = 1, tag = "voip" } },

    { rule_any = { class = { "Spotify", "spotify" } },
      properties = { screen = 1, tag = "musica" } },

    { rule_any = { class = { "Steam" } },
      properties = { screen = 1, tag = "jogos" } },

    { rule_any = { class = { "Ulauncher", "Synapse", "albert" } },
        properties = {
            no_border = true,
            -- screen = awful.screen.preferred,
            -- placement = awful.placement.centered,
            callback = function(c)
                c.screen = mouse.screen
                end,
            titlebars_enabled = false,
        }
    },

    { rule_any = { type = { "dock", "splash" } },
        properties = {
            focusable = false,
            no_border = true,
            titlebars_enabled = false,
            floating = true,
            placement = awful.placement.no_offscreen,
        }
    },

    { rule_any = { type = { "dialog", "notification" }, name = { "Picture-in-Picture" } },
        properties = {
            floating = true,
            placement = awful.placement.no_offscreen+awful.placement.centered,
        }
    },

    -- Show Xfdesktop and wallpaper in all tags
    { rule_any = { type = { "desktop" } },
        callback = function(c)
            c.screen = awful.screen.getbycoord(0, 0)
            end,
        properties = {
            x = 0,
            y = 0,
            sticky = true,
            focusable = false,
            no_border = true,
            skip_taskbar = true,
            keys = {},
        }
    },
    -- Xfce panel Wrapper-2.0 type windows (e.g. calendar)
    { rule_any = { class = { "Wrapper-2.0", "steam_app_306130" } },
        properties = {
            floating = true,
            no_border = true,
            titlebars_enabled = false,
            placement = awful.placement.no_offscreen,
        }
    },

    { rule = { class = "Xfce4-display-settings" },
            properties = {
                floating = true,
                placement = awful.placement.centered,
                screen = screen.primary,
                titlebars_enabled = false,
            }
    },
}

-- Hotkeys popup rules
for group_name in pairs(keys.vim.keys) do
    hotkeys_popup.hotkeys:add_group_rules(group_name,
        { rule_any = { name = { "vim", "VIM", "Vim" } }
    })
end

hotkeys_popup.hotkeys:add_group_rules( "Firefox: tabs",
    { color = "#009F00",
      rule_any = { class = { "Firefox", "firefox" } }
})

for group_name in pairs(keys.tmux.keys) do
    hotkeys_popup.hotkeys:add_group_rules(group_name,
        { rule = { name = "tmux" } 
        })
end

-- }}} Rules --

-- {{{ Signals
--
-- Hide borders when maximize
function manage_borders (c)
    if c.no_border then
        if c.border_width ~= 0 then
            c.border_width = 0
        end
        return
    end

    if c.maximized == true or c.fullscreen then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
    end
end


-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    manage_borders(c)

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Signal functions to hide borders when maximized
client.connect_signal("property::hidden", manage_borders)
client.connect_signal("property::minimized", manage_borders)
client.connect_signal("property::maximized", manage_borders)
client.connect_signal("property::fullscreen", manage_borders)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            if c.maximized then
                c.maximized = false
            end
            if c.floating then
                c.floating = false
            end
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 2, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            if c.maximized or not c.floating then
                c.floating = true
            end
            if c.maximized then
                c.maximized = false
            end
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar = awful.titlebar(c, { size = 3 })

    titlebar : setup {
        { -- Left
            -- awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Border Radius
-- client.connect_signal("property::geometry", function (c)
--     if c.maximized == false then
--         gears.timer.delayed_call(function()
--             gears.surface.apply_shape_bounding(c, gears.shape.rounded_rect, 15)
--         end)
--     else
--         gears.timer.delayed_call(function()
--             gears.surface.apply_shape_bounding(c, gears.shape.rectangle)
--         end)
--     end
-- end)

-- Make the focused window's border glow
client.connect_signal("focus", function (c)
    c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function (c)
    c.border_color = beautiful.border_normal
end)

-- }}} Signals --

-- Autostart Applications {{{

-- Set keyboard layout

-- This should be loaded by xinitrc, in case it doesn't...
-- awful.spawn.with_shell("test -f ~/.Xkeymap && xkbcomp ~/.Xkeymap $DISPLAY")

-- Custom i3lock-color script
awful.spawn.with_shell("xss-lock -- screenlock")
-- awful.spawn.with_shell("xfdesktop")
-- awful.spawn.with_shell("picom -b --experimental-backend")

-- }}} Autostart Applications --
