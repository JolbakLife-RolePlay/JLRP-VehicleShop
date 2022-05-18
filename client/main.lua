local points = {}
do
    for k, v in pairs(Config.Zones) do
        if v.ShopEntering.Blip and v.ShopEntering.Blip == true then
            local blip = AddBlipForCoord(v.ShopEntering.Position)

            SetBlipSprite (blip, v.ShopEntering.BlipType or 326)
            SetBlipDisplay(blip, 2)
            SetBlipScale  (blip, v.ShopEntering.BlipSize and (v.ShopEntering.BlipSize + 0.0) or 1.0)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(_U('car_dealer'))
            EndTextCommandSetBlipName(blip)
        end

        local x, y, z = table.unpack(v.ShopEntering.Position)

        local zone = CircleZone:Create(v.ShopEntering.Position, v.ShopEntering.DrawDistace and (v.ShopEntering.DrawDistace + 0.0) or 20.0, {
            name = GetCurrentResourceName()..":CircleZone:"..k,
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
                        DrawMarker(v.ShopEntering.MarkerType or 36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.ShopEntering.Size.x or 1.5, v.ShopEntering.Size.y or 1.5, v.ShopEntering.Size.z or 1.5, v.ShopEntering.RGB.r or 255, v.ShopEntering.RGB.g or 255, v.ShopEntering.RGB.b or 255, 50, false, true, 2, nil, nil, false)
                        if #(PolyZone.getPlayerPosition() - points[zone].point) <= 1.0 then
                            if not isTextUIShown then
                                TextUI('show', 'open_shop', {shop_name = v.ShopName})
                                isTextUIShown = true
                            end
                            if IsControlJustReleased(0, 38) then
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

function OpenMenu(type)
end