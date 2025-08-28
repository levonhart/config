local wezterm = require('wezterm')
local mappings = require('mappings')
local config = {}

local act = wezterm.action
local mux = wezterm.mux
-- remember to set branch to `major_refactor` (see: https://wezterm.org/config/plugins.html?h=plugin#making-changes-to-a-existing-plugin)
local sessionizer = wezterm.plugin.require 'https://github.com/mikkasendke/sessionizer.wezterm'
local sessions = require('sessions')

config = wezterm.config_builder()
sessionizer.apply_to_config(config, true) -- NOTE: pass another argument with true to this to disable the default binds 

local colorscheme = require('farol')

config = {
	term = 'wezterm',

	color_scheme = 'ayu',
	colors = colorscheme.colors,

	font = wezterm.font {
		family = 'Fira Code Nerd Font',
		stretch = 'Expanded',
		weight = 'Medium',
		harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
	},
	font_size = 10.0,

	window_background_opacity = 0.9,
	tab_bar_at_bottom = true,
	show_new_tab_button_in_tab_bar = false,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = 'NONE',
	window_frame = {
		font = wezterm.font { family = 'Fira Code Nerd Font', weight = 'Medium' },
		font_size = 10.0,
		active_titlebar_bg = colorscheme.colors.background,
		inactive_titlebar_bg = colorscheme.colors.background,
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = 'NeverPrompt',
	default_gui_startup_args = { 'start', '--always-new-process' },

	-- mappings
	disable_default_key_bindings = true,
	leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1500 },
	keys = mappings.keys,
	key_tables = mappings.key_tables,
	mouse_bindings = mappings.mouse_bindings,
	default_cursor_style = 'BlinkingBlock',
	animation_fps = 1,

	-- multiplex
	ssh_domains = {
		{
			name = 'iracema',
			remote_address = 'iracema',
		},
	},
	unix_domains = {
		{
			name = 'unix',
		},
	},
}

sessionizer.spec = {
	{
		name = 'sessions',
		options = {
			title = 'Sessions',
			description = 'Select a workspace:',
			always_fuzzy = true,
			callback = sessionizer.actions.SwitchToWorkspace
		},
		sessionizer.generators.MostRecentWorkspace {},
		sessionizer.generators.AllActiveWorkspaces { filter_default = false, filter_current = false, },
		processing = sessionizer.helpers.for_each_entry(function(entry)
			entry.label = entry.label:gsub(wezterm.home_dir, '~')
		end),
	},
	{
		name = 'repos',
		options = {
			title = 'Repos',
			description = 'Select a workspace:',
			always_fuzzy = true,
			callback = sessionizer.actions.SwitchToWorkspace
		},
		processing = sessionizer.helpers.for_each_entry(function(entry)
			entry.label = entry.label:gsub(wezterm.home_dir, '~')
		end),

		-- sessionizer.generators.DefaultWorkspace { name_overwrite = 'default' },
		sessionizer.generators.FdSearch(sessions.repos_dir),
	},
	{
        name = 'config',
        options = {
            title = 'Config Files',
            description = 'Select a config file to edit:',
			callback = function(window, pane, id, label)
				if not id then return end

				local current_workspace = wezterm.mux.get_active_workspace()
				require('sessionizer.history').push(current_workspace)
				window:perform_action(act.SwitchToWorkspace({
					name = sessions.config, spawn = { cwd = id } }), pane)
			end
        },
		processing = sessionizer.helpers.for_each_entry(function(entry)
			entry.label = entry.label:gsub(wezterm.home_dir, '~')
		end),
        sessions.config_dir,
		sessionizer.generators.FdSearch { overwrite = {
			'fd', '-td', '--max-depth=' .. 2, '--prune', '--format', '{}', '.',
			sessions.config_dir, }
		},
    }
}


wezterm.on('update-right-status', function(window, pane)
	local symbol = ''
	local prefix = ''
	local workspace = window:active_workspace()
	if workspace == 'default' then workspace = '' else workspace = workspace .. ' ' end

	local keytable = window:active_key_table() or ''

	if window:leader_is_active() then
		prefix = ' 🚀 '   -- ocean wave
		symbol = ' ' -- optional separator
	end

	window:set_right_status(wezterm.format {
		{ Text = workspace },
		{ Foreground = { Color = config.colors.tab_bar.active_tab.fg_color } },
		{ Text = symbol },
		'ResetAttributes',
		{ Background = { Color = config.colors.tab_bar.active_tab.bg_color } },
		{ Foreground = { Color = config.colors.tab_bar.active_tab.fg_color } },
		{ Text = keytable },
		{ Text = prefix },
	})

	return { colors = { compose_cursor = '#FFFF00' } }
end)


return config
