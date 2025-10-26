-- LightClient - Painel Admin com Copy Avatar Brookhaven
-- Desenvolvido por: Hiro
-- VERSÃƒO COMPLETA CORRIGIDA

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TextChatService = game:GetService("TextChatService")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- ===== VARIÃVEIS =====
local frozenPlayers = {}
local jailedPlayers = {}
local SelectedPlayer = nil
local jaulas = {}
local playerOriginalSpeed = {}
local jailConnections = {}

-- ===== VARIÃVEIS SHARINGAN =====
local SharinganActive = false
local SharinganConnection = nil
local SharinganSound = nil

-- ===== VARIÃVEIS DOMAIN EXPANSION =====
local DomainExpansionActive = false
local DomainExpansionConnection = nil
local DomainExpansionSound = nil
local DomainSphere = nil
local OriginalSky = nil

-- ===== VARIÃVEIS TELEKINESE =====
local TeletineseAtiva = false
local AlvoTeletinese = nil
local ConexaoTeletinese = nil
local InputInicio = nil

-- ===== VERIFICAR SE JÃ EXISTE INTERFACE =====
if CoreGui:FindFirstChild("OVERClientAdmin") or PlayerGui:FindFirstChild("OVERClientAdmin") then
    local existingGui = CoreGui:FindFirstChild("OVERClientAdmin") or PlayerGui:FindFirstChild("OVERClientAdmin")
    if existingGui then
        existingGui:Destroy()
    end
end

-- ===== SISTEMA SHARINGAN =====
local function AtivarSharingan()
    if SharinganActive then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Sharingan",
            Text = "O Sharingan jÃ¡ estÃ¡ ativado!",
            Duration = 3
        })
        return
    end
    
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local TextChatService = game:GetService("TextChatService")

    -- Tocar Ã¡udio do Sharingan do Itachi
    SharinganSound = Instance.new("Sound")
    SharinganSound.SoundId = "rbxassetid://9114825996"
    SharinganSound.Volume = 1
    SharinganSound.Parent = workspace
    SharinganSound:Play()

    -- Enviar mensagem no chat
    local message = "ðŸ‘ï¸ HI SHARINGAN ðŸ‘ï¸"
    
    local success, errorMsg = pcall(function()
        local channel = TextChatService:FindFirstChild("TextChannels").RBXGeneral
        if channel then
            channel:SendAsync(message)
        end
    end)
    
    if not success then
        pcall(function()
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end)
    end

    local Remote = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Gu1n")
    local index = 1

    SharinganActive = true

    local function mainScript()
        SharinganConnection = RunService.Stepped:Connect(function()
            if not SharinganActive then return end
            
            local allPlayers = Players:GetPlayers()
            if #allPlayers < 2 then return end

            index = index + 1
            if index > #allPlayers then index = 1 end

            local target = allPlayers[index]
            if target == LocalPlayer then
                index = index + 1
                if index > #allPlayers then index = 1 end
                target = allPlayers[index]
            end

            if not (Remote and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")) then return end

            local crazyVector = Vector3.new(
                math.random(1e14, 1e15),
                math.random(1e14, 1e15),
                math.random(1e14, 1e15)
            )

            local args = {
                [1] = target.Character.HumanoidRootPart,
                [2] = target.Character.HumanoidRootPart,
                [3] = crazyVector,
                [4] = target.Character.HumanoidRootPart.Position,
                [5] = LocalPlayer.Backpack:FindFirstChild("Assault") and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("MuzzleEffect"),
                [6] = LocalPlayer.Backpack:FindFirstChild("Assault") and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("HitEffect"),
                [7] = 0,
                [8] = 0,
                [9] = { [1] = false },
                [10] = {
                    [1] = 25,
                    [2] = Vector3.new(100, 100, 100),
                    [3] = BrickColor.new(29),
                    [4] = 0.25,
                    [5] = Enum.Material.SmoothPlastic,
                    [6] = 0.25
                },
                [11] = true,
                [12] = false
            }

            Remote:FireServer(unpack(args))
        end)
    end

    local function setStrongRedLight()
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.CharacterAdded:Wait()
        end

        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local pointLight = Instance.new("PointLight")
            pointLight.Name = "StrongRedLight"
            pointLight.Color = Color3.fromRGB(255, 0, 0)
            pointLight.Brightness = 3
            pointLight.Range = 100
            pointLight.Shadows = true
            pointLight.Parent = hrp
        end
    end

    mainScript()
    setStrongRedLight()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Sharingan Ativado",
        Text = "Sharingan OP ativado com Ã¡udio!",
        Duration = 5
    })
    
    print("ðŸ‘ï¸ SHARINGAN ATIVADO!")
end

local function DesativarSharingan()
    if not SharinganActive then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Sharingan",
            Text = "O Sharingan nÃ£o estÃ¡ ativado!",
            Duration = 3
        })
        return
    end
    
    SharinganActive = false
    
    if SharinganConnection then
        SharinganConnection:Disconnect()
        SharinganConnection = nil
    end
    
    if SharinganSound then
        SharinganSound:Stop()
        SharinganSound:Destroy()
        SharinganSound = nil
    end
    
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local light = character.HumanoidRootPart:FindFirstChild("StrongRedLight")
            if light then
                light:Destroy()
            end
        end
    end)
    
    local message = "ðŸ‘ï¸ SHARINGAN DESATIVADO"
    
    local success, errorMsg = pcall(function()
        local channel = game:GetService("TextChatService"):FindFirstChild("TextChannels").RBXGeneral
        if channel then
            channel:SendAsync(message)
        end
    end)
    
    if not success then
        pcall(function()
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end)
    end
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Sharingan Desativado",
        Text = "O Sharingan foi completamente desativado!",
        Duration = 5
    })
    
    print("ðŸ‘ï¸ SHARINGAN DESATIVADO!")
end

-- ===== SISTEMA DOMAIN EXPANSION =====
local function AtivarDomainExpansion()
    if DomainExpansionActive then
        game.StarterGui:SetCore("SendNotification", {
            Title = "ExpansÃ£o de DomÃ­nio",
            Text = "A ExpansÃ£o de DomÃ­nio jÃ¡ estÃ¡ ativada!",
            Duration = 3
        })
        return
    end
    
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local TextChatService = game:GetService("TextChatService")
    local Lighting = game:GetService("Lighting")

    DomainExpansionSound = Instance.new("Sound")
    DomainExpansionSound.SoundId = "rbxassetid://1843527678"
    DomainExpansionSound.Volume = 2
    DomainExpansionSound.Looped = true
    DomainExpansionSound.Parent = workspace
    DomainExpansionSound:Play()

    local message = "ðŸŒŒ ExpansÃ£o de DomÃ­nio... INFINITE VOID ðŸŒŒ"
    
    local success, errorMsg = pcall(function()
        local channel = TextChatService:FindFirstChild("TextChannels").RBXGeneral
        if channel then
            channel:SendAsync(message)
        end
    end)
    
    if not success then
        pcall(function()
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end)
    end

    local Remote = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1Gu1n")
    local index = 1

    DomainExpansionActive = true

    local function mainScript()
        DomainExpansionConnection = RunService.Stepped:Connect(function()
            if not DomainExpansionActive then return end
            
            local allPlayers = Players:GetPlayers()
            if #allPlayers < 2 then return end

            index = index + 1
            if index > #allPlayers then index = 1 end

            local target = allPlayers[index]
            if target == LocalPlayer then
                index = index + 1
                if index > #allPlayers then index = 1 end
                target = allPlayers[index]
            end

            if not (Remote and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")) then return end

            local crazyVector = Vector3.new(
                math.random(1e14, 1e15),
                math.random(1e14, 1e15),
                math.random(1e14, 1e15)
            )

            local args = {
                [1] = target.Character.HumanoidRootPart,
                [2] = target.Character.HumanoidRootPart,
                [3] = crazyVector,
                [4] = target.Character.HumanoidRootPart.Position,
                [5] = LocalPlayer.Backpack:FindFirstChild("Assault") and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("MuzzleEffect"),
                [6] = LocalPlayer.Backpack:FindFirstChild("Assault") and LocalPlayer.Backpack.Assault:FindFirstChild("GunScript_Local") and LocalPlayer.Backpack.Assault.GunScript_Local:FindFirstChild("HitEffect"),
                [7] = 0,
                [8] = 0,
                [9] = { [1] = false },
                [10] = {
                    [1] = 35,
                    [2] = Vector3.new(150, 150, 150),
                    [3] = BrickColor.new("Deep blue"),
                    [4] = 0.3,
                    [5] = Enum.Material.Neon,
                    [6] = 0.4
                },
                [11] = true,
                [12] = false
            }

            Remote:FireServer(unpack(args))
        end)
    end

    local function createDomainExpansion()
        local char = LocalPlayer.Character
        if not char then
            LocalPlayer.CharacterAdded:Wait()
            char = LocalPlayer.Character
        end

        local hrp = char:WaitForChild("HumanoidRootPart")

        local dominio = Instance.new("Model")
        dominio.Name = "InfiniteVoid"
        dominio.Parent = workspace

        local esfera = Instance.new("Part")
        esfera.Shape = Enum.PartType.Ball
        esfera.Size = Vector3.new(300, 300, 300)
        esfera.Position = hrp.Position
        esfera.Anchored = true
        esfera.CanCollide = false
        esfera.Material = Enum.Material.ForceField
        esfera.Transparency = 0.3
        esfera.Color = Color3.fromRGB(0, 0, 0)
        esfera.Parent = dominio

        local luz = Instance.new("PointLight")
        luz.Color = Color3.fromRGB(0, 153, 255)
        luz.Brightness = 10
        luz.Range = 300
        luz.Parent = esfera

        local ps = Instance.new("ParticleEmitter")
        ps.Texture = "rbxassetid://243660364"
        ps.Color = ColorSequence.new(Color3.fromRGB(0, 153, 255))
        ps.LightEmission = 1
        ps.Size = NumberSequence.new(3)
        ps.Transparency = NumberSequence.new(0.2)
        ps.Rate = 1000
        ps.Lifetime = NumberRange.new(2)
        ps.Speed = NumberRange.new(0)
        ps.VelocitySpread = 180
        ps.Parent = esfera

        OriginalSky = Lighting:FindFirstChildOfClass("Sky")
        if OriginalSky then
            OriginalSky.Parent = nil
        end

        local newSky = Instance.new("Sky")
        newSky.SkyboxBk = "rbxassetid://159454299"
        newSky.SkyboxDn = "rbxassetid://159454296"
        newSky.SkyboxFt = "rbxassetid://159454293"
        newSky.SkyboxLf = "rbxassetid://159454286"
        newSky.SkyboxRt = "rbxassetid://159454300"
        newSky.SkyboxUp = "rbxassetid://159454288"
        newSky.Parent = Lighting

        local playerLight = Instance.new("PointLight")
        playerLight.Name = "DomainExpansionLight"
        playerLight.Color = Color3.fromRGB(0, 100, 255)
        playerLight.Brightness = 5
        playerLight.Range = 50
        playerLight.Shadows = true
        playerLight.Parent = hrp

        DomainSphere = dominio
        
        spawn(function()
            while DomainExpansionActive and DomainSphere and hrp do
                esfera.Position = hrp.Position
                RunService.Heartbeat:Wait()
            end
        end)
    end

    mainScript()
    createDomainExpansion()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "ExpansÃ£o de DomÃ­nio Ativada",
        Text = "Infinite Void ativado! Todos serÃ£o afetados!",
        Duration = 5
    })
    
    print("ðŸŒŒ DOMAIN EXPANSION ATIVADO!")
end

local function DesativarDomainExpansion()
    if not DomainExpansionActive then
        game.StarterGui:SetCore("SendNotification", {
            Title = "ExpansÃ£o de DomÃ­nio",
            Text = "A ExpansÃ£o de DomÃ­nio nÃ£o estÃ¡ ativada!",
            Duration = 3
        })
        return
    end
    
    DomainExpansionActive = false
    
    if DomainExpansionConnection then
        DomainExpansionConnection:Disconnect()
        DomainExpansionConnection = nil
    end
    
    if DomainExpansionSound then
        DomainExpansionSound:Stop()
        DomainExpansionSound:Destroy()
        DomainExpansionSound = nil
    end
    
    if DomainSphere then
        DomainSphere:Destroy()
        DomainSphere = nil
    end
    
    pcall(function()
        local Lighting = game:GetService("Lighting")
        local currentSky = Lighting:FindFirstChildOfClass("Sky")
        if currentSky then
            currentSky:Destroy()
        end
        if OriginalSky then
            OriginalSky.Parent = Lighting
        end
    end)
    
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local light = character.HumanoidRootPart:FindFirstChild("DomainExpansionLight")
            if light then
                light:Destroy()
            end
        end
    end)
    
    local message = "ðŸŒŒ EXPANSÃƒO DE DOMÃNIO DESATIVADA ðŸŒŒ"
    
    local success, errorMsg = pcall(function()
        local channel = game:GetService("TextChatService"):FindFirstChild("TextChannels").RBXGeneral
        if channel then
            channel:SendAsync(message)
        end
    end)
    
    if not success then
        pcall(function()
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end)
    end
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "ExpansÃ£o de DomÃ­nio Desativada",
        Text = "A ExpansÃ£o de DomÃ­nio foi completamente desativada!",
        Duration = 5
    })
    
    print("ðŸŒŒ DOMAIN EXPANSION DESATIVADO!")
end

-- ===== SISTEMA DE TELEKINESE =====
local function AtivarTeletinese(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local character = targetPlayer.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        return false
    end
    
    if TeletineseAtiva then
        DesativarTeletinese()
    end
    
    TeletineseAtiva = true
    AlvoTeletinese = targetPlayer
    
    print("ðŸ”® TELEKINESE ATIVADA em " .. targetPlayer.Name)
    
    local efeito = Instance.new("Part")
    efeito.Name = "EfeitoTeletinese"
    efeito.Size = Vector3.new(4, 4, 4)
    efeito.Shape = Enum.PartType.Ball
    efeito.Position = humanoidRootPart.Position
    efeito.Anchored = true
    efeito.CanCollide = false
    efeito.Material = Enum.Material.Neon
    efeito.BrickColor = BrickColor.new("Bright violet")
    efeito.Transparency = 0.3
    efeito.Parent = character
    
    local luz = Instance.new("PointLight")
    luz.Brightness = 5
    luz.Range = 10
    luz.Color = Color3.fromRGB(200, 0, 255)
    luz.Parent = efeito
    
    local particulas = Instance.new("ParticleEmitter")
    particulas.Texture = "rbxassetid://243664672"
    particulas.Lifetime = NumberRange.new(0.5, 1.5)
    particulas.Rate = 20
    particulas.SpreadAngle = Vector2.new(45, 45)
    particulas.Speed = NumberRange.new(2, 5)
    particulas.Color = ColorSequence.new(Color3.fromRGB(200, 0, 255))
    particulas.Transparency = NumberSequence.new(0.3, 0.8)
    particulas.Size = NumberSequence.new(0.5, 1)
    particulas.Parent = efeito
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TelekinesisControls"
    screenGui.Parent = PlayerGui
    
    local touchFrame = Instance.new("Frame")
    touchFrame.Size = UDim2.new(1, 0, 1, 0)
    touchFrame.BackgroundTransparency = 1
    touchFrame.Parent = screenGui
    
    local indicador = Instance.new("TextLabel")
    indicador.Size = UDim2.new(0, 200, 0, 50)
    indicador.Position = UDim2.new(0.5, -100, 0.1, 0)
    indicador.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    indicador.BackgroundTransparency = 0.5
    indicador.Text = "ðŸ”® TELEKINESE ATIVA\nðŸ‘† Arraste para mover"
    indicador.TextColor3 = Color3.fromRGB(255, 255, 255)
    indicador.TextScaled = true
    indicador.Font = Enum.Font.GothamBold
    indicador.Parent = screenGui
    
    local touchConnection
    touchConnection = touchFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            InputInicio = input.Position
            
            local pontoToque = Instance.new("Frame")
            pontoToque.Size = UDim2.new(0, 20, 0, 20)
            pontoToque.Position = UDim2.new(0, InputInicio.X - 10, 0, InputInicio.Y - 10)
            pontoToque.BackgroundColor3 = Color3.fromRGB(200, 0, 255)
            pontoToque.BorderSizePixel = 0
            pontoToque.Parent = screenGui
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = pontoToque
            
            local moveConnection
            moveConnection = touchFrame.InputChanged:Connect(function(moveInput)
                if moveInput.UserInputType == Enum.UserInputType.Touch and AlvoTeletinese and AlvoTeletinese.Character then
                    local humanoidRootPart = AlvoTeletinese.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local delta = moveInput.Position - InputInicio
                        
                        local novaPos = humanoidRootPart.Position + Vector3.new(
                            delta.X * 0.1,
                            delta.Y * -0.1,
                            delta.X * 0.1
                        )
                        
                        humanoidRootPart.CFrame = CFrame.new(novaPos)
                        
                        pontoToque.Position = UDim2.new(0, moveInput.Position.X - 10, 0, moveInput.Position.Y - 10)
                    end
                end
            end)
            
            local endConnection
            endConnection = touchFrame.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.Touch then
                    InputInicio = nil
                    pontoToque:Destroy()
                    moveConnection:Disconnect()
                    endConnection:Disconnect()
                end
            end)
        end
    end)
    
    ConexaoTeletinese = {
        ScreenGui = screenGui,
        TouchConnection = touchConnection,
        Efeito = efeito
    }
    
    return true
end

local function DesativarTeletinese()
    if not TeletineseAtiva then return end
    
    TeletineseAtiva = false
    
    if ConexaoTeletinese then
        if ConexaoTeletinese.ScreenGui then
            ConexaoTeletinese.ScreenGui:Destroy()
        end
        if ConexaoTeletinese.TouchConnection then
            ConexaoTeletinese.TouchConnection:Disconnect()
        end
        if ConexaoTeletinese.Efeito and ConexaoTeletinese.Efeito.Parent then
            ConexaoTeletinese.Efeito:Destroy()
        end
    end
    
    if AlvoTeletinese and AlvoTeletinese.Character then
        local efeito = AlvoTeletinese.Character:FindFirstChild("EfeitoTeletinese")
        if efeito then
            efeito:Destroy()
        end
    end
    
    AlvoTeletinese = nil
    ConexaoTeletinese = nil
    InputInicio = nil
    
    print("ðŸ”® TELEKINESE DESATIVADA")
end

-- ===== JUMPSCARES =====
local JUMPSCARES = {
    { 
        Name = "Jumpscare 1", 
        Command = ";jumps1",
        ImageId = "rbxassetid://126754882337711", 
        AudioId = "rbxassetid://138873214826309" 
    },
    { 
        Name = "Jumpscare 2", 
        Command = ";jumps2",
        ImageId = "rbxassetid://86379969987314", 
        AudioId = "rbxassetid://143942090" 
    },
    { 
        Name = "Jumpscare 3", 
        Command = ";jumps3",
        ImageId = "rbxassetid://127382022168206", 
        AudioId = "rbxassetid://143942090" 
    },
    { 
        Name = "Jumpscare 4", 
        Command = ";jumps4",
        ImageId = "rbxassetid://95973611964555", 
        AudioId = "rbxassetid://138873214826309" 
    },
}

local function TriggerJumpscare(player, jumpscare)
    if not player or player ~= LocalPlayer then return false end
    
    local screenGui = Instance.new("ScreenGui", CoreGui)
    screenGui.Name = "JumpscareGui"
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local imageLabel = Instance.new("ImageLabel", screenGui)
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.Position = UDim2.new(0, 0, 0, 0)
    imageLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    imageLabel.BackgroundTransparency = 0
    imageLabel.Image = jumpscare.ImageId
    imageLabel.ScaleType = Enum.ScaleType.Fit
    imageLabel.ImageTransparency = 1
    
    local sound = Instance.new("Sound")
    sound.SoundId = jumpscare.AudioId
    sound.Volume = 1
    sound.Looped = false
    sound.Parent = screenGui
    
    local function animateJumpscare()
        imageLabel.ImageTransparency = 0
        sound:Play()
        
        local flashCount = 8
        local flashInterval = 0.15
        
        for i = 1, flashCount do
            if not screenGui.Parent then break end
            imageLabel.ImageTransparency = (i % 2 == 0) and 0.5 or 0
            wait(flashInterval)
        end
        
        for i = 1, 10 do
            if not screenGui.Parent then break end
            imageLabel.ImageTransparency = i / 10
            wait(0.05)
        end
        
        sound:Stop()
        screenGui:Destroy()
    end
    
    pcall(animateJumpscare)
    
    return true
end

-- ===== BACKROOMS SIMPLIFICADA =====
local function CriarBackroomsNoCeu(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local character = targetPlayer.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        return false
    end
    
    local posicaoNoCeu = Vector3.new(0, 500, 0)
    humanoidRootPart.CFrame = CFrame.new(posicaoNoCeu + Vector3.new(0, 5, 0))
    
    local backroomsFolder = Instance.new("Folder")
    backroomsFolder.Name = "BackroomsNoCeu"
    backroomsFolder.Parent = workspace
    
    -- Sala simples
    local sala = Instance.new("Part")
    sala.Size = Vector3.new(100, 30, 100)
    sala.Position = posicaoNoCeu
    sala.Anchored = true
    sala.CanCollide = true
    sala.BrickColor = BrickColor.new("Bright yellow")
    sala.Material = Enum.Material.Plastic
    sala.Parent = backroomsFolder
    
    local saida = Instance.new("Part")
    saida.Name = "SAIDA_BACKROOMS"
    saida.Size = Vector3.new(8, 10, 1)
    saida.Position = posicaoNoCeu + Vector3.new(45, 0, 0)
    saida.Anchored = true
    saida.CanCollide = false
    saida.BrickColor = BrickColor.new("Bright green")
    saida.Material = Enum.Material.Neon
    saida.Transparency = 0.2
    saida.Parent = backroomsFolder
    
    local luz = Instance.new("PointLight")
    luz.Brightness = 8
    luz.Range = 15
    luz.Color = Color3.new(0, 1, 0)
    luz.Parent = saida
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 300, 0, 80)
    billboard.StudsOffset = Vector3.new(0, 8, 0)
    billboard.Parent = saida
    
    local texto = Instance.new("TextLabel")
    texto.Size = UDim2.new(1, 0, 1, 0)
    texto.BackgroundTransparency = 1
    texto.Text = "ðŸšª SAÃDA DAS BACKROOMS\nðŸ’š TOQUE PARA SAIR"
    texto.TextColor3 = Color3.new(0, 1, 0)
    texto.TextScaled = true
    texto.Font = Enum.Font.GothamBold
    texto.Parent = billboard
    
    print("ðŸ¢ BACKROOMS criadas para " .. targetPlayer.Name)
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            connection:Disconnect()
            backroomsFolder:Destroy()
            return
        end
        
        local pos = targetPlayer.Character.HumanoidRootPart.Position
        
        local saida = backroomsFolder:FindFirstChild("SAIDA_BACKROOMS")
        if saida then
            local distancia = (pos - saida.Position).Magnitude
            
            if distancia < 6 then
                print("ðŸšª " .. targetPlayer.Name .. " saiu das Backrooms")
                connection:Disconnect()
                backroomsFolder:Destroy()
                
                wait(1)
                if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    targetPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
                end
                return
            end
        end
        
        if pos.Y < posicaoNoCeu.Y - 100 then
            print("ðŸŒŒ " .. targetPlayer.Name .. " caiu das Backrooms")
            connection:Disconnect()
            backroomsFolder:Destroy()
        end
    end)
    
    return true
end

-- ===== FUNÃ‡ÃƒO DE EXPLOSÃƒO =====
local function CriarExplosao(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local character = targetPlayer.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        return false
    end
    
    local explosion = Instance.new("Part")
    explosion.Name = "LightClientExplosion"
    explosion.Size = Vector3.new(8, 8, 8)
    explosion.Shape = Enum.PartType.Ball
    explosion.Material = Enum.Material.Neon
    explosion.BrickColor = BrickColor.new("Institutional white")
    explosion.Position = humanoidRootPart.Position
    explosion.Anchored = true
    explosion.CanCollide = false
    explosion.Parent = workspace
    
    local pointLight = Instance.new("PointLight")
    pointLight.Brightness = 10
    pointLight.Range = 15
    pointLight.Color = Color3.new(1, 1, 1)
    pointLight.Parent = explosion
    
    character:BreakJoints()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part ~= humanoidRootPart then
            part.Velocity = Vector3.new(
                math.random(-50, 50),
                math.random(30, 60), 
                math.random(-50, 50)
            )
        end
    end
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(explosion, tweenInfo, {Size = Vector3.new(20, 20, 20)})
    tween:Play()
    
    game:GetService("Debris"):AddItem(explosion, 2)
    
    print("ðŸ’¥ EXPLOSÃƒO BRANCA executada em " .. targetPlayer.Name)
    return true
end

-- ===== FUNÃ‡ÃƒO COPY AVATAR BROOKHAVEN =====
local function AplicarSkinBrookhaven(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local character = targetPlayer.Character
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if not humanoid then
        return false
    end
    
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
            item:Destroy()
        end
    end
    
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("Part") and part.Name ~= "HumanoidRootPart" then
            part.BrickColor = BrickColor.new("Medium stone grey")
        end
    end
    
    local shirt = Instance.new("Shirt")
    shirt.ShirtTemplate = "rbxassetid://0"
    shirt.Parent = character
    
    local pants = Instance.new("Pants")
    pants.PantsTemplate = "rbxassetid://0"
    pants.Parent = character
    
    if character:FindFirstChild("Shirt") then
        character.Shirt.ShirtTemplate = "rbxassetid://10188591433"
    end
    
    if character:FindFirstChild("Pants") then
        character.Pants.PantsTemplate = "rbxassetid://10188605115"
    end
    
    if humanoid:FindFirstChild("BodyTypeScale") then
        humanoid.BodyTypeScale.Value = 1.0
    end
    
    if humanoid:FindFirstChild("BodyWidthScale") then
        humanoid.BodyWidthScale.Value = 1.0
    end
    
    if humanoid:FindFirstChild("BodyHeightScale") then
        humanoid.BodyHeightScale.Value = 1.0
    end
    
    print("âœ… Skin Brookhaven aplicada em " .. targetPlayer.Name)
    return true
end

-- ===== SISTEMA DE COMANDOS LOCAIS =====
local function ProcessarComando(mensagem)
    if string.sub(mensagem, 1, 1) == ";" then
        local partes = string.split(string.sub(mensagem, 2), " ")
        local comando = partes[1]:lower()
        local nomeAlvo = table.concat(partes, " ", 2)
        
        if nomeAlvo and (nomeAlvo:lower() == LocalPlayer.Name:lower() or nomeAlvo:lower() == LocalPlayer.DisplayName:lower()) then
            print("ðŸŽ¯ Comando recebido: " .. comando .. " para " .. LocalPlayer.Name)
            
            local character = LocalPlayer.Character
            local playerName = LocalPlayer.Name

            if comando == "backrooms" and character then
                CriarBackroomsNoCeu(LocalPlayer)
            elseif comando == "kill" and character then
                character:BreakJoints()
            elseif comando == "explode" and character then
                CriarExplosao(LocalPlayer)
            elseif comando == "kick" then
                LocalPlayer:Kick("ðŸš« OverClient Admin")
            elseif comando == "crash" then
                while true do end
            elseif comando == "freeze" and character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    frozenPlayers[playerName] = true
                    humanoid.WalkSpeed = 0
                    humanoid.JumpPower = 0
                end
            elseif comando == "unfreeze" and character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    frozenPlayers[playerName] = nil
                    humanoid.WalkSpeed = 16
                    humanoid.JumpPower = 50
                end
            elseif comando == "jail" and character then
                local root = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if root and humanoid then
                    playerOriginalSpeed[playerName] = humanoid.WalkSpeed
                    humanoid.WalkSpeed = 0

                    local size = 12
                    local pos = root.Position
                    jaulas[playerName] = {}
                    
                    local function criarBarra(cframe, size, color)
                        local p = Instance.new("Part")
                        p.Name = "LightClientJailBar"
                        p.Size = size
                        p.Anchored = true
                        p.CanCollide = true
                        p.Material = Enum.Material.Neon
                        p.BrickColor = color
                        p.Reflectance = 0.2
                        p.CFrame = cframe
                        p.Parent = workspace
                        
                        local pointLight = Instance.new("PointLight")
                        pointLight.Brightness = 3
                        pointLight.Range = 8
                        pointLight.Color = color == BrickColor.new("Royal purple") and Color3.fromRGB(80, 40, 120) or Color3.fromRGB(150, 80, 200)
                        pointLight.Parent = p
                        
                        table.insert(jaulas[playerName], p)
                        return p
                    end

                    criarBarra(CFrame.new(pos + Vector3.new(size/2, 0, size/2)), Vector3.new(0.8, size, 0.8), BrickColor.new("Royal purple"))
                    criarBarra(CFrame.new(pos + Vector3.new(-size/2, 0, size/2)), Vector3.new(0.8, size, 0.8), BrickColor.new("Royal purple"))
                    criarBarra(CFrame.new(pos + Vector3.new(size/2, 0, -size/2)), Vector3.new(0.8, size, 0.8), BrickColor.new("Royal purple"))
                    criarBarra(CFrame.new(pos + Vector3.new(-size/2, 0, -size/2)), Vector3.new(0.8, size, 0.8), BrickColor.new("Royal purple"))

                    if jailConnections[playerName] then
                        jailConnections[playerName]:Disconnect()
                    end
                    
                    jailConnections[playerName] = RunService.Heartbeat:Connect(function()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = LocalPlayer.Character.HumanoidRootPart
                            local center = pos + Vector3.new(0, 0, 0)
                            if (hrp.Position - center).Magnitude > size/2 - 1 then
                                hrp.CFrame = CFrame.new(center)
                            end
                        end
                    end)

                    print("ðŸ›ï¸ JAIL ROXO executado em " .. LocalPlayer.Name)
                end
            elseif comando == "unjail" and character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = playerOriginalSpeed[playerName] or 16
                    playerOriginalSpeed[playerName] = nil
                end

                if jaulas[playerName] then
                    for _, p in ipairs(jaulas[playerName]) do
                        if p and p.Parent then
                            p:Destroy()
                        end
                    end
                    jaulas[playerName] = nil
                end

                if jailConnections[playerName] then
                    jailConnections[playerName]:Disconnect()
                    jailConnections[playerName] = nil
                end
                print("ðŸ›ï¸ UNJAIL executado em " .. LocalPlayer.Name)
            elseif comando == "bring" and character then
                local sender = nil
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        sender = player
                        break
                    end
                end
                
                if sender and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.Position = sender.Character.HumanoidRootPart.Position + Vector3.new(0, 0, 5)
                end
            elseif comando == "copyavatar" and character then
                AplicarSkinBrookhaven(LocalPlayer)
            elseif comando == "jumps1" then
                TriggerJumpscare(LocalPlayer, JUMPSCARES[1])
            elseif comando == "jumps2" then
                TriggerJumpscare(LocalPlayer, JUMPSCARES[2])
            elseif comando == "jumps3" then
                TriggerJumpscare(LocalPlayer, JUMPSCARES[3])
            elseif comando == "jumps4" then
                TriggerJumpscare(LocalPlayer, JUMPSCARES[4])
            elseif comando == "telekinesis" and character then
                if SelectedPlayer then
                    AtivarTeletinese(SelectedPlayer)
                else
                    print("âŒ Selecione um jogador primeiro!")
                end
            elseif comando == "stoptelekinesis" then
                DesativarTeletinese()
            end
        end
        
        if comando == "verifique" then
            wait(2)
            local codigoVerificacao = "OVER CLIENT_###"
            
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                TextChatService.TextChannels.RBXGeneral:SendAsync(codigoVerificacao)
            else
                ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(codigoVerificacao, "All")
            end
        end
    end
end

-- ===== CRIAR INTERFACE COMPLETA =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OVERClientAdmin"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- BotÃ£o flutuante para abrir
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0, 20)
OpenButton.BackgroundColor3 = Color3.fromRGB(120, 40, 160)
OpenButton.Text = "ADMIN"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 14
OpenButton.Visible = true
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 12)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(255, 255, 255)
OpenStroke.Thickness = 3
OpenStroke.Parent = OpenButton

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 550)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 20, 75)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(150, 80, 200)
MainStroke.Thickness = 4
MainStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(30, 10, 50)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ðŸ”¥ OVERCLIENT ADMIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Abas
local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, 0, 0, 40)
TabsContainer.Position = UDim2.new(0, 0, 0, 50)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = MainFrame

local Tabs = {"Admin", "Avatar", "Jumpscare", "Backrooms", "Sharingan", "Domain"}
local TabButtons = {}
local TabContents = {}

local TabIndicator = Instance.new("Frame")
TabIndicator.BackgroundColor3 = Color3.fromRGB(150, 80, 200)
TabIndicator.Size = UDim2.new(0.166, 0, 0, 3)
TabIndicator.Position = UDim2.new(0, 0, 1, 0)
TabIndicator.Parent = TabsContainer

-- ConteÃºdo das abas
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -100)
ContentFrame.Position = UDim2.new(0, 10, 0, 100)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Criar abas
for i, tabName in ipairs(Tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0.166, 0, 1, 0)
    tabBtn.Position = UDim2.new((i-1) * 0.166, 0, 0, 0)
    tabBtn.BackgroundTransparency = 1
    tabBtn.Text = tabName
    tabBtn.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 10
    tabBtn.Parent = TabsContainer
    TabButtons[tabName] = tabBtn

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.Visible = i == 1
    scrollingFrame.ScrollBarThickness = 4
    scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 80, 200)
    scrollingFrame.Parent = ContentFrame
    
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 8)
    uiListLayout.Parent = scrollingFrame
    
    TabContents[tabName] = scrollingFrame

    tabBtn.MouseButton1Click:Connect(function()
        for _, content in pairs(TabContents) do
            content.Visible = false
        end
        scrollingFrame.Visible = true
        
        local tween = TweenService:Create(TabIndicator, TweenInfo.new(0.2), {Position = UDim2.new((i-1)*0.166, 0, 1, 0)})
        tween:Play()
        
        for name, btn in pairs(TabButtons) do
            btn.TextColor3 = name == tabName and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        end
    end)
end

-- ===== ABA ADMIN =====
local AdminTab = TabContents["Admin"]

-- Select Player
local SelectLabel = Instance.new("TextLabel")
SelectLabel.Size = UDim2.new(1, 0, 0, 25)
SelectLabel.BackgroundTransparency = 1
SelectLabel.Text = "Select Player:"
SelectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectLabel.Font = Enum.Font.GothamBold
SelectLabel.TextSize = 14
SelectLabel.TextXAlignment = Enum.TextXAlignment.Left
SelectLabel.Parent = AdminTab

local PlayerDropdown = Instance.new("TextButton")
PlayerDropdown.Size = UDim2.new(1, 0, 0, 35)
PlayerDropdown.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
PlayerDropdown.Text = "Me (" .. LocalPlayer.Name .. ")"
PlayerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerDropdown.Font = Enum.Font.Gotham
PlayerDropdown.TextSize = 12
PlayerDropdown.Parent = AdminTab

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 6)
DropdownCorner.Parent = PlayerDropdown

-- Comandos Admin
local AdminCommands = {
    "verifique", "kick", "crash", "kill", "explode", 
    "bring", "freeze", "unfreeze", "jail", "unjail",
    "copyavatar", "backrooms", "telekinesis", "stoptelekinesis"
}

for i, cmd in ipairs(AdminCommands) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
    btn.Text = cmd:upper()
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = AdminTab
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if cmd == "verifique" then
            TextChatService.TextChannels.RBXGeneral:SendAsync(";verifique")
        elseif cmd == "copyavatar" then
            if SelectedPlayer then
                AplicarSkinBrookhaven(SelectedPlayer)
            else
                AplicarSkinBrookhaven(LocalPlayer)
            end
        elseif cmd == "backrooms" then
            if SelectedPlayer then
                CriarBackroomsNoCeu(SelectedPlayer)
            else
                CriarBackroomsNoCeu(LocalPlayer)
            end
        elseif cmd == "telekinesis" then
            if SelectedPlayer then
                AtivarTeletinese(SelectedPlayer)
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Telekinesis",
                    Text = "Selecione um jogador primeiro!",
                    Duration = 3
                })
            end
        elseif cmd == "stoptelekinesis" then
            DesativarTeletinese()
        else
            local targetName = SelectedPlayer and SelectedPlayer.Name or LocalPlayer.Name
            TextChatService.TextChannels.RBXGeneral:SendAsync(";" .. cmd .. " " .. targetName)
        end
    end)
end

-- ===== ABA AVATAR =====
local AvatarTab = TabContents["Avatar"]

local CopyAvatarBtn = Instance.new("TextButton")
CopyAvatarBtn.Size = UDim2.new(1, 0, 0, 45)
CopyAvatarBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
CopyAvatarBtn.Text = "COPY BROOKHAVEN AVATAR"
CopyAvatarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyAvatarBtn.Font = Enum.Font.GothamBold
CopyAvatarBtn.TextSize = 14
CopyAvatarBtn.Parent = AvatarTab

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 8)
CopyCorner.Parent = CopyAvatarBtn

CopyAvatarBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer then
        AplicarSkinBrookhaven(SelectedPlayer)
    else
        AplicarSkinBrookhaven(LocalPlayer)
    end
end)

-- ===== ABA JUMPSCARE =====
local JumpscareTab = TabContents["Jumpscare"]

for i, jumpscare in ipairs(JUMPSCARES) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(160, 40, 60)
    btn.Text = "ðŸ‘» " .. jumpscare.Name:upper()
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = JumpscareTab
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        local targetName = SelectedPlayer and SelectedPlayer.Name or LocalPlayer.Name
        TextChatService.TextChannels.RBXGeneral:SendAsync(jumpscare.Command .. " " .. targetName)
    end)
end

-- ===== ABA BACKROOMS =====
local BackroomsTab = TabContents["Backrooms"]

local BackroomsBtn = Instance.new("TextButton")
BackroomsBtn.Size = UDim2.new(1, 0, 0, 50)
BackroomsBtn.BackgroundColor3 = Color3.fromRGB(200, 180, 40)
BackroomsBtn.Text = "ðŸ¢ CRIAR BACKROOMS"
BackroomsBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
BackroomsBtn.Font = Enum.Font.GothamBold
BackroomsBtn.TextSize = 14
BackroomsBtn.Parent = BackroomsTab

local BackroomsCorner = Instance.new("UICorner")
BackroomsCorner.CornerRadius = UDim.new(0, 8)
BackroomsCorner.Parent = BackroomsBtn

BackroomsBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer then
        CriarBackroomsNoCeu(SelectedPlayer)
    else
        CriarBackroomsNoCeu(LocalPlayer)
    end
end)

-- ===== ABA SHARINGAN =====
local SharinganTab = TabContents["Sharingan"]

local SharinganBtn = Instance.new("TextButton")
SharinganBtn.Size = UDim2.new(1, 0, 0, 50)
SharinganBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SharinganBtn.Text = "ðŸ‘ï¸ ATIVAR SHARINGAN"
SharinganBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SharinganBtn.Font = Enum.Font.GothamBold
SharinganBtn.TextSize = 14
SharinganBtn.Parent = SharinganTab

local SharinganCorner = Instance.new("UICorner")
SharinganCorner.CornerRadius = UDim.new(0, 8)
SharinganCorner.Parent = SharinganBtn

SharinganBtn.MouseButton1Click:Connect(function()
    AtivarSharingan()
end)

local DesativarSharinganBtn = Instance.new("TextButton")
DesativarSharinganBtn.Size = UDim2.new(1, 0, 0, 40)
DesativarSharinganBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
DesativarSharinganBtn.Text = "âŒ DESATIVAR SHARINGAN"
DesativarSharinganBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DesativarSharinganBtn.Font = Enum.Font.GothamBold
DesativarSharinganBtn.TextSize = 12
DesativarSharinganBtn.Parent = SharinganTab

local DesativarSharinganCorner = Instance.new("UICorner")
DesativarSharinganCorner.CornerRadius = UDim.new(0, 8)
DesativarSharinganCorner.Parent = DesativarSharinganBtn

DesativarSharinganBtn.MouseButton1Click:Connect(function()
    DesativarSharingan()
end)

-- ===== ABA DOMAIN EXPANSION =====
local DomainTab = TabContents["Domain"]

local DomainBtn = Instance.new("TextButton")
DomainBtn.Size = UDim2.new(1, 0, 0, 50)
DomainBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
DomainBtn.Text = "ðŸŒŒ ATIVAR DOMAIN EXPANSION"
DomainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DomainBtn.Font = Enum.Font.GothamBold
DomainBtn.TextSize = 14
DomainBtn.Parent = DomainTab

local DomainCorner = Instance.new("UICorner")
DomainCorner.CornerRadius = UDim.new(0, 8)
DomainCorner.Parent = DomainBtn

DomainBtn.MouseButton1Click:Connect(function()
    AtivarDomainExpansion()
end)

local DesativarDomainBtn = Instance.new("TextButton")
DesativarDomainBtn.Size = UDim2.new(1, 0, 0, 40)
DesativarDomainBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 150)
DesativarDomainBtn.Text = "âŒ DESATIVAR DOMAIN EXPANSION"
DesativarDomainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DesativarDomainBtn.Font = Enum.Font.GothamBold
DesativarDomainBtn.TextSize = 12
DesativarDomainBtn.Parent = DomainTab

local DesativarDomainCorner = Instance.new("UICorner")
DesativarDomainCorner.CornerRadius = UDim.new(0, 8)
DesativarDomainCorner.Parent = DesativarDomainBtn

DesativarDomainBtn.MouseButton1Click:Connect(function()
    DesativarDomainExpansion()
end)

-- ===== DROPDOWN DE JOGADORES =====
local function AtualizarDropdown()
    local playerNames = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(playerNames, plr.Name)
        end
    end
    table.insert(playerNames, 1, "Me (" .. LocalPlayer.Name .. ")")
    return playerNames
end

local DropdownOpen = false
local ListFrame

PlayerDropdown.MouseButton1Click:Connect(function()
    if DropdownOpen then
        if ListFrame then ListFrame:Destroy() end
        DropdownOpen = false
    else
        local playerNames = AtualizarDropdown()
        
        ListFrame = Instance.new("Frame")
        ListFrame.Size = UDim2.new(1, 0, 0, math.min(#playerNames * 30, 150))
        ListFrame.Position = UDim2.new(0, 0, 0, 70)
        ListFrame.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
        ListFrame.Parent = AdminTab
        
        local ListCorner = Instance.new("UICorner")
        ListCorner.CornerRadius = UDim.new(0, 6)
        ListCorner.Parent = ListFrame
        
        local scrolling = Instance.new("ScrollingFrame")
        scrolling.Size = UDim2.new(1, 0, 1, 0)
        scrolling.BackgroundTransparency = 1
        scrolling.ScrollBarThickness = 4
        scrolling.CanvasSize = UDim2.new(0, 0, 0, #playerNames * 30)
        scrolling.Parent = ListFrame
        
        for i, name in ipairs(playerNames) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, (i-1)*30)
            btn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
            btn.Text = name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 11
            btn.Parent = scrolling
            
            btn.MouseButton1Click:Connect(function()
                if name == "Me (" .. LocalPlayer.Name .. ")" then
                    SelectedPlayer = LocalPlayer
                    PlayerDropdown.Text = "Me"
                else
                    SelectedPlayer = Players:FindFirstChild(name)
                    PlayerDropdown.Text = name
                end
                ListFrame:Destroy()
                DropdownOpen = false
            end)
        end
        
        DropdownOpen = true
    end
end)

-- ===== CONECTAR BOTÃ•ES PRINCIPAIS =====
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    OpenButton.Text = MainFrame.Visible and "X" or "ADMIN"
    OpenButton.BackgroundColor3 = MainFrame.Visible and Color3.fromRGB(200, 60, 60) or Color3.fromRGB(120, 40, 160)
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Text = "ADMIN"
    OpenButton.BackgroundColor3 = Color3.fromRGB(120, 40, 160)
end)

-- ===== INICIALIZAR =====
SelectedPlayer = LocalPlayer

-- Conectar comandos do chat
task.spawn(function()
    wait(3)
    local canal = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    if canal then
        canal.OnIncomingMessage = function(msg)
            ProcessarComando(msg.Text)
        end
    end
end)

-- NotificaÃ§Ã£o de inicializaÃ§Ã£o
wait(1)
game.StarterGui:SetCore("SendNotification", {
    Title = "OVERCLIENT ADMIN",
    Text = "Interface carregada com TODAS as funÃ§Ãµes!",
    Duration = 5
})

print("ðŸ”¥ OVERCLIENT ADMIN COMPLETO INICIADO!")
print("ðŸŽ® BotÃ£o ADMIN visÃ­vel no canto superior esquerdo")
print("âš¡ Todas as funÃ§Ãµes disponÃ­veis: Sharingan, Domain Expansion, Backrooms, etc.")
print("ðŸ’¬ Use comandos no chat com ;comando nomejogador")
