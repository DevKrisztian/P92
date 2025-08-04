ESX = exports['es_extended']:getSharedObject()

local mainMenu = nil
local menuOpen = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if #(coords - Config.KraftPozicio) < 2.0 then
            ESX.ShowHelpNotification("Nyomd meg az ~INPUT_CONTEXT~ gombot a P92 kraftolásához")

            if IsControlJustReleased(0, 38) then -- E gomb
                openMenu()
            end
        end
    end
end)

function openMenu()
    if menuOpen then return end
    menuOpen = true

    mainMenu = NativeUI.CreateMenu("Fegyverkészítés", "~b~Válaszd ki a készítendő fegyvert")
    _menuPool:Add(mainMenu)

    local p92Item = NativeUI.CreateItem("P92 készítése", "10 fém, 1 markolat, 1 alkatrész szükséges")
    mainMenu:AddItem(p92Item)

    mainMenu.OnItemSelect = function(sender, item, index)
        if item == p92Item then
            TriggerEvent('craft:p92')
            mainMenu:Visible(false)
            menuOpen = false
        end
    end

    _menuPool:RefreshIndex()
    mainMenu:Visible(true)
end

_menuPool = NativeUI.CreatePool()
Citizen.CreateThread(function()
    while true do
        Wait(0)
        _menuPool:ProcessMenus()
    end
end)

RegisterNetEvent('craft:p92')
AddEventHandler('craft:p92', function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
    ESX.ShowNotification("~g~Készíted a P92 pisztolyt...")

    Wait(5000)

    ClearPedTasks(playerPed)
    TriggerServerEvent('craft:makeP92')
end)
RegisterNetEvent("p92:openCraftMenu")
AddEventHandler("p92:openCraftMenu", function()
    local options = {
        {label = "🔫 P92 Fegyver készítése", value = "craft_p92"},
        {label = "🔘 9mm töltény készítése", value = "craft_9mm"},
    }

    local input = lib.inputDialog("Kraft Menü", {
        {type = "select", label = "Válassz mit szeretnél készíteni", options = options}
    })

    if not input then return end

    if input[1] == "craft_p92" then
        TriggerServerEvent("p92:craftWeapon", "weapon_p92")
    elseif input[1] == "craft_9mm" then
        TriggerServerEvent("p92:craftWeapon", "ammo_9mm")
    end
end)
