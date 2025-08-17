-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Janela Principal (sem sistema de Key)
local Window = Rayfield:CreateWindow({
    Name = "Overfluent Premium",
    LoadingTitle = "Overfluent",
    LoadingSubtitle = "By Rafael",
    ConfigurationSaving = {Enabled = false},
    Discord = {Enabled = false},
})

-- ==============================
-- TAB: Auto Plantar
-- ==============================
local PlantTab = Window:CreateTab("Auto Plantar", 4483362458)
PlantTab:CreateSection("Configuração de Plantio")

-- Dropdown com todas as frutas (seeds)
local seeds = {"Maçã", "Banana", "Cenoura", "Morango", "Uva", "Abacaxi", "Batata", "Tomate", "Melancia"} -- adicione mais se precisar
local selectedSeed = nil

PlantTab:CreateDropdown({
    Name = "Escolher Semente",
    Options = seeds,
    CurrentOption = "Maçã",
    Callback = function(option)
        selectedSeed = option
        Rayfield:Notify({
            Title = "Semente Selecionada",
            Content = "Você selecionou: " .. option,
            Duration = 5
        })
    end
})

PlantTab:CreateToggle({
    Name = "Ativar Auto Plantar",
    CurrentValue = false,
    Callback = function(value)
        if value then
            print("Auto plantar ativado com: " .. tostring(selectedSeed))
        else
            print("Auto plantar desativado")
        end
    end,
})

-- ==============================
-- TAB: Auto Comprar
-- ==============================
local BuyTab = Window:CreateTab("Auto Comprar", 4483362458)
BuyTab:CreateSection("Compra Automática")

BuyTab:CreateToggle({
    Name = "Ativar Auto Comprar",
    CurrentValue = false,
    Callback = function(value)
        if value then
            print("Auto comprar ativado")
        else
            print("Auto comprar desativado")
        end
    end,
})

-- ==============================
-- TAB: Auto Coletar Planta Favorita
-- ==============================
local FavTab = Window:CreateTab("Auto Coletar", 4483362458)
FavTab:CreateSection("Coletar Planta Favorita")

FavTab:CreateToggle({
    Name = "Ativar Auto Coletar",
    CurrentValue = false,
    Callback = function(value)
        if value then
            print("Auto coletar planta favorita ativado")
        else
            print("Auto coletar planta favorita desativado")
        end
    end,
})

-- ==============================
-- TAB: FPS Booster
-- ==============================
local FpsTab = Window:CreateTab("FPS Booster", 4483362458)
FpsTab:CreateSection("Otimização do Jogo")

FpsTab:CreateButton({
    Name = "Ativar Otimização (FPS + Saturação)",
    Callback = function()
        -- Suavizar FPS
        setfpscap(120)
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        -- Saturação
        local Lighting = game:GetService("Lighting")
        local ColorCorrection = Instance.new("ColorCorrectionEffect")
        ColorCorrection.Saturation = 0.5 -- aumenta saturação
        ColorCorrection.Contrast = 0.1
        ColorCorrection.Parent = Lighting

        Rayfield:Notify({
            Title = "FPS Booster",
            Content = "Otimização ativada: mais FPS e cores mais vivas!",
            Duration = 8
        })
    end,
})
