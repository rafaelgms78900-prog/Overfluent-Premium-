-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Janela Principal
local Window = Rayfield:CreateWindow({
    Name = "Overfluent Premium",
    LoadingTitle = "Overfluent",
    LoadingSubtitle = "By Rafael",
    ConfigurationSaving = {Enabled = false},
    Discord = {Enabled = false},
    KeySystem = true,
    KeySettings = {
        Title = "Overfluent Premium Key",
        Subtitle = "Sistema de Key",
        Note = "SUA KEY: Rafaelblox", -- Key já visível
        FileName = "OverfluentKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Rafaelblox"}
    }
})

-- ==============================
-- TAB: Auto Plantar
-- ==============================
local PlantTab = Window:CreateTab("Auto Plantar", 4483362458)
PlantTab:CreateSection("Configuração de Plantio")

local SelectedSeed = nil
local SeedDropdown = PlantTab:CreateDropdown({
    Name = "Selecione a Semente",
    Options = {
        "Apple Seed", "Banana Seed", "Orange Seed", "Pineapple Seed",
        "Strawberry Seed", "Watermelon Seed", "Mango Seed", "Blueberry Seed",
        "Pear Seed", "Grape Seed", "Lemon Seed", "Cherry Seed"
    },
    CurrentOption = {"Apple Seed"},
    MultipleOptions = false,
    Flag = "SeedDropdown",
    Callback = function(Option)
        SelectedSeed = Option[1]
    end,
})

PlantTab:CreateToggle({
    Name = "Ativar Auto Plantar",
    CurrentValue = false,
    Flag = "AutoPlant",
    Callback = function(Value)
        -- Aqui entraria a lógica de auto plantar usando SelectedSeed
    end,
})

-- ==============================
-- TAB: Auto Comprar
-- ==============================
local BuyTab = Window:CreateTab("Auto Comprar", 4483362458)
BuyTab:CreateSection("Compra Automática")

local SelectedBuySeed = nil
local BuyDropdown = BuyTab:CreateDropdown({
    Name = "Comprar Semente",
    Options = {
        "Apple Seed", "Banana Seed", "Orange Seed", "Pineapple Seed",
        "Strawberry Seed", "Watermelon Seed", "Mango Seed", "Blueberry Seed",
        "Pear Seed", "Grape Seed", "Lemon Seed", "Cherry Seed"
    },
    CurrentOption = {"Apple Seed"},
    MultipleOptions = false,
    Flag = "BuyDropdown",
    Callback = function(Option)
        SelectedBuySeed = Option[1]
    end,
})

BuyTab:CreateToggle({
    Name = "Ativar Auto Comprar",
    CurrentValue = false,
    Flag = "AutoBuy",
    Callback = function(Value)
        -- Aqui entraria a lógica de auto comprar usando SelectedBuySeed
    end,
})

-- ==============================
-- TAB: Notificação Planta Favorita
-- ==============================
local NotifyTab = Window:CreateTab("Notificação", 4483362458)
NotifyTab:CreateSection("Planta Favorita")

NotifyTab:CreateDropdown({
    Name = "Selecionar Planta Favorita",
    Options = {
        "Apple Seed", "Banana Seed", "Orange Seed", "Pineapple Seed",
        "Strawberry Seed", "Watermelon Seed", "Mango Seed", "Blueberry Seed",
        "Pear Seed", "Grape Seed", "Lemon Seed", "Cherry Seed"
    },
    CurrentOption = {"Apple Seed"},
    MultipleOptions = false,
    Flag = "FavSeed",
    Callback = function(Option)
        Rayfield:Notify({
            Title = "Planta Favorita Selecionada!",
            Content = "Você escolheu: " .. Option[1],
            Duration = 5
        })
    end,
})
