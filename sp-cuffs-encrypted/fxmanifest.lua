fx_version 'adamant'
game 'gta5'

escrow_ignore {
	'config.lua',
}

lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	"client/functions.lua",
	"config.lua"
}

client_scripts { 'client/*.lua' }

server_scripts { 'server/*.lua', '@oxmysql/lib/MySQL.lua'}
 
ui_page "ui/index.html"
  
files { 
	"ui/index.html",
	"ui/style.css",
	'ui/script.js',
	'ui/avatar.png'
}

escrow_ignore {
    "config.lua",
}
dependency '/assetpacks'