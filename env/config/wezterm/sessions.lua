local wezterm = require('wezterm')

local repos = wezterm.home_dir .. '/repos/'

local work_dirs = {
	repos .. 'FNDE-Goal-Programming',
	repos .. 'k-mbis',
}

local personal_dirs = {
	repos .. 'pargo-lab-ansible-pull',
}

M = {
	repos_dir = repos,
	config = '~/repos/config',
	config_dir = wezterm.home_dir .. '/repos/config',
	default = 'default',
	default_dir = repos,
	work = work_dirs,
	personal = personal_dirs,
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
