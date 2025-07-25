RegisterServerEvent('craft:makeP92')
AddEventHandler('craft:makeP92', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local fem = xPlayer.getInventoryItem('femdarab')
    local alkatresz = xPlayer.getInventoryItem('alkatresz')
    local markolat = xPlayer.getInventoryItem('markolat')

    if fem.count >= 10 and alkatresz.count >= 1 and markolat.count >= 1 then
        xPlayer.removeInventoryItem('femdarab', 10)
        xPlayer.removeInventoryItem('alkatresz', 1)
        xPlayer.removeInventoryItem('markolat', 1)
        xPlayer.addInventoryItem('weapon_pistol', 1)

        TriggerClientEvent('esx:showNotification', source, 'Sikeresen készítettél egy ~g~P92~s~ pisztolyt!')
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Nincs elég alapanyagod a fegyver készítéséhez.')
    end
end)
