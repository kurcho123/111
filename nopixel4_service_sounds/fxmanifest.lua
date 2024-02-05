fx_version 'adamant'
game "gta5"

files {
	"audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"sfx/**/*.awc"
}

lua54 'yes'

data_file "AUDIO_GAMEDATA" "audioconfig/taxi_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/taxi_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_taxi"

data_file "AUDIO_GAMEDATA" "audioconfig/phantom_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/phantom_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_phantom"
dependency '/assetpacks'