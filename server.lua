-- Játékos visszajelzés + animáció trigger
TriggerClientEvent('p92:playCrafting', source, recipe.label)

-- Várakozás (megegyezik a progress bar idővel!)
Citizen.Wait(5000)

-- Jutalom adása ez után
recipe.give(xPlayer)
TriggerClientEvent('esx:showNotification', source, "✅ Sikeresen készítettél: " .. recipe.label)
TriggerClientEvent('playCraftSound', source)
local craftRecipes = {
    ["weapon_p92"] = {
        label = "P92 Fegyver",
        items = {
            {item = "iron", amount = 10},
            {item = "gunpowder", amount = 5},
            {item = "screw", amount = 4}
        },
        give = function(xPlayer)
            xPlayer.addWeapon("weapon_p92", 100)
        end
    },
    ["ammo_9mm"] = {
        label = "9mm töltény",
        items = {
            {item = "gunpowder", amount = 2},
            {item = "metal", amount = 2}
        },
        give = function(xPlayer)
            xPlayer.addInventoryItem("ammo_9mm", 30)
        end
    }
}

RegisterServerEvent("p92:craftWeapon")
AddEventHandler("p92:craftWeapon", function(craftId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or not craftRecipes[craftId] then return end

    local recipe = craftRecipes[craftId]

    -- Ellenőrzés
    for _, req in pairs(recipe.items) do
        if xPlayer.getInventoryItem(req.item).count < req.amount then
            TriggerClientEvent('esx:showNotification', source, "❌ Nincs elég " .. req.item)
            return
        end
    end

    -- Alapanyagok eltávolítása
    for _, req in pairs(recipe.items) do
        xPlayer.removeInventoryItem(req.item, req.amount)
    end

    -- Jutalom adása
    recipe.give(xPlayer)
    TriggerClientEvent('esx:showNotification', source, "✅ Sikeresen készítettél: " .. recipe.label)
    TriggerClientEvent('playCraftSound', source)
end)
