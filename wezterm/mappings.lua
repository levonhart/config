local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local sessionizer = wezterm.plugin.require 'https://github.com/mikkasendke/sessionizer.wezterm'
local sessions = require('sessions')
local session_name = sessions.session_name

local timeout <const> = 3000

M = {
	keys = {
		{ key = 'a',   mods = 'LEADER',      action = act.AttachDomain('unix') },
		{ key = 'a',   mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' }, },
		{ key = 'd',   mods = 'LEADER',      action = act.DetachDomain { DomainName = 'unix' } },
		{ key = '/',   mods = 'LEADER|CTRL', action = act.ShowLauncher, },
		{ key = 'P',   mods = 'SHIFT|CTRL',  action = act.ActivateCommandPalette },
		{ key = ':',   mods ='LEADER|SHIFT', action = act.ActivateCommandPalette },
		{ key = ',',   mods = 'LEADER|CTRL', action = act.ShowDebugOverlay },
		{ key = 'W',   mods = 'CTRL|SHIFT',  action = act.CloseCurrentPane { confirm = false }, },
		{ key = 'q',   mods = 'SUPER',       action = act.QuitApplication, },
		{ key = 'Tab', mods = 'CTRL|SHIFT',  action = act.ActivateTabRelative(1), },
		{ key = '"',   mods = 'CTRL|SHIFT',  action = act.ActivateTabRelative(-1), },
		{ key = 'h',   mods = 'CTRL|ALT',    action = act.ActivateTabRelative(-1), },
		{ key = 'l',   mods = 'CTRL|ALT',    action = act.ActivateTabRelative(1), },
		{ key = 's',   mods = 'LEADER|CTRL', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
		{ key = 'v',   mods = 'LEADER|CTRL', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
		{ key = 'k',   mods = 'LEADER|CTRL', action = act.Multiple { act.ActivatePaneDirection('Up'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'j',   mods = 'LEADER|CTRL', action = act.Multiple { act.ActivatePaneDirection('Down'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'h',   mods = 'LEADER|CTRL', action = act.Multiple { act.ActivatePaneDirection('Left'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'l',   mods = 'LEADER|CTRL', action = act.Multiple { act.ActivatePaneDirection('Right'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = ';',   mods = 'LEADER',      action = act.ActivatePaneDirection('Prev') },
		{ key = 'q',   mods ='LEADER',       action = act.PaneSelect { mode = 'Activate' } },
		{ key = '}',   mods ='LEADER|SHIFT', action = act.Multiple { act.PaneSelect {},
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '{',   mods ='LEADER|SHIFT', action = act.Multiple { act.PaneSelect { mode = 'SwapWithActiveKeepFocus' },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '<',   mods = 'SHIFT|CTRL',  action = act.AdjustPaneSize { 'Left', 4 } },
		{ key = '>',   mods = 'SHIFT|CTRL',  action = act.AdjustPaneSize { 'Right', 4 } },
		{ key = '+',   mods = 'SHIFT|CTRL',  action = act.AdjustPaneSize { 'Up', 4 } },
		{ key = '_',   mods = 'SHIFT|CTRL',  action = act.AdjustPaneSize { 'Down', 4 } },
		{ key = '<',   mods ='LEADER|SHIFT', action = act.Multiple { act.AdjustPaneSize { 'Left', 4 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '>',   mods ='LEADER|SHIFT', action = act.Multiple { act.AdjustPaneSize { 'Right', 4 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '+',   mods ='LEADER|SHIFT', action = act.Multiple { act.AdjustPaneSize { 'Up', 4 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '_',   mods ='LEADER|SHIFT', action = act.Multiple { act.AdjustPaneSize { 'Down', 4 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '+',   mods = 'LEADER',      action = act.Multiple { act.AdjustPaneSize { 'Up', 4 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '-',   mods = 'LEADER',      action = act.Multiple { act.AdjustPaneSize { 'Down', 4 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'R',   mods = 'SHIFT|CTRL',  action = act.RotatePanes('CounterClockwise') },
		{ key = 'E',   mods = 'SHIFT|CTRL',  action = act.RotatePanes('Clockwise') },
		{ key = 'T',   mods = 'SHIFT|CTRL',  action = act.SpawnTab 'CurrentPaneDomain' },
		{ key = '1',   mods = 'ALT',         action = act.ActivateTab(0) },
		{ key = '2',   mods = 'ALT',         action = act.ActivateTab(1) },
		{ key = '3',   mods = 'ALT',         action = act.ActivateTab(2) },
		{ key = '4',   mods = 'ALT',         action = act.ActivateTab(3) },
		{ key = '5',   mods = 'ALT',         action = act.ActivateTab(4) },
		{ key = '6',   mods = 'ALT',         action = act.ActivateTab(5) },
		{ key = '7',   mods = 'ALT',         action = act.ActivateTab(6) },
		{ key = '8',   mods = 'ALT',         action = act.ActivateTab(7) },
		{ key = '9',   mods = 'ALT',         action = act.ActivateTab(8) },
		{ key = '0',   mods = 'ALT',         action = act.ActivateTab(-1) },
		{ key = 'k',   mods = 'CTRL|ALT',    action = act({ MoveTabRelative = -1 }) },
		{ key = 'j',   mods = 'CTRL|ALT',    action = act({ MoveTabRelative = 1 }) },
		{ key = '0',   mods = 'CTRL',        action = act.ResetFontSize },
		{ key = ')',   mods = 'SHIFT|CTRL',  action = act.ResetFontSize },
		{ key = '+',   mods = 'CTRL',        action = act.IncreaseFontSize },
		{ key = '-',   mods = 'CTRL',        action = act.DecreaseFontSize },
		{ key = '0',   mods = 'CTRL',        action = act.ResetFontSize },
		{ key = '0',   mods = 'SHIFT|CTRL',  action = act.ResetFontSize },
		{ key = '=',   mods = 'CTRL',        action = act.IncreaseFontSize },
		{ key = '=',   mods = 'SHIFT|CTRL',  action = act.IncreaseFontSize },
		{ key = 'C',   mods = 'SHIFT|CTRL',  action = act.CopyTo 'Clipboard' },
		{ key = 'S',   mods = 'SHIFT|CTRL',  action = act.Search 'CurrentSelectionOrEmptyString' },
		{ key = 'L',   mods = 'SHIFT|ALT',   action = act.ClearScrollback 'ScrollbackOnly' },
		{ key = 'H',   mods = 'SHIFT|CTRL',  action = act.ActivateCopyMode },
		{ key = 'X',   mods = 'SHIFT|CTRL',  action = act.QuickSelect },
		{ key = 'y',   mods = 'LEADER',      action = act.QuickSelect },
		{ key = 'z',   mods = 'LEADER',      action = act.Multiple { act.TogglePaneZoomState,
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'z',   mods = 'SHIFT|CTRL',  action = act.TogglePaneZoomState },
		{ key = '{',   mods = 'SHIFT|CTRL',  action = act.ActivateWindowRelative(-1) },
		{ key = '}',   mods = 'SHIFT|CTRL',  action = act.ActivateWindowRelative(1) },
		{ key = 'r',   mods = 'LEADER',      action = act.ReloadConfiguration },
		{ key = 'M',   mods = 'SHIFT|CTRL',  action = act.Hide },
		-- { key = 'n',   mods = 'SHIFT|CTRL',  action = act.SpawnWindow },
		{ key = 'U',     mods = 'SHIFT|CTRL',   action = act.ScrollByPage(-1) },
		{ key = 'D',     mods = 'SHIFT|CTRL',   action = act.ScrollByPage(1) },
		{ key = ':',          mods = 'SHIFT|CTRL',
			action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
		{ key = 'V',          mods = 'SHIFT|CTRL',  action = act.PasteFrom 'Clipboard' },
		-- },_={
		{ key = 'Enter',      mods = 'CTRL|SHIFT',  action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
		{ key = 'phys:Space', mods = 'CTRL|SHIFT',  action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
		{ key = 'LeftArrow',  mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Left' },
		{ key = 'RightArrow', mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Right' },
		{ key = 'UpArrow',    mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Up' },
		{ key = 'DownArrow',  mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Down' },
		{ key = 'LeftArrow',  mods = 'SHIFT|ALT',   action = act.AdjustPaneSize { 'Left', 4 } },
		{ key = 'RightArrow', mods = 'SHIFT|ALT',   action = act.AdjustPaneSize { 'Right', 4 } },
		{ key = 'UpArrow',    mods = 'SHIFT|ALT',   action = act.AdjustPaneSize { 'Up', 4 } },
		{ key = 'DownArrow',  mods = 'SHIFT|ALT',   action = act.AdjustPaneSize { 'Down', 4 } },
		{ key = 'PageUp',     mods = 'SHIFT',       action = act.ScrollByPage(-1) },
		{ key = 'PageUp',     mods = 'SHIFT|ALT',   action = act.ScrollByPage(-1) },
		{ key = 'PageUp',     mods = 'CTRL',        action = act.ActivateTabRelative(-1) },
		{ key = 'PageUp',     mods = 'SHIFT|ALT',   action = act.MoveTabRelative(-1) },
		{ key = 'PageDown',   mods = 'SHIFT',       action = act.ScrollByPage(1) },
		{ key = 'PageDown',   mods = 'SHIFT|ALT',   action = act.ScrollByPage(1) },
		{ key = 'PageDown',   mods = 'CTRL',        action = act.ActivateTabRelative(1) },
		{ key = 'PageDown',   mods = 'SHIFT|ALT',   action = act.MoveTabRelative(1) },
		{ key = 'Insert',     mods = 'SHIFT',       action = act.PasteFrom 'PrimarySelection' },
		{ key = 'Insert',     mods = 'CTRL',        action = act.CopyTo 'PrimarySelection' },
		{ key = 'Copy',       mods = 'NONE',        action = act.CopyTo 'Clipboard' },
		{ key = 'Paste',      mods = 'NONE',        action = act.PasteFrom 'Clipboard' },
		-- Tmux
		{ key = 'o',          mods = 'LEADER|CTRL', action = act.Multiple { act.RotatePanes('CounterClockwise'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'o',          mods = 'LEADER|ALT',  action = act.Multiple { act.RotatePanes('Clockwise'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'c',          mods = 'LEADER', 	    action = act.SpawnTab 'CurrentPaneDomain', },
		{ key = 'x',          mods = 'LEADER',      action = act.CloseCurrentPane { confirm = false } },
		{ key = 'x',          mods = 'LEADER|CTRL', action = act.CloseCurrentPane { confirm = false }, },
		{ key = 'p',          mods = 'LEADER', 	    action = act.Multiple { act.ActivateTabRelative(-1),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'p',          mods = 'LEADER|CTRL', action = act.Multiple { act.ActivateTabRelative(-1),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'n',          mods = 'LEADER', 	    action = act.Multiple { act.ActivateTabRelative(1),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'n',          mods = 'LEADER|CTRL', action = act.Multiple { act.ActivateTabRelative(1),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '%',          mods= 'LEADER|SHIFT', action = act.Multiple { act.SplitHorizontal { domain = 'CurrentPaneDomain' },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '"',          mods= 'LEADER|SHIFT', action = act.Multiple { act.SplitVertical { domain = 'CurrentPaneDomain' },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'k',          mods = 'LEADER',      action = act.Multiple { act.ActivatePaneDirection('Up'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'j',          mods = 'LEADER',      action = act.Multiple { act.ActivatePaneDirection('Down'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'h',          mods = 'LEADER',      action = act.Multiple { act.ActivatePaneDirection('Left'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'l',          mods = 'LEADER',      action = act.Multiple { act.ActivatePaneDirection('Right'),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '[',          mods = 'LEADER',      action = act.ActivateCopyMode},
		{ key = 'LeftArrow',  mods = 'LEADER', 	    action = act.Multiple { act.AdjustPaneSize { 'Left', 5 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'RightArrow', mods = 'LEADER', 	    action = act.Multiple { act.AdjustPaneSize { 'Right', 5 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'DownArrow',  mods = 'LEADER', 	    action = act.Multiple { act.AdjustPaneSize { 'Down', 5 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'UpArrow',    mods = 'LEADER', 	    action = act.Multiple { act.AdjustPaneSize { 'Up', 5 },
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = ',', mods = 'LEADER', action = act.PromptInputLine {
				description = 'Enter new name for tab',
				action = wezterm.action_callback(function(window, pane, line)
					if line then window:active_tab():set_title(line) end
				end), },
		},
		{ key = '&', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = true }, },
		{ key = '!', mods = 'LEADER|SHIFT', action = wezterm.action_callback(function(window, pane)
					pane:move_to_new_tab()
					pane:activate()
				end),
		},
		{ key = 'k', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(-1) },
		{ key = 'j', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(1) },
		-- Workspaces
		{ key = 'S', mods = 'LEADER|SHIFT', action = act.PromptInputLine {
			description = 'New session name',
			action = wezterm.action_callback(function(window, pane, line)
				if line:len() > 0 then window:perform_action(act.SwitchToWorkspace { name = line }, pane)
				else window:perform_action(act.SwitchToWorkspace, pane) end
			end), },
		},
		{ key = 'Enter',   mods = 'LEADER', action = act.SwitchToWorkspace }, -- new session (random name)
		{ key = 'C', mods = 'LEADER|SHIFT', action = act.SwitchToWorkspace }, -- new session (random name)
		{ key = ')',          mods ='LEADER|SHIFT', action = act.Multiple { act.SwitchWorkspaceRelative(1),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = '(',          mods ='LEADER|SHIFT', action = act.Multiple { act.SwitchWorkspaceRelative(-1),
			act.ActivateKeyTable { name = 'mux_mode', one_shot = false, until_unknown = true, timeout_milliseconds = timeout }, }
		},
		{ key = 'i',   mods = 'SHIFT|CTRL',   action = act.SwitchWorkspaceRelative(1) },
		{ key = 'o',   mods = 'SHIFT|CTRL',   action = act.SwitchWorkspaceRelative(-1) },
		{ key = 'w',   mods = 'LEADER',       action = act.ShowTabNavigator, },
		{ key = '$', mods = 'LEADER|SHIFT',   action = act.PromptInputLine {
			description = 'Rename session',
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end), },
		},
		{ key = '@', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				local panes_num = #pane:tab():panes()
				if panes_num > 1 then
					local new_session = session_name(window)
					pane:move_to_new_window(new_session)
					mux.set_active_workspace(new_session)
				end
			end),
		},
		{ key = 's', mods = 'LEADER',      action = sessionizer.show('sessions'), },
		{ key = 'f', mods = 'LEADER|CTRL', action = sessionizer.show() },
		{ key = 'r', mods = 'LEADER|CTRL', action = sessionizer.show('repos') },
		{ key = '.', mods = 'LEADER|CTRL', action = sessionizer.show('config') },
		{ key = 'Y', mods ='LEADER|SHIFT', action = act.SwitchToWorkspace { name = sessions.default, }, },
		{ key = '.', mods = 'LEADER',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.config)
			end),
		},
		{
			key = 'J', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.personal[1])
			end),
		},
		{
			key = 'K', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.personal[2])
			end),
		},
		{
			key = 'L', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.personal[3])
			end),
		},
		{
			key = 'H', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.personal[4])
			end),
		},
		{
			key = 'U', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.work[1])
			end),
		},
		{
			key = 'I', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.work[2])
			end),
		},
		{
			key = 'O', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.work[3])
			end),
		},
		{
			key = 'P', mods = 'LEADER|SHIFT',
			action = wezterm.action_callback(function(window, pane)
				sessionizer.actions.SwitchToWorkspace(window, pane, sessions.work[4])
			end),
		},
	},
	key_tables = {
		copy_mode = {
			{ key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
			{ key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
			{ key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
			{ key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
			{ key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
			{ key = 'a', mods = 'NONE', action = act.CopyMode 'Close' },
			{ key = 'i', mods = 'NONE', action = act.CopyMode 'Close' },
			{ key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
			{ key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
			{ key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
			{ key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
			{ key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
			{ key = 'F', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
			{ key = 'F', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
			{ key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
			{ key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
			{ key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
			{ key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
			{ key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
			{ key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
			{ key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
			{ key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
			{ key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
			{ key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
			{ key = 'T', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
			{ key = 'T', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
			{ key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
			{ key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
			{ key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
			{ key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
			{ key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
			{ key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
			{ key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
			{ key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
			{ key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
			{ key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
			{ key = 'f', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = false } } },
			{ key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
			{ key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
			{ key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
			{ key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
			{ key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
			{ key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
			{ key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
			{ key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
			{ key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
			{ key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
			{ key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
			{ key = 't', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = true } } },
			{ key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },
			{ key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
			{ key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
			{ key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
			{ key = 'y', mods = 'NONE', action = act.Multiple {
					act.CopyTo 'ClipboardAndPrimarySelection', act.CopyMode 'Close' }
			},
			{ key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
			{ key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
			{ key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
			{ key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
			{ key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
			{ key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
			{ key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
			{ key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
			{ key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
			{ key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
		},

		search_mode = {
			{ key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
			{ key = 'Enter', mods = 'SHIFT', action = act.CopyMode 'NextMatch' },
			{ key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
			{ key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
			{ key = 'g', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
			{ key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
			{ key = 'G', mods = 'SHIFT|CTRL', action = act.CopyMode 'PriorMatch' },
			{ key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
			{ key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
			{ key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
			{ key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
			{ key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
			{ key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
			{ key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
		},
		mux_mode = {
			{ key = 'Escape', action = act.PopKeyTable },
			{ key = 'a', action = act.PopKeyTable },
			{ key = 'i', action = act.PopKeyTable },
			{ key = 'c', mods = 'CTRL', action = act.PopKeyTable },
			{ key = 'k', action = act.ActivatePaneDirection('Up') },
			{ key = 'j', action = act.ActivatePaneDirection('Down') },
			{ key = 'h', action = act.ActivatePaneDirection('Left') },
			{ key = 'l', action = act.ActivatePaneDirection('Right') },
			{ key = 'o',   mods = 'CTRL',   action = act.RotatePanes('CounterClockwise') },
			{ key = 'o',   mods = 'ALT',    action = act.RotatePanes('Clockwise') },
			{ key = '<',   mods = 'SHIFT',  action = act.AdjustPaneSize { 'Left', 4 } },
			{ key = '>',   mods = 'SHIFT',  action = act.AdjustPaneSize { 'Right', 4 } },
			{ key = '+',   mods = 'SHIFT',  action = act.AdjustPaneSize { 'Up', 4 } },
			{ key = '_',   mods = 'SHIFT',  action = act.AdjustPaneSize { 'Down', 4 } },
			{ key = '+',                    action = act.AdjustPaneSize { 'Up', 4 } },
			{ key = '-',                    action = act.AdjustPaneSize { 'Down', 4 } },
			{ key = 'LeftArrow',            action = act.AdjustPaneSize { 'Left', 4 } },
			{ key = 'RightArrow',           action = act.AdjustPaneSize { 'Right', 4 } },
			{ key = 'UpArrow',              action = act.AdjustPaneSize { 'Up', 4 } },
			{ key = 'DownArrow',            action = act.AdjustPaneSize { 'Down', 4 } },
			{ key = 'z', action = act.TogglePaneZoomState },
			{ key = '}', mods = 'SHIFT', action = act.PaneSelect({}) },
			{ key = '{', mods = 'SHIFT', action = act.PaneSelect({ mode = 'SwapWithActive' }) },
			{ key = 'c', action = act.SpawnTab('CurrentPaneDomain') },
			{ key = '&', mods = 'SHIFT', action = act.CloseCurrentTab({ confirm = true }) },
			{ key = 'p',                 action = act.ActivateTabRelative(-1) },
			{ key = 'n',                 action = act.ActivateTabRelative(1) },
			{ key = 'j', mods = 'CTRL',  action = act.MoveTabRelative(-1) },
			{ key = 'k', mods = 'CTRL',  action = act.MoveTabRelative(1) },
			{ key = 'w',                 action = act.ShowTabNavigator },
			{ key = ')', mods = 'SHIFT', action = act.SwitchWorkspaceRelative(1) },
			{ key = '(', mods = 'SHIFT', action = act.SwitchWorkspaceRelative(-1) },
			{ key = '!', mods = 'SHIFT', action = wezterm.action_callback(function(_, pane)
					pane:move_to_new_tab()
					pane:activate()
				end),
			},
			{ key = '@', mods = 'SHIFT',
				action = wezterm.action_callback(function(window, pane)
					local panes_num = #pane:tab():panes()
					if panes_num > 1 then
						local new_session = session_name(window)
						pane:move_to_new_window(new_session)
						mux.set_active_workspace(new_session)
					end
					window:perform_action(act.PopKeyTable)
				end),
			},
			{ key = 'LeftShift',  action = act.Nop },
			{ key = 'RightShift',  action = act.Nop },
			{ key = 'LeftControl',  action = act.Nop },
			{ key = 'RightControl',  action = act.Nop },
		},
	},
}

return M
