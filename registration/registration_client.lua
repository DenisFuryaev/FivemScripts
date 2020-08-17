RegisterNetEvent("register")

AddEventHandler("register", function()
    EnableGui(true)
end)

RegisterCommand("reg", function(source, args)
    EnableGui(true)
end)

RegisterCommand("id", function(source, args)
    TriggerServerEvent("showPlayerId")
end)

RegisterNUICallback("exit", function(data)
    EnableGui(false)
end)

RegisterNUICallback("submit", function(data)
    EnableGui(false)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {"^1Welcome to the BMK server^0 " .. data.firstname .. " " .. data.lastname}
        }
    )
    TriggerServerEvent("registerNewPlayer", data)
end)

function EnableGui(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "enableui",
        enable = bool,
    })
end

AddEventHandler('onClientGameTypeStart', function()
    TriggerServerEvent("showPlayerId")
end)

Citizen.CreateThread(function() 
    while true do
        -- disable idle cam
        N_0xf4f2c0d4ee209e20() 
        Wait(1000)
    end 
  end)

  -- Citizen.CreateThread(function()
--     while display do
--         Citizen.Wait(0)

--         -- DisableControlAction(0, 1, display) -- LookLeftRight
--         -- DisableControlAction(0, 2, display) -- LookUpDown
--         -- DisableControlAction(0, 142, display) -- MeleeAttackAlternate
--         -- DisableControlAction(0, 18, display) -- Enter
--         -- DisableControlAction(0, 322, display) -- ESC
--         -- DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
--     end
-- end)