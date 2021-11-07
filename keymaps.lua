local awesome, client, screen = awesome, client, screen
local string, os = string, os

local awful             = require("awful")
                          require("awful.autofocus")
local beautiful         = require("beautiful")
local naughty           = require("naughty")
--local menubar         = require("menubar")

local lain              = require("lain")

local hotkeys_popup = require("awful.hotkeys_popup").widget
--require("awful.hotkeys_popup.keys")
local myhotkey          = hotkeys_popup.new({
    width = 1200, height = 700,
    group_margin = 25
})
local my_table          = require("gears.table")
local help              = require("helpers")
local focusNext         = help.focusNext
local toggleWibarForTag = help.toggleWibarForTag

local modkey       = "Mod4"
local altkey       = "Mod1"
local modkey1      = "Control"

local prompt_scripts   = "~/.config/spectrwm/prompt_scripts/"

local browser           = "brave"
local screenshot        = "flameshot gui"
local filemanager       = "pcmanfm"
local terminal          = "alacritty"

local brightnessUp      = "light -A 5"
local brightnessDown    = "light -D 5"


local keymaps = {}


keymaps.globalkeys = my_table.join(

--- Client ----
    awful.key(
        {modkey},"Tab", function()
            focusNext(-1)
        end,
        {description="Cycle Windows in tag", group="Client"}
    ),
    awful.key(
        {modkey,"Shift"},"Tab", function()
            focusNext(1)
        end,
        {description="Cycle Windows in tag", group="Client"}
    ),

--------------

--- Launchers ----
    awful.key( 
        {modkey},"t", function()
            awful.spawn(terminal) end,
        {description = "Terminal", group = "Launcher"}
    ),

    awful.key( 
        {modkey},"e", function()
            awful.spawn(filemanager) end,
        {description = "File Manager", group = "Launcher"}
    ),

    awful.key(
        {modkey,altkey},"b",function()
            awful.spawn(browser) end,
        {description=browser, group="Launcher"}
    ),

    awful.key(
        {modkey},"s",function()
            awful.spawn("rofi -show drun") end,
        {description="rofi", group="Launcher"}
    ),

    awful.key(
        {modkey,"Shift"},"s",function()
            awful.spawn("rofi -show window") end,
        {description="window switcher", group="Launcher"}
    ),

    awful.key(
        {modkey,"Shift"},"k",function()
            awful.spawn("keepassxc") end,
        {description="KeepassXC", group="Launcher"}
    ),

    awful.key(
        {modkey},"Return",function()
            awful.spawn(string.format("dmenu_run",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))end,
    {description = "show dmenu", group = "Launcher"}),

    awful.key(
        {modkey,"Shift"},"Return",function()
            beautiful.quake:toggle() end,
        {description="Dropdown Terminal", group="Launcher"}
    ),


----------------------------

--- Prompt Scripts ----
    awful.key(
        {modkey,modkey1},"k",function()
        awful.spawn.with_shell(prompt_scripts .. "killUserProcess") end,
        {description="Kill Script", group="Prompt Script"}
    ),

    awful.key(
        {modkey,modkey1},"v",function()
        awful.spawn.with_shell(prompt_scripts .. "setVolume") end,
        {description="Set Volume", group="Prompt Script"}
    ),

------------


    awful.key(
        {}, "Print", function()
        awful.spawn(screenshot) end,
        {description="Screenshot", group="Launcher" }
    ),

-- Controls --
    awful.key(
        {modkey,modkey1},"equal",function()
        awful.spawn(brightnessUp) end,
        {description="Brightness Up", group="Control" }
    ),
    awful.key(
        {modkey,modkey1},"minus",function()
        awful.spawn(brightnessDown) end,
        {description="Brightness Down", group="Control" }
    ),

    awful.key(
        {modkey,modkey1},"n",function()
        awful.spawn("networkmanager_dmenu") end,
        {description="Network", group="Prompt Script" }
    ),

    awful.key(
        {modkey,modkey1},"b",function()
        awful.spawn("rofi-bluetooth") end,
        {description="Bluetooth", group="Prompt Script" }
    ),

    awful.key(
        {modkey,modkey1},"e",function()
        awful.spawn.with_shell("nmcli c down Ethernet") end,
        {description="Ethernet Off", group="Control"}
    ),

    awful.key(
        {modkey,modkey1,"Shift"},"e",function()
        awful.spawn.with_shell("nmcli c up Ethernet") end,
        {description="Ethernet on", group="Control"}
    ),

-----------------


    awful.key({ modkey }, "v", function () awful.util.spawn( "pavucontrol" ) end,
        {description = "pulseaudio control", group = "Launcher"}),


    -- ctrl+alt +  ...
    awful.key({ modkey, modkey1   }, "p", function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
        {description = "Picom toggle", group = "Control"}),

    -- alt + ...
--    awful.key({ altkey, "Shift"   }, "t", function () awful.spawn.with_shell( "variety -t  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
--        {description = "Pywal Wallpaper trash", group = "altkey"}),
--    awful.key({ altkey, "Shift"   }, "n", function () awful.spawn.with_shell( "variety -n  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
--        {description = "Pywal Wallpaper next", group = "altkey"}),
--    awful.key({ altkey, "Shift"   }, "u", function () awful.spawn.with_shell( "wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
--        {description = "Pywal Wallpaper update", group = "altkey"}),
--    awful.key({ altkey, "Shift"   }, "p", function () awful.spawn.with_shell( "variety -p  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
--        {description = "Pywal Wallpaper previous", group = "altkey"}),
--    awful.key({ altkey }, "t", function () awful.util.spawn( "variety -t" ) end,
--        {description = "Wallpaper trash", group = "altkey"}),
--    awful.key({ altkey }, "n", function () awful.util.spawn( "variety -n" ) end,
--        {description = "Wallpaper next", group = "altkey"}),
--    awful.key({ altkey }, "p", function () awful.util.spawn( "variety -p" ) end,
--        {description = "Wallpaper previous", group = "altkey"}),
--    awful.key({ altkey }, "f", function () awful.util.spawn( "variety -f" ) end,
--        {description = "Wallpaper favorite", group = "altkey"}),
--    awful.key({ altkey }, "Left", function () awful.util.spawn( "variety -p" ) end,
--        {description = "Wallpaper previous", group = "altkey"}),
--    awful.key({ altkey }, "Right", function () awful.util.spawn( "variety -n" ) end,
--        {description = "Wallpaper next", group = "altkey"}),
--    awful.key({ altkey }, "Up", function () awful.util.spawn( "variety --pause" ) end,
--        {description = "Wallpaper pause", group = "altkey"}),
--    awful.key({ altkey }, "Down", function () awful.util.spawn( "variety --resume" ) end,
--        {description = "Wallpaper resume", group = "altkey"}),

    -- Hotkeys Awesome

    awful.key({ modkey }, "F1",  function()  myhotkey:show_help() end,
        {description = "show help", group="Awesome"}),

    awful.key({ modkey }, "F2",  function()  redtip:show() end,
        {description = "show help", group="Awesome"}),

    awful.key({ altkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "Tag"}),


     -- Tag browsing modkey + tab
    awful.key({ modkey  }, "Right",   awful.tag.viewnext,
        {description = "view next", group = "Tag"}),
    awful.key({ modkey }, "Left",  awful.tag.viewprev,
        {description = "view previous", group = "Tag"}),


    -- Non-empty tag browsing
--   awful.key({ modkey }, "Tab", function () lain.util.tag_view_nonempty(1) end,
--              {description = "view  next nonempty", group = "Tag"}),
--   awful.key({ modkey,"Shift" }, "Tab", function () lain.util.tag_view_nonempty(-1) end,
--             {description = "view  previous nonempty", group = "Tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "Client"}
    ),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "Client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "Client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "Client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "Client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "Client"}),


        -- By direction client focus with arrows
        awful.key({ modkey1, modkey }, "Down",
            function()
                awful.client.focus.global_bydirection("down")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus down", group = "Client"}),
        awful.key({ modkey1, modkey }, "Up",
            function()
                awful.client.focus.global_bydirection("up")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus up", group = "Client"}),
        awful.key({ modkey1, modkey }, "Left",
            function()
                awful.client.focus.global_bydirection("left")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus left", group = "Client"}),
        awful.key({ modkey1, modkey }, "Right",
            function()
                awful.client.focus.global_bydirection("right")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus right", group = "Client"}),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "Client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "Screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "Screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "Client"}),
    awful.key({ altkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "Client"}),

    -- Show/Hide Wibox
    awful.key({ modkey, "Shift" }, "b", function ()
            for s in screen do
                s.statusbar.visible = not s.statusbar.visible
            end
        end,
        {description = "toggle wibar", group = "Awesome"}),

    -- Show/Hide wibox on current tag
    awful.key({ modkey },"b", function() toggleWibarForTag() end,
    {description ="toggle wibar on current tag", group="Awesome"}),

 -- Show/Hide Systray
    awful.key({ modkey }, "-", function ()
    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, {description = "Toggle systray visibility", group = "Awesome"}),

 -- Show/Hide Systray
    awful.key({ modkey }, "KP_Subtract", function ()
    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, {description = "Toggle systray visibility", group = "Awesome"}),



    -- On the fly useless gaps change
    awful.key({ modkey, altkey }, "equal", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "Tag"}),
    awful.key({ modkey, altkey }, "minus", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "Tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "Tag"}),
    awful.key({ modkey, "Control" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "y", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "Tag"}),

    -- Standard program
    awful.key({ modkey }, "q", awesome.restart,
              {description = "reload awesome", group = "Awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "Awesome"}),

    awful.key({ modkey,modkey1 }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "Layout"}),
    awful.key({ modkey,modkey1 }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "Layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "Layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "Layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "Layout"}),
    --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
             -- {description = "select previous", group = "Layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "Client"}),

    -- Widgets popups
    --awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
        --{description = "show calendar", group = "widgets"}),
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
              --{description = "show filesystem", group = "widgets"}),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
              --{description = "show weather", group = "widgets"}),


    -- ALSA volume control
    awful.key(
        { }, "XF86AudioRaiseVolume", function()
            beautiful.volume.change("5%+") end,
        {description = "Increase Volume", group="Control"}),

    awful.key(
        { }, "XF86AudioLowerVolume", function()
            beautiful.volume.change("5%-") end,
        {description = "Decrease Volume", group="Control"}),

    awful.key(
        { }, "XF86AudioMute",function()
            beautiful.volume.change("toggle") end,
        {description = "Toggle Mute", group="Control"}),

  
    --Media keys supported by vlc, spotify, audacious, xmm2, ...
    --awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
    --awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
    --awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),
    --awful.key({}, "XF86AudioStop", function() awful.util.spawn("playerctl stop", false) end),

--Media keys supported by mpd.
--    awful.key({}, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end),
--    awful.key({}, "XF86AudioNext", function () awful.util.spawn("mpc next") end),
--    awful.key({}, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end),
--    awful.key({}, "XF86AudioStop", function () awful.util.spawn("mpc stop") end),
--
--    -- MPD control
--    awful.key({ modkey1, "Shift" }, "Up",
--        function ()
--            os.execute("mpc toggle")
--            beautiful.mpd.update()
--        end,
--        {description = "mpc toggle", group = "widgets"}),
--    awful.key({ modkey1, "Shift" }, "Down",
--        function ()
--            os.execute("mpc stop")
--            beautiful.mpd.update()
--        end,
--        {description = "mpc stop", group = "widgets"}),
--    awful.key({ modkey1, "Shift" }, "Left",
--        function ()
--            os.execute("mpc prev")
--            beautiful.mpd.update()
--        end,
--        {description = "mpc prev", group = "widgets"}),
--    awful.key({ modkey1, "Shift" }, "Right",
--        function ()
--            os.execute("mpc next")
--            beautiful.mpd.update()
--        end,
--        {description = "mpc next", group = "widgets"}),
--    awful.key({ modkey1, "Shift" }, "s",
--
--
--
--        function ()
--            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
--            if beautiful.mpd.timer.started then
--                beautiful.mpd.timer:stop()
--                common.text = common.text .. lain.util.markup.bold("OFF")
--            else
--                beautiful.mpd.timer:start()
--                common.text = common.text .. lain.util.markup.bold("ON")
--            end
--            naughty.notify(common)
--        end,
--        {description = "mpc on/off", group = "widgets"}),

    -- Copy primary to clipboard (terminals to gtk)
    --awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
             -- {description = "copy terminal to gtk", group = "hotkeys"}),
     --Copy clipboard to primary (gtk to terminals)
    --awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              --{description = "copy gtk to terminal", group = "hotkeys"}),


    -- Default
    --[[ Menubar

    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "super"})
    --]]

    awful.key({ altkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "Awesome"})
    --]]
)

keymaps.clientkeys = my_table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "Client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "Client"}),

    awful.key({ modkey },           "c",      function (c) c:kill()                         end,
              {description = "close", group = "Client"}),
    awful.key({ modkey }, "a",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "Client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "Client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "Client"}),
    awful.key({ modkey,modkey1          }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "Client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "Client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "Client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "Tag"}
        descr_toggle = {description = "toggle tag #", group = "Tag"}
        descr_move = {description = "move focused client to tag #", group = "Tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "Tag"}
    end
    local key = i+9
    if i==9 then key = 49 end

    keymaps.globalkeys = my_table.join(keymaps.globalkeys,
        -- View tag only.
        awful.key({ altkey }, "#" .. key,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Shift" }, "#" .. key,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey }, "#" .. key,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              --tag:view_only()
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control" }, "#" .. key,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

return keymaps
