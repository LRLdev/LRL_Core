-- Event to play sound into client
-- @params: sound, desc

RegisterNetEvent("LRL_Core:PlaySound")
AddEventHandler("LRL_Core:PlaySound", function(sound, descSound)
	PlaySoundFrontend(-1, sound,descSound, 0)
end)