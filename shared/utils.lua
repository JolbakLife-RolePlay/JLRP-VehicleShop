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
            Core.ShowNotification(message)
        elseif Config.Notification == 'ox_lib' then
            lib.notify({
                title = extra.shop_name,
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

end