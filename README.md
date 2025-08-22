# Callback-Storage
You can Store Callbacks. Perfect for exploiting 
# Example Usage
```local Callback = require(path.to.CallbackLibrary)

-- Register a warn callback
Callback.Register("warn", function(msg)
    warn("WARN:", msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Warn",
        Text = msg,
        Duration = 3
    })
end)

-- Register hello callback
Callback.Register("hello", function(player)
    print("Hello "..player.Name)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hello",
        Text = "Hello "..player.Name,
        Duration = 3
    })
end)

-- Single-line callback
Callback.Parse("callback://warn", "This is a test!")

-- Block-style callback (executes code inside!)

local block = [[
callback://start hello
print("Inside block code running...")
print("Player argument is:", ...)
callback://end
]]
Callback.Parse(block, game.Players.LocalPlayer)
```
# Credit
Make sure to Credit me before using or taking inspiration from this
