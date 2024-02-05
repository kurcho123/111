fx_version "cerulean"
version "1.0.12"
game "gta5"
author "17Movement"
this_is_a_map 'yes'
lua54 "yes"

ui_page "web/index.html"

files {
    "stream/vehicles/**/**.meta",
    "web/index.html",
    "web/assets/**/*.*",
}

shared_script "Config.lua"

server_scripts {
    "server/functions.lua",
    "server/server.lua",
}

client_scripts {
    "client/functions.lua",
    "client/target.lua",
    "client/client.lua",
}

escrow_ignore {
    "Config.lua",
    "client/target.lua",
    "client/functions.lua",
    "server/functions.lua",
}

data_file 'HANDLING_FILE'            'stream/vehicles/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE'    'stream/vehicles/**/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE'   'stream/vehicles/**/carvariations.meta'


data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_billboard_01.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_billboard_15.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_crane_frame.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_dock_crane.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_oil_derrick.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_oilrig_pipe.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_oilrig_smallpipe.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/17mov_basepill.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/docknt.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/drill2.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/drill2a.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/oilrig.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/oilrigmlo.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/oilrigmlo_2.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/platform1.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/platform2.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/v_int_59.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/ytyp/xm_x17dlc_props_base.ytyp')
dependency '/assetpacks'