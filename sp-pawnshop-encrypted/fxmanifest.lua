fx_version 'cerulean'
game 'gta5'

description 'Sigma Pawnshop'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua',
}

server_script 'server/server.lua'

lua54 'yes'
dependency '/assetpacks'