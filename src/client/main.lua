LRL.Functions = {}

RegisterNetEvent('LRL:Client:TriggerCallback', function(name, ...)
    if LRL.ServerCallbacks[name] then
        LRL.ServerCallbacks[name](...)
        LRL.ServerCallbacks[name] = nil
    end
end)

function LRL.Functions.TriggerCallback(name, cb, ...)
    LRL.ServerCallbacks[name] = cb
    TriggerServerEvent('LRL:Server:TriggerCallback', name, ...)
end

RegisterCommand("teste3", function()
    LRL.Functions.TriggerCallback('LRL:server:teste', function(rank)
        print("TESTE 123")
    end)

end)