local points, vehicles, categories = {}, {}, {}
local RESOURCENAME = GetCurrentResourceName()
local isInShopMenu = false
do
    for k, v in pairs(Config.Zones.ShopEntering) do
        if v.Blip and v.Blip == true then
            local blip = AddBlipForCoord(v.Position)

            SetBlipSprite (blip, v.BlipType or 326)
            SetBlipDisplay(blip, 2)
            SetBlipScale  (blip, v.BlipSize and (v.BlipSize + 0.0) or 1.0)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.ShopName)
            EndTextCommandSetBlipName(blip)
        end

        local x, y, z = table.unpack(v.Position)

        local zone = CircleZone:Create(v.Position, v.DrawDistace and (v.DrawDistace + 0.0) or 20.0, {
            name = RESOURCENAME..":CircleZone:"..k,
            useZ = true,
            debugPoly = false
        })

        zone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
            points[zone] = {point = zone:getCenter(), zone = zone, isInZone = isPointInside}
            if isPointInside then
                CreateThread(function()
                    local isTextUIShown = false
                    while points[zone].isInZone do
                        Wait(0)        
                        DrawMarker(v.MarkerType or 36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x or 1.5, v.Size.y or 1.5, v.Size.z or 1.5, v.RGB.r or 255, v.RGB.g or 255, v.RGB.b or 255, 50, false, true, 2, nil, nil, false)
                        if #(PolyZone.getPlayerPosition() - points[zone].point) <= 1.0 then
                            if not isTextUIShown then
                                TextUI('show', 'open_shop', {shop_name = v.ShopName})
                                isTextUIShown = true
                            end
                            if IsControlJustReleased(0, 38) and Framework.PlayerData.dead == false then
                                OpenMenu(v.Type)
                            end
                        else                        
                            if isTextUIShown then
                                TextUI('hide')
                                isTextUIShown = false
                            end
                        end
                    end
                end)
            end
        end, 2000)
    end
end

function OpenMenu(categoriesToShow)
    Framework.TriggerServerCallback('JLRP-VehicleShop:getVehiclesAndCategories', function(result)
		vehicles = result.vehicles
        categories = result.categories
	end)
    Wait(500)
    
    IsInShopMenu = true
    StartShopRestriction()
	Framework.UI.Menu.CloseAll()

    local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

    

    for t = 1, #categoriesToShow, 1 do
        for i = 1, #categories, 1 do
            if categoriesToShow[t] == categories[i].name then
                vehiclesByCategory[categories[i].name] = {}
                break
            end
        end  
    end
    
    

    for i = 1, #vehicles, 1 do
		if IsModelInCdimage(GetHashKey(vehicles[i].model)) then
            if vehiclesByCategory[vehicles[i].category] then
			    table.insert(vehiclesByCategory[vehicles[i].category], vehicles[i])
            end
		else
			print(('[JLRP-VehicleShop] [^3ERROR^7] Vehicle "%s" does not exist'):format(vehicles[i].model))
		end
	end
    
    for _, v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

    for i = 1, #categories, 1 do
        local category = categories[i]
        if vehiclesByCategory[category.name] then
            local categoryVehicles = vehiclesByCategory[category.name]
            local options          = {}

            for j = 1, #categoryVehicles, 1 do
                local vehicle = categoryVehicles[j]

                if i == 1 and j == 1 then
                    firstVehicleData = vehicle
                end

                table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _Locale('money_currency', Framework.Math.GroupDigits(vehicle.price))))
            end

            table.sort(options)

            table.insert(elements, {
                name    = category.name,
                label   = category.label,
                value   = 0,
                type    = 'slider',
                max     = #categories[i],
                options = options
            })
        end
	end
    
    print(Framework.Table.Dump(vehiclesByCategory))
end

function StartShopRestriction()
	CreateThread(function()
		while IsInShopMenu do
			Wait(0)
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

RegisterNetEvent('JLRP-VehicleShop:syncVehicles')
AddEventHandler('JLRP-VehicleShop:syncVehicles', function(vehicles)
	vehicles = vehicles
end)

RegisterNetEvent('JLRP-VehicleShop:syncCategories')
AddEventHandler('JLRP-VehicleShop:syncCategories', function(categories)
	categories = categories
end)

