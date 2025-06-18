-- Pull in the weztem API
local wezterm = require("wezterm")

local mux = wezterm.mux

-- This will hold the config.
local config = wezterm.config_builder()

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.color_scheme = "rose-pine"

config.colors = {
        cursor_bg = "#e0def4", -- Cursor background color
        cursor_border = "#e0def4", -- Cursor border color
        cursor_fg = "#232136", -- Cursor foreground color
        selection_bg = "#393552", -- Selection background color
        selection_fg = "#e0def4", -- Selection foreground color
        ansi = {
                "#393552", -- Black
                "#eb6f92", -- Red
                "#9ccfd8", -- Green
                "#f6c177", -- Yellow
                "#3e8fb0", -- Blue
                "#c4a7e7", -- Magenta
                "#9ccfd8", -- Cyan
                "#e0def4", -- White
        },
        brights = {
                "#6e6a86", -- Bright Black
                "#eb6f92", -- Bright Red
                "#9ccfd8", -- Bright Green
                "#f6c177", -- Bright Yellow
                "#3e8fb0", -- Bright Blue
                "#c4a7e7", -- Bright Magenta
                "#9ccfd8", -- Bright Cyan
                "#e0def4", -- Bright White
        },
}

-- Dimmer for background
local dimmer = {
        brightness = 0.05,
        saturation = 0.75,
}


-- Define the two background options (wallpaper and transparent)
local background_with_wallpaper = {
        {
                source = {
                  File = wezterm.config_dir .. "/backgrounds/iu-bg.jpg",
    },
                width = "Cover",
                height = "Cover",
                vertical_align = "Middle",
                horizontal_align = "Center",
                repeat_x = "NoRepeat",
                repeat_y = "NoRepeat",
                opacity = 1,
                hsb = dimmer,
        },
}

local transparent_background = {
        {
                source = {
                        Color = "#0a0a0a",
                },
                width = "100%",
                height = "100%",
                opacity = 0.8,
        },
}

-- Initialize with the wallpaper by default
config.background = background_with_wallpaper

-- config.background = transparent_background
-- config.macos_window_background_blur = 30

-- Toggle function between the two backgrounds
local current_background = "wallpaper"

wezterm.on("toggle-background", function(window)
        if current_background == "wallpaper" then
                -- Switch to transparent background
                config.background = transparent_background
                current_background = "transparent"
                config.window_background_opacity = 0
                config.macos_window_background_blur = 30
        else
                -- Switch to wallpaper
                config.background = background_with_wallpaper
                current_background = "wallpaper"
                config.window_background_opacity = 1
                config.macos_window_background_blur = 0
        end
        window:set_config_overrides(config)
end)

config.keys = {
        {
                key = "b",
                mods = "CTRL|SHIFT",
                action = wezterm.action.EmitEvent("toggle-background"),
        },
}

-- Window options
config.window_padding = {
        left = 40,
        right = 40,
        top = 40,
        bottom = 20,
}

-- Set to WSL as default
config.default_domain = 'WSL:Ubuntu'

-- FullScreen when startup
wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return config

