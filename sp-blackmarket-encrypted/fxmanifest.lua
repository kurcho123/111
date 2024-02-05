fx_version 'cerulean'
name 'sp-blackmarket'
description 'Black Market script by Bulgar Development'
author 'Bulgar Development'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

escrow_ignore {
	'config.lua',
}
dependency '/assetpacks'