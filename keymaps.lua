local awesome, client, screen = awesome, client, screen
local string, os = string, os

local awful             = require("awful")
                          require("awful.autofocus")
local gears             = require("gears")                          
local beautiful         = require("beautiful")
local naughty           = require("naughty")
--local menubar         = require("menubar")

local lain              = require("lain")
-- local internet          = "Ethernet"
local internet          = "iut"

local hotkeys_popup = require("awful.hotkeys_popup").widget

local myhotkey = hotkeys_popup.new({
    width = 1360, height = 740,
    group_margin = 25
})

local gtable            = gears.table
local help              = require("helpers")
local focusNext         = help.focusNext
local toggleWibarForTag = help.toggleWibarForTag

local Mod           = "Mod4"
local Alt           = "Mod1"
local Control       = "Control"
local Shift         = "Shift"

local scripts_dir          = "~/.config/Scripts/"
local prompt_scripts_dir   = scripts_dir .. "prompt_scripts/"
local awm_scripts_dir      = "~/.config/awesome/scripts/"

local browser           = "brave"
local screenshot        = "flameshot gui"
local filemanager       = "pcmanfm"
local terminal          = "alacritty"

local brightnessUpCmd      = "light -A 5"
local brightnessDown       = "light -D 5"


local keymaps = {}


keymaps.globalkeys = gtable.join(

--- Client ----
    awful.key(
        {Mod},"Tab", function()
            focusNext(-1) end,
        {description="cycle clients in tag",group="Client"}
    ),
    awful.key(
        {Mod,Shift},"Tab", function()
            focusNext(1) end,
        {description="cycle clients in tag",group="Client"}
    ),

--------------

--- Launchers ----
    awful.key( 
        {Mod},"t", function()
            awful.spawn(terminal) end,
        {description="Terminal",group="Launcher"}
    ),

    awful.key( 
        {Mod},"e", function()
            awful.spawn(filemanager) end,
        {description="File Manager",group="Launcher"}
    ),

    awful.key(
        {Mod,Alt},"b",function()
            awful.spawn(browser) end,
        {description=browser,group="Launcher"}
    ),

    awful.key(
        {Mod},"s",function()
            awful.spawn("rofi -show drun") end,
        {description="rofi",group="Launcher"}
    ),

    awful.key(
        {Mod,Shift},"s",function()
            awful.spawn("rofi -show window") end,
        {description="window switcher",group="Launcher"}
    ),

    awful.key(
        {Mod},"F8",function()
            awful.spawn("keepassxc") end,
        {description="KeepassXC",group="Launcher"}
    ),

    awful.key(
        {Mod},"Return",function()
            awful.spawn("dmenu_run")end,
    {description="dmenu",group="Launcher"}),

    awful.key(
        {Mod,Shift},"Return",function()
            beautiful.quake:toggle() end,
        {description="Dropdown Terminal",group="Launcher"}
    ),

    awful.key(
        {Mod}, "v", function()
            awful.util.spawn( "pavucontrol" ) end,
        {description="pulseaudio control",group="Launcher"}
    ),


----------------------------

--- Prompt Scripts ----
    awful.key(
        {Mod},"F4",function()
        awful.spawn.with_shell(prompt_scripts_dir .. "killUserProcess") end,
        {description="Kill Script",group="Prompt Script"}
    ),

    awful.key(
        {Mod,Control},"v",function()
        awful.spawn.with_shell(prompt_scripts_dir .. "setVolume") end,
        {description="Set Volume",group="Prompt Script"}
    ),

------------


    awful.key(
        {}, "Print", function()
        awful.spawn(screenshot) end,
        {description="Screenshot",group="Launcher"}
    ),

-- Controls --

---volume---
    awful.key(
        {},"XF86AudioRaiseVolume", function()
            beautiful.volume.change("5%+") end,
        {description="Increase Volume",group="Control"}
    ),

    awful.key(
        {},"XF86AudioLowerVolume", function()
            beautiful.volume.change("5%-") end,
        {description="Decrease Volume",group="Control"}
    ),

    awful.key(
        {},"XF86AudioMute",function()
            beautiful.volume.change("toggle") end,
        {description="Toggle Mute",group="Control"}
    ),

----appvolume-----
    awful.key(
        {Shift},"XF86AudioRaiseVolume",function()
        awful.spawn.with_shell(scripts_dir .. "changePerAppVolume.sh +5%") end,
        {description="Increase App Volume",group="Control"}
    ),

    awful.key(
        {Shift},"XF86AudioLowerVolume",function()
        awful.spawn.with_shell(scripts_dir .. "changePerAppVolume.sh -5%") end,
        {description="Decrease App Volume",group="Control"}
    ),

    awful.key(
        {Shift},"XF86AudioMute",function()
        awful.spawn.with_shell(scripts_dir .. "togglePerAppMute.sh") end,
        {description="Toggle App Mute",group="Control"}
    ),

----brightness----
    awful.key(
        {Mod,Control},"equal",function()
        awful.spawn(brightnessUpCmd) end,
        {description="Brightness Up",group="Control"}
    ),
    awful.key(
        {Mod,Control},"minus",function()
        awful.spawn(brightnessDown) end,
        {description="Brightness Down",group="Control"}
    ),

    awful.key(
        {Mod,Control},"n",function()
        awful.spawn("networkmanager_dmenu") end,
        {description="Network",group="Prompt Script"}
    ),

    awful.key(
        {Mod,Control},"b",function()
        awful.spawn("rofi-bluetooth") end,
        {description="Bluetooth",group="Prompt Script"}
    ),

    awful.key(
        {Mod,Control},"e",function()
        awful.spawn.with_shell("nmcli c down " .. internet) end,
        {description="Ethernet Off",group="Control"}
    ),

    awful.key(
        {Mod,Control,Shift},"e",function()
        awful.spawn.with_shell("nmcli c up " .. internet) end,
        {description="Ethernet on",group="Control"}
    ),

    awful.key(
        {Mod,Control}, "p", function() 
            awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
        {description="Picom toggle",group="Control"}
    ),

-----------------

----awesome----
    awful.key(
        {Control,Alt},"Delete",function()
            awful.spawn.with_shell("dm-tool switch-to-greeter")
        end,
        {description="Lock", group="Awesome"}
    ),


    awful.key(
        {Mod},"F5",function()
            gears.wallpaper.maximized(beautiful.wallpaper,awful.screen.focused())
        end,
        {description="redraw wallpaper", group="Awesome"}
    ),


    awful.key(
		{Mod},"q",
            awesome.restart,
        {description="reload awesome",group="Awesome"}
	),

    awful.key(
		{Mod,Shift},"q",
            awesome.quit,
        {description="quit awesome",group="Awesome"}
	),


    awful.key(
        {Mod},"F1",function()
            myhotkey:show_help() end,
        {description="show help",group="Awesome"}
    ),

    awful.key(
        {Mod,Shift},"F1",function()
            hotkeys_popup.show_help() end,
        {description="default hotkeys widget",group="Awesome"}
    ),

    awful.key(
        {Mod},"F2",function()
            awful.spawn.with_shell(awm_scripts_dir.. "search_keys_awesome") end,
        {description="search keybindings",group="Awesome"}
    ),


    awful.key(
        {Mod,Shift}, "b", function()
            local s = awful.screen.focused()
            s.statusbar.visible = not s.statusbar.visible
            for _,t in pairs(s.tags) do
                t.statusbarvisible = s.statusbar.visible
            end
        end,
        {description="toggle wibar on screen",group="Awesome"}
    ),

    awful.key(
        {Mod},"b", function()
            toggleWibarForTag() end,
        {description="toggle wibar on tag",group="Awesome"}
    ),

    awful.key({Mod}, "-", function()
        local s=awful.screen.focused();s.systray.visible = not s.systray.visible end,
        {description="Toggle systray visibility",group="Awesome"}
    ),

    awful.key(
        {Mod},"KP_Subtract", function()
            local s=awful.screen.focused();s.systray.visible = not s.systray.visible end,
        {description="Toggle systray visibility",group="Awesome"}
    ),



------------------------------------------------------------

-------tag-----
    awful.key(
        {Mod},"Escape",
            awful.tag.history.restore,
        {description="go back",group="Tag"}
    ),

     -- Tag browsing
    awful.key(
        {Mod},"Right",
            awful.tag.viewnext,
        {description="view next",group="Tag"}
    ),

    awful.key(
        {Mod},"Left", 
            awful.tag.viewprev,
        {description="view previous",group="Tag"}
    ),

    -- Non-empty tag browsing
   awful.key(
		{Mod,Shift},"Right", function() 
            lain.util.tag_view_nonempty(1) end,
        {description="view  next nonempty",group="Tag"}
	),

   awful.key(
		{Mod,Shift},"Left", function() 
            lain.util.tag_view_nonempty(-1) end,
        {description="view  previous nonempty",group="Tag"}
	),

    -- On the fly useless gaps change
    awful.key(
		{Mod,Alt},"k",function()
			lain.util.useless_gaps_resize(1) end,
        {description="increment useless gaps",group="Tag"}
	),

    awful.key(
		{Mod,Alt}, "j",function()
			lain.util.useless_gaps_resize(-1) end,
        {description="decrement useless gaps",group="Tag"}
	),

    -- Dynamic tagging
    awful.key(
	    {Mod,Alt},"n",function()
			lain.util.add_tag() end,
        {description="add new tag",group="Tag"}
	),

    awful.key(
		{Mod,Alt},"r",function()
			lain.util.rename_tag() end,
        {description="rename tag",group="Tag"}
	),


    awful.key(
		{Mod,Alt},"d",function()
			lain.util.delete_tag() end,
        {description="delete tag",group="Tag"}
	),



------------------------------------------------------------

-------------client--------

    -- By direction client focus
    awful.key(
		{Mod},"j",function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description="focus down",group="Client"}
	),

    awful.key(
		{Mod},"k", function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description="focus up",group="Client"}
	),

    awful.key(
		{Mod},"h", function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description="focus left",group="Client"}
	),

    awful.key(
		{Mod},"l", function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description="focus right",group="Client"}
	),


--- By direction swapping
    awful.key(
		{Mod,Shift},"l", function()
			awful.client.swap.bydirection("right") end,
        {description="swap right",group="Client"}
	),


    awful.key(
		{Mod,Shift},"h", function()
			awful.client.swap.bydirection("left") end,
        {description="swap left",group="Client"}
	),

    awful.key(
		{Mod,Shift},"j", function()
			awful.client.swap.bydirection("down") end,
        {description="swap down",group="Client"}
	),

    awful.key(
		{Mod,Shift},"k", function()
			awful.client.swap.bydirection("up") end,
        {description="swap up",group="Client"}
	),


    awful.key(
		{Mod},"]", function()
			awful.screen.focus_relative( 1) end,
       {description="focus the next screen",group="Screen"}
	),

    awful.key(
		{Mod},"[", function()
			awful.screen.focus_relative(-1) end,
        {description="focus the previous screen",group="Screen"}
	),

    awful.key(
		{Mod},"u",
            awful.client.urgent.jumpto,
        {description="jump to urgent client",group="Client"}
	),

    awful.key(
		{Alt},"Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description="go back",group="Client"}
	),

    awful.key(
        {Mod,Shift},"n",function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description="restore minimized",group="Client"}
	),


-----layout-------
    awful.key(
		{Mod,Alt},"l",     function()
			awful.tag.incmwfact(0.05) end,
        {description="increase master width factor",group="Layout"}
	),

    awful.key(
		{Mod,Alt},"h",     function()
			awful.tag.incmwfact(-0.05) end,
        {description="decrease master width factor",group="Layout"}
	),

    awful.key(
		{Mod,Shift},".",     function()
			awful.tag.incnmaster(1, nil, true) end,
        {description="increase the number of master clients",group="Layout"}
	),

    awful.key(
		{Mod,Shift},",",     function()
			awful.tag.incnmaster(-1, nil, true) end,
        {description="decrease the number of master clients",group="Layout"}
	),

    awful.key(
		{Mod},".",     function()
			awful.tag.incncol( 1, nil, true) end,
        {description="increase the number of columns",group="Layout"}
	),

    awful.key(
		{Mod},",",     function()
			awful.tag.incncol(-1, nil, true) end,
        {description="decrease the number of columns",group="Layout"}
	),

    awful.key(
		{Mod},"space", function()
			awful.layout.inc( 1) end,
        {description="select next",group="Layout"}
	),

    awful.key(
		{Mod,Shift},"space", function()
			awful.layout.inc(-1) end,
        {description="select previous",group="Layout"}
	),


    awful.key(
        {Alt},"x",function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description="lua execute prompt",group="Awesome"}
    )
)

keymaps.clientkeys = gtable.join(
    awful.key(
		{Alt,Shift},"m",
            lain.util.magnify_client,
        {description="magnify client",group="Client"}
	),

    awful.key(
		{Mod},"f",function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description="toggle fullscreen",group="Client"}
	),


    awful.key(
		{Mod},"c", function(c) 
            c:kill() end,
        {description="close",group="Client"}
	),

    awful.key(
		{Mod},"a",
            awful.client.floating.toggle                     ,
        {description="toggle floating",group="Client"}
	),

    awful.key(
		{Mod,Control},"Return", function(c)
            c:swap(awful.client.getmaster()) end,
        {description="move to master",group="Client"}
	),

    awful.key(
		{Mod},"o", function(c) 
            c:move_to_screen() end,
        {description="move to screen",group="Client"}
	),

    awful.key(
		{Mod,Control},"t", function(c) 
            c.ontop = not c.ontop  end,
        {description="toggle keep on top",group="Client"}
	),

    awful.key(
		{Mod},"n", function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description="minimize",group="Client"}
	),

    awful.key(
		{Mod},"m", function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description="maximize",group="Client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description="view tag #",group="Tag"}
        descr_toggle = {description="toggle tag #",group="Tag"}
        descr_move = {description="move focused client to tag #",group="Tag"}
        descr_toggle_focus = {description="toggle focused client on tag #",group="Tag"}
    end
    local key = i+9
    if i==9 then key = 49 end

    keymaps.globalkeys = gtable.join(keymaps.globalkeys,
        -- View tag only.
        awful.key(
            { Alt },"#" .. key,function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end, descr_view
        ),
        -- Toggle tag display.
        awful.key(
            {Mod,Shift},"#" .. key,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end, descr_toggle
        ),
        -- Move client to tag.
        awful.key(
            {Mod},"#" .. key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                        --tag:view_only()
                    end
                end
            end, descr_move
        ),
        -- Toggle tag on focused client.
        awful.key(
            {Mod,Control},"#" .. key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end, descr_toggle_focus
        )
    )
end

return keymaps
