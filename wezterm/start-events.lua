local wezterm = require('wezterm')
local mux = wezterm.mux
local config = {}
config = wezterm.config_builder()

wezterm.on('gui-startup', function(cmd)
	if cmd ~= nil then
		local tab, pane, window = mux.spawn_window(cmd)
		return
	end

	local unix_domain = mux.get_domain('unix')
	mux.set_default_domain(unix_domain)
	unix_domain:attach()
	local workspaces = mux.get_workspace_names()

	local workspace_name = config.default_workspace or 'default'
	local max = 0
	for _, w in pairs(workspaces) do
		local n = tonumber(w:match('^' .. workspace_name .. '~(%d+)$') or 0)
		if n > max then max = n end
	end
	workspace_name = workspace_name .. '~' .. tostring(max+1)

	local found = false
	for _, name in pairs(workspaces) do
		if name == workspace_name then found = true end
	end
	if not found then
		local tab, pane, window = mux.spawn_window({})
		window:gui_window():perform_action(
			act.switchtoworkspace {
				name = workspace_name, spawn = { cwd = '~/' },
			}, pane)
		window:set_workspace(workspace_name)
	end
	mux.set_active_workspace(workspace_name)

	-- local workspaces = mux.get_workspace_names()
	-- assert( workspaces ~= nil and #workspaces > 0 )
	-- local workspace_name = config.default_workspace or 'default'
	-- local max = 0
	-- for _, w in pairs(workspaces) do
	-- 	local n = tonumber(w:match('^' .. workspace_name .. '~(%d+)$') or 0)
	-- 	if n > max then max = n end
	-- end
	-- workspace_name = workspace_name .. '~' .. tostring(max+1)

	-- local tab, pane, window = mux.spawn_window {
	-- 	domain = { domainname = 'unix' },
	-- 	workspace = 'unix-ws',
	-- }
end)
