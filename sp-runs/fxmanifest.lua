fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Bulgar Dev'
description 'Bulgar Dev Runs made for Bulgar OG'

shared_scripts {
    '@ox_lib/init.lua',
    "shared/*.lua",
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}