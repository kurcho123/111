fx_version 'adamant'
games {'gta5'}
lua54 'yes'

author 'Hugo Rafael Simoes'
description 'CaixaManual'
version '1.0'

client_scripts {
	"client.lua",
	"config.lua",	
}

escrow_ignore {
    "config.lua",
}
dependency '/assetpacks'