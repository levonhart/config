---------------------------------------------------------------------------
--- Additional hotkeys for awful.hotkeys_widget
--
-- @author Yauheni Kirylau &lt;yawghen@gmail.com&gt;
-- @copyright 2014-2015 Yauheni Kirylau
-- @submodule awful.hotkeys_popup
---------------------------------------------------------------------------


local keys = {
  vim = require("keys.vim"),
  firefox = require("keys.firefox"),
  tmux = require("keys.tmux"),
}
return keys

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
