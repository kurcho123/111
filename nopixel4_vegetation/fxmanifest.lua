fx_version 'adamant'
games { 'gta5' }

author 'Razed'
description 'nopixel 4.0 - Vegetation'
version '1.0.0'

this_is_a_map 'yes'

files {
    "nve_vegetation_cache_y.dat"
}


data_file 'DLC_ITYP_REQUEST' 'stream/vegetation.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/v_proc1.ytyp'

escrow_ignore {
    'stream/**/*.ytd'
  }
  
lua54 'yes'
dependency '/assetpacks'