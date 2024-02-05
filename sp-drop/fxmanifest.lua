fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'Bulgar Weapon Drops'
version      '1.0.0'
description  'Bulgar Weapon Drops by Bulgar Development.'
author       'Bulgar Development'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'core/shared.lua',
    "locales/locale.lua",
    "locales/translations/*.lua",
    'modules/**/shared.lua',
}

server_scripts {
    'bridge/**/server.lua',
    'modules/**/server.lua',
}

client_scripts {
    'core/client.lua',
    'bridge/**/client.lua',
    'modules/**/client.lua',
}
