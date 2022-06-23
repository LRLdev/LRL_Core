LRL.Server.playersSource = {}
LRL.Server.playersIds = {}

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    print(user_id)
    print(source)

    print("TESTE")
    print(json.encode(LRL.Server.playersSource))
    print(json.encode(LRL.Server.playersIds))
    LRL.Server.playersSource[user_id] = source
    LRL.Server.playersIds[source] = user_id
end)
