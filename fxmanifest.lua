fx_version 'cerulean'
game 'gta5'

version '1.0.0'
author 'Lucas Leite | LRLeite#1911'
description 'CORE responsible for the translation and the compatibility with different types of frameworks'

client_scripts {
    'src/client/*',
    'src/client/clientMain.lua',
    'src/client/player.lua',
    'src/client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'src/server/**/*.lua',
}


lua54 'yes'
