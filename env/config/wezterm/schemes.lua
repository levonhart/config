local wezterm = require 'wezterm'
local act = wezterm.action
local sessions = require('sessions')
local sessionizer = wezterm.plugin.require 'https://github.com/levonhart/wezterm-sessionizer'
local history = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-history"

return {
	sessions = {
		options = {
			title = 'Sessions',
			description = 'Select a workspace:',
			always_fuzzy = true,
			callback = history.Wrapper(sessionizer.DefaultCallback)
		},
		history.MostRecentWorkspace {},
		sessionizer.AllActiveWorkspaces { filter_default = false, filter_current = false, },
		processing = sessionizer.for_each_entry(function(entry)
			entry.label = entry.label:gsub(wezterm.home_dir, '~')
		end),
	},
	repos = {
		options = {
			title = 'Repos',
			description = 'Select a workspace:',
			always_fuzzy = true,
			callback = history.Wrapper(sessionizer.DefaultCallback)
		},
		processing = sessionizer.for_each_entry(function(entry)
			entry.label = entry.label:gsub(wezterm.home_dir, '~')
		end),

		-- sessionizer.DefaultWorkspace { name_overwrite = 'default' },
		sessionizer.FdSearch(sessions.repos_dir),
	},
	config = {
        options = {
            title = 'Config Files',
            description = 'Select a config file to edit:',
			callback = history.Wrapper(function(window, pane, id, label)
				if not id then return end
				window:perform_action(act.SwitchToWorkspace({
					name = sessions.config, spawn = { cwd = id } }), pane)
			end)
        },
		processing = sessionizer.for_each_entry(function(entry)
			entry.label = entry.label:gsub(wezterm.home_dir, '~')
		end),
        sessions.config_dir,
		sessionizer.FdSearch { sessions.config_dir, max_depth = 8 },
    },
	default = {
		options = {
			title = 'Sessionizer',
			description = 'Select a workspace:',
			always_fuzzy = true,
			callback = history.Wrapper(sessionizer.DefaultCallback)
		},
		processing = sessionizer.for_each_entry(function(entry)
			entry.label = entry.label:gsub(wezterm.home_dir, '~')
		end),

		history.MostRecentWorkspace {},
		sessionizer.AllActiveWorkspaces { filter_default = false, filter_current = false, },
		sessionizer.FdSearch { sessions.repos_dir, max_depth = 5, },
	},
}


