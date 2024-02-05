fx_version 'adamant'
games { 'gta5' }

author 'NVE Team'
description 'Mission Row Police Department'
version '1.0.0'

this_is_a_map 'yes'
lua54 'yes'

client_scripts {
  "client.lua"
  }

files {
  'np4_mrpd_timecycles.xml',
  'stream/gtxd.meta'
}

data_file 'TIMECYCLEMOD_FILE' 'np4_mrpd_timecycles.xml'
data_file "GTXD_PARENTING_DATA" "stream/gtxd.meta"
dependency '/assetpacks'