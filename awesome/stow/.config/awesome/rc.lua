pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")
-- Themes. Currently using Quiet theme, a theme of my own creation
beautiful.init(gears.filesystem.get_configuration_dir() .. "quiet/theme.lua")

-- Notification library
local naughty = require("naughty")

-- Declarative object management
local revelation = require("awesome-revelation")

revelation.init()
revelation.charorder = "1234567890qwertyuiopasdfghjklzxcvbnm"

-- Hotkey help for other apps
require("awful.hotkeys_popup.keys")

-- Autostart stuff
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

terminal = "alacritty" -- Lua superiority
browser = "firefox"
filemgr = "spacefm"
editor = os.getenv("EDITOR") or "vim" -- Lisp superiority (my default editor is emacs)

-- Super key as mod key. Windows key for you window plebians
modkey = "Mod4"
altkey = "Mod1"

if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    }
end

-- Layout config
require("config.layout")

-- Keybindings
require("config.keys")

-- Bar config
require("config.bar")

-- Titlebar config
require("config.titlebar")

-- Rules config
require("config.rules")
