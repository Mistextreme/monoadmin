local internalName = "Sevent"
CustomizableAction = CustomizableAction or {}
CustomizableAction[internalName] = {}
local intTable = CustomizableAction[internalName]

-- playerId, reason, duration in seconds; 0 = permanent
intTable.onPlayerPunishmentBan = function(player, reason, duration)
    DropPlayer(player, reason)
    return true, nil
end

intTable.onPlayerPunishmentKick = function(player, reason)
    DropPlayer(player, reason)
    return true, nil
end
