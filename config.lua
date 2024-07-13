Config = {}

-- Hier wird die erlaubte Gruppe für den Befehl /event festgelegt
Config.EventCommandGroups = {"projektleitung", "eventleitung"  }

Config.EventCommand = "event"
Config.JoinCommand = "join"


Config.Blip = {
    ["Event"] = {
        blipOptions = {
            name       = "Event",
            id         = 546, -- The blip ID you want to use
            scale      = 1.0,
            color      = 46,
            shortRange = true,
        },
    }
}

Config.Notify = function(type, msg)
    exports["md_hud"]:Notify(type, "Event", msg, 5000)
end

Config.Announce = function(msg)
    TriggerClientEvent("md_hud:announce", -1, "Event", msg, 6000)
end