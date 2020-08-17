local vehicle_id
local engine_enabled = true
local hood_open = false
local trunk_open = false
local front_left_open = false
local front_right_open = false
local back_left_open = false
local back_right_open = false

RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
end)

function EnableGui(gui_enable)
    SendNUIMessage({
        type = "enableui",
        enable = gui_enable,
    })
end

function UpdateFuel(fuel_level)
    SendNUIMessage({
        type = "updatefuel",
        fuel = fuel_level,
    })
    --print("here")
end

Citizen.CreateThread(function()
    local gui_enabled = false
    local fuel_level;
    SetNuiFocus(false, false)

    while true do
        
        Citizen.Wait(100)
        vehicle_id = GetVehiclePedIsIn(PlayerPedId(-1), false)

        if vehicle_id == 0 then
            -- player is not in the car
            gui_enabled = false
        else
            -- player is in the car
            fuel_level = GetVehicleFuelLevel(vehicle_id)
            UpdateFuel(fuel_level)
            if (fuel_level > 0) then
                SetVehicleFuelLevel(vehicle_id, fuel_level - 0.01)
            else 
                SetVehicleFuelLevel(vehicle_id, 0)
            end
            
            gui_enabled = true
            if IsControlPressed(0,36) then
                Citizen.Wait(200)
                SetNuiFocus(true, true)
            end
        end
        
        EnableGui(gui_enabled)
    end
end)

-- ---------------------| Car Control Natives |---------------------|

RegisterNUICallback("engine", function(data)
    if engine_enabled then
        print(GetVehicleFuelLevel(vehicle_id))
        SetVehicleEngineOn(vehicle_id, false, false, true);
        engine_enabled = false
        SetVehicleFuelLevel(vehicle_id, 0)
        
    else
        SetVehicleEngineOn(vehicle_id, true, false, true);
        engine_enabled = true
        -- SetVehicleEngineHealth(vehicle_id, 1000)
        SetVehicleFuelLevel(vehicle_id, 60.0)
    end
end)

RegisterNUICallback("front_left", function(data)
    front_left_open = not front_left_open
    if front_left_open then
        SetVehicleDoorOpen(vehicle_id, 0, true, false)
    else
        SetVehicleDoorShut(vehicle_id, 0, true)
    end
end)

RegisterNUICallback("front_right", function(data)
    front_right_open = not front_right_open
    if front_right_open then
        SetVehicleDoorOpen(vehicle_id, 1, true, false)
    else
        SetVehicleDoorShut(vehicle_id, 1, true)
    end
end)

RegisterNUICallback("back_left", function(data)
    back_left_open = not back_left_open
    if back_left_open then
        SetVehicleDoorOpen(vehicle_id, 2, true, false)
    else
        SetVehicleDoorShut(vehicle_id, 2, true)
    end
end)

RegisterNUICallback("back_right", function(data)
    back_right_open = not back_right_open
    if back_right_open then
        SetVehicleDoorOpen(vehicle_id, 3, true, false)
    else
        SetVehicleDoorShut(vehicle_id, 3, true)
    end
end)


RegisterNUICallback("hood", function(data)
    hood_open = not hood_open
    if hood_open then
        SetVehicleDoorOpen(vehicle_id, 4, true, true)
    else
        SetVehicleDoorShut(vehicle_id, 4, true)
    end
end)

RegisterNUICallback("trunk", function(data)
    trunk_open = not trunk_open
    if hood_open then
        SetVehicleDoorOpen(vehicle_id, 5, true, true)
    else
        SetVehicleDoorShut(vehicle_id, 5, true)
    end
end)