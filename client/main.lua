local points, vehicles, categories = {}, {}, {}
local isInShopMenu, isThreadActive, isInAnyZone = false, false, false

do
    while RESOURCENAME ~= 'JLRP-VehicleShop' do print('Change the resource name to \'JLRP-VehicleShop\'; Otherwise it won\'t start!') Wait(5000) end
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

        v.MarkerDrawDistance = v.MarkerDrawDistance and (v.MarkerDrawDistance + 0.0) or 20.0

        local zone = CircleZone:Create(marker, v.MarkerDrawDistance, {
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

        points[zone] = {point = zone:getCenter(), zone = v, isInZone = false, type = 'shop'}

        zone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
            points[zone].isInZone = isPointInside
            isInAnyZone = IsInAnyZone()
            if isPointInside then
                RunThread()
            end
        end, 2000)
    end

    for k, v in pairs(Config.Zones.SellZones) do

        local marker = vec(v.MarkerPosition.x, v.MarkerPosition.y, v.MarkerPosition.z)
        if v.Blip and v.Blip == true then
            local blip = AddBlipForCoord(marker)

            SetBlipSprite(blip, v.BlipType or 326)
            SetBlipDisplay(blip, 2)
            SetBlipScale(blip, v.BlipSize and (v.BlipSize + 0.0) or 1.0)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(_U('sell_blip'))
            EndTextCommandSetBlipName(blip)
        end
        
        v.MarkerDrawDistance = v.MarkerDrawDistance and (v.MarkerDrawDistance + 0.0) or 20.0

        local zone = CircleZone:Create(marker, v.MarkerDrawDistance, {
            name = RESOURCENAME..":SellZonesCircleZone:"..k,
            useZ = true,
            debugPoly = false
        })
        
        local acceptedTypes = ''

        if v.Type then
            if type(v.Type) == 'string' then
                local _temp = v.Type
                v.Type = {}
                v.Type[1] = _temp
                acceptedTypes = v.Type[1]
            elseif type(v.Type) == 'table' then
                for t = 1, #v.Type, 1 do
                    acceptedTypes = acceptedTypes..v.Type[t]..', '
                    if v.Type[t] == 'all' then
                        table.wipe(v.Type)
                        v.Type = {}
                        v.Type[1] = 'all'
                        acceptedTypes = v.Type[1]
                        break
                    end
                end

                local length = string.len(acceptedTypes)
                local _temp = string.sub(acceptedTypes, length-1, length)
                if _temp == ', ' then
                    acceptedTypes = string.sub(acceptedTypes, 1, length - 2)
                end
            end
        else
            v.Type = {}
            v.Type[1] = 'all'
            acceptedTypes = v.Type[1]
        end

        points[zone] = {point = zone:getCenter(), zone = v, isInZone = false, accepted_types = acceptedTypes, type = 'sell'}

        zone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
            points[zone].isInZone = isPointInside
            isInAnyZone = IsInAnyZone()
            if isPointInside then
                RunThread()
            end
        end, 2000)
    end
end

function OpenShopMenu(categoriesToShow, insideShopPosition, shopName, markerPosition, deliveryPosition)
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
			print(('['..RESOURCENAME..'] [^3ERROR^7] Vehicle "%s" does not exist'):format(vehicles[i].model))
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

                table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('money_currency', Core.Math.GroupDigits(vehicle.price))))
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
			title = _U('buy_vehicle_shop', vehicleData.name, Core.Math.GroupDigits(vehicleData.price)),
			align = Config.MenuAlignment,
			elements = {
				{label = _U('no'),  value = 'no'},
				{label = _U('yes'), value = 'yes'}
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

                        Notification('success', _U('purchase_successful', vehicleData.name, result.plate), {shop_name = shopName})
                    else
                        Notification('error', _U('not_enough_money'), {shop_name = shopName})
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
    RequestModel(model)
	if not HasModelLoaded(model) then
        DisableKeymanager(true)
		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(_U('awaiting_model'))
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

function OpenSellMenu(categoriesToSell, acceptedCategories)
    local callback = 'waiting'
    isInShopMenu = true
    StartShopRestriction()
	Core.UI.Menu.CloseAll()

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local plate = Core.Math.Trim(GetVehicleNumberPlateText(vehicle))

    FreezeEntityPosition(vehicle, true)

    Core.TriggerServerCallback('JLRP-VehicleShop:getVehiclePriceAndType', function(result)
        if result then
            if categoriesToSell[1] ~= 'all' then
                local shouldContinue = false
                for t = 1, #categoriesToSell, 1 do
                    if categoriesToSell[t] == result.category then
                        shouldContinue = true
                        break
                    end
                end
                if not shouldContinue then 
                    Notification('info', _U('cannot_sell_here', acceptedCategories))
                    FreezeEntityPosition(vehicle, false)
                    isInShopMenu = false
                    return
                end
            end
            local price = result.price / 100 * Config.ResellPercentage
            Core.UI.Menu.Open('default', RESOURCENAME, 'vehicle_shop_sell', {
                title    = _U('sell_vehicle', Core.Math.GroupDigits(price)),
                align    = Config.MenuAlignment,
                elements = {
                    {label = _U('no'),  value = 'no'},
                    {label = _U('yes'), value = 'yes'}
                }
            }, function(data, menu)
                if data.current.value == 'yes' then
                    Core.TriggerServerCallback('JLRP-VehicleShop:sellVehicle', function(result)
						if result then
							Core.Game.DeleteVehicle(vehicle)
                            Notification('success', _U('vehicle_sold_for', Core.Math.GroupDigits(price)))
                            isInShopMenu = false
                            menu.close()
						else
                            Notification('error', _U('not_yours'))
						end
					end, GetEntityModel(vehicle), plate)
                else
                    FreezeEntityPosition(vehicle, false)
                    isInShopMenu = false
                    menu.close()
                end
            end, function(data, menu)
                FreezeEntityPosition(vehicle, false)
                isInShopMenu = false
                menu.close()
            end)
        end
    end, GetEntityModel(vehicle))
end



function IsInAnyZone()
    for _, v in pairs(points) do
        if v.isInZone == true then
            return true
        end
    end
    return false
end

function RunThread()
    if not isThreadActive then
        isThreadActive = true
        Citizen.CreateThreadNow(function()
            local isTextUIShown, textUIIsBeingShownInK = false
            local PlayerPed
            local PlayerCoords
            local distance
            while isInAnyZone do
                PlayerPed = PlayerPedId()
                PlayerCoords = GetEntityCoords(PlayerPed)
                for k, v in pairs(points) do
                    distance = #(v.point - PlayerCoords)
                    if v.isInZone == true and (distance <= v.zone.MarkerDrawDistance) then
                        DrawMarker(v.zone.MarkerType or 36, v.zone.MarkerPosition.x, v.zone.MarkerPosition.y, v.zone.MarkerPosition.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.zone.MarkerSize.x or 1.5, v.zone.MarkerSize.y or 1.5, v.zone.MarkerSize.z or 1.5, v.zone.MarkerRGB.r or 255, v.zone.MarkerRGB.g or 255, v.zone.MarkerRGB.b or 255, 50, false, true, 2, nil, nil, false)
                        if v.zone.EnableSecondaryMarker and v.zone.EnableSecondaryMarker == true then
                            DrawMarker(1, v.zone.MarkerPosition.x, v.zone.MarkerPosition.y, v.zone.MarkerPosition.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.zone.MarkerSize.x + 1.0, v.zone.MarkerSize.y + 1.0, 0.5, v.zone.MarkerRGB.r or 255, v.zone.MarkerRGB.g or 255, v.zone.MarkerRGB.b or 255, 50, false, true, 2, nil, nil, false)
                        end
                        if distance <= 1.5 and (v.type == 'shop' and IsPedOnFoot(PlayerPed) or v.type == 'sell' and not IsPedOnFoot(PlayerPed)) then
                            if not isTextUIShown then
                                if v.type == 'shop' then
                                    TextUI('show', 'open_shop', {shop_name = v.zone.ShopName})
                                elseif v.type == 'sell' then
                                    TextUI('show', 'open_sell', {shop_name = _U('sell_blip'), accepted_types = v.accepted_types})
                                end
                                isTextUIShown = true
                                textUIIsBeingShownInK = k
                            end
                            if IsControlJustReleased(0, 38) and Core.PlayerData.dead == false then
                                if v.type == 'shop' then
                                    OpenShopMenu(v.zone.Type, v.zone.InsideShopPosition, v.zone.ShopName, v.zone.MarkerPosition, v.zone.DeliveryPosition)
                                elseif v.type == 'sell' then
                                    OpenSellMenu(v.zone.Type, v.accepted_types)
                                end     
                            end
                        else
                            if isTextUIShown and textUIIsBeingShownInK and textUIIsBeingShownInK == k then
                                TextUI('hide')
                                isTextUIShown = false
                                textUIIsBeingShownInK = nil
                            end
                        end
                    end
                end
                Wait(0)
            end
            isThreadActive = false
            if isTextUIShown then TextUI('hide') end
        end)
    end
end

