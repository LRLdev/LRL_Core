fx_version 'cerulean'
game 'gta5'

version '1.0.0'
author 'Lucas Leite | LRLeite#1911'
description 'CORE responsible for the translation and the compatibility with different types of frameworks'

client_scripts {
    'src/client/core/main.lua',
    'src/client/core/client.lua',
    'src/client/functions/player.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'src/server/**/*.lua',
    'src/server/core/queries.lua',
}


lua54 'yes'
