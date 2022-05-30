framework = nil



function getInitInfos()
	local playerIdent = 1
	
    MySQL.query('show tables', function(result)
        if result then
            for k,v in pairs(result) do
                print(json.encode(v))
				
                if string.find(v["Tables_in_bahamas"], "summerz_") then
					framework =  "BAHAMAS"
				end
            end
			teste()
        end
    end)
end


function teste()
	print(framework)
end

function init()
	local teste = getInitInfos()
end


AddEventHandler("onResourceStart", function(param)
	if(param=="lrl_core") then
		init()
		print(framework)
	end
	
end)