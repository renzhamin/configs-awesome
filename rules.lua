local awful         = require("awful")
local beautiful     = require("beautiful")
local clientkeys    = require("keymaps").clientkeys
local clientbuttons = require("mousebinds").clientbuttons


awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor = false
        }

    },


    -- Floating clients.
    {
        rule_any = {
            type = { "dialog" },
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "Program",
                "zoom",
            },
            class = {
                "Gcolor2",
                "Arandr",
                "Imagewriter",
                "Peek",
            },

            name = {
                "Event Tester",  -- xev.
            },

            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
                "Preferences",
                "setup",
            }
        }, 
        properties = { 
            placement = awful.placement.centered,
            floating = true, 
            titlebars_enabled = true,
        }
    }
}
