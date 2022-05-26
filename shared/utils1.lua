FRAMEWORK = nil -- To Store the metadata of exports
FRAMEWORKNAME = nil
Core = nil
RESOURCENAME = GetCurrentResourceName()

if IsDuplicityVersion() then -- Only register the body of else in server

    function isPlateTaken(plate)
        local result = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate})
        return (result ~= nil)
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
                        print(('['..RESOURCENAME..'] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.citizenid))
                        response = false
                    end
                else
                    print(('['..RESOURCENAME..'] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.citizenid))
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
                        print(('['..RESOURCENAME..'] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
                        response = false
                    end
                else
                    print(('['..RESOURCENAME..'] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
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