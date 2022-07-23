LRL = {}
LRL.ServerCallbacks = {}
LRL.UseableItems = {}
LRL.Server = {}
LRL.Player = {}

framework = nil

-- Exports inits
-- @returns All the functions inside the core
exports('initCore', function()
    return LRL
end)

-- Init Function
function Init()
    print('[LRL] Initializing Core...')
    local databases = {
        ["crv5"] = "summerz_fidentity",
        ["vRP"] = "vrp_user_identities",
        ["bahamas"] = "summerz_characters",
    }

    local tablesFind = {}
    
    for k, v in pairs(databases) do
        local result = MySQL.scalar.await('show tables like @framework', { framework = v })
        if(result) then
            table.insert( tablesFind, v)
        end
    end
    assert(#tablesFind > 0, '[LRL] Nenhum framework encontrado')
    table.sort(tablesFind)
    
    if #tablesFind>1 then
        for a,b in pairs(tablesFind) do
            if b=="summerz_fidentity" then
                framework = "crv5"
                break
            end
        end
    else
        for k,v in pairs(databases) do 
            for a,b in pairs(tablesFind) do
                if v==b then
                    framework = k
                    break
                end
            end

        end
    end
    
    print('[LRL] Core Initialized.')   
    print('[LRL] Framework: '..framework)   
    assert(framework~=nil, '[LRL] Database nao encontrado')
end

CreateThread(Init) -- Initilize the core