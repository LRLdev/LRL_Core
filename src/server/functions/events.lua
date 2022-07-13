LRL.Server.playersSource = {}
LRL.Server.playersIds = {}

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    LRL.Server.playersSource[user_id] = source
    LRL.Server.playersIds[source] = user_id
end)

-- Event to handle a creative v5 player connection
AddEventHandler("playerConnect",function(user_id,source)
    LRL.Server.playersSource[user_id] = source
    LRL.Server.playersIds[source] = user_id
end)


AddEventHandler("playerDropped",function(reason)
    local source = source
    local user_id = LRL.Server.playersIds[source]
    LRL.Server.playersSource[user_id] = nil
    LRL.Server.playersIds[source] = nil
end)