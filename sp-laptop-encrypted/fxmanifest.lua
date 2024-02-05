fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "Job Tablet by Bulgar Development for Bulgar OG"
author "Bulgar Development"
version "1.0.0"

shared_script 'config.lua'
client_scripts {'client/*.lua'}
server_scripts {'server/*.lua'}

ui_page 'ui/ui.html'
files {
	'ui/ui.html',
	'ui/*.css',
	'ui/*.js',
	'ui/imgs/*.png',
    'ui/imgs/app/*.png',
	'ui/sounds/*.ogg'
}

escrow_ignore {
	'config.lua',
}
dependency '/assetpacks'