-- Játékos visszajelzés + animáció trigger
TriggerClientEvent('p92:playCrafting', source, recipe.label)

-- Várakozás (megegyezik a progress bar idővel!)
Citizen.Wait(5000)

-- Jutalom adása ez után
recipe.give(xPlayer)
TriggerClientEvent('esx:showNotification', source, "✅ Sikeresen készítettél: " .. recipe.label)
TriggerClientEvent('playCraftSound', source)
