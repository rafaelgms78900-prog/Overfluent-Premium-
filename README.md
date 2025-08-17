-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
    KeySystem = false,
})

-- ==============================
-- TAB: Auto Plantar
-- ==============================
local PlantTab = Window:CreateTab("Auto Plantar", 4483362458)
PlantTab:CreateSection("Configuração de Plantio")

-- (seu código de auto plantar aqui)

-- ==============================
-- TAB: Auto Comprar
-- ==============================
local BuyTab = Window:CreateTab("Auto Comprar", 4483362458)
BuyTab:CreateSection("Compra Automática")

-- (seu código de auto comprar aqui)

-- ==============================
-- TAB: Eggs ESP
-- ==============================
local EggsTab = Window:CreateTab("Eggs ESP", 4483362458)
EggsTab:CreateSection("Visualizar pets dos ovos")

-- Função para escanear ovos
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
    Name = "Ver Pets Disponíveis",
    Callback = function()
        scanEggs()
    end,
})
