fx_version 'bodacious'

game 'gta5'

author "0Resmon"

description "Created by 0Resmon discord.gg/0resmon"

shared_scripts {
    '@ox_lib/init.lua',
}


client_scripts { 'config.lua',  'client.lua'  }
server_scripts { '@mysql-async/lib/MySQL.lua', 'config.lua', 'server.lua'  }

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/s4.js',
    'web/fonts/*.ttf',
    'web/fonts/*.woff',
    'web/fonts/*.woff2',
    'web/Human/*.png',
    'web/items/*.png',
}

lua54 "yes"

escrow_ignore {
    'config.lua', 'client.lua' , 'server.lua', 'setup/ox-items.lua', 'setup/qb-items.lua'
} 

lua54 'yes'
dependency '/assetpacks'
dependency '/assetpacks'