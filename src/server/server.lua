LRL.Functions = {}

-- Callbacks
function LRL.Functions.CreateCallback(name, cb)
    LRL.ServerCallbacks[name] = cb
end
-- Trigger Callback
function LRL.Functions.TriggerCallback(name, source, cb, ...)
    if not LRL.ServerCallbacks[name] then return end
    LRL.ServerCallbacks[name](source, cb, ...)
end

RegisterNetEvent('LRL:Server:TriggerCallback', function(name, ...)
    local src = source
    LRL.Functions.TriggerCallback(name, src, function(...)
        TriggerClientEvent('LRL:Client:TriggerCallback', src, name, ...)
    end, ...)
end)

LRL.Functions.CreateCallback('LRL:server:teste', function(source, cb)
    local src = source
    print(json.encode(src))
end)