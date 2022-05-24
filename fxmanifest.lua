fx_version 'cerulean'
use_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

name 'JLRP-VehicleShop'
author 'Mahan Moulaei'
discord 'Mahan#8183'
description 'JolbakLifeRP Vehicle Shop'

version '0.0'

shared_scripts {
	'@JLRP-Framework/shared/locale.lua',
	'@ox_lib/init.lua',
	'shared/utils.lua',
	'locales/*.lua',
	'config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'client/main.lua'
}

dependencies {
	'oxmysql',
	'JLRP-Framework',
}

provides {
	'esx_vehicleshop'
}