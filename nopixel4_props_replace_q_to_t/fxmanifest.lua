fx_version 'adamant'
games { 'gta5' }

author 'NVE Team'
description 'nopixel 4.0 - Props'
version '1.0.0'

this_is_a_map 'yes'

escrow_ignore {
    'stream/**/*.ytd',
    'stream/prop_sign_interstate_01.yft', --causes crashes
    'stream/prop_sign_interstate_02.yft', --causes crashes
    'stream/prop_sign_interstate_03.yft', --causes crashes
    'stream/prop_sign_interstate_04.yft', --causes crashes
    'stream/prop_sign_interstate_05.yft' --causes crashes
  }
  
lua54 'yes'
dependency '/assetpacks'