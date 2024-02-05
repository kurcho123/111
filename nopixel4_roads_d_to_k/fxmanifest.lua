fx_version 'adamant'
games { 'gta5' }

author 'Razed'
description 'nopixel 4.0 - Roads and Pavement'
version '1.0.0'

this_is_a_map 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/downtown_01_metadata_002_strm.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/dt1_rd1_interior_dt1_rd1_tun3.ytyp'

escrow_ignore {
    'stream/**/*.ytd'
  }
  
lua54 'yes'
dependency '/assetpacks'