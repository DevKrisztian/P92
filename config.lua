RegisterNetEvent("p92:playCrafting")
AddEventHandler("p92:playCrafting", function(label)
    local playerPed = PlayerPedId()

    -- Animáció betöltése
    local dict = "amb@prop_human_parking_meter@male@idle_a"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end

    -- Progress bar megjelenítés
    lib.progressBar({
        duration = 5000, -- 5 másodperc
        label = "Készítés folyamatban: " .. label,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = dict,
            clip = "idle_a",
        }
    })
end)
-- Config rész
local requiredItems = {
    {item = "iron", amount = 10},
    {item = "gunpowder", amount = 5},
    {item = "screw", amount = 4},
    {item = "wood", amount = 2},
}

local craftedItem = "weapon_p92"

-- ESX vagy QBCore szerint, itt ESX példa:
ESX = exports['es_extended']:getSharedObject()

-- P92 craft parancs
RegisterCommand("craftp92", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        print("Hiba: játékos nem található!")
        return
    end

    -- Ellenőrzés: minden szükséges alapanyag megvan-e
    for _, req in pairs(requiredItems) do
        local count = xPlayer.getInventoryItem(req.item).count
        if count < req.amount then
            TriggerClientEvent('esx:showNotification', source, "❌ Nincs elég " .. req.item .. " (Szükséges: " .. req.amount .. ")")
            return
        end
    end

    -- Alapanyagok eltávolítása
    for _, req in pairs(requiredItems) do
        xPlayer.removeInventoryItem(req.item, req.amount)
    end

    -- Fegyver hozzáadása
    xPlayer.addWeapon(craftedItem, 100)
    TriggerClientEvent('esx:showNotification', source, "✅ Sikeresen legyártottad a P92 fegyvert!")
    TriggerClientEvent('playCraftSound', source)
end)
