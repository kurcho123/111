fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

version '3.6.5'

ui_page 'html/index.html'

files {
    'html/**/*'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/*.lua',
    'locales/*.lua',
    'utils/*.lua'
}

client_scripts {
    'client/custom/**/**.lua',
    'client/*.lua',
    'client/modules/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/custom/**/**.lua',
    'server/*.lua',
    'server/modules/*.lua'
}

exports {
    'CallRemoteMethod',
    'RegisterMethod'
}

server_exports {
    'CallRemoteMethod',
    'RegisterMethod'
}

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'client/custom/**/**.lua',
    'server/custom/**/**.lua'
}

dependencies {
    '/gameBuild:2802',    -- requires at least game build 2189
    '/server:5895',       -- required last artifacts
    '/native:0x6AE51D4B', -- required last artifacts
    '/onesync',           -- requires onesync
    'ox_lib',
    'meta_libs',
    'bob74_ipl'
}

dependency '/assetpacks'