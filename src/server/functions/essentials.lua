-- Get user ID from user source
-- @param source User source
-- @returns The user ID
function LRL.Server.GetUserId(source)
    assert(source, '[LRL] Source não definido')
    return LRL.Server.playersIds[source]
end

-- Get user source from user id
-- @param user_id User ID
-- @returns The user source
function LRL.Server.GetUserSource(user_id)
    assert(user_id, '[LRL] User_id não definido')
    return LRL.Server.playersSource[user_id]
end

-- Get user data from user id
-- @param user_id User ID
-- @param key Key to get
-- @returns The user data
function LRL.Server.GetUserData(user_id, key)
    assert(user_id, '[LRL] User_id não definido')
    assert(key, '[LRL] Key não definido')
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
    assert(user_id, '[LRL] User_id não definido')
    local result = MySQL.single.await(queries[framework]['get_user_datatable'],{ user_id = 1 })
    
    local datatable = {}
    for k,v in pairs(json.decode(result["dvalue"])) do
        datatable[k] = v
    end

    return datatable
end

-- Set User Data 
-- @param user_id The user id.
-- @returns The user datatable.
function LRL.Server.SetUserData(user_id,key,value)
    local result = MySQL.query.await(queries[framework]['set_user_data'],{ user_id = user_id, key = key, value = value })

    if result then
        return true
    else
        error("[LRL] Erro - SetUserData.")
    end

end

-- Get Server Data
-- @param key Key to get
-- @returns The server data
function LRL.Server.GetServerData(key)
    local result = MySQL.single.await(queries[framework]['get_server_data'],{ dkey = key })
    
    if result then
        return type(result)=="table" and result or json.decode(result)
    end
end


function LRL.Server.SetServerData(key,value)
    local result = MySQL.query.await(queries[framework]['set_server_data'],{ dkey = key, value = value })
    if result then
        return true
    else
        error("[LRL] Erro - SetServerData.")
    end
end
