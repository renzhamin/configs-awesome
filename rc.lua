--[[

     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats

     lain : https://github.com/lcpz/lain

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

--local menubar       = require("menubar")

local lain          = require("lain")
local freedesktop   = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi
-- }}}
local help          = require("helpers")
local keys          = require("keymaps")
local mousebinds    = require("mousebinds")
local globalkeys    = keys.globalkeys

local smax          = require("singleMax")



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}



-- {{{ Autostart windowless processes

--help.run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

local themes = {
    "multicolor",		-- 1
    "powerarrow",      		-- 2
    "powerarrow-blue",	 	-- 3
    "blackburn",		-- 4
}

-- choose your theme here
local chosen_theme = themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- modkey or mod4 = super key
local modkey       = "Mod4"
local altkey       = "Mod1"
local modkey1      = "Control"

local terminal          = "alacritty"

awful.util.tagnames  = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }

awful.util.terminal = terminal

--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
--awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music" }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }
awful.layout.suit.tile.left.mirror = true

local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    smax,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.corner.ne,
    awful.layout.suit.corner.sw,
    awful.layout.suit.corner.se,
    lain.layout.cascade,
    lain.layout.cascade.tile,
    lain.layout.centerwork,
    lain.layout.centerwork.horizontal,
    lain.layout.termfair,
    lain.layout.termfair.center,
}

awful.layout.layouts = { layouts[1],layouts[6],layouts[7],layouts[5] }

local layoutEntries = {}

for _,l in pairs(layouts) do
    table.insert(layoutEntries,{ l.name, function()
        awful.screen.focused().selected_tag.layout = l
    end})
end

awful.util.taglist_buttons = mousebinds.taglist_buttons
awful.util.tasklist_buttons = mousebinds.tasklist_buttons

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}



-- {{{ Menu
local myawesomemenu = {
     { "restart", awesome.restart },
     { "hotkeys", function() return false, hotkeys_popup.show_help end },
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu },
        { "Layouts", layoutEntries },
    },
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
--        { "Sleep", "systemctl suspend" },
--        { "Restart", "systemctl reboot" },
--        { "Shutdown", "systemctl poweroff" },
        -- other triads can be put here
    }
})
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(beautiful.at_screen_connect)
-- }}}


-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 1, function () awful.util.mymainmenu:hide() end),
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Set keys
root.keys(globalkeys)

require("rules")

require("signals")

-- Autostart applications
awful.spawn.with_shell("~/.config/spectrwm/Scripts/autostart.sh")
local tag3 = screen[1].tags[3]

tag3.barvisible = false
tag3.layout     = smax
tag3.gap        = 0
