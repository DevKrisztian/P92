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
