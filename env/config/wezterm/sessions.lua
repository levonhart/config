local wezterm = require('wezterm')
local wezterm_sessions = loadfile(wezterm.home_dir .. '/.wezterm-sessions.lua')

local local_cfg =  {
	work_dirs = {}, personal_dirs = {}, config_dir = wezterm.home_dir .. '/.config'
}
if wezterm_sessions then local_cfg = wezterm_sessions() end

local repos = wezterm.home_dir .. '/repos/'

M = {
	default_name = 'default',
	config_name = '~/repos/config',
	repos_dir = repos,
	default_dir = repos,
	config_dir = local_cfg.config_dir,
	work = local_cfg.work_dirs,
	personal = local_cfg.personal_dirs,
}

M.session_name = function(window)
	local workspace_name = window:active_workspace():gsub('~%d+$', '')
	local workspaces = wezterm.mux.get_workspace_names()
	local max = 0
	for _, w in pairs(workspaces) do
		local n = tonumber(w:match('^' .. workspace_name .. '~(%d+)$') or 0)
		if n > max then max = n end
	end
	workspace_name = workspace_name .. '~' .. tostring(max + 1)
	return workspace_name
end


return M
