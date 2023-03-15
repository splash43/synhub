local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()

_G.lineState = false
_G.nameState = false
_G.boxState = false
_G.teamCheck = true

local localPlayer = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint
local HeadOff = Vector3.new(0,0.5,0)


function name_esp(v)

    -- NAME TEXT
    local text = Drawing.new("Text")
    text.Visible = false
    text.Center = true
    text.Outline  = true
    text.Font = 2
    text.Color = Color3.new(1,1,1)
    text.Size = 13

    -- RENDER NAME TEXT
    game:GetService("RunService").RenderStepped:Connect(function()
        if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= localPlayer and v.Character.Humanoid.Health > 0 then
            local Head = v.Character.Head
            local Vector, onScreen = worldToViewportPoint(CurrentCamera, v.Character.HumanoidRootPart.Position)
            local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
            
            if onScreen then
                text.Position = Vector2.new(HeadPosition.X, HeadPosition.Y - 10)
                text.Text = v.DisplayName

                if _G.teamCheck and v.TeamColor == localPlayer.TeamColor then
                    text.Visible = false
                else
                    text.Visible = _G.nameState
                end

            else
                text.Visible = false
            end
        else
            text.Visible = false
        end
    end)

end

for i, v in pairs(game.Players:GetChildren()) do
    coroutine.wrap(name_esp)(v)
end

game.Players.PlayerAdded:Connect(function(v)
    coroutine.wrap(name_esp)(v)
end)

-- LINE ESP

local localPlayer = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

function line_esp(v)

    -- LINE
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = Color3.new(1,1,1)
    tracer.Thickness = 1
    tracer.Transparency = 1

    game:GetService("RunService").RenderStepped:Connect(function()
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= localPlayer and v.Character.Humanoid.Health > 0 then
            local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

            if onScreen then
                tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                tracer.To = Vector2.new(Vector.X, Vector.Y)


                if _G.teamCheck and v.TeamColor == localPlayer.TeamColor then
                    tracer.Visible = false
                else
                    tracer.Visible = _G.lineState
                end

            else
                tracer.Visible = false
            end
        else
            tracer.Visible = false
        end
    end)
end

for i, v in pairs(game.Players:GetChildren()) do
    coroutine.wrap(line_esp)(v)
end

game.Players.PlayerAdded:Connect(function(v)
    coroutine.wrap(line_esp)(v)
end)


local localPlayer = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

local screenDimensions = workspace.CurrentCamera.ViewportSize
local screenRatio = screenDimensions.X / screenDimensions.Y


local HeadOff = Vector3.new(0,0.5,0)
local LegOff = Vector3.new(0,3,0)

function box_esp(v)

    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.new(1,1,1)
    box.Thickness = 1
    box.Transparency = 1
    box.Filled = false

    game:GetService("RunService").RenderStepped:Connect(function()
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= localPlayer and v.Character.Humanoid.Health > 0 then

            local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local RootPart = v.Character.HumanoidRootPart
            local Head = v.Character.Head
            local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
            local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
            local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

            if onScreen then

                box.Size = Vector2.new(screenDimensions.X * 0.8 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                box.Position = Vector2.new(RootPosition.X - box.Size.X / 2, RootPosition.Y - box.Size.Y / 2)

                if _G.teamCheck and v.TeamColor == localPlayer.TeamColor then
                    box.Visible = false
                else
                    box.Visible = _G.boxState
                end

            else
                box.Visible = false
            end
        else
            box.Visible = false
        end
    end)

end

for i, v in pairs(game.Players:GetChildren()) do
    coroutine.wrap(box_esp)(v)
end

game.Players.PlayerAdded:Connect(function(v)
    coroutine.wrap(box_esp)(v)
end)

local Window = Rayfield:CreateWindow({
    Name = "Synergy | Arsenal",
    LoadingTitle = "Synergy | Arsenal",
    LoadingSubtitle = "by speeds#0001",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = true,
       Invite = "pctfaQ7Y", -- The Discord invite code, do not include discord.gg/
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Sirius Hub",
       Subtitle = "Key System",
       Note = "Join the discord (discord.gg/sirius)",
       FileName = "SiriusKey",
       SaveKey = true,
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = "Hello"
    }
})

local Visuals = Window:CreateTab("Visuals",12707256659) -- Title, Image

local Name_Esp = Visuals:CreateToggle({
    Name = "Name ESP",
    Info = "See everyones name through walls.", -- Speaks for itself, Remove if none.
    CurrentValue = false,
    Flag = "NameEsp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
         _G.nameState = Value
     end,
})

local Line_Esp = Visuals:CreateToggle({
    Name = "Line ESP",
    Info = "Draws a line tracer from the center of your screen to the players.", -- Speaks for itself, Remove if none.
    CurrentValue = false,
    Flag = "LineEsp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
         _G.lineState = Value
     end,
})

local Box_Esp = Visuals:CreateToggle({
    Name = "Box ESP",
    Info = "Draws a box around players.", -- Speaks for itself, Remove if none.
    CurrentValue = false,
    Flag = "BoxEsp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
         _G.boxState = Value
     end,
})

local dwCamera = workspace.CurrentCamera
local dwRunService = game:GetService("RunService")
local dwUIS = game:GetService("UserInputService")
local dwEntities = game:GetService("Players")
local dwLocalPlayer = dwEntities.LocalPlayer
local dwMouse = dwLocalPlayer:GetMouse()

local Rage = Window:CreateTab("Aimbot",12716344256) -- Title, Image

_G.settings = {
    Aimbot = false,
    Aiming = false,
    Aimbot_AimPart = "Head",
    Aimbot_TeamCheck = true,
    Aimbot_Draw_FOV = false,
    Aimbot_FOV_Radius = 50,
    Aimbot_FOV_Color = Color3.fromRGB(255,255,255),
    Aimbot_Wallcheck = false
}

local fov_circle = Drawing.new("Circle")
fov_circle.Visible = false
fov_circle.Radius = _G.settings.Aimbot_FOV_Radius
fov_circle.Color = _G.settings.Aimbot_FOV_Color
fov_circle.Thickness = 1
fov_circle.Filled = false
fov_circle.Transparency = 1
fov_circle.Position = Vector2.new(dwCamera.ViewportSize.X /2, dwCamera.ViewportSize.Y/2)

local closest_char = nil

dwUIS.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        _G.settings.Aiming = true
    end
end)

dwUIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        _G.settings.Aiming = false
    end
end)

dwRunService.RenderStepped:Connect(function()
    fov_circle.Visible = _G.settings.Aimbot_Draw_FOV
    fov_circle.Radius = _G.settings.Aimbot_FOV_Radius
    fov_circle.Position = Vector2.new(dwCamera.ViewportSize.X /2, dwCamera.ViewportSize.Y/2)
    

    if _G.settings.Aimbot == false then return end

    closest_char = nil
    local dist = math.huge 

    if _G.settings.Aiming then
        for i, v in next, dwEntities:GetChildren() do
            if v ~= dwLocalPlayer and
            v.Character and
            v.Character:FindFirstChild("HumanoidRootPart") and
            v.Character:FindFirstChild("Humanoid") and
            v.Character:FindFirstChild("Humanoid").Health > 0 then
                if _G.settings.Aimbot_TeamCheck == true and
                v.Team ~= dwLocalPlayer.Team or
                _G.settings.Aimbot_TeamCheck == false then
                    local char = v.Character
                    local char_part_pos = dwCamera:WorldToViewportPoint(char[_G.settings.Aimbot_AimPart].Position)
                    if char_part_pos ~= nil then
                        local is_onscreen = char_part_pos.Z > 0
                        local is_visible = true
                        if _G.settings.Aimbot_Wallcheck == true then
                            local ray = Ray.new(dwCamera.CFrame.Position, char[_G.settings.Aimbot_AimPart].Position - dwCamera.CFrame.Position)
                            local hit_part, hit_pos = workspace:FindPartOnRayWithIgnoreList(ray, {dwLocalPlayer.Character})
                            if hit_part and hit_part:IsDescendantOf(char) == false then
                                is_visible = false
                            end
                        end
                        if is_onscreen and is_visible then
                            local mag = (Vector2.new(dwMouse.X, dwMouse.Y) - Vector2.new(char_part_pos.X, char_part_pos.Y)).Magnitude
                            if mag < dist and mag < _G.settings.Aimbot_FOV_Radius then
                                dist = mag
                                closest_char = char
                            end
                        end
                    end
                end
            end
        end

        if closest_char ~= nil and
        closest_char:FindFirstChild("HumanoidRootPart") and
        closest_char:FindFirstChild("Humanoid") and
        closest_char:FindFirstChild("Humanoid").Health > 0 then
            dwCamera.CFrame = CFrame.new(dwCamera.CFrame.Position, closest_char[_G.settings.Aimbot_AimPart].Position)
        end
    end
end)

--// AIMBOT

local Aimbot_Toggle = Rage:CreateToggle({
    Name = "Aimbot",
    Info = "Toggles aimbot.", -- Speaks for itself, Remove if none.
    CurrentValue = false,
    Flag = "Aimbot", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
         _G.settings.Aimbot = Value
         _G.settings.Aimbot_Draw_FOV = Value
     end,
})

local Aimbot_Check = Rage:CreateToggle({
    Name = "Wall Check",
    Info = "Only lock on if they are visible.", -- Speaks for itself, Remove if none.
    CurrentValue = false,
    Flag = "AimbotWall", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
         _G.settings.Aimbot_Wallcheck = Value
     end,
})

local Aimbot_Fov = Rage:CreateSlider({
    Name = "Aimbot FOV",
    Info = "Size of your aimbot FOV.", -- Speaks for itself, Remove if none.
    Range = {0, screenDimensions.X},
    Increment = 1,
    Suffix = "units",
    CurrentValue = 1,
    Flag = "AimbotSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.settings.Aimbot_FOV_Radius = Value
    end,
})

 
