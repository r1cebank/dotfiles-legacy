pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local gfs = require("gears.filesystem")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local theme = dofile(gfs.get_configuration_dir() .. "quiet/theme.lua")


-- Declarative object management
local hotkeys_popup = require("awful.hotkeys_popup")
local bling = require("bling")

bling.widget.tag_preview.enable {
    show_client_content = true,
    x = 0,
    y = 0,
    scale = 0.25,
    honor_padding = false,
    honor_workarea = false,
    placement_fn = function(c)
        awful.placement.bottom_left(c, {
            margins = {
                bottom = 30,
                left = 30
            }
        })
    end
}
bling.widget.task_preview.enable {
    x = 20,
    y = 20,
    height = 200,
    width = 200,
    placement_fn = function(c)
        awful.placement.bottom(c, {
            margins = {
                bottom = 30
            }
        })
    end
}

awful.screen.connect_for_each_screen(function(s)

    -- Set tags and default layout
    awful.tag({ "web", "term", "docs", "file", "media", "misc"}, s, awful.layout.suit.fair)

    -- Show currently used layout
    s.layoutbox = awful.widget.layoutbox(s)

    s.layoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end)
    ))


    local taglist_shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 15)
    end

    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rounded_rect
        },
        layout   = {
            spacing = 5,
            spacing_widget = {
                color = '#181e23',
                shape = gears.shape.rounded_rect,
                widget = wibox.widget.separator,
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                            margins = 0,
                            widget = wibox.container.margin,
                        },
                        widget = wibox.container.background,
                    },
                    {
                        id     = 'index_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:connect_signal('mouse::enter', function()
                    if #c3:clients() > 0 then
                        awesome.emit_signal("bling::tag_preview::update", c3)
                        awesome.emit_signal("bling::tag_preview::visibility", s, true)
                    end

                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::tag_preview::visibility", s, false)
                    if self.has_backup then self.bg = self.backup end
                end)
            end,
            update_callback = function(self, c3, index, objects)
            end,
        },
        buttons = taglist_buttons
    }

    -- Clock
    clock = wibox.widget.textclock()

    -- Battery
    battery = awful.widget.watch('bash -c "echo Battery: `cat /sys/class/power_supply/BAT0/capacity`%/`cat /sys/class/power_supply/BAT1/capacity`%"', 15) 

    -- Menu
    awesomemenu = {
     {"Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
     {"Reload", awesome.restart},
     {"Quit", function() awesome.quit() end},
    }

    appmenu = {
     {"Terminal", function() awful.spawn.with_shell(terminal) end},
     {"Browser", function() awful.spawn.with_shell(browser) end},
     {"File manager", function() awful.spawn.with_shell(filemgr) end},
    }

    scriptmenu = {
     {"Take screenshot", function() awful.spawn.with_shell("~/.dotfiles/bin/rofi-screenshot") end},
     {"Shorten url", function() awful.spawn.with_shell("~/.dotfiles/bin/rofi-shorturl") end},
    }

    mainmenu = awful.menu({items = {
        {"AwesomeWM", awesomemenu, beautiful.awesome_icon},
        {"Scripts", scriptmenu, beautiful.terminal},
        {"Apps", appmenu, beautiful.app},
    }})

    launcher = awful.widget.launcher({image = beautiful.self_icon, menu = mainmenu})

    -- Create the top bar
    s.wibar = awful.wibar({
        position = "bottom",
        x = 0,
        y = 0,
        screen = s,
        height = 35,
        visible = true,
        stretch = true,
        bg = "#181e23",
    })

    -- Add widgets
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            launcher,
            s.taglist,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            {
                s.tasklist,
                widget = wibox.container.background
            }
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(wibox.widget.systray(), 7, 7, 10, 10),
            wibox.layout.margin(clock, 7, 7, 7, 7),
            wibox.layout.margin(battery, 7, 7, 7, 7),
            wibox.layout.margin(s.layoutbox, 7, 7, 7, 7),
        },
    }
end)
