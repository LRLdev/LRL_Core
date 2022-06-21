function LRL.Server.GetUserData(user_id, key)
    local user_id = parseInt(user_id)
    local result = MySQL.single.await(queries['bahamas']['get_user_data'],{ user_id })
    
    if result then
        return result
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
