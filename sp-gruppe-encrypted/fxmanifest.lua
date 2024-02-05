
fx_version 'cerulean'

author 'kristiyanpts'

game 'gta5'

shared_script {
	'config.lua',
	'@ox_lib/init.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/server.lua'
}

lua54 'yes'

dependency '/assetpacks'
dependency '/assetpacks'