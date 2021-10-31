local awful = require("awful")
local gears         = require("gears")
require("awful.autofocus")
local naughty = require("naughty")

local hotkeys_popup = require("awful.hotkeys_popup")

local bling = require("bling")
local machi = require("layout-machi")
local revelation = require("awesome-revelation")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility

globalkeys = mytable.join(
    --- AwesomeWM ---

    -- Toggle titlebar
    awful.key({modkey}, '`', function() awful.titlebar.toggle(client.focus) end, {
        description = "Toggle title bar", group = "AwesomeWM"
    }),

    -- Edit the current layout
    awful.key({modkey}, "'", function() machi.default_editor.start_interactive() end, {
        description = "Edit the current layout",
        group = "Machi"
    }),

    -- Switch windows in Machi layout
    awful.key({modkey}, ".", function() machi.switcher.start(client.focus) end, {
        description = "Switch windows in Machi layout",
        group = "Machi"
    }),

    -- Toggle Wibar
    awful.key({modkey}, "b", function()
        for s in screen do s.wibar.visible = not s.wibar.visible end
        end, {
        description = 'Togkle Wibar', group = "AwesomeWM"
    }),

    -- Expose
    awful.key({modkey}, "e", revelation, {
        description = 'Expose', group = "AwesomeWM"
    }),

    --- Bling ---

    -- Toggle swallowing
    awful.key({modkey}, 's', function() bling.module.window_swallowing.toggle() end, {
    description = 'Toggle swallowing', group = "Bling"
    }),

    -- Add client to tabbed layout
    awful.key({modkey}, 't', function() bling.module.tabbed.pick() end, {
    description = 'Add client to tabbed layout', group = "Bling"
    }),

    -- Tab through clients in tabbed client
    awful.key({modkey}, 'Tab', function() bling.module.tabbed.iter() end, {
    description = 'Tab through clients in tabbed client', group = "Bling"
    }),

    --- Tags ---

    -- Previous tag
    awful.key({modkey}, "Left", awful.tag.viewprev, {
        description = "Previous Tag",
        group = "Tags"
    }),

    -- Next Tag
    awful.key({modkey}, "Right", awful.tag.viewnext, {
        description = "Next Tag",
        group = "Tags"
    }),

    --- Windows ---

    -- Switch layout
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end, {
        description = "Switch layout",
        group = "Windows"
    }),

    -- Toggle floating mode
    awful.key({modkey, "Control"}, "space", function()
        client.focus.floating = not client.focus.floating
    end, {
        description = "Toggle floating mode",
        group = "Windows"
    }),

    -- Toggle Fullscreen
    awful.key({modkey, "Shift"}, "f", function()
            client.focus.fullscreen = not client.focus.fullscreen client.focus:raise()
        end, {
        description = "Toggle fullscreen mode",
        group = "Windows"
    }),

    -- Close window
    awful.key({modkey, "Shift"}, "q", function() client.focus:kill() end, {
        description = "Close window",
        group = "Windows"
    }),

    -- Focus left
    awful.key({modkey}, "h", function() awful.client.focus.bydirection("left") end, {
        description = "Focus left",
        group = "Windows"
    }),

    -- Focus down
    awful.key({modkey}, "j", function() awful.client.focus.bydirection("down") end, {
        description = "Focus down",
        group = "Windows"
    }),

    -- Focus up
    awful.key({modkey}, "k", function() awful.client.focus.bydirection("up") end, {
        description = "Focus up",
        group = "Windows"
    }),

    -- Focus right
    awful.key({modkey}, "l", function() awful.client.focus.bydirection("right") end, {
        description = "Focus right",
        group = "Windows"
    }),

    -- Swap with next client
    awful.key({modkey, "Control"}, "j", function() awful.client.swap.byidx(1) end, {
        description = "Swap with next client",
        group = "Windows"
    }),

    -- Swap with previous client
    awful.key({modkey, "Control"}, "k", function() awful.client.swap.byidx(-1) end, {
        description = "Swap with previous client",
        group = "Windows"
    }),

    -- Resize to the right
    awful.key({modkey, "Shift"}, "l", function() awful.tag.incmwfact(0.05) end, {
        description = "Resize to the right",
        group = "Windows"
    }),

    -- Resize to the left
    awful.key({modkey, "Shift"}, "h", function() awful.tag.incmwfact(-0.05) end, {
        description = "Resize to the left",
        group = "Windows"
    }),

    -- Minimize windows
    awful.key({modkey}, "m", function() client.focus.minimized = true end, {
        description = "Minimize windows",
        group = "Windows"
    }),

    -- Un-minimize windows
    awful.key({modkey, "Control"}, "m", function () local c = awful.client.restore() if c then c:activate { raise = true, context = "key.unminimize" } end end, {
        description = "Un-minimize windows",
        group = "Windows"
    }),

    -- Restart awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart,
                {description = "reload awesome", group = "awesome" }),

    --- Applications and menus --

    -- Open terminal
    awful.key({modkey}, "Return", function() awful.spawn(terminal) end, {
        description = "Open terminal",
        group = "Applications and menus"
    }),

    -- Open firefox
    awful.key({modkey}, "q", function() awful.spawn(browser) end, {
        description = "Open Firefox",
        group = "Applications and menus"
    }),

    -- Open run menu
    awful.key({modkey}, "r", function() awful.spawn.with_shell("rofi -show run -display-run 'Launcher'") end, {
        description = "Open run launcher",
        group = "Applications and menus"
    }),

    -- Open emoji menu
    awful.key({modkey, "Shift"}, "e", function() awful.spawn.with_shell("rofi -show emoji -display-emoji 'Emoji'") end, {
        description = "Open emoji launcher",
        group = "Applications and menus"
    }),

    -- Open launcher
    awful.key({modkey}, "space", function() awful.spawn.with_shell("rofi -show drun -display-drun 'App Launcher'") end, {
        description = "Open desktop launcher",
        group = "Applications and menus"
    }),

    -- Take screenshot
    awful.key({modkey, "Shift"}, "s", function() awful.spawn.with_shell("~/.dotfiles/bin/rofi-screenshot") end, {
        description = "Take screenshot",
        group = "Applications and menus"
    }),

    -- Power menu
    awful.key({modkey}, "Escape", function() awful.spawn.with_shell("~/.dotfiles/bin/rofi-power") end, {
        description = "Power menu",
        group = "Applications and menus"
    }),

    -- Lock screen
    awful.key({}, "XF86Sleep", function() os.execute(string.format("%s/.dotfiles/bin/lock", os.getenv("HOME"))) end, {
        description = "Power menu",
        group = "Applications and menus"
    }),
    awful.key({ altkey, "Control" }, "l", function () os.execute(string.format("%s/.dotfiles/bin/lock", os.getenv("HOME"))) end,
                {description = "lock screen", group = "hotkeys"}),

    -- Hotkey menu
    awful.key({modkey}, "/", hotkeys_popup.show_help, {
        description = "Hotkey menu",
        group = "Applications and menus"
    }),

    -- Various functions

    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -D pulse sset Master 2%+", false) end),
        awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -D pulse sset Master 2%-", false) end),
        awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer -D pulse sset Master toggle", false) end),

    -- Toggle song
    awful.key({modkey}, "XF86AudioMute", function()
        awful.spawn.with_shell("playerctl play-pause")
        end, {
        description = "Toggle song",
        group = "Various functions"
    }),

    -- Screen brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end,
              {description = "-10%", group = "hotkeys"})
)

globalkeys = mytable.join(globalkeys,
    awful.key {
        modifiers = { modkey },
        keygroup = "numrow",
        description = "Only view tag",
        group = "Tag",
        on_press = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Control" },
        keygroup = "numrow",
        description = "Toggle tag",
        group = "Tags",
        on_press = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup = "numrow",
        description = "Move focused client to tag",
        group = "Tags",
        on_press = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end
    }
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = mytable.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Set keys
root.keys(globalkeys)


client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({modkey}, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({modkey}, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)
