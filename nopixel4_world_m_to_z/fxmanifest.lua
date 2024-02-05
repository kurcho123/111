fx_version 'adamant'
games { 'gta5' }

author 'Razed'
description 'nopixel 4.0 - World Overhaul'
version '1.0.0'

this_is_a_map 'yes'

escrow_ignore {
    'stream/**/*.ytd',
    'stream/sm_22_alpha_1001.ydr' --causes crashes
  }
  
lua54 'yes'
dependency '/assetpacks'