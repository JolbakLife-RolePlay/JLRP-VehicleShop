FRAMEWORK = nil -- To Store the metadata of exports
FRAMEWORKNAME = nil
Core = nil
do
    if GetResourceState('JLRP-Framework') ~= 'missing' then
        FRAMEWORKNAME = 'JLRP-Framework'
        FRAMEWORK = exports[FRAMEWORKNAME]
        Core = FRAMEWORK:GetFrameworkObjects()
    elseif GetResourceState('es_extended') ~= 'missing' then
        FRAMEWORKNAME = 'es_extended'
        FRAMEWORK = exports[FRAMEWORKNAME]
        Core = FRAMEWORK:getSharedObject()
    end
end

if not IsDuplicityVersion() then -- Only register the body of if in client

    function TextUI(type, reason, extra)
        if type == 'show' then
            local message = '[E]'
            if reason == 'open_shop' then
                message = _Locale('open_shop', extra.shop_name)
            elseif reason == 'open_sell' then
                if extra.accepted_types == 'all' then extra.accepted_types = _Locale('all_vehicles') end
                message = _Locale('sell_zone', extra.accepted_types)
            end
            if Config.TextUI == 'jlrp' or Config.TextUI == 'esx' then
                Core.TextUI(message, type)
            elseif Config.TextUI == 'ox_lib' then
                lib.showTextUI(message, {
                    position = 'left-center', 
                    style = {
                        backgroundColor = '#020040', 
                        color = white, 
                        borderColor = '#d90000', 
                        borderWidth = 2
                    }
                })
            end
        elseif type == 'hide' then
            if Config.TextUI == 'jlrp' or Config.TextUI == 'esx' then
                Core.HideUI()
            elseif Config.TextUI == 'ox_lib' then
                lib.hideTextUI()
            end
        end
    end
    
    function Notification(type, message, extra)
        if Config.Notification == 'jlrp' or Config.Notification == 'esx' then
            Core.ShowNotification(message, type, 3000)
        elseif Config.Notification == 'ox_lib' then
            lib.notify({
                title = extra.shop_name or '',
                description = message,
                position = 'left-center',
                style = {
                    backgroundColor = '#020040',
                    color = white,
                    borderColor = '#d90000',
                    borderWidth = 2
                },
                icon = type == 'success' and 'IoCheckmarkDoneCircleOutline' or type == 'error' and 'RiErrorWarningLine' or 'FcInfo',
                iconColor = type == 'success' and '#09e811' or type == 'error' and '#d90000' or '#12d0ff'
            })
        end
    end
    
    function DisableKeymanager(state)
        if FRAMEWORKNAME == 'JLRP-Framework' then
            FRAMEWORK:disableControl(state)
        end
    end

else -- Only register the body of else in server

    function isPlateTaken(plate)
        MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
        function(result)
            return (result ~= nil)
        end)
    end

    function InsertInDatabase(xPlayer, plate, vehicle)
        local response = false
        if FRAMEWORKNAME == 'JLRP-Framework' then
            local id = MySQL.insert.await('INSERT INTO owned_vehicles (owner, owner_identifier, plate, vehicle, type) VALUES (?, ?, ?, ?, ?)', {
                xPlayer.citizenid,
                xPlayer.identifier,
                plate,
                json.encode({model = vehicle.model, plate = plate}),
                vehicle.category
            })
            if id then response = true end
        elseif FRAMEWORKNAME == 'es_extended' then
            local id = MySQL.insert.await('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (?, ?, ?, ?)', {
                xPlayer.identifier,
                plate,
                json.encode({model = vehicle.model, plate = plate}),
                vehicle.category
            })
            if id then response = true end
        end
        return response
    end

    function SelectVehicleFromDatabase(xPlayer, model, plate)
        local response = false

        if FRAMEWORKNAME == 'JLRP-Framework' then
            local result = MySQL.single.await('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.citizenid, plate})
            if result then -- does the owner match?
                local vehicle = json.decode(result.vehicle)
                if GetHashKey(vehicle.model) == model then
                    if vehicle.plate == plate then
                        response = true
                    else
                        print(('[JLRP-VehicleShop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.citizenid))
                        response = false
                    end
                else
                    print(('[JLRP-VehicleShop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.citizenid))
                    response = false
                end
            end
        elseif FRAMEWORKNAME == 'es_extended' then
            local result = MySQL.single.await('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate})
            if result then -- does the owner match?
                local vehicle = json.decode(result.vehicle)
                if GetHashKey(vehicle.model) == model then
                    if vehicle.plate == plate then
                        response = true
                    else
                        print(('[JLRP-VehicleShop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
                        response = false
                    end
                else
                    print(('[JLRP-VehicleShop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
                    response = false
                end
            end
        end
        return response
    end

    function RemoveOwnedVehicle(plate)
        local response = false
        local result = MySQL.update.await('DELETE FROM owned_vehicles WHERE plate = ?', {plate})
        if result then response = true end
        return response
    end

end

local NumberCharset = {}
local Charset = {}
local isPlateBeingGenerated = false

if FRAMEWORKNAME ~= 'JLRP-Framework' then
    for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

    for i = 65,  90 do table.insert(Charset, string.char(i)) end
    for i = 97, 122 do table.insert(Charset, string.char(i)) end
end

-- register this for both server and client
function GeneratePlate()
    while isPlateBeingGenerated == true do Wait(0) end
    isPlateBeingGenerated = true
    local generatedPlate
    local doBreak = 'waiting'

	while true do
		Wait(0)
		math.randomseed(GetGameTimer())
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
		end

        if not IsDuplicityVersion() then
            Core.TriggerServerCallback('JLRP-VehicleShop:isPlateTaken', function(isPlateTaken)
                doBreak = isPlateTaken
            end, generatedPlate)
            while type(doBreak) == 'string' do Wait(0) end
            doBreak = not doBreak
        else
            doBreak = not isPlateTaken(generatedPlate)
        end
		
		if doBreak == true then
			break
		end
	end
    isPlateBeingGenerated = false
    return generatedPlate
end

function GetRandomNumber(length)
    if FRAMEWORKNAME == 'JLRP-Framework' then
        return Core.Integer.Random(length)
    end

    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end

function GetRandomLetter(length)
    if FRAMEWORKNAME == 'JLRP-Framework' then
        return Core.String.Random(length)
    end

    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

exports('GeneratePlate', function() -- for compatibility with esx - works on both server and client
	return GeneratePlate()
end)