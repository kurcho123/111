fx_version 'cerulean'
lua54 'yes'
description 'Up-N-Atom Job by Bulgar Development'
game 'gta5'
author 'kristiyanpts'

shared_script {
	'config.lua',
	'@ox_lib/init.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}

dependency '/assetpacks'

escrow_ignore {
    'config.lua',
}