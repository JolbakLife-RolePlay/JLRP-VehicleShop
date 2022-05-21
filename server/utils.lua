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