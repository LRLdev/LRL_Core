-- GetUserFines
-- Returns the user fines of the player.
-- @param player_id The player id.
function LRL.Server.GetUserFines(player_id)
    assert(player_id, '[LRL] Player_id não definido')
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
    assert(player_id, '[LRL] Player_id não definido')
    assert(value, '[LRL] Value não definido')
    local result = MySQL.query.await(queries[framework]['set_fines'],{ fines = value, id = player_id })

    if result then
        return true
    else
        error("[LRL] Nao foi possivel atualizar as multas do jogador")
    end
end


--
function LRL.Server.AddUserMoney(player_id,value)
    assert(player_id, '[LRL] Player_id não definido')
    assert(value, '[LRL] Value não definido')
    local result = MySQL.query.await(queries[framework]['add_user_money'],{ bank = value, id = player_id })

    if result then
        return true
    else
        error("[LRL] Nao foi adicionar dinheiro no banco do player")
    end
end

function LRL.Server.GetUserBank(player_id)
    assert(player_id, '[LRL] Player_id não definido')
    
    local result = MySQL.query.await(queries[framework]['get_user_money'],{ id = player_id })

    if result then
        return true
    else
        error("[LRL] Nao foi adicionar dinheiro no banco do player")
    end
end

function LRL.Server.RemoveUserMoney(user_id,value)
    assert(user_id, '[LRL] TryFullPayment - User_id não definido')
    assert(value, '[LRL] TryFullPayment - Value não definido')

    local result = MySQL.query.await(queries[framework]['del_user_money'],{ bank = value, id = user_id })

    if result then
        return true
    else
        error("[LRL] Nao foi possivel remover dinheiro do banco do player. ID: "..user_id.." Valor: "..value)
    end
end