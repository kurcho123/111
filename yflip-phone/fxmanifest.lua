fx_version "cerulean"

description "YFlip Phone(Early Access)"
author "TeamsGG Development"
version "0.8.0"

lua54 "yes"

games {
  "gta5",
  "rdr3"
}

ui_page "ui/build/index.html"

shared_scripts {
  "@ox_lib/init.lua",
  "shared/**/*.lua",
  "config/*.lua"
}

client_script "client/**/*.lua"

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "server/**/*.lua"
}

files {
  "ui/build/**/*",
  "config/*.json"
}

escrow_ignore {
  "config/**/*",

  "client/apps/framework/**/*.lua",
  "client/apps/framework/**/*.lua",
  "server/apps/framework/**/*.lua",
  "shared/*.lua",

  "client/custom/**/*.lua",
  "server/custom/**/*.lua"
}

dependency "ox_lib"

dependency '/assetpacks'