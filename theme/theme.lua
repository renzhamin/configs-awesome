local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local help  = require("helpers")

local os,string = os,string
local my_table = gears.table 

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/theme"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/wallpaper.jpeg"
theme.font                                      = "Noto Sans Regular 10"
theme.hotkeys_font                              = "FreeSans 13"
theme.hotkeys_description_font                  = "Cantarell 14"
--theme.bg_normal                                 = "#141F22"
theme.bg_normal                                 = "#001520"
--theme.bg_normal                                 = "#000000"
theme.bg_focus                                  = "#00121B"
theme.bg_urgent                                 = "#000000"
theme.fg_normal                                 = "#aaaaaa"
theme.fg_focus                                  = "#ff8c00"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#ffffff"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#5e81ac"
theme.border_marked                             = "#3ca4d8"

--- Taglist
theme.taglist_font                              = "Noto Sans Regular 13"
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
----------------------------------------------------------------------------------------

--- Tasklist ----
theme.tasklist_bg_normal                        = theme.bg_normal
theme.tasklist_bg_focus                         = theme.bg_focus
theme.tasklist_plain_task_name                  = false
theme.tasklist_disable_icon                     = false
----------------------------------------------------------------------------------------

--- Right Click Menu
theme.menu_bg_normal                            = "#000000"
theme.menu_bg_focus                             = "#000000"
theme.menu_border_width                         = 0
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(260)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#ff8c00"
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
----------------------------------------------------------------------------------------

--theme.widget_temp                               = theme.confdir .. "/icons/temp.png"
--theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
--theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
--theme.widget_weather                            = theme.confdir .. "/icons/dish.png"
--theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
--theme.widget_music                              = theme.confdir .. "/icons/note.png"
--theme.widget_music_on                           = theme.confdir .. "/icons/note.png"
--theme.widget_music_pause                        = theme.confdir .. "/icons/pause.png"
--theme.widget_music_stop                         = theme.confdir .. "/icons/stop.png"

--- Widget Icons ---
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.png"
theme.widget_mem                                = theme.confdir .. "/icons/mem.png"
theme.widget_netdown                            = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/net_up.png"
theme.widget_batt                               = theme.confdir .. "/icons/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                = theme.confdir .. "/icons/spkr.png"
----------------------------------------------------------------------------------------

---- Layout ---
theme.useless_gap                               = 1
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
----------------------------------------------------------------------------------------

--- TitleBar Icons ----
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"
----------------------------------------------------------------------------------------

--- Quake Terminal
theme.quake = lain.util.quake({ app = "alacritty",argname = "--title %s",extra = "--class QuakeDD -o background_opacity=1",  height = 0.2 })

local markup = lain.util.markup

local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    require("singlemax"),
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


local layoutEntries = {}

for _,l in pairs(layouts) do
    table.insert(layoutEntries,{ l.name, function()
        awful.screen.focused().selected_tag.layout = l
    end})
end

local layoutBoxMenu = awful.menu({items = layoutEntries})

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
--local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#535f7a", ">") .. markup("#de5e1e", " %H:%M "))
local mytextclock = wibox.widget.textclock(markup("#7788af", "%a %b%d ") .. markup("#de5e1e", " %l:%M "))
mytextclock.font = theme.font

-- Calendar
--theme.cal = lain.widget.cal({
--    attach_to = { mytextclock },
--    notification_preset = {
--        font = "Noto Sans Mono Medium 10",
--        fg   = theme.fg_normal,
--        bg   = theme.bg_normal
--    }
--})

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2803138, -- placeholder (Belgium)
    notification_preset = { font = "Noto Sans Mono Medium 10", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°C "))
    end
})


-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    notify = "off",
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = " "
        else
            volume_now.level = volume_now.level .. "% "
        end

        widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level))
    end
})

theme.volume.change = function(cmd)
    os.execute(string.format("amixer -q set %s %s",theme.volume.channel,cmd))
    theme.volume.update()
end

theme.volume.widget:buttons(awful.util.table.join(
    awful.button({}, 2, function() -- middle click
        theme.volume.change("toggle")
    end),
    awful.button({}, 4, function() -- scroll up
        theme.volume.change("5%+")
    end),
    awful.button({}, 5, function() -- scroll down
        theme.volume.change("5%-")
    end)
))

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = lain.widget.net({
    notify = "off",
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        if mem_now.used > 999 then 
            mem_now.used = string.format("%.1fG ",mem_now.used/1024)
        else
            mem_now.used = mem_now.used .. "M "
        end
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used ))
    end
})

-- MPD
local musicplr = "urxvt -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    --[[awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc prev")
        theme.mpd.update()
    end),
    --]]
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc stop")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FFFFFF", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})



function theme.at_screen_connect(s)
    gears.wallpaper.maximized(theme.wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    for _,t in pairs(s.tags) do
        t.statusbarvisible = true
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 2, function () 
                               help.toggleAndAutoHideMenu(6,layoutBoxMenu)end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.statusbar = awful.wibar({ position = "top", screen = s, height = dpi(22), bg = theme.bg_normal, fg = theme.fg_normal })

    s.systray = wibox.widget.systray()
    s.systray.visible = true

    -- Add widgets to the wibox
    s.statusbar:setup {
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
        },
        -- Middle widget
        s.mytasklist,
--        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --mailicon,
            --mail.widget,
            --mpdicon,
            --theme.mpd.widget,
            netdownicon,
            netdowninfo.widget,
            volicon,
            theme.volume.widget,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            --weathericon,
            --theme.weather.widget,
            --tempicon,
            --temp.widget,
            baticon,
            bat.widget,
            clockicon,
            mytextclock,
            s.systray,
            s.mylayoutbox,
        },
        layout = wibox.layout.align.horizontal,
    }

    -- Create the bottom wibox
 --   s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

 --   -- Add widgets to the bottom wibox
 --   s.mybottomwibox:setup {
 --       layout = wibox.layout.align.horizontal,
 --       { -- Left widgets
 --           layout = wibox.layout.fixed.horizontal,
 --       },
 --       s.mytasklist, -- Middle widget
 --       { -- Right widgets
 --           layout = wibox.layout.fixed.horizontal,
 --           s.mylayoutbox,
 --       },
 --   }
end

return theme
