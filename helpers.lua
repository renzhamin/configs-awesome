local awful         =   require("awful")
local ipairs        =   ipairs
local helpers       =   {}

function helpers.checkWibarForTag(t)
    t.screen.mywibox.visible = t.barvisible
end

function helpers.toggleWibarForTag()
    local t = awful.screen.focused().selected_tag
    t.barvisible = not t.barvisible
    helpers.checkWibarForTag(t)
end

function helpers.run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

local function round(i,n,inc)
    i = (i+inc) 
    if i == 0 then i = n
    elseif i == n+1 then i = 1 end
    return i
end

function helpers.getNextClient(inc)
    local cls = awful.screen.focused().selected_tag:clients()
    local n = #cls

    if not n then return end
    if n == 1 then return cls[1] end

    for i=1,n do
        if cls[i] == client.focus then 
            return cls[round(i,n,inc)]
        end
    end
    return cls[1]
end

local function focusClient(c)
    c.minimized = false
    client.focus = c
    c:raise()
end

--- inc = +1/-1 only !
function helpers.focusNext(inc)
    local c = helpers.getNextClient(inc)
    if c then focusClient(c) end
end

return helpers
