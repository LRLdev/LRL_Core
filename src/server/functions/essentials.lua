function LRL.Server.GetUserId(source)
    assert(user_id, '[LRL] Source não definido')
    return LRL.playersIds[source]
end

function LRL.Server.GetUserSource(user_id)
    assert(user_id, '[LRL] User_id não definido')
    return LRL.playersSource[user_id]
end

function LRL.Server.GetUserData(user_id, key)
    local user_id = parseInt(user_id)
    local result = MySQL.single.await(queries[framework]['get_user_data'],{ user_id = user_id, key = key })
    
    if result then
        return result
    else
        error("[LRL] Erro - GetUserData.")
    end
end

-- Get User Datatable 
-- @param user_id The user id.
-- @returns The user datatable.
function LRL.Server.GetUserDatatable(user_id)
    local user_id = parseInt(user_id)
    local result = MySQL.single.await(queries['bahamas']['get_user_datatable'],{ user_id })
    
    if result then
        return result
    end
end

function LRL.Server.GetServerData(key)
    local result = MySQL.single.await(queries[framework]['get_server_data'],{ key = key })
    
    if result then
        return json.decode(result)
    end
end

function LRL.Server.SetServerData(key,value)
    local result = MySQL.query.await(queries[framework]['set_server_data'],{ dkey = key, value = value })
    -- local result = nil

    if result then
        return true
    else
        error("[LRL] Erro - SetServerData.")
    end
end
