fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Bulgar'
description 'Hodi i duhai'
version '1.0.0'

shared_scripts { '@ox_lib/init.lua' }

client_scripts {
 'config.lua',
 'client/client.lua',
}

server_scripts {
 'config.lua',
 'server/server.lua',  
}

exports {
    'IsRobbingHouse'
}

lua54 'yes'