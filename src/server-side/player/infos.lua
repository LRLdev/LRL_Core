



function getUserIdentity(param)

    assert(param ~= nil, "ID é nulo favor verificar")
    local userIdentity = nil

    MySQL.query('show tables', function(result)
        if result then
            for k,v in pairs(result) do
                
                if string.find(v["Tables_in_bahamas"], "summerz_") then
					framework =  "BAHAMAS"
				end
            end
			teste()
        end
    end)
    
end


-- DECLARING

return LRL