fx_version 'adamant'
games { 'gta5' }

author 'Razed'
description 'nopixel 4.0 - Roads and Pavement'
version '1.0.0'

this_is_a_map 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/beverly_metadata_001_strm.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/country_01_metadata_021_strm.ytyp'

escrow_ignore {
    'stream/**/*.ytd'
  }
  
lua54 'yes'
dependency '/assetpacks'