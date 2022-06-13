LRL.Player = {}


function LRL.Player.GetCoords()
    local entity = PlayerPedId()
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return vector4(coords.x, coords.y, coords.z, heading)
end

