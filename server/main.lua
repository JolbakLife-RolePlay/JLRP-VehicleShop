local vehicles, categories = {}, {}
local RESOURCENAME = GetCurrentResourceName()
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == RESOURCENAME then
        --sendVehiclesAndCategoriesToCLient()
        getVehiclesAndCategories()
	end
end)

function getVehiclesAndCategories()
    vehicles = MySQL.query.await('SELECT * FROM vehicles')
    categories = MySQL.query.await('SELECT * FROM vehicle_categories')
end

function sendVehiclesAndCategoriesToCLient()
    categories = MySQL.query.await('SELECT * FROM vehicle_categories')
    vehicles = MySQL.query.await('SELECT * FROM vehicles')
    TriggerClientEvent('JLRP-VehicleShop:syncVehicles', -1, vehicles)
    TriggerClientEvent('JLRP-VehicleShop:syncCategories', -1, categories)
end

Framework.RegisterServerCallback('JLRP-VehicleShop:getVehiclesAndCategories', function(source, cb)
    cb({vehicles = vehicles, categories = categories})
end)