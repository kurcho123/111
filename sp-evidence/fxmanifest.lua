fx_version 'cerulean'
game 'gta5'

author 'R14 Development (Owner: cjsjs#2964) (Invite: https://discord.gg/Dj3nXTaUYZ)'
description 'r14-evidence'
version '1.641'


shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
}

ui_page 'html/evidence.html'

client_scripts {
	'config.lua',
	'client/*.lua',
}

server_scripts {	
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

dependencies {
    'screenshot-basic',
    'oxmysql',
}

files {
	'html/evidence.html',
	'html/main.js',
}

lua54 'yes'
