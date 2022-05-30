if Config.TransferVehicle.Enable == true then
    Core.RegisterCommand(Config.TransferVehicle.Command, 'user', function(xPlayer, args, showError)

        if xPlayer.source == args.playerId.source then showError(_U('cannot_transfer_to_self')) return end

        local playerPed = GetPlayerPed(xPlayer.source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if vehicle == 0 then showError(_U('not_in_vehicle')) return end
        local plate = Core.Math.Trim(GetVehicleNumberPlateText(vehicle))
        local model = GetEntityModel(vehicle)

        local targetPed = GetPlayerPed(args.playerId.source)

        local response = SelectVehicleFromDatabase(xPlayer, model, plate)
        if response then
            if #(GetEntityCoords(playerPed) - GetEntityCoords(targetPed)) <= Config.TransferVehicle.DistanceToTargetPlayer + 0.0 then
                local result = TransferOwnedVehicle(plate, args.playerId)
                if result then
                    xPlayer.showNotification(_U('self_transfer_successful', plate, GetPlayerName(args.playerId.source), args.playerId.source))
                    args.playerId.showNotification(_U('target_transfer_successful', GetPlayerName(xPlayer.source), xPlayer.source, plate))
                else
                    showError(_U('error_in_transfer'))
                end
            else
                showError(_U('target_too_far'))
            end
        else
            showError(_U('not_yours'))
        end
    end, false, {help = _U('command_transfervehicle'), validate = true, arguments = {
        {name = 'playerId', help = _U('command_playerid'), type = 'player'}
    }})
end