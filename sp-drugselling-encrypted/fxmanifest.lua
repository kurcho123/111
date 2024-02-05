fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Bulgar Dev'
description 'Bulgar Dev Drug Salles made for Bulgar OG'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
}

server_scripts {    
    'server/sv_drugsell.lua',
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',   
    'client/cl_drugsell.lua'
}

dependencies {
    'qb-core',
    'PolyZone',
}

escrow_ignore {
	'shared/config.lua',
}
dependency '/assetpacks'