fx_version 'adamant'
game "gta5"

files {
	"audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"sfx/**/*.awc"
}

lua54 'yes'

data_file "AUDIO_GAMEDATA" "audioconfig/lg169benzom352_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg169benzom352_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg169benzom352"
dependency '/assetpacks'