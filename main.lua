local Callback = {}
local Stored = {}

function Callback.Register(name, func)
    if type(name) ~= "string" or type(func) ~= "function" then return end
    Stored[name] = func
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Callback Registered",
            Text = "Stored: "..name,
            Duration = 3
        })
    end)
end

function Callback.Run(name, ...)
    local cb = Stored[name]
    if cb then
        local s,e = pcall(cb, ...)
        if not s then warn(e) end
    else
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Callback Missing",
                Text = tostring(name).." not found",
                Duration = 3
            })
        end)
    end
end

function Callback.Remove(name)
    if Stored[name] then
        Stored[name] = nil
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Callback Removed",
                Text = "Removed: "..tostring(name),
                Duration = 3
            })
        end)
    end
end

function Callback.List()
    for n,_ in pairs(Stored) do print("Callback:",n) end
end

function Callback.Parse(text,...)
    local single = string.match(text,"^callback://([%w_]+)")
    if single then
        Callback.Run(single,...)
        return
    end

    local blockName = string.match(text,"callback://start%s+([%w_]+)")
    local blockCode = string.match(text,"callback://start[%w%s_]*\n(.-)\ncallback://end")
    if blockName and blockCode then
        local f,err = loadstring(blockCode)
        if f then
            local ok,errmsg = pcall(f,...)
            if not ok then warn(errmsg) end
        else
            warn(err)
        end
        Callback.Run(blockName, blockCode, ...)
    end
end

return Callback
