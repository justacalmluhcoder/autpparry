
-- BladeBall AutoParry Hub Script

-- Load OrionLib UI library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "BladeBall Hub"})

local Tab = Window:MakeTab({Name = "Combat"})

-- Wait for ParryEvent in ReplicatedStorage (this might need changing if event name is different)
local ParryEvent = game.ReplicatedStorage:WaitForChild("ParryEvent")
local RunService = game:GetService("RunService")

local autoparryToggle = false
local connection

-- Function to spam parry every frame when enabled
local function autoParry()
    connection = RunService.Heartbeat:Connect(function()
        ParryEvent:FireServer()
    end)
end

-- Add toggle to turn Auto Parry on/off
Tab:AddToggle({
    Name = "Auto Parry",
    Default = false,
    Callback = function(value)
        autoparryToggle = value
        if autoparryToggle then
            autoParry()
        else
            if connection then
                connection:Disconnect()
            end
        end
    end
})

