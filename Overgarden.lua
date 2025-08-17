--// Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// Janela Principal
local Window = Rayfield:CreateWindow({
    Name = "Overfluent Premium 🌱",
    LoadingTitle = "Overfluent Hub",
    LoadingSubtitle = "By Rafael",
    ConfigurationSaving = {Enabled = false},
    Discord = {Enabled = false},
    KeySystem = true,
    KeySettings = {
        Title = "Overfluent Premium Key",
        Subtitle = "Sistema de Key",
        Note = "Digite a Key, Rafaelblox",
        FileName = "OverfluentKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Rafaelblox"}
    }
})

-- ======================================================
-- TAB: Auto Plantar
-- ======================================================
local PlantTab = Window:CreateTab("🌱 Auto Plantar", 4483362458)
PlantTab:CreateSection("Selecione a semente")

local seeds = {
    "Tomato Seed", "Carrot Seed", "Potato Seed", "Corn Seed",
    "Wheat Seed", "Apple Seed", "Pumpkin Seed", "Berry Seed",
    "Strawberry Seed", "Cabbage Seed", "Onion Seed", "Melon Seed",
    "Banana Seed", "Pineapple Seed", "Grapes Seed", "Orange Seed"
}

local SelectedSeed = nil

PlantTab:CreateDropdown({
    Name = "Escolher semente",
    Options = seeds,
    CurrentOption = "Tomato Seed",
    Callback = function(opt)
        SelectedSeed = opt
        Rayfield:Notify({
            Title = "Semente selecionada",
            Content = "Você escolheu: " .. opt,
            Duration = 5
        })
    end
})

PlantTab:CreateToggle({
    Name = "Ativar Auto Plantar",
    CurrentValue = false,
    Callback = function(state)
        if state then
            -- loop básico de plantar
            task.spawn(function()
                while state do
                    if SelectedSeed then
                        print("Plantando:", SelectedSeed)
                        -- aqui você chama o remote do jogo para plantar
                    end
                    task.wait(2)
                end
            end)
        end
    end
})

-- ======================================================
-- TAB: Auto Comprar
-- ======================================================
local BuyTab = Window:CreateTab("🛒 Auto Comprar", 4483362458)
BuyTab:CreateSection("Compra Automática")

BuyTab:CreateToggle({
    Name = "Ativar Auto Comprar",
    CurrentValue = false,
    Callback = function(state)
        if state then
            print("Auto Comprar ativado")
            -- aqui você coloca a lógica de comprar automático
        else
            print("Auto Comprar desativado")
        end
    end
})

-- ======================================================
-- TAB: Auto Coletar
-- ======================================================
local CollectTab = Window:CreateTab("✨ Auto Coletar", 4483362458)
CollectTab:CreateSection("Sua planta favorita")

local FavoritePlant = nil

CollectTab:CreateDropdown({
    Name = "Escolher planta favorita",
    Options = seeds,
    CurrentOption = "Tomato Seed",
    Callback = function(opt)
        FavoritePlant = opt
        Rayfield:Notify({
            Title = "Planta Favorita",
            Content = "Você selecionou: " .. opt,
            Duration = 5
        })
    end
})

CollectTab:CreateToggle({
    Name = "Ativar Auto Coletar",
    CurrentValue = false,
    Callback = function(state)
        if state then
            task.spawn(function()
                while state do
                    if FavoritePlant then
                        print("Coletando planta:", FavoritePlant)
                        -- aqui você coloca o remote de coletar
                    end
                    task.wait(2)
                end
            end)
        end
    end
})

-- ======================================================
-- TAB: FPS Booster
-- ======================================================
local FpsTab = Window:CreateTab("⚡ FPS Booster", 4483362458)
FpsTab:CreateSection("Otimização e Saturação")

FpsTab:CreateButton({
    Name = "Ativar Otimização + Cores",
    Callback = function()
        -- Otimização
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 0.5
            end
        end

        -- FPS boost
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        -- Aumentar saturação
        local Lighting = game:GetService("Lighting")
        local ColorCorrection = Instance.new("ColorCorrectionEffect")
        ColorCorrection.Saturation = 0.3
        ColorCorrection.Contrast = 0.2
        ColorCorrection.Parent = Lighting

        Rayfield:Notify({
            Title = "FPS Booster",
            Content = "O jogo está mais leve e com cores mais vivas!",
            Duration = 6
        })
    end
})
