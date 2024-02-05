-- Discord: https://discord.gg/9EbY4nM5uu

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Bulgar Development'
description 'Towing script for Bulgar OG'
version '1.0.0'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'