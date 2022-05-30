----------
-- VARIAVEIS UTEIS
----------
local callbackResponses = {}
local currentRequestId = 0
local callbacks = {}

-- register new callback
function Register(name, callback)
	assert(name ~= nil and type(name) == "string", "Parameter \"name\" must be a string!")
	assert(callback ~= nil, "Parameter \"callback\" must be a function!")

	callbacks[name] = callback
end

-- Trigger Callback
function Trigger(name, ...)
	assert(name ~= nil and type(name) == "string", "Parameter \"name\" must be a string!")

	return TriggerWithTimeout(name, 5000, ...)
end

RegisterNetEvent("LRL:cc")
AddEventHandler("LRL:cc", function(name, requestId, data)
	local requestName = name .. tostring(requestId)

	if (callbacks[name] ~= nil) then
		-- execute callback function and return its result
		local result = { callbacks[name](table.unpack(data)) }
		
		TriggerServerEvent("LRL:ccResponse", requestName, result)
	else
		-- callback does not exist
		print(
			"^1[ERROR] ClientCallback \"" .. name .. "\" does not exist!^0\n" .. 
			"    Potential solutions:\n" .. 
			"    - \"LRL_Core\" Precisa ser exportado antes de startar o script!\n" .. 
			"    - Tenha certeza que você está colaborando!"
		)
		
		TriggerServerEvent("LRL:ccDoesNotExist", requestName, name)
	end
end)

RegisterNetEvent("LRL:scResponse")
AddEventHandler("LRL:scResponse", function(requestName, data)
	if (callbackResponses[requestName] ~= nil) then
		-- receive data
		callbackResponses[requestName] = data
	end
end)

RegisterNetEvent("LRL:scDoesNotExist")
AddEventHandler("LRL:scDoesNotExist", function(requestName, name)
	if (callbackResponses[requestName] ~= nil) then
		callbackResponses[requestName] = "ERROR"

		print(
			"^1[ERROR] ServerCallback \"" .. name .. "\" does not exist!^0\n" .. 
			"    Potential solutions:\n" .. 
			"    - \"kimi_callbacks\" needs to be started before the script that is using this export!\n" .. 
			"    - Make sure that there is no typo in the Register or Trigger function!"
		)
	end
end)

-- Declaração dos Exports
exports("Register", Register)
exports("Trigger", Trigger)
exports("TriggerWithTimeout", TriggerWithTimeout)