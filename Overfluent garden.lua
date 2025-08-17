-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local EggsService = ReplicatedStorage:WaitForChild("EggsService")

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
        Note = "Digite a Key, Rafaelblox",
        FileName = "OverfluentKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Rafaelblox"}
    }
})

-- ==============================
-- TAB: Auto Plantar
-- ==============================
local PlantTab = Window:CreateTab("🌱 Auto Plantar", 4483362458)
PlantTab:CreateSection("Configuração de Plantio")

local frutas = {
    "Apple Seed", "Banana Seed", "Orange Seed", "Pear Seed", "Peach Seed", 
    "Grape Seed", "Strawberry Seed", "Blueberry Seed", "Lemon Seed",
    "Watermelon Seed", "Pineapple Seed", "Mango Seed", "Cherry Seed"
}

local frutaSelecionada = nil

PlantTab:CreateDropdown({
    Name = "Escolher fruta para plantar",
    Options = frutas,
    CurrentOption = "Apple Seed",
    Callback = function(option)
        frutaSelecionada = option
    end
})

PlantTab:CreateToggle({
    Name = "Ativar Auto Plantar",
    CurrentValue = false,
    Callback = function(value)
        _G.AutoPlantar = value
        while _G.AutoPlantar do
            task.wait(2)
            if frutaSelecionada then
                print("Plantando:", frutaSelecionada)
                -- Coloque aqui a função de plantar a fruta
            end
        end
    end,
})

-- ==============================
-- TAB: Auto Comprar
-- ==============================
local BuyTab = Window:CreateTab("💰 Auto Comprar", 4483362458)
BuyTab:CreateSection("Compra Automática")

BuyTab:CreateToggle({
    Name = "Ativar Auto Comprar",
    CurrentValue = false,
    Callback = function(value)
        _G.AutoComprar = value
        while _G.AutoComprar do
            task.wait(5)
            print("Comprando sementes automaticamente...")
            -- Coloque aqui a função de comprar sementes
        end
    end,
})

-- ==============================
-- TAB: Auto Coletar
-- ==============================
local CollectTab = Window:CreateTab("🌸 Auto Coletar", 4483362458)
CollectTab:CreateSection("Notificar / Coletar Planta Favorita")

local plantaFavorita = nil

CollectTab:CreateDropdown({
    Name = "Escolher Planta Favorita",
    Options = frutas,
    CurrentOption = "Apple Seed",
    Callback = function(option)
        plantaFavorita = option
    end
})

CollectTab:CreateToggle({
    Name = "Ativar Auto Coletar",
    CurrentValue = false,
    Callback = function(value)
        _G.AutoColetar = value
        while _G.AutoColetar do
            task.wait(3)
            if plantaFavorita then
                Rayfield:Notify({
                    Title = "Coleta Automática",
                    Content = "Coletando: " .. plantaFavorita,
                    Duration = 5
                })
                print("Coletando:", plantaFavorita)
                -- Coloque aqui a função de coletar a planta
            end
        end
    end,
})

-- ==============================
-- TAB: Eggs ESP
-- ==============================
local EggsTab = Window:CreateTab("🥚 Eggs ESP", 4483362458)
EggsTab:CreateSection("Mostrar Pets dos Ovos")

-- Função para mostrar pets de cada ovo
local function scanEggs()
    for _, egg in pairs(EggsService:GetChildren()) do
        if egg:IsA("Folder") then
            local pets = {}
            for _, pet in pairs(egg:GetChildren()) do
                table.insert(pets, pet.Name)
            end

            Rayfield:Notify({
                Title = "Ovo: " .. egg.Name,
                Content = "Pode vir: " .. table.concat(pets, ", "),
                Duration = 10
            })
        end
    end
end

-- Botão para atualizar
EggsTab:CreateButton({
    Name = "Ver Pets dos Ovos",
    Callback = function()
        scanEggs()
    end,
})
