local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Overfluent Premium",
   LoadingTitle = "Overfluent Premium GUI",
   LoadingSubtitle = "by Rafael",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Overfluent",
      FileName = "Config"
   },
   Discord = {
      Enabled = false
   },

   KeySystem = true,
   KeySettings = {
      Title = "Overfluent Premium",
      Subtitle = "Key System",
      Note = "Clique no botão abaixo para pegar sua Key!",
      FileName = "OverfluentKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"RAFAEL123", "OVERFLUENTVIP"} -- suas keys válidas
   }
})

-- Fun Tab
local FunTab = Window:CreateTab("Fun", 4483362458)

FunTab:CreateLabel("Bem-vindo ao Overfluent Premium!")
FunTab:CreateButton({
   Name = "🔑 Pegar Key (Linkvertise)",
   Callback = function()
       setclipboard("https://linkvertise.com/seu_link_aqui")
       Rayfield:Notify({
           Title = "Link Copiado",
           Content = "Cole no navegador para pegar sua Key!",
           Duration = 6.5,
           Image = 4483362458,
       })
   end,
})
