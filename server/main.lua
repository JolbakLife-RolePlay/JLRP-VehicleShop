local vehicles, categories = {}, {}
local RESOURCENAME = GetCurrentResourceName()
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == RESOURCENAME then
        checkNumberOfPlateCharacters()
        getVehiclesAndCategories()
	end
end)

function checkNumberOfPlateCharacters()
    local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('['..RESOURCENAME..'] [^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
	end
end

function getVehiclesAndCategories()
    vehicles = MySQL.query.await('SELECT * FROM vehicles')
    categories = MySQL.query.await('SELECT * FROM vehicle_categories')
end

Core.RegisterServerCallback('JLRP-VehicleShop:getVehiclesAndCategories', function(source, cb)
    cb({vehicles = vehicles, categories = categories})
end)

function getVehicleFromModel(model)
	for i = 1, #vehicles do
		local vehicle = vehicles[i]
		if vehicle.model == model then
			return vehicle
		end
	end
	return
end

Core.RegisterServerCallback('JLRP-VehicleShop:isPlateTaken', function(source, cb, plate)
	cb(isPlateTaken(plate))
end)

Core.RegisterServerCallback('JLRP-VehicleShop:buyVehicle', function(source, cb, model)
	local xPlayer = Core.GetPlayerFromId(source)
    local vehicle = getVehicleFromModel(model)
	local modelPrice = vehicle.price
    local plate = GeneratePlate()

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		local response = InsertInDatabase(xPlayer, plate, vehicle)
        cb({success = response, plate = plate})
	else
		cb({success = false})
	end
end)

