-- GetUserIdentity
-- Returns the user identity of the player.

function LRL.Server.GetUserIdentity(player_id)
    local result = MySQL.single.await(queries[framework]['get_identity'],{ player_id })
    local identity = {}
    if result then
        identity = {
            firstname = result.name,
            lastname = result.lastname or result.name2,
            registration = result.serial or result.registration or ''
            phone = result.phone or phone
        }
        print(json.encode(identity))
    else
        error("[LRL] Nao foi possivel obter a identidade do jogador")
    end
end


