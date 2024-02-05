fx_version 'cerulean'
author 'marcinhu#0001 & beastpt#0001'
Description 'qb-insurance'
game 'gta5'

ui_page 'html/index.html'

shared_scripts {
    "config/**",
    '@ox_lib/init.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    "server/**.lua",
}

client_script {
    "client/**.lua",
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/main.js',
    'html/img/*'
}

escrow_ignore {
    "images/**",
    "config/**",
    "README.lua",
    "SQL.sql",
}

lua54 'yes'
dependency '/assetpacks'
