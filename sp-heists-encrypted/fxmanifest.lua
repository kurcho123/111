fx_version 'cerulean'
game 'gta5'

author 'kristiyanpts'
description 'Bulgar Heists for Bulgar OG by Bulgar Development'
version '1.0.0'
lua54 'yes'

shared_scripts { 
    '@ox_lib/init.lua',
    'shared/*.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',  
}

dependency '/assetpacks'