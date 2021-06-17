---------------------------------------------------------------------------
--- Firefox hotkeys for awful.hotkeys_widget
--
-- @author Jonathan &lt;jonathan@tinypulse.com&gt;
-- @copyright 2017 Jonathan
-- @submodule awful.hotkeys_popup
---------------------------------------------------------------------------

local firefox = {}

firefox.keys = {

    ["Firefox: tabs"] = {{
        modifiers = { "Mod1" },
        keys = {
            ["1..9"] = "go to tab"
        }
    }, {
        modifiers = { "Ctrl" },
        keys = {
            t = "new tab",
            w = 'close tab',
            ['Tab'] = "next tab"
        }
    }, {
        modifiers = { "Ctrl", "Shift" },
        keys = {
          ['Tab'] = "previous tab"
        }
    }}
}

-- local fire_rule = { class = { "Firefox", "firefox" } }
-- for group_name, group_data in pairs({
--     ["Firefox: tabs"] = { color = "#009F00", rule_any = fire_rule }
-- }) do
--     hotkeys_popup.add_group_rules(group_name, group_data)
-- end


-- hotkeys_popup.add_hotkeys(firefox_keys)

return firefox

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
