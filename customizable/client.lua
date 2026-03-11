local internalName = "events"
CustomizableAction = CustomizableAction or {}
CustomizableAction[internalName] = {}

local intTable = CustomizableAction[internalName]

intTable.revive = function()
    if Config.Framework == 'esx' then
        TriggerEvent('esx_ambulancejob:revive')
    else
        local ped = MonoAdmin.State.ped
        local coords = GetEntityCoords(ped)

        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
        SetEntityHealth(ped, GetEntityMaxHealth(ped))
        ClearPedBloodDamage(ped)
        ResetPedVisibleDamage(ped)
        ClearPedTasksImmediately(ped)
    end
    return true
end

intTable.heal = function()
    if Config.Framework == 'esx' then
        TriggerEvent('esx_ambulancejob:heal', 'big', true)
    else
        local ped = MonoAdmin.State.ped
        SetEntityHealth(ped, GetEntityMaxHealth(ped))
        SetPedArmour(ped, 100)
        ClearPedBloodDamage(ped)
        ResetPedVisibleDamage(ped)
    end
    return true
end
