fx_version 'cerulean'
game 'gta5'

description 'qb-bossmenu'
version '2.0.0'

shared_script '@ox_lib/init.lua'

client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

server_exports {
    'GetAccount',
    'GetaccountGang',
}

lua54 'yes'
