-- GetUserFines
-- Returns the user fines of the player.
-- @param player_id The player id.
function LRL.Server.GetUserFines(player_id)
    local count = 0
    local result = MySQL.single.await(queries[framework]['get_fines'],{ id = player_id })
  
    if result then
        return result.multas
    else
        error("[LRL] Nao foi possivel obter as multas do jogador")
    end
end


-- SetUserFines
-- Sets the user fines of the player.
-- @param player_id The player id.
-- @param value The value of the fines.
function LRL.Server.SetUserFines(player_id,value)
    local result = MySQL.query.await(queries[framework]['set_fines'],{ fines = value, id = player_id })

    if result then
        return true
    else
        error("[LRL] Nao foi possivel atualizar as multas do jogador")
    end
end