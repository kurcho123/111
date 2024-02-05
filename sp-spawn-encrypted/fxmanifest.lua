fx_version 'cerulean'
lua54 'yes'
game 'gta5'

ui_page 'html/index.html'

files {'html/*.html', 'html/*.js', 'html/*.css', 'html/images/*.png', 'html/*.png'}

client_script 'cl_spawn.lua'

server_scripts {
    'sv_spawn.lua',
    '@oxmysql/lib/MySQL.lua'
}
dependency '/assetpacks'