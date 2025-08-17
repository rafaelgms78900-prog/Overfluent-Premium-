-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Janela Principal
local Window = Rayfield:CreateWindow({
    Name = "Overfluent Premium",
    LoadingTitle = "Overfluent",
    LoadingSubtitle = "Por Rafael",
    ConfigurationSaving = {Enabled = false},
    Discord = {Enabled = false},
    KeySystem = true,
    KeySettings = {
        Title = "Overfluent Premium Key",
        Subtitle = "Sistema de Key",
        Note = "Digite a Key: Rafaelblox",
        FileName = "OverfluentKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Rafaelblox"}
    }
})

local frutas = {
    "Carrot","Strawberry","Spring Onion","Blueberry","Rose","Orange Tulip","Artichoke",
    "Rhubarb","Onion","Tomato","Daffodil","Cauliflower","Raspberry","Butternut Squash",
    "Foxglove","Corn","Horsetail","Twisted Tangle","Jalapeno","Watermelon","Pumpkin",
    "Avocado","Green Apple","Apple","Banana","Lilac","Taro Flower","Bamboo","Rafflesia",
    "Lingonberry","Veinpetal","Crown Melon","Peach","Pineapple","Amber Spine","Coconut",
    "Cactus","Dragon Fruit","Mango","Kiwi","Bell Pepper","Prickly Pear","Pink Lily",
    "Purple Dahlia","Tall Asparagus","Sugarglaze","Grape","Loquat","Mushroom","Pepper",
    "Cacao","Feijoa"
}

-- Auto Plantar
local PlantTab = Window:CreateTab("Auto Plantar", 4483362458)
PlantTab:CreateSection("Configurar Planta")
local frutaPlantar = frutas[1]
PlantTab:CreateDropdown({
    Name = "Fruta para Plantar",
    Options = frutas,
    CurrentOption = frutaPlantar,
    Callback = function(opt) frutaPlantar = opt[1] end,
})
PlantTab:CreateToggle({
    Name = "Ativar Auto Plantar",
    CurrentValue = false,
    Callback = function(v)
        while v do
            task.wait(1)
            -- Código do Plant_RE aqui
        end
    end,
})

-- Auto Comprar
local BuyTab = Window:CreateTab("Auto Comprar", 4483362458)
BuyTab:CreateSection("Comprar Semente")
local frutaComprar = frutas[1]
BuyTab:CreateDropdown({
    Name = "Fruta para Comprar",
    Options = frutas,
    CurrentOption = frutaComprar,
    Callback = function(opt) frutaComprar = opt[1] end,
})
BuyTab:CreateToggle({
    Name = "Ativar Auto Comprar",
    CurrentValue = false,
    Callback = function(v)
        while v do
            task.wait(1.5)
            -- Código do BuySeedStock aqui
        end
    end,
})

-- Notificação de Planta Favorita
local NotifyTab = Window:CreateTab("Notificação", 4483362458)
NotifyTab:CreateSection("Sua Planta Favorita")
local frutaFavorita = frutas[1]
NotifyTab:CreateDropdown({
    Name = "Planta Favorita",
    Options = frutas,
    CurrentOption = frutaFavorita,
    Callback = function(opt) frutaFavorita = opt[1] end,
})
NotifyTab:CreateButton({
    Name = "Notificar Favorita",
    Callback = function()
        Rayfield:Notify({
            Title = "Aviso!",
            Content = "Sua planta favorita: " .. frutaFavorita,
            Duration = 5
        })
    end,
})
