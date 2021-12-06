local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

local lain          = require("lain")
local freedesktop   = require("freedesktop")

local hotkeys_popup = require("awful.hotkeys_popup").widget
local gtable        = gears.table -- 4.{0,1} compatibility

local dpi           = require("beautiful.xresources").apply_dpi

local help          = require("helpers")
local keys          = require("keymaps")
local mousebinds    = require("mousebinds")
local globalkeys    = keys.globalkeys
local smax          = require("singlemax")

if awesome.startup_errors then
    naughty.notify({ 
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors 
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            timeout = 10,
            title = "Oops, an error happened!",
            text = tostring(err) 
        })
        in_error = false
    end)
end


local themes = {
    "multicolor",
    "powerarrow", 
    "powerarrow-blue",
    "blackburn",
}

local chosen_theme = themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)



awful.util.tagnames  = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }

awful.util.terminal = "alacritty"

awful.layout.suit.tile.left.mirror = true

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    smax,
    awful.layout.suit.floating,
}

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

local myawesomemenu = {
     { "restart", awesome.restart },
     { "hotkeys", function() return false, hotkeys_popup.show_help end },
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu },
    },
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
    }
})

awful.screen.connect_for_each_screen(beautiful.at_screen_connect)

root.buttons(gtable.join(
    awful.button({ }, 1, function () awful.util.mymainmenu:hide() end),
    awful.button({ }, 3, function () help.toggleAndAutoHideMenu(10,awful.util.mymainmenu) end),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 4, awful.tag.viewprev)
))

root.keys(globalkeys)

require("rules")
require("signals")

awful.spawn.with_shell("sh ~/.config/Scripts/autostart.sh")

local tag3 = screen[1].tags[3]
tag3.statusbarvisible = false
tag3.layout = smax
