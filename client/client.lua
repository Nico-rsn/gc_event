-- Variable to store the blip and its coordinates
local eventBlip = nil
local eventCoords = nil
local joinedEvent = false -- Flag to check if the player has already joined the event
local eventjoin = false

-- Ensure ESX is initialized
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("event:removeBlip")
AddEventHandler("event:removeBlip", function()
   if eventBlip ~= nil then
        RemoveBlip(eventBlip)
        eventBlip = nil
    end
end)

RegisterCommand(Config.EventCommand, function(source, args, rawCommand)
    -- Check if the player is in the "projektleitung" group
    ESX.TriggerServerCallback('checkPlayerGroup', function(isAllowed)
        if isAllowed then
            local playerPed = PlayerPedId()
            -- Get the player's coordinates
            local playerCoords = GetEntityCoords(playerPed)
            eventCoords = playerCoords
            TriggerServerEvent("CreateEvent")
        else
            -- Notify the player that they do not have permission
            Config.Notify("error", "Du hast keine Berechtigung, diesen Befehl auszuführen")
        end
    end)
end, false)

local eventttttt = false
RegisterCommand(Config.JoinCommand, function(source, args, rawCommand)
    -- Check if the player is unconscious (bewusstlos)
    if IsEntityDead(PlayerPedId()) then
        Config.Notify("error", "Du kannst dich nicht zum Event teleportieren, wenn du bewusstlos bist")
        return
    end

    if eventttttt then
        if not eventjoin then 
          DoScreenFadeOut(1000)
          while not IsScreenFadedOut() do
              Citizen.Wait(0)
          end
          eventjoin = true
          TriggerServerEvent("join:event")
          Citizen.Wait(1000)
          DoScreenFadeIn(1000)
          Config.Notify("success", "Du wurdest zum Event teleportiert")
        else
            Config.Notify("error", "Das kannst du nicht mehr")
        end
    else
    end
end, false)

RegisterNetEvent("start:eventblip")
AddEventHandler("start:eventblip", function(coords)
    if eventBlip ~= nil then
        RemoveBlip(eventBlip)
        eventBlip = nil
        eventttttt = false
    end
    eventjoin = false
    eventttttt = true

    eventBlip = AddBlipForCoord(coords.x, coords.y, coords.z)

    local blipConfig = Config.Blip["Event"].blipOptions
    SetBlipSprite(eventBlip, blipConfig.id)
    SetBlipColour(eventBlip, blipConfig.color)
    SetBlipScale(eventBlip, blipConfig.scale)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipConfig.name)
    EndTextCommandSetBlipName(eventBlip)
end)
