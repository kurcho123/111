fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'
author 'Bulgar Dev'
description 'Bulgar Dev Runs made for Bulgar OG'

shared_scripts {
    'shared/sh_shared.lua',
    'shared/locales.lua',
    '@ox_lib/init.lua',
}

client_scripts{
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'client/cl_planting.lua',
    'client/cl_processing.lua',
} 
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_planting.lua',
    'server/sv_processing.lua',
}

dependencies {
    'PolyZone',
}

escrow_ignore {
	'shared/sh_shared.lua',
	'shared/locales.lua',
}
dependency '/assetpacks'