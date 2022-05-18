fx_version 'cerulean'

game 'gta5'
lua54 'yes'

name 'JLRP-VehicleShop'
author 'Mahan Moulaei'
discord 'Mahan#8183'
description 'JolbakLifeRP Vehicle Shop'

version '0.0'

shared_scripts {
    '@JLRP-Framework/imports.lua',
	'@JLRP-Framework/shared/locale.lua',
	'@ox_lib/init.lua',
	'locales/*.lua',
	'config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/CircleZone.lua',
	'client/utils.lua',
	'client/main.lua'
}

dependencies {
	'oxmysql',
	'JLRP-Framework',
}
