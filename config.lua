Config = {}
Config.Locale = 'en'

Config.TextUI = 'ox_lib' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
Config.Notification = 'ox_lib' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
Config.MenuAlignment = 'right'
Config.Zones = {
    ShopEntering = {
        {
            Type = {'sports', 'super'},
            ShopName = 'Original Car Shop',
            MarkerPosition = {x = -33.7, y = -1102.0, z = 26.4},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 255, g = 255, b = 255},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            Blip = true,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            InsideShopPosition = {x = -47.5, y = -1097.2, z = 25.4, h = -20.0},
        }
    }
}