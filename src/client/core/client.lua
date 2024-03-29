LRL.Functions = {}

RegisterNetEvent('LRLc:TriggerCallback', function(name, ...)
    if LRL.ServerCallbacks[name] then
        LRL.ServerCallbacks[name](...)
        LRL.ServerCallbacks[name] = nil
    end
end)

function LRL.Functions.TriggerCallback(name, cb, ...)
    LRL.ServerCallbacks[name] = cb
    TriggerServerEvent('LRLs:TriggerCallback', name, ...)
end

