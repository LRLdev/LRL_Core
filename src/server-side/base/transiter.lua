

functions = requite


local callbackResponses = {}
local currentRequestId = 0

local callbacks = {}



-- register new callback
function Register(name, callback)
	assert(name ~= nil and type(name) == "string", "Parameter \"name\" must be a string!")
	assert(callback ~= nil, "Parameter \"callback\" must be a function!")

	callbacks[name] = callback
end

-- trigger callback
function Trigger(name, playerId, ...)
	assert(name ~= nil and type(name) == "string", "Parameter \"name\" must be a string!")
	assert(playerId ~= nil and type(playerId) == "number", "Parameter \"playerId\" must be a number!")

	return TriggerWithTimeout(name, playerId, 5000, ...)
end

-- trigger callback with custom timeout
function TriggerWithTimeout(name, playerId, timeout, ...)
	assert(name ~= nil and type(name) == "string", "Parameter \"name\" must be a string!")
	assert(playerId ~= nil and type(playerId) == "number", "Parameter \"playerId\" must be a number!")
	assert(timeout ~= nil and type(timeout) == "number", "Parameter \"timeout\" must be a number!")

	-- set id for current request
	local requestId = currentRequestId

	-- advance next request id
	currentRequestId = currentRequestId + 1
	if (currentRequestId >= 65536) then
		currentRequestId = 0
	end

	-- create request name from callback name and request id
	local requestName = name .. tostring(requestId)

	-- initialize callback response
	callbackResponses[requestName] = true

	-- send data to client
	TriggerClientEvent("LRL:cc", playerId, name, requestId, { ... })

	-- await cb response
	local timer = GetGameTimer()
	while (callbackResponses[requestName] == true) do
		Citizen.Wait(0)

		if (GetGameTimer() > timer + timeout) then
			-- timed out
			print(
				"^1[ERROR] ClientCallback \"" .. name .. "\" timeout depois de " .. tostring(timeout) .. "ms!^0\n" .. 
				"    Solução:\n" .. 
				"    - Poderá ter um erro no seu client console, cheque ele!\n" .. 
				"    - Ping do player está maior que o Timeout."
			)

			callbackResponses[requestName] = "ERROR"
		end
	end

	-- return nil if error occurred
	if (callbackResponses[requestName] == "ERROR") then
		return nil
	end

	-- return unpacked data
	local data = callbackResponses[requestName]
	callbackResponses[requestName] = nil
	return table.unpack(data)
end

RegisterNetEvent("LRL:sc")
AddEventHandler("LRL:sc", function(name, requestId, data)
	local src = source

	local requestName = name .. tostring(requestId)

	if (callbacks[name] ~= nil) then
		-- execute callback function and return its result
		local result = { callbacks[name](src, table.unpack(data)) }

		TriggerClientEvent("LRL:scResponse", src, requestName, result)
	else
		-- callback does not exist
		print(
			"^1[ERROR] ServerCallback \"" .. name .. "\" does not exist!^0\n" .. 
			"    Solução:\n" .. 
			"    - \"LRL_Core\" precisa ser startado antes que o script que está lhe utilizando!\n" .. 
			"    - Qualquer coisa chame o LRLeite para suporte!"
		)

		TriggerClientEvent("LRL:scDoesNotExist", src, requestName, name)
	end
end)

RegisterNetEvent("LRL:ccResponse")
AddEventHandler("LRL:ccResponse", function(requestName, data)
	if (callbackResponses[requestName] ~= nil) then
		-- receive data
		callbackResponses[requestName] = data
	end
end)

RegisterNetEvent("LRL:ccDoesNotExist")
AddEventHandler("LRL:ccDoesNotExist", function(requestName, name)
	if (callbackResponses[requestName] ~= nil) then
		callbackResponses[requestName] = "ERROR"

		print(
			"^1[ERROR] ClientCallback \"" .. name .. "\" does not exist!^0\n" .. 
			"    Potential solutions:\n" .. 
			"    - \"LRL_Core\" precisa ser startado antes que o script que está lhe utilizando!\n" .. 
			"    - Qualquer coisa chame o LRLeite para suporte!"
		)
	end
end)


exports("Register", Register)
exports("Trigger", Trigger)
exports("TriggerWithTimeout", TriggerWithTimeout)