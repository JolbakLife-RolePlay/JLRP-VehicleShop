Config = {}
Config.Locale = 'en'

Config.TextUI = 'ox_lib' -- valid values: 'jlrp' or 'ox_lib' or 'esx'
--[[
Config.Zones = {
    {
        Type = 'car',
        ShopName = 'Original Car Shop',
        ShopEntering = {
            Position = vector3(-33.7, -1102.0, 26.4),
            Size = {x = 1.5, y = 1.5, z = 1.0},
            RGB = {r = 255, g = 255, b = 255},
            DrawDistance = 20.0,
            MarkerType = 36,
            Blip = true,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0
        }
    }
}
]]
Config.Zones = {
    ShopEntering = {
        {
            Type = {'sports', 'super'},
            ShopName = 'Original Car Shop',
            Position = vector3(-33.7, -1102.0, 26.4),
            Size = {x = 1.5, y = 1.5, z = 1.0},
            RGB = {r = 255, g = 255, b = 255},
            DrawDistance = 20.0,
            MarkerType = 36,
            Blip = true,
            BlipType = 326,
            BlipColour = 0,
            BlipSize = 1.0
        }
    }
}