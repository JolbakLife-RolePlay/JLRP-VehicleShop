local points, vehicles, categories = {}, {}, {}
local RESOURCENAME = GetCurrentResourceName()
local isInShopMenu = false
do
    while Core == nil do Wait(100) end
    for k, v in pairs(Config.Zones.Shops) do

        local marker = vec(v.MarkerPosition.x, v.MarkerPosition.y, v.MarkerPosition.z)
        if v.Blip and v.Blip == true then
            local blip = AddBlipForCoord(marker)

            SetBlipSprite (blip, v.BlipType or 326)
            SetBlipDisplay(blip, 2)
            SetBlipScale  (blip, v.BlipSize and (v.BlipSize + 0.0) or 1.0)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.ShopName)
            EndTextCommandSetBlipName(blip)
        end

        local zone = CircleZone:Create(marker, v.MarkerDrawDistance and (v.MarkerDrawDistance + 0.0) or 20.0, {
            name = RESOURCENAME..":ShopsCircleZone:"..k,
            useZ = true,
            debugPoly = false
        })
        
        if v.Type then
            if type(v.Type) == 'string' then
                local _temp = v.Type
                v.Type = {}
                v.Type[1] = _temp
            elseif type(v.Type) == 'table' then
                for t = 1, #v.Type, 1 do
                    if v.Type[t] == 'all' then
                        table.wipe(v.Type)
                        v.Type = {}
                        v.Type[1] = 'all'
                        break
                    end
                end
            end
        else
            v.Type = {}
            v.Type[1] = 'all'
        end

        zone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
            points[zone] = {point = zone:getCenter(), zone = zone, isInZone = isPointInside}
            if isPointInside then
                CreateThread(function()
                    local isTextUIShown = false
                    while points[zone].isInZone do
                        Wait(0)        
                        DrawMarker(v.MarkerType or 36, v.MarkerPosition.x, v.MarkerPosition.y, v.MarkerPosition.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.MarkerSize.x or 1.5, v.MarkerSize.y or 1.5, v.MarkerSize.z or 1.5, v.MarkerRGB.r or 255, v.MarkerRGB.g or 255, v.MarkerRGB.b or 255, 50, false, true, 2, nil, nil, false)
                        if #(PolyZone.getPlayerPosition() - points[zone].point) <= 1.5 and IsPedOnFoot(PlayerPedId()) then
                            if not isTextUIShown then
                                TextUI('show', 'open_shop', {shop_name = v.ShopName})
                                isTextUIShown = true
                            end
                            if IsControlJustReleased(0, 38) and Core.GetPlayerData().dead == false then
                                OpenMenu(v.Type, v.InsideShopPosition, v.ShopName, v.MarkerPosition, v.DeliveryPosition)
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

    for k, v in pairs(Config.Zones.SellZones) do

        local marker = vec(v.MarkerPosition.x, v.MarkerPosition.y, v.MarkerPosition.z)
        if v.Blip and v.Blip == true then
            local blip = AddBlipForCoord(marker)

            SetBlipSprite (blip, v.BlipType or 326)
            SetBlipDisplay(blip, 2)
            SetBlipScale  (blip, v.BlipSize and (v.BlipSize + 0.0) or 1.0)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(_Locale('sell_blip'))
            EndTextCommandSetBlipName(blip)
        end   

        local zone = CircleZone:Create(marker, v.MarkerDrawDistance and (v.MarkerDrawDistance + 0.0) or 20.0, {
            name = RESOURCENAME..":SellZonesCircleZone:"..k,
            useZ = true,
            debugPoly = false
        })
        
        local acceptedTypes

        if v.Type then
            if type(v.Type) == 'string' then
                local _temp = v.Type
                v.Type = {}
                v.Type[1] = _temp
            elseif type(v.Type) == 'table' then
                for t = 1, #v.Type, 1 do
                    if v.Type[t] == 'all' then
                        table.wipe(v.Type)
                        v.Type = {}
                        v.Type[1] = 'all'
                        break
                    end
                end
            end
        else
            v.Type = {}
            v.Type[1] = 'all'
        end

        zone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
            points[zone] = {point = zone:getCenter(), zone = zone, isInZone = isPointInside}
            if isPointInside then
                CreateThread(function()
                    local isTextUIShown = false
                    while points[zone].isInZone do
                        Wait(0)        
                        DrawMarker(v.MarkerType or 36, v.MarkerPosition.x, v.MarkerPosition.y, v.MarkerPosition.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.MarkerSize.x or 1.5, v.MarkerSize.y or 1.5, v.MarkerSize.z or 1.5, v.MarkerRGB.r or 255, v.MarkerRGB.g or 255, v.MarkerRGB.b or 255, 50, false, true, 2, nil, nil, false)
                        DrawMarker(1, v.MarkerPosition.x, v.MarkerPosition.y, v.MarkerPosition.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.MarkerSize.x + 1.0, v.MarkerSize.y + 1.0, 0.5, v.MarkerRGB.r or 255, v.MarkerRGB.g or 255, v.MarkerRGB.b or 255, 50, false, true, 2, nil, nil, false)
                        if #(PolyZone.getPlayerPosition() - points[zone].point) <= 1.5 and not IsPedOnFoot(PlayerPedId()) then
                            if not isTextUIShown then
                                TextUI('show', 'open_sell', {shop_name = _Locale('sell_blip'), accepted_types = acceptedTypes})
                                isTextUIShown = true
                            end
                            if IsControlJustReleased(0, 38) and Core.GetPlayerData().dead == false then
                                --OpenMenu(v.Type, v.InsideShopPosition, v.ShopName, v.MarkerPosition, v.DeliveryPosition)
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

function OpenMenu(categoriesToShow, insideShopPosition, shopName, markerPosition, deliveryPosition)
    Core.TriggerServerCallback('JLRP-VehicleShop:getVehiclesAndCategories', function(result)
		vehicles = result.vehicles
        categories = result.categories
	end)
    Wait(500)
    
    isInShopMenu = true
    StartShopRestriction()
	Core.UI.Menu.CloseAll()

    local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil
    local isFirstvehicleDataSet = false

    if categoriesToShow[1] == 'all' then
        for i = 1, #categories, 1 do
            vehiclesByCategory[categories[i].name] = {}
        end  
    else
        for t = 1, #categoriesToShow, 1 do
            for i = 1, #categories, 1 do
                if categoriesToShow[t] == categories[i].name then
                    vehiclesByCategory[categories[i].name] = {}
                    break
                end
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
            local options = {}

            for j = 1, #categoryVehicles, 1 do
                local vehicle = categoryVehicles[j]

                if not isFirstvehicleDataSet then
                    firstVehicleData = vehicle
                    isFirstvehicleDataSet = true
                end

                table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _Locale('money_currency', Core.Math.GroupDigits(vehicle.price))))
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
    
    local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, vec(insideShopPosition.x, insideShopPosition.y, insideShopPosition.z))

    Core.UI.Menu.Open('default', RESOURCENAME, 'vehicle_shop', {
		title    = shopName,
		align    = Config.MenuAlignment,
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		Core.UI.Menu.Open('default', RESOURCENAME, 'shop_confirm', {
			title = _Locale('buy_vehicle_shop', vehicleData.name, Core.Math.GroupDigits(vehicleData.price)),
			align = Config.MenuAlignment,
			elements = {
				{label = _Locale('no'),  value = 'no'},
				{label = _Locale('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' then
                Core.TriggerServerCallback('JLRP-VehicleShop:buyVehicle', function(result)
                    if result.success == true then
                        isInShopMenu = false
                        menu2.close()
                        menu.close()
                        DeleteDisplayVehicle()
                        
                        Core.Game.SpawnVehicle(vehicleData.model, vec(deliveryPosition.x, deliveryPosition.y, deliveryPosition.z), deliveryPosition.h, function(vehicle)
                            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                            SetVehicleNumberPlateText(vehicle, result.plate)
                            FreezeEntityPosition(playerPed, false)
                            SetEntityVisible(playerPed, true)
                        end)

                        Notification('success', _Locale('purchase_successful', vehicleData.name, result.plate), {shop_name = shopName})
                    else
                        Notification('error', _Locale('not_enough_money'), {shop_name = shopName})
                    end
                end, vehicleData.model)
                
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicle()
		local playerPed = PlayerPedId()

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, vec(markerPosition.x, markerPosition.y, markerPosition.z))

		isInShopMenu = false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicle()
		WaitForVehicleToLoad(vehicleData.model)

		Core.Game.SpawnLocalVehicle(vehicleData.model, vec(insideShopPosition.x, insideShopPosition.y, insideShopPosition.z), insideShopPosition.h, function(vehicle)
            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            FreezeEntityPosition(vehicle, true)
        end)
	end)

	DeleteDisplayVehicle()
	WaitForVehicleToLoad(firstVehicleData.model)

	Core.Game.SpawnLocalVehicle(firstVehicleData.model, vec(insideShopPosition.x, insideShopPosition.y, insideShopPosition.z), insideShopPosition.h, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)
end

function StartShopRestriction()
	CreateThread(function()
		while isInShopMenu do
			Wait(0)
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

function WaitForVehicleToLoad(model)
	--local modelHash = GetHashKey(model)
    RequestModel(model)
	if not HasModelLoaded(model) then
        DisableKeymanager(true)
		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(_Locale('awaiting_model'))
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(model) do
			Wait(0)
			DisableAllControlActions(0)
		end
		BusyspinnerOff()
        DisableKeymanager(false)
	end
end

function DeleteDisplayVehicle()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if DoesEntityExist(vehicle) then
        Core.Game.DeleteVehicle(vehicle)
    end
end