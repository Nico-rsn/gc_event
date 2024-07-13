ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local event={}
-- Callback to check player group
ESX.RegisterServerCallback('checkPlayerGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    
    for _, allowedGroup in ipairs(Config.EventCommandGroups) do
        if playerGroup == allowedGroup then
            cb(true)
            return
        end
    end
    
    cb(false)
end)

eventplayers = {}
RegisterServerEvent("CreateEvent", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if eventopen  then
        Config.Announce("Das Event ist beendet")
        TriggerClientEvent("event:removeBlip", -1)
        eventopen = false
        eventplayers = {}
        return
    end
    event["name"] = "1v1"
    event["position"] = GetEntityCoords(GetPlayerPed(xPlayer.source))
    Config.Announce("Ein Event hat begonnen. Schreibe /join, um dich zum Event zu teleportieren")
    TriggerClientEvent("start:eventblip", -1, GetEntityCoords(GetPlayerPed(xPlayer.source)))
    print(json.encode(event))
    eventopen = true
end)

RegisterServerEvent("join:event")
AddEventHandler('join:event', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if eventplayers[source] then
        return
    end

    SetEntityCoords(GetPlayerPed(source), event["position"])
    eventplayers[source] = true
end)
