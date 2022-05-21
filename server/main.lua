local vehicles, categories = {}, {}
local RESOURCENAME = GetCurrentResourceName()
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == RESOURCENAME then
        getVehiclesAndCategories()
	end
end)

function getVehiclesAndCategories()
    vehicles = MySQL.query.await('SELECT * FROM vehicles')
    categories = MySQL.query.await('SELECT * FROM vehicle_categories')
end

Core.RegisterServerCallback('JLRP-VehicleShop:getVehiclesAndCategories', function(source, cb)
    cb({vehicles = vehicles, categories = categories})
end)