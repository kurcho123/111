
fx_version 'cerulean'

author 'KevinGirardx'

game 'gta5'

shared_script {
    '@ox_lib/init.lua',
	'config.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/server.lua'
}

lua54 'yes'

files {
	'common/carvariations.meta',
	'common/vehicles.meta',
	'common/*.meta'
}
data_file 'VEHICLE_METADATA_FILE' 'common/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'common/carvariations.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/box.ytyp'

escrow_ignore {
    'config.lua',
}

dependency '/assetpacks'
dependency '/assetpacks'