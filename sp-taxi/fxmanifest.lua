--[[FX INFO]]
fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

--[[RESOURCE INFO]]
name 'uniq-taxi'
author 'grandson'
description 'Advanced Taxi Job'
version '1.0.1'
 
--[[FX DEPENDENCIES]]
dependencies {
	'/server:5848',
    '/onesync',
}

--[[FX FILES]]
ui_page 'web/index.html'

files {
    'web/index.html',
    'web/**/*',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',
    'shared/**/*.lua'
}

client_scripts {
    'client/*.lua',
}

server_script {
	'@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

escrow_ignore {
    '*.sql',
    'shared/*.lua',
    'shared/**/*.lua',
    'client/framework_loader.lua',
    'client/call_taxi.lua',
    'client/orders.lua',
    'client/taximeter.lua',
    'server/framework_loader.lua'
}
dependency '/assetpacks'