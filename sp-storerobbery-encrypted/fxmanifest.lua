fx_version 'cerulean'
game 'gta5'
author 'Vank1ta - Sigma Development'
description 'Store Robbery'
version '1.0.1'
lua54 'yes'

shared_script 'shared/config.lua'

client_script {
    'client/cl_main.lua',
}

server_scripts {
    'server/sv_framework.lua',
    'server/sv_main.lua'
}

-- escrow_ignore {
-- 	'shared/config.lua'
-- }
dependency '/assetpacks'