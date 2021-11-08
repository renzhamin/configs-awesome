local pairs = pairs
local client = client

local smax = { name = "" }


function smax.arrange(p)
    local area = p.workarea
    local cls = p.clients
    local n = #cls
    if n==0 then return end
    
    for _, c in pairs(cls) do
        local g = {
            x = area.x,
            y = area.y,
            width = area.width,
            height = area.height
        }
        if c ~= client.focus then
            n = n-1
            c.minimized = true
        end
        p.geometries[c] = g
    end

    ---- just moved to this tag, no client is focused
    if n == 0 then 
        cls[1].minimized = false 
    end 
    
end

--- smaximized layout.
-- @clientlayout awful.layout.suit.smax

function smax.skip_gap(nclients, t) -- luacheck: no unused args
    return true
end

return smax
