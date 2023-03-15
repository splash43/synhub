local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "⚡ Synergy Hub", HidePremium = false, IntroEnabled = false})
local local_player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local shopsFolder = game:GetService("Workspace"):FindFirstChild("Shops")
local eggs = {}

if shopsFolder then
    for _, child in ipairs(shopsFolder:GetChildren()) do
        table.insert(eggs,child.Name)
    end

    print("Child Names:")
    for _, name in ipairs(eggs) do
        print(name)
    end
else
    print("Shops folder not found")
end

-- Variables

_G.run_speed = 0
_G.fov = 0
_G.tap_speed = 0.1
_G.rebirth_amount = 0
_G.rebirth_speed = 0
_G.rebirth_enabled = false
_G.rebirth_upgrade_speed = 0
_G.rebirth_upgrade_enabled = false
_G.auto_tapper_enabled = false

_G.auto_egg = false
_G.egg_type = "Starter"

-- Functions


-- Tab Creation
local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Farmer = Window:MakeTab({
	Name = "Rebirths",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Eggs = Window:MakeTab({
	Name = "Eggs",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


Main:AddSlider({
	Name = "Run Speed",
	Min = 1,
	Max = 200,
	Default = 20,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "speed",
	Callback = function(Value)
		_G.run_speed = Value
		local_player.Character.Humanoid.WalkSpeed = _G.run_speed
	end    
})

Main:AddSlider({
	Name = "FOV",
	Min = 70,
	Max = 120,
	Default = 20,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "FOV",
	Callback = function(Value)
		_G.fov = Value
		camera.FieldOfView= _G.fov
	end    
})

Main:AddToggle({
	Name = "Auto Tapper",
	Default = false,
	Callback = function(Value)
		_G.auto_tapper_enabled = Value
		while _G.auto_tapper_enabled do
			wait(_G.tap_speed)
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Tap"):FireServer("Main")
		end
	end    
})

Main:AddSlider({
	Name = "Auto Tapper Speed",
	Min = 0.1,
	Max = 5,
	Default = 0.1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.1,
	ValueName = "seconds",
	Callback = function(Value)
		_G.tap_speed = Value
	end    
})

Farmer:AddToggle({
	Name = "Auto Rebirth",
	Default = false,
	Callback = function(Value)
		_G.rebirth_enabled = Value
		while _G.rebirth_enabled do
			wait(_G.rebirth_speed)
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Rebirth"):FireServer(_G.rebirth_amount)
		end
	end    
})

Farmer:AddSlider({
	Name = "Auto Rebirth Speed",
	Min = 0.1,
	Max = 5,
	Default = 0.1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.1,
	ValueName = "seconds",
	Callback = function(Value)
		_G.rebirth_speed = Value
	end    
})


Farmer:AddTextbox({
	Name = "Rebirth Amount",
	Default = "1",
	TextDisappear = false,
	Callback = function(Value)
		_G.rebirth_amount = tonumber(Value)
	end	  
})

Farmer:AddToggle({
	Name = "Auto Rebirth Upgrade",
	Default = false,
	Callback = function(Value)
		_G.rebirth_upgrade_enabled = Value
		while _G.rebirth_upgrade_enabled do
			wait(_G.rebirth_upgrade_speed)
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Upgrade"):FireServer("rebirthUpgrades")
		end
	end    
})

Farmer:AddSlider({
	Name = "Auto Rebirth Upgrade Speed",
	Min = 0.1,
	Max = 5,
	Default = 0.1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.1,
	ValueName = "seconds",
	Callback = function(Value)
		_G.rebirth_upgrade_speed = Value
	end    
})

Eggs:AddToggle({
	Name = "Auto Hatch",
	Default = false,
	Callback = function(Value)
		_G.auto_egg = Value
		while _G.auto_egg do
			wait(1)
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("HatchEgg"):InvokeServer({[1]= {}, [2] = _G.egg_type, [3] = 1})
		end
	end    
})

Eggs:AddDropdown({
	Name = "Select Egg",
	Default = "Select an egg",
	Options = eggs,
	Callback = function(Value)
		_G.egg_type = Value
	end    
})