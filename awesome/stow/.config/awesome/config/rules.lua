pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- Declarative object management
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Hotkey help for other apps
require("awful.hotkeys_popup.keys")

-- Application tag assignments
local application_tags = {
  web = {
    "firefox",
    "qutebrowser"
  },
  term = {
    "Alacritty"
  },
  docs = {
    "Gedit",
    "Code",
    "Vivado",
    "trilium notes",
    "obsidian",
    "Blender"
  },
  file = {
    "Pcmanfm",
    "Spacefm"
  },
  media = {
    "Xfmpc"
  },
  misc = {
    "TelegramDesktop"
  }
}

local application_rules = {}

for tag_name, tag_apps in pairs(application_tags) do
  for _, application in pairs(tag_apps) do
    table.insert(application_rules, {
      rule = { class = application },
      properties = { screen = 1, tag = tag_name }
    })
  end
end

-- Rules
awful.rules.rules = {
    -- All clients will match this rule
    {
        rule = {},
        properties = {
            border_width = 0,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
            awful.placement.no_offscreen,
            titlebars_enabled = true
        }
    }, -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            }
        },
        properties = {
            floating = true
        }
    },
    table.unpack(application_rules)
}
