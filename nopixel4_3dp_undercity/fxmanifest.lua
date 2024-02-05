fx_version 'cerulean'
game 'gta5'

author 'Denis3D, Synced3D and sanhje'
description 'Undercity - Sewer System Southside'
version '1.0.0'
lua54 'yes'
this_is_a_map 'yes'

data_file 'TIMECYCLEMOD_FILE' '3dp_undercity_timecycles.xml'

files {
    '3dp_undercity_timecycles.xml',
}

client_script {
    '3dp_undercity_entitysets.lua',
}

dependencies { 
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    '/gameBuild:2545',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2545.
}

escrow_ignore {
    'stream/**/*.ytd',
}
dependency '/assetpacks'