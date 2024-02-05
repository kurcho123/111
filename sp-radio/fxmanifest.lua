fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]] --
name 'fd_radio_v2'
version      '1.5.2'
repository 'https://https://github.com/FelisDevelopment/fd_radio_v2'
description 'Felis Development Radio v2'

data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_yellow.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_yellow.ydr'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_grey.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_grey.ydr'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_blue.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_blue.ydr'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_green.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_green.ydr'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_red.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_red.ydr'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_white.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/walkietalkie_white.ydr'

--[[ Manifest ]] --
dependencies {
    '/server:5104',
    '/onesync',
    'pma-voice',
    'PolyZone'
}

files {
    'web/dist/index.html',
    'web/dist/**/*',
    'locales/*.json',
}

ui_page 'web/dist/index.html'

shared_scripts {
    -- UNCOMMENT IF USING OX_LIB
    -- '@ox_lib/init.lua',
    'config.lua',
    'locale.lua',
    'modules/**/shared.lua',
    'modules/**/shared/*.lua'
}

client_scripts {
    -- COMMENT OUT IF USING OX_LIB
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'modules/**/client.lua',
    'modules/**/client/*.lua'
}

server_scripts {
    'modules/**/server.lua',
    'modules/**/server/*.lua'
}

escrow_ignore {
    "config.lua",
    "locale.lua",
    "modules/bridge/**",
    "modules/callback/**",
    "data/**",
    "optional/**",
    "modules/jammer/client/pickup_init.lua"
}
