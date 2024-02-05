fx_version 'cerulean'
games { 'gta5' }

author "VT Developmet's"
description 'Винарна'
version '1.0.7'
lua54 'yes'

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
  'client/*.lua'
}

shared_script {
  '@ox_lib/init.lua',
  '@qb-core/shared/locale.lua',
  'locales/en.lua',
  'shared/*.lua'
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  'server/*.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/sp_props_barrel_pack.ytyp'

dependencies {
  "PolyZone"
}

--
-- Escrow
--
escrow_ignore {
    'locales/*.json',
    'shared/sh_config.lua',
}


dependency '/assetpacks'