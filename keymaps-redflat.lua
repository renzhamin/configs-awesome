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

local redflat   = require("redflat")
local redtip    = redflat.float.hotkeys


local keymaps = {}


local raw_keys = {

--- Client ----
    {
		
        {modkey},"Tab", function()
            focusNext(-1)
        end,
        {description="Cycle Windows in tag", group="Client"}
    
	},
    {
		
        {modkey,"Shift"},"Tab", function()
            focusNext(1)
        end,
        {description="Cycle Windows in tag", group="Client"}
    
	},

--------------

--- Launchers ----
    {
		 
        {modkey},"t", function()
        awful.spawn(terminal) end,
        {description = "Terminal", group = "Launcher"}
    
	},

    {
		 
        {modkey},"e", function()
        awful.spawn(filemanager) end,
        {description = "File Manager", group = "Launcher"}
    
	},

    {
		
        {modkey,altkey},"b",function()
        awful.spawn(browser) end,
        {description=browser, group="Launcher"}
    
	},

    {
		
        {modkey},"s",function()
        awful.spawn("rofi -show drun") end,
        {description="rofi", group="Launcher"}
    
	},

    {
		
        {modkey,"Shift"},"s",function()
        awful.spawn("rofi -show window") end,
        {description="window switcher", group="Launcher"}
    
	},

    {
		
        {modkey,"Shift"},"k",function()
        awful.spawn("keepassxc") end,
        {description="KeepassXC", group="Launcher"}
    
	},

    {
		
        {modkey},"Return",function()
        awful.spawn(string.format("dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn NotoMonoRegular:bold:pixelsize=14",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))end,
    {description = "show dmenu", group = "Launcher"}
	},


----------------------------

--- Prompt Scripts ----
    {
		
        {modkey,modkey1},"k",function()
        awful.spawn.with_shell(prompt_scripts .. "killUserProcess") end,
        {description="Kill Script", group="Prompt Script"}
    
	},

    {
		
        {modkey,modkey1},"v",function()
        awful.spawn.with_shell(prompt_scripts .. "setVolume") end,
        {description="Set Volume", group="Prompt Script"}
    
	},

------------


    {
		
        {}, "Print", function()
        awful.spawn(screenshot) end,
        {description="Screenshot", group="Launcher"}
    
	},

-- Controls --
    {
		
        {modkey,modkey1},"equal",function()
        awful.spawn(brightnessUp) end,
        { description="Brightness Up", group="Control" }
    
	},
    {
		
        {modkey,modkey1},"minus",function()
        awful.spawn(brightnessDown) end,
        { description="Brightness Down", group="Control" }
    
	},

    {
		
        {modkey,modkey1},"n",function()
        awful.spawn("networkmanager_dmenu") end,
        { description="Network", group="Prompt Script" }
    
	},

    {
		
        {modkey,modkey1},"b",function()
        awful.spawn("rofi-bluetooth") end,
        { description="Bluetooth", group="Prompt Script" }
    
	},

    {
		
        {modkey,modkey1},"e",function()
        awful.spawn.with_shell("nmcli c down Ethernet") end,
        {description="Ethernet Off", group="Control"}
    
	},

    {
		
        {modkey,modkey1,"Shift"},"e",function()
        awful.spawn.with_shell("nmcli c up Ethernet") end,
        {description="Ethernet on", group="Control"}
    
	},

-----------------


    {
		{ modkey }, "v", function () awful.util.spawn( "pavucontrol" ) end,
        {description = "pulseaudio control", group = "Launcher"}
	},


    -- ctrl+alt +  ...
    {
		{ modkey, modkey1   }, "p", function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
        {description = "Picom toggle", group = "Control"}
	},


    {
		{ modkey }, "F1",  function()  myhotkey:show_help() end,
        {description = "show help", group="awesome"}
	},

    {
		{ modkey }, "F2",  function()  redtip:show() end,
        {description = "show help", group="awesome"}
	},

    {
		{ altkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}
	},


     -- Tag browsing modkey + tab
    {
		{ modkey  }, "Right",   awful.tag.viewnext,
        {description = "view next", group = "tag"}
	},
    {
		{ modkey }, "Left",  awful.tag.viewprev,
        {description = "view previous", group = "tag"}
	},


    {
		{ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "Client"}
    
	},
    {
		{ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "Client"}
    
	},

    -- By direction client focus
    {
		{ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "Client"}
	},
    {
		{ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "Client"}
	},
    {
		{ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "Client"}
	},
    {
		{ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "Client"}
	},


        -- By direction client focus with arrows
    {
		{ modkey1, modkey }, "Down",
            function()
                awful.client.focus.global_bydirection("down")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus down", group = "Client"}
	},
    {
		{ modkey1, modkey }, "Up",
            function()
                awful.client.focus.global_bydirection("up")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus up", group = "Client"}
	},
    {
		{ modkey1, modkey }, "Left",
            function()
                awful.client.focus.global_bydirection("left")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus left", group = "Client"}
	},
    {
		{ modkey1, modkey }, "Right",
            function()
                awful.client.focus.global_bydirection("right")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus right", group = "Client"}
	},


    -- Layout manipulation
    {
		{ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "Client"}
	},
    {
		{ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "Client"}
	},
    {
		{ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}
	},
    {
		{ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}
	},
    {
		{ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "Client"}
	},
    {
		{ altkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "Client"}
	},

    -- Show/Hide Wibox
    {
		{ modkey, "Shift" }, "b", function ()
            for s in screen do
                s.statusbar.visible = not s.statusbar.visible
            end
        end,
        {description = "toggle wibar", group = "awesome"}
	},

    -- Show/Hide wibox on current tag
    {
		{ modkey },"b", function() toggleWibarForTag() end,
    {description ="toggle wibar on current tag", group="awesome"}
	},

 -- Show/Hide Systray
    {
		{ modkey }, "-", function ()
    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, {description = "Toggle systray visibility", group = "awesome"}
	},

 -- Show/Hide Systray
    {
		{ modkey }, "KP_Subtract", function ()
    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, {description = "Toggle systray visibility", group = "awesome"}
	},



    -- On the fly useless gaps change
    {
		{ modkey, altkey }, "equal", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}
	},
    {
		{ modkey, altkey }, "minus", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}
	},

    -- Dynamic tagging
    {
		{ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}
	},
    {
		{ modkey, "Control" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}
	},
    {
		{ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}
	},
    {
		{ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}
	},
    {
		{ modkey, "Shift" }, "y", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}
	},

    -- Standard program
    {
		{ modkey }, "q", awesome.restart,
              {description = "reload awesome", group = "awesome"}
	},
    {
		{ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}
	},

    {
		{ modkey,modkey1 }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}
	},
    {
		{ modkey,modkey1 }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}
	},
    {
		{ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}
	},
    {
		{ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}
	},
    {
		{ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}
	},
    {
		{ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}
	},
    {
		{ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}
	},
  
    {
		{ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "Client"}
	},

     {
		{ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            beautiful.volume.update() end,
            {description="Increase Volume", group="Control"}
	},

    {
		{ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description="Increase Volume", group="Control"}
	},

    {
		{ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description="Mute Volume", group="Control"}
	},


    {
		{ altkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}
    }
    --]]
}

keymaps.globalkeys = redflat.util.key.build(raw_keys)

local raw_client_keys = {
    {
		{ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "Client"}
	},
    {
		{ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "Client"}
	},

    {
		{ modkey },           "c",      function (c) c:kill()                         end,
              {description = "close", group = "Client"}
	},
    {
		{ modkey }, "a",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "Client"}
	},
    {
		{ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "Client"}
	},
    {
		{ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "Client"}
	},
    {
		{ modkey, "Shift"}, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "Client"}
	},
    {
		{ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "Client"}
	},
    {
		{ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "Client"}
	},
}

keymaps.clientkeys = redflat.util.key.build(raw_client_keys)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    keymaps.globalkeys = my_table.join(keymaps.globalkeys,
        -- View tag only.
        awful.key({ altkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey }, "#" .. i + 9,
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
        awful.key({ modkey, "Control" }, "#" .. i + 9,
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


redtip:set_pack("Main",my_table.join(raw_keys,raw_client_keys),3)

return keymaps
