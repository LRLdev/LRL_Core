-- GetUserIdentity
-- Returns the user identity of the player.
function LRL.Server.GetUserIdentity(player_id)
    local result = MySQL.single.await(queries['bahamas']['get_identity'],{ player_id })
    
    if result then
        print(json.encode(result))
    end
end


