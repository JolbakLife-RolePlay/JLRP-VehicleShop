Config = {}
Config.Locale = 'en'

Config.TextUI = 'ox_lib' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
Config.Notification = 'jlrp' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
Config.MenuAlignment = 'right'

-- looks like this: 'LLL 111'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 4
Config.PlateNumbers  = 4
Config.PlateUseSpace = false

Config.Zones = {
    Shops = {
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
            DeliveryPosition = {x = -28.6, y = -1085.6, z = 25.5, h = 330.0},
        },
        {
            Type = {'motorcycles', 'bikes'},
            ShopName = 'Original Motor Shop',
            MarkerPosition = {x = -43.4, y = -1104.8, z = 26.4},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 0, g = 255, b = 255},
            MarkerDrawDistance = 20.0,
            MarkerType = 37,
            Blip = true,
            BlipType = 226,
            BlipColour = 0,
            BlipSize = 1.0,
            InsideShopPosition = {x = -47.5, y = -1097.2, z = 25.4, h = -20.0},
            DeliveryPosition = {x = -28.6, y = -1085.6, z = 25.5, h = 330.0},
        }
    },

    SellZones = {
        {
            Type = {'sports', 'all'},
            MarkerPosition = {x = -36.29, y = -1088.59, z = 26.4},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 255, g = 0, b = 0},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            Blip = false,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
        }
    }
}