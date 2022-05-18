local FRAMEWORK -- To Store the metadata of exports
Core = nil
do
    if GetResourceState('JLRP-Framework') ~= 'missing' then
        FRAMEWORK = exports['JLRP-Framework']
        Core = FRAMEWORK:GetFrameworkObjects()
    elseif GetResourceState('es_extended') ~= 'missing' then
        FRAMEWORK = exports['es_extended']
        Core = FRAMEWORK:getSharedObject()
    end
end



function TextUI(type, reason, extra)
    if type == 'show' then
        local message = '[E]'
        if reason == 'open_shop' then
            message = _U('open_shop', extra.shop_name)
        end
        if Config.TextUI == 'jlrp' or Config.TextUI == 'esx' then
            Core.TextUI(message, type)
        elseif Config.TextUI == 'ox_lib' then
            lib.showTextUI(message, {position = 'left-center', style = {backgroundColor = '#020040', color = white, borderColor = '#d90000', borderWidth = 2}})
        end
    elseif type == 'hide' then
        lib.hideTextUI()
    end
end