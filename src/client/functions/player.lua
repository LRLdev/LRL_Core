LRL.Player = {}

local PlayerProps = {}
local PlayerHasProp = false

function LRL.Player.GetCoords()
    local entity = PlayerPedId()
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return vector4(coords.x, coords.y, coords.z, heading)
end


function LRL.Player.GetUserHealth()
    local source = PlayerPedId()   
    return GetEntityHealth(source)
end

function LRL.Player.SetUserHealth(health)
    local source = PlayerPedId()   
    assert(health~=nil, 'LRL.Player.SetUserHealth: quantidade de vida nula')
    SetEntityHealth(source, health)
end


-- GetUserArmor
-- Returns the user armor of the player.
function LRL.Player.GetUserArmor(source)
    local source = PlayerPedId()
    return GetPedArmour((source))
end

function LRL.Player.SetUserArmour(armour)
    local source = PlayerPedId()
    assert(armour~=nil, 'LRL.Player.SetUserArmour: Quantidade de armadura nula')
    SetPedArmour(source, armour)
end

function LRL.Player.SetEntityCoords(entity, x,y,z)
    assert(entity~=nil, "LRL.Player.SetEntityCoords: entidade é nula")

    SetEntityCoords(entity, x,y,z)
end

function LRL.Player.IsPlayerDead()
    local source = PlayerPedId()
    return IsPedDeadOrDying(source, true)
end

function LRL.Player.CreateObject(model, bone, off1, off2, off3, rot1, rot2, rot3)
    assert(model~=nil, "LRL.Player.CreateObject: modelo nulo")
    assert(bone~=nil, "LRL.Player.CreateObject: bone nulo")

    local Player = PlayerPedId()

    local x,y,z = table.unpack(GetEntityCoords(Player))

    if not HasModelLoaded(model) then
        while not HasModelLoaded(GetHashKey(model)) do
            RequestModel(GetHashKey(model))
            Wait(10)
        end
    end
  
    prop = CreateObject(GetHashKey(model), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(model)
end

function LRL.Player.DestroyAllProps()
    for _,v in pairs(PlayerProps) do
      DeleteEntity(v)
    end
    PlayerHasProp = false
    print('[LRL] - Todos os objetos foram destruídos')
end

function LRL.Player.RequestAnimDict(animDict)
	if HasAnimDictLoaded(animDict) then return end
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(5)
	end
end

function LRL.Player.PlayAnim(animDict, animName, upperbodyOnly, duration)
    local flags = upperbodyOnly == true and 16 or 0
    local runTime = duration ~= nil and duration or -1
    LRL.Player.RequestAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 3.0, 3.0, runTime, flags, 0.0, 0, 0, 0)
    RemoveAnimDict(animDict)
end

function LRL.Player.StopAnim(animDict)
    
    ClearPedTasks(PlayerPedId())
    ClearPedSecondaryTask(PlayerPedId())
end

function LRL.Player.PlaySound(soundId, audioName, audioRef, p3, p4, p5)
    PlaySoundFrontend(-1, soundId,audioName, 0)
end