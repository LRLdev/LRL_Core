LRL = {}
LRL.Config = QBConfig
LRL.Shared = QBShared
LRL.ServerCallbacks = {}
LRL.UseableItems = {}
LRL.Server = {}
LRL.Player = {}

framework = nil

exports('initCore', function()
    return LRL
end)

-- Init Function
function Init()
    print('[LRL] Initializing Core...')
    local databases = {
        ["vRP"] = "vrp_user_identities",
        ["bahamas"] = "summerz_characters",
    }


    CreateThread(function()
        for k, v in pairs(databases) do
            local result = MySQL.single.await('show tables like @framework', { framework = v })
            if(result) then
                framework = k
            
            end
        end        
        assert(framework~=nil, '[LRL] Database nao encontrado')
    end)
 
   
end



Init()