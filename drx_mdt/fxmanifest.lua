fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

author 'Deltarix'
description 'Made with love with the help of mk3ext'
version '1.3.1.4'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'configurables/server.lua',
  'server/bridge/**/*.lua',
  'server/closed/citizen/*.lua',
  'server/closed/pages/*.lua',
  'server/closed/staff/*.lua',
  'server/closed/utils/*.lua',
  'server/closed/*.lua',
}

client_scripts {
  'configurables/client.lua',
  'client/**/*.lua',
}

files {
  'web/index.html',
  'web/assets/*.js',
  'web/assets/*.css',
  'web/images/*.*',
  'web/images/**/*.*',
  'web/images/cameras/*.*',
  'configurables/*.json'
}

ui_page 'web/index.html'

dependencies {
  '/onesync',
  'oxmysql'
}

escrow_ignore {
  'configurables/client.lua',
  'configurables/server.lua',
  'server/bridge/**/*.lua',
  'client/bridge/**/*.lua',
}
dependency '/assetpacks'