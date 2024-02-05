fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Vank1ta - Sigma Development'
description 'Atm Robbery'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    '@ox_lib/init.lua',
    'shared/config.lua',
}

client_scripts {
    'client/cl_main.lua',
    'client/cl_drilling.lua',
}

server_scripts {
   'server/sv_main.lua'
}

data_file "DLC_ITYP_REQUEST" "stream/loq_atm.ytyp"

dependencies {
    'meta_libs'
}

escrow_ignore {
	'shared/config.lua',
    'server/sv_main.lua'
}
dependency '/assetpacks'