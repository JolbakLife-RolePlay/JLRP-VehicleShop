Config = {}
Config.Locale = 'en'

Config.TextUI = 'ox_lib' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
Config.Notification = 'jlrp' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
Config.ProgressBar = 'ox_lib' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
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
            TestDrive = {
                Enable = true,
                Time = 60,
                Position = {x = -28.6, y = -1085.6, z = 25.5, h = 330.0}
            },
			Buyable = true
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
            TestDrive = {
                Enable = true,
                Time = 60,
                Position = {x = -28.6, y = -1085.6, z = 25.5, h = 330.0}
            },
			Buyable = true
        },
        {
            Type = {'vip_rollsroyce'},
            ShopName = 'Rolls Royce Shop',
            MarkerPosition = {x = -1169.80, y = -730.18, z = 21.04},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 255, g = 255, b = 255},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            EnableSecondaryMarker = false,
            Blip = true,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            InsideShopPosition = {x = -1175.88, y = -733.84, z = 20.33, h = 223.0},
            DeliveryPosition = {x = -1174.20, y = -746.28, z = 20.31, h = 221.0},
            TestDrive = {
                Enable = true,
                Time = 10,
                Position = {x = -1142.29, y = -740.75, z = 19.28, h = 286.30}
            },
			Buyable = false
        },
        {
            Type = {'vip_audi', 'vip_bentley', 'vip_bmw', 'vip_bugatti', 'vip_chevrolet', 'vip_ferrari', 'vip_ford', 'vip_koenigsegg', 'vip_lamborghini', 'vip_mclaren', 'vip_mercedesbenz', 'vip_nissan', 'vip_porsche', 'vip_tesla'},
            ShopName = 'VIP Vehicle Shop',
            MarkerPosition = {x = 205.49, y = -179.11, z = 54.60},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 150, g = 255, b = 150},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            EnableSecondaryMarker = false,
            Blip = true,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            InsideShopPosition = {x = 219.06, y = -187.62, z = 53.88, h = 209.76},
            DeliveryPosition = {x = 216.52, y = -165.97, z = 56.00, h = 250.00},
            TestDrive = {
                Enable = true,
                Time = 30,
                Position = {x = 216.52, y = -165.97, z = 56.00, h = 250.00}
            },
			Buyable = false
        },
        {
            Type = {'persian_citroen', 'persian_ikco', 'persian_nissan', 'persian_peugeot', 'persian_saipa'},
            ShopName = 'Persian Vehicle Shop',
            MarkerPosition = {x = 1225.33, y = 2739.16, z = 37.99},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 150, g = 255, b = 150},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            EnableSecondaryMarker = false,
            Blip = true,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            InsideShopPosition = {x = 1225.04, y = 2732.35, z = 37.3, h = 272.12},
            DeliveryPosition = {x = 1200.51, y = 2726.46, z = 37.50, h = 260.8},
            TestDrive = {
                Enable = true,
                Time = 30,
                Position = {x = 1200.51, y = 2726.46, z = 37.50, h = 260.8}
            },
			Buyable = true
        },
        {
            Type = {'persian_citroen', 'persian_ikco', 'persian_nissan', 'persian_peugeot', 'persian_saipa'},
            ShopName = 'Real Vehicle Shop',
            MarkerPosition = {x = -798.12, y = -210.17, z = 37.06},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 150, g = 255, b = 255},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            EnableSecondaryMarker = false,
            Blip = true,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            InsideShopPosition = {x = 1225.04, y = 2732.35, z = 37.3, h = 272.12},
            DeliveryPosition = {x = 1200.51, y = 2726.46, z = 37.50, h = 260.8},
            TestDrive = {
                Enable = true,
                Time = 30,
                Position = {x = 1200.51, y = 2726.46, z = 37.50, h = 260.8}
            },
			Buyable = true
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
            TestDrive = {
                Enable = true, -- enables/disables the test drive functionality for current shop
                Time = 60, -- time of the test drive is seconds - only works if Enable is true
                Position = {x = -28.6, y = -1085.6, z = 25.5, h = 330.0}
            },
            Buyable = true -- let the player buy vehicles from current shop or not. useful when you plan to ask for real-life money from players instead of in-game money for some vehicles
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
        {
            Type = {'vip_rollsroyce'},
            MarkerPosition = {x = -1142.26, y = -732.738, z = 20.45},         
            MarkerSize = {x = 1.5, y = 1.5, z = 1.0},
            MarkerRGB = {r = 255, g = 0, b = 0},
            MarkerDrawDistance = 20.0,
            MarkerType = 36,
            EnableSecondaryMarker = true,
            Blip = false,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0,
            ResellPercentage = 40
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