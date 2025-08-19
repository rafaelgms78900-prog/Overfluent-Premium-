local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Overfluent | by Lancelot_",
   LoadingTitle = "Overfluent Hub",
   LoadingSubtitle = "Script ainda em beta",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "OverfluentHub",
      FileName = "Config"
   },
   KeySystem = false
})

-- Combat Tab
local CombatTab = Window:CreateTab("Combat", 4483362458)

-- Kill All
CombatTab:CreateToggle({
    Name = "Kill All",
    CurrentValue = false,
    Flag = "KillAll",
    Callback = function(Value)
        _G.KillAll = Value
        while _G.KillAll do
            task.wait(0.2)
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    local args = {
                        [1] = v,
                        [2] = 5555
                    }
                    game:GetService("ReplicatedStorage").PlayerHitEvent:FireServer(unpack(args))
                end
            end
        end
    end,
})

-- Kill TP
CombatTab:CreateToggle({
    Name = "Kill TP",
    CurrentValue = false,
    Flag = "KillTP",
    Callback = function(Value)
        _G.KillTP = Value
        while _G.KillTP do
            task.wait(0.5)
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                        local args = {
                            [1] = v,
                            [2] = 5555
                        }
                        game:GetService("ReplicatedStorage").PlayerHitEvent:FireServer(unpack(args))
                    end
                end
            end
        end
    end,
})

-- Visual Tab
local VisualTab = Window:CreateTab("Visual", 4483362458)

VisualTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(Value)
        _G.ESPEnabled = Value

        local function createESP(player)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("ESPBox") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESPBox"
                box.Size = Vector3.new(4, 6, 1)
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.Transparency = 0.5
                box.AlwaysOnTop = true
                box.Adornee = player.Character.HumanoidRootPart
                box.Parent = player.Character
            end
        end

        while _G.ESPEnabled do
            task.wait(1)
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    createESP(v)
                end
            end
        end

        if not _G.ESPEnabled then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("ESPBox") then
                    v.Character:FindFirstChild("ESPBox"):Destroy()
                end
            end
        end
    end,
})

-- Features Tab
local FeaturesTab = Window:CreateTab("Features", 4483362458)

-- Infinite Jump
FeaturesTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        _G.InfJump = Value
        local UIS = game:GetService("UserInputService")
        UIS.JumpRequest:Connect(function()
            if _G.InfJump then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end,
})

-- Fly
FeaturesTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)
        _G.Flying = Value
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        local bv, bg

        if _G.Flying then
            bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0,0,0)
            bv.MaxForce = Vector3.new(4000,4000,4000)
            bv.Parent = hrp

            bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(4000,4000,4000)
            bg.P = 10000
            bg.Parent = hrp

            game:GetService("RunService").Heartbeat:Connect(function()
                if not _G.Flying then return end
                local camCF = workspace.CurrentCamera.CFrame
                local moveDir = Vector3.new()
                local UIS = game:GetService("UserInputService")
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
                bv.Velocity = moveDir * 50
                bg.CFrame = camCF
            end)
        else
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
    end,
})

-- Noclip
FeaturesTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        _G.Noclip = Value
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Noclip and game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end,
})

-- WalkSpeed
FeaturesTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 2,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
    end,
})

-- Click TP
FeaturesTab:CreateToggle({
    Name = "Click TP",
    CurrentValue = false,
    Flag = "ClickTP",
    Callback = function(Value)
        _G.ClickTP = Value
        local UIS = game:GetService("UserInputService")
        local Player = game.Players.LocalPlayer
        local Mouse = Player:GetMouse()
        
        UIS.InputBegan:Connect(function(input)
            if _G.ClickTP and input.UserInputType == Enum.UserInputType.MouseButton1 then
                if Mouse.Target then
                    Player.Character:MoveTo(Mouse.Hit.p)
                end
            end
        end)
    end,
})

-- Reset Character
FeaturesTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})
