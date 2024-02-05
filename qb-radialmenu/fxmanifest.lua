fx_version 'adamant'
games { 'gta5' }

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_script {
    "config.lua",
    "client_menu.lua",
	"utils.lua",
	"client/stretcher.lua",
	"client/clothing.lua",
	"client/trunk.lua",
	"emotes_triggers.lua"
}
server_scripts {
	"server/stretcher.lua",
	"server/trunk.lua",
}

ui_page "nui/dist/index.html"
files {
  "nui/dist/*",
  "nui/dist/index.html",
	"nui/dist/assets/*",
}
