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
                message = _U('open_shop', extra.shop_name)
            elseif reason == 'open_sell' then
                if extra.accepted_types == 'all' then extra.accepted_types = _U('all_vehicles') end
                message = _U('sell_zone', extra.accepted_types)
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

    if FRAMEWORKNAME == 'JLRP-Framework' then
        RegisterNetEvent('JLRP-Framework:playerLoaded')
        AddEventHandler('JLRP-Framework:playerLoaded', function(xPlayer, isNew, skin)
            Core.PlayerLoaded = true
            Core.PlayerData = xPlayer
        end)

        AddEventHandler('JLRP-Framework:setPlayerData', function(key, val, last)
            if GetInvokingResource() == FRAMEWORKNAME then
                Core.PlayerData[key] = val
            end
        end)
    elseif FRAMEWORKNAME == 'es_extended' then
        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
            Core.PlayerLoaded = true
            Core.PlayerData = xPlayer
        end)

        AddEventHandler('esx:setPlayerData', function(key, val, last)
            if GetInvokingResource() == FRAMEWORKNAME then
                Core.PlayerData[key] = val
            end
        end)
    end

end

exports('GeneratePlate', function() -- works on both server and client
	return GeneratePlate()
end)