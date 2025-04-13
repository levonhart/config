return {
    colors = {
        foreground = '#a9d5c4',
        background = '#18191E',

        cursor_bg = '#5AD1AA',
        cursor_fg = '#18191E',
        cursor_border = '#47A8A1',

        -- the foreground color of selected text
        selection_fg = '#FF4D00',
        -- the background color of selected text
        selection_bg = '#090B26',

        -- The color of the scrollbar "thumb"; the portion that represents the current viewport
        scrollbar_thumb = '#222222',

        -- The color of the split lines between panes
        split = '#444444',

        ansi = { '#373C45', '#FF5050', '#44B273', '#ED722E', '#1D918B', '#D16BB7', '#00BFA4', '#8E8D8D' },
        brights = { '#CCCCCC', '#FF4D00', '#10B981', '#FFFF00', '#0DB9D7', '#D68EB2', '#5AD1AA', '#FFFADE' },

        -- -- Arbitrary colors of the palette in the range from 16 to 255
        indexed = { [136] = '#FFFF00' },

        -- Since: 20220319-142410-0fcdea07
        -- When the IME, a dead key or a leader key are being processed and are effectively
        -- holding input pending the result of input composition, change the cursor
        -- to this color to give a visual cue about the compose state.
        compose_cursor = '#1D918B',

		tab_bar = {
			background = '#18191E',
			inactive_tab_edge = '#8E8D8D',
			active_tab = {
				fg_color = '#a9d5c4',
				bg_color = '#282c34',
			},
			inactive_tab = {
				fg_color = '#a9d5c4',
				bg_color = '#18191E',
			},
			inactive_tab_hover = {
				fg_color = '#a9d5c4',
				bg_color = '#21252D',
			},
			new_tab = {
				fg_color = '#a9d5c4',
				bg_color = '#18191E',
			},
			new_tab_hover = {
				fg_color = '#a9d5c4',
				bg_color = '#21252D',
			},
		}
    },

}
