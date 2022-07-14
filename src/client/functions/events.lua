-- Event to play sound into client
-- @params: sound, desc

RegisterNetEvent("LRL_Core:PlaySound")
AddEventHandler("LRL_Core:PlaySound", function(sound, descSound)
	assert(sound ~= nil, '[LRL] Sound nao encontrado')	
	assert(descSound ~= nil, '[LRL] Descricao do Sound nao encontrado')
	PlaySoundFrontend(-1, sound,descSound, true)
end)