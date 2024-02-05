fx_version 'cerulean'
game {'gta5'}
author 'Uyuyorum'
description 'Uyuyorum Loading Screen'
version '1.0.0'
loadscreen 'ui/loading.html'
files { 
		'config.js',
		'ui/loading.html',
		'ui/assets/img/bg/*.png',
		'ui/assets/img/bg/*.jpg',
		'ui/assets/img/*.png',
		'ui/assets/img/*.jpg',
		'ui/assets/css/*.css',
		'ui/assets/js/*.js',
		'ui/assets/audio/*.mp3',
		'ui/assets/audio/*.mp4',
		-- 'ui/assets/video/*.webm',
		'ui/assets/video/*.mp4',
	}
server_script {'steamkey.lua'}