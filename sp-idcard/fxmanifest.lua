fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'um-idcard'
author 'uyuyorum {um}'
version '1.2.7'
license 'GPL-3.0 license'
repository 'https://github.com/alp1x/um-idcard'
description 'FiveM Identity Card for QBCore and ESX and QBox'

dependencies {
	'ox_lib'
}

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_script 'main/client.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'bridge/**/*.lua',
	'main/server.lua',
	'main/version.lua',
}

ui_page 'web/index.html'

files {
	'web/index.html',
	'web/css/style.css',
	'web/flags/*.png',
	'web/images/*.png',
	'lang/global.js',
	'web/js/*.js',
	'web/badges/*.png',
}