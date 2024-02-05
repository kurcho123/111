fx_version 'cerulean'
games { 'gta5' }

author 'Bulgar Development'
description 'Да го духаш педал'
version '1.0.0'

lua54 'yes'

shared_script '@ox_lib/init.lua'

client_script {
    'core.lua',
    'client/main.lua',
}
server_script {
    '@oxmysql/lib/MySQL.lua',
    'core.lua',
    'server/config.lua',
    'server/functions.lua',
    'server/main.lua'
}

ui_page "nui/index.html"
files { 'nui/**/*' }

escrow_ignore {
    'core.lua',
    'server/config.lua',
    'server/functions.lua',
    'client/**',
    'nui/**',
}
dependency '/assetpacks'