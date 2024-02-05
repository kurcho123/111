fx_version          "bodacious"
game                "gta5"
author              "0Resmon"
discord             "discord.gg/0resmon"
description         "Created for 0Resmon Resources"

creator "Kibra"

client_scripts {
    "modules/client/main.lua",
    "modules/client/events.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "modules/server/main.lua",
    "modules/server/events.lua"
}

escrow_ignore {
    "config.lua"
}

ui_page "web/index.html"

files {
    "web/index.html",
    "web/sound.mp3",
    "web/index.js",
    "web/style.css"
}

shared_scripts {
    "config.lua",
    "shared/common.lua",
}

lua54 "yes"
dependency '/assetpacks'