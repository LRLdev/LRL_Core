-- Get user identity
-- Get identity from user 
-- @param player_id The player id.
function LRL.Server.GetUserIdentity(player_id)
    assert(player_id, '[LRL] Player_id não definido')
    local result = MySQL.single.await(queries[framework]['get_identity'],{ player_id })
    
    local identity = {}
    if result then
        identity = {
            firstname = result.name,
            lastname = result.lastname or result.name2 or result.firstname,
            registration = result.serial or result.registration or '',
            phone = result.phone or phone
        }
        return identity
    else
        error("[LRL] Nao foi possivel obter a identidade do jogador")
    end
end

-- Has permission
-- Verify if the player has the permission
-- @param user_id The player id.
-- @param permission The permission to verify.
function LRL.Player.HasPermission(user_id,permission)
    assert(user_id, '[LRL] Player_id não definido')
    assert(permission, '[LRL] Permission não definido')
    local result =  LRL.Server.GetUserDatatable(user_id)
    local dataPermission = result["permission"] or result["perm"] or result["groups"] or {}
    if type(dataPermission)=="lua_rapidjson_object" then dataPermission = json.encode(dataPermission) end
    
    
    if result~=nil then
        for k,v in pairs(dataPermission) do
            print(k,v)
            if k==permission then
                return true
            end
        end
    end
    
    return false
end

-- Set Permission
-- Set permission to the player
-- @param user_id The player id.
-- @param permission The permission to verify.
function LRL.Player.SetPermission(user_id, permission)
    assert(user_id, '[LRL] Player_id não definido')
    assert(permission, '[LRL] Permission não definido')
    local result =  LRL.Server.GetUserDatatable(user_id)

    permission = tostring(permission)
    if result then
        if framework=="crv5" then
            if result["perm"] == nil then
                result["perm"] = {}
            end
    
            if result["perm"][permission] == nil then
                result["perm"][permission] = true
            end
        elseif framework=="bahamas" then
            
            if result["permission"] == nil then
                result["permission"] = {}
            end
    
            if result["permission"][permission] == nil then
                result["permission"][permission] = true
            end
        end        
       
        LRL.Server.SetUserData(user_id,"Datatable",json.encode(result))
    else
        error("[LRL] SetPermission - Não foi possivel recuperar o datatable")
    end

end

-- Remove Permission
-- Remove player permission
-- @param user_id The player id.
-- @param permission The permission to verify.
function LRL.Player.RemovePermission(user_id, permission)
    assert(user_id, '[LRL] Player_id não definido')
    assert(permission, '[LRL] Permission não definido')
    local result = LRL.Server.GetUserDatatable(user_id)

    permission = tostring(permission)

    if result then
        if framework=="crv5"then
            if result["perm"] then
                if result["perm"][permission] then
                    result["perm"][permission] = nil
                end
            end

        elseif framework =="bahamas" then
            if result["permission"] then
                if result["permission"][permission] then
                    result["permission"][permission] = nil
                end
            end
        end
        LRL.Server.SetUserData(user_id,"Datatable",json.encode(result))
    else
        error("[LRL] RemovePermission - Não foi possivel recuperar o datatable")
    
    end
end

-- Add prison
-- Add prison to the player
-- @param user_id The player id.
-- @param value How much time the player will be in prison.
function LRL.Player.AddPrison(player_id,value)
    assert(player_id, '[LRL] Prison - Player_id não definido')
    assert(value, '[LRL] Prison - Value não definido')

    local result = MySQL.query.await(queries[framework]['add_prison'],{ prison = value, user_id = player_id })
   
    if result then
        return true
    else
        error("[LRL] Nao foi possivel adicionar prisão ao jogador")
    end
end
