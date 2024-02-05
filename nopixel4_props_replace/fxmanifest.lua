fx_version 'adamant'
games { 'gta5' }

author 'NVE Team'
description 'nopixel 4.0 - Props'
version '1.0.0'

this_is_a_map 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/firefly_map.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/pillars.ytyp'

escrow_ignore {
    'stream/**/*.ytd'
  }
  
lua54 'yes'
dependency '/assetpacks'