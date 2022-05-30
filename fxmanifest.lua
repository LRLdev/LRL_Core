fx_version 'cerulean'
game 'gta5'


version '1.0.0'

client_scripts {
    'src/client-side/*',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'src/server-side/**/*.lua',
}
server_exports{
    "getUserIdentity"
}