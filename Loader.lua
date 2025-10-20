-- Light Admin Loader
local function CarregarLightAdmin()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local Whitelist = {
        "hiro0881", "drakeee777", "cartolahub7", "ppyszt", "pedro_roneido", 
        "pedro_roneido20", "ixi362", "jifhgiu", "piloto158d", "rafaelgms67901",
        "ilu1_22", "xmarcelo_27262", "ryansididd", "redz_hub99975", "teteu0902201mc",
        "amongus23445844sad", "ttyyryjuh", "kevin_oliverra10", "eduard0k0", "gh707080s",
        "luroblox1262", "bonasamigo", "manopp83", "zack_89901"
    }
    
    local function VerificarWhitelist()
        local username = LocalPlayer.Name:lower()
        for _, user in ipairs(Whitelist) do
            if username == user:lower() then
                return true
            end
        end
        return false
    end
    
    if not VerificarWhitelist() then
        LocalPlayer:Kick("Voce nao esta na whitelist!")
        return
    end
    
    print("✅ Whitelist aprovada! Carregando sistema principal...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rafaelgms78900-prog/Overfluent-Premium-/main/main-system.lua"))()
end

CarregarLightAdmin()
