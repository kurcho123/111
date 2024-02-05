fx_version 'adamant'
lua54 'yes'
game 'gta5'

author 'okok#3488'
description 'okokTalkToNPC'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
}

escrow_ignore {
    "config.lua",
}
dependency '/assetpacks'