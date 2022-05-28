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
            EnableSecondaryMarker = false,
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
            EnableSecondaryMarker = false,
            Blip = true,
            BlipType = 226,
            BlipColour = 0,
            BlipSize = 1.0,
            InsideShopPosition = {x = -47.5, y = -1097.2, z = 25.4, h = -20.0},
            DeliveryPosition = {x = -28.6, y = -1085.6, z = 25.5, h = 330.0},
        },
        --[[
        {
            Type = {'motorcycles', 'bikes'}, -- category of vehicles to buy || valid values => 'category' or 'all' or {'category1', 'category2', etc} or {'all'}
            ShopName = 'Original Motor Shop', -- name of the shop
            MarkerPosition = {x = -43.4, y = -1104.8, z = 26.4}, -- position of the shop marker to enter the shop menu
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0}, -- size of the shop marker to enter the shop menu
            MarkerRGB = {r = 0, g = 255, b = 255}, -- color of the shop marker to enter the shop menu
            MarkerDrawDistance = 20.0, -- draw distance of the shop marker to enter the shop menu
            MarkerType = 37, -- type of the shop marker to enter the shop menu
            EnableSecondaryMarker = false, -- if true, another marker will be automatically added under the MarkerPosition
            Blip = true, -- if true, a blip for current shop will be added on the map
            BlipType = 226, -- type of blip on map - only works if Blip is true
            BlipColour = 0, -- colour of blip on map - only works if Blip is true
            BlipSize = 1.0, -- size of blip on map - only works if Blip is true
            InsideShopPosition = {x = -47.5, y = -1097.2, z = 25.4, h = -20.0}, -- position where you will preview the vehicles of current shop
            DeliveryPosition = {x = -28.6, y = -1085.6, z = 25.5, h = 330.0}, -- position that the vehicle is spawned if the purchase is successful
        }
        ]]
    },

    SellZones = {
        {
            Type = {'sports', 'super'},
            MarkerPosition = {x = -36.29, y = -1088.59, z = 26.4},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 255, g = 0, b = 0},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            EnableSecondaryMarker = true,
            Blip = false,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            ResellPercentage = 50
        },
        {
            Type = {'motorcycles'},
            MarkerPosition = {x = -29.28, y = -1092.47, z = 26.4},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 255, g = 0, b = 0},
            MarkerDrawDistance = 20.0,
            MarkerType = 37,
            EnableSecondaryMarker = true,
            Blip = false,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            ResellPercentage = 50
        },
        {
            Type = {'bikes'},
            MarkerPosition = {x = -27.71, y = -1089.37, z = 26.4},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 255, g = 0, b = 0},
            MarkerDrawDistance = 20.0,
            MarkerType = 38,
            EnableSecondaryMarker = true,
            Blip = false,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            ResellPercentage = 50
        },
        --[[
        {
            Type = {'vans', 'suv', 'offroad'}, -- category of vehicles to sell || valid values => 'category' or 'all' or {'category1', 'category2', etc} or {'all'}
            MarkerPosition = {x = -27.71, y = -1089.37, z = 26.4}, -- position of the marker to enter the sell menu
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0}, -- size of the marker to enter the sell menu
            MarkerRGB = {r = 255, g = 0, b = 0}, -- color of the marker to enter the sell menu
            MarkerDrawDistance = 20.0, -- draw distance of the marker to enter the sell menu
            MarkerType = 38, -- type of the marker to enter the sell menu
            EnableSecondaryMarker = true, -- if true, another marker will be automatically added under the MarkerPosition
            Blip = false,-- if true, a blip for current vehicle delete zone will be added on the map
            BlipType = 326, -- type of blip on map - only works if Blip is true
            BlipColour = 0, -- colour of blip on map - only works if Blip is true
            BlipSize = 1.0, -- size of blip on map - only works if Blip is true
            ResellPercentage = 50 -- the percentage of original vehicle money will be added to player after the sale is successful
        }
        ]]
    }
}