# MonoAdmin Bridge System

The bridge system provides a unified interface for framework-specific functionality.
Each framework (ESX, Qbox, etc.) implements the same interface.

## Configuration

The framework is set automatically from your MonoAdmin cloud project settings.
Supported frameworks:
- `esx` — ESX Legacy
- `qbox` — Qbox Framework (qbx_core)
- `standalone` — No framework (native FiveM only)

## Framework Differences

| Aspect | ESX | Qbox |
|--------|-----|------|
| **Player Identifier** | `steam:XXXXX` or `char1:XXXXX` | `char:XXXXX` (charId) |
| **User Table** | `users` (combined) | `users` + `characters` (separate) |
| **Jobs** | `jobs` + `job_grades` | `ox_groups` + `ox_group_grades` |
| **Money** | JSON in `users.accounts` | `accounts` table (relational) |
| **Vehicles** | `owned_vehicles.owner` (string) | `vehicles.owner` (FK to charId) |
| **Inventory** | JSON in `users.inventory` | `character_inventory` table |

## Standalone Mode

Standalone mode works without any framework. It uses only native FiveM functions.

**Works in Standalone:**
- Player listing (GetPlayers, GetPlayerInfo, GetPlayerPosition)
- Admin actions (Kick, Heal, Revive, Teleport, Freeze)
- Native notifications (ShowNotification)
- ACE permission detection (GetPlayerGroup)

**Not Available (No Framework):**
- Money system (GetMoney, GiveMoney, SetMoney, RemoveMoney)
- Inventory system (GiveItem, RemoveItem, GetInventory)
- Job system (SetJob, GetPlayerJob)
- Ban storage (use external ban system like txAdmin)
- All database query methods

**Use standalone for:**
- Servers without roleplay frameworks
- Testing/development without framework dependencies
- RP-lite or minigame servers

## Runtime Methods (Live Player Actions)

| Method | Params | Returns | Description |
|--------|--------|---------|-------------|
| `Initialize()` | - | `boolean` | Initialize framework connection |
| `HealPlayer(serverId)` | serverId | `success, error` | Heal player to full health |
| `KickPlayer(serverId, reason)` | serverId, reason | `success, error` | Kick player from server |
| `BanPlayer(serverId, reason, duration)` | serverId, reason, duration | `success, error` | Ban player |
| `SetJob(serverId, job, grade)` | serverId, job, grade | `success, error` | Set player's job |
| `RevivePlayer(serverId)` | serverId | `success, error` | Revive dead player |
| `TeleportPlayer(serverId, x, y, z)` | serverId, coords | `success, error` | Teleport player |
| `FreezePlayer(serverId, freeze)` | serverId, freeze | `success, error` | Freeze/unfreeze player |
| `GiveItem(serverId, item, amount)` | serverId, item, amount | `success, error` | Give inventory item |
| `GetPlayers()` | - | `players[]` | Get all online players |
| `GetPlayerInfo(serverId)` | serverId | `playerInfo` | Get player details |
| `GetPlayerPosition(serverId)` | serverId | `{x,y,z}` | Get player coords |
| `GetPlayerGroup(serverId)` | serverId | `string` | Get permission group |
| `GetPlayerMoney(serverId)` | serverId | `{cash,bank,dirty}` | Get live money |
| `SetMoney(serverId, type, amount)` | serverId, type, amount | `success, error` | Set money amount |
| `GiveMoney(serverId, type, amount)` | serverId, type, amount | `success, error` | Add money |
| `RemoveMoney(serverId, type, amount)` | serverId, type, amount | `success, error` | Remove money |
| `RemoveItem(serverId, item, amount)` | serverId, item, amount | `success, error` | Remove inventory item |
| `GetInventory(serverId)` | serverId | `inventory[]` | Get live inventory |
| `SetGroup(serverId, group)` | serverId, group | `success, error` | Set permission group |

## Database Methods (Query from DB)

| Method | Params | Returns | Description |
|--------|--------|---------|-------------|
| `GetPlayerData(params)` | `{identifier}` | `characters[]` | Get player data from DB |
| `GetPlayerVehicles(params)` | `{identifier}` | `{vehicles,owners}` | Get player vehicles |
| `GetPlayerMoneyFromDb(params)` | `{identifier}` | `{accounts,addon}` | Get money from DB |
| `GetPlayerJob(params)` | `{identifier}` | `jobInfo` | Get job with grades |
| `GetPlayerLicenses(params)` | `{identifier}` | `licenses[]` | Get player licenses |
| `GetPlayerBanking(params)` | `{identifier}` | `transactions[]` | Get banking history |
| `GetJobs(params)` | - | `jobs[]` | Get all jobs with grades |
| `GetItems(params)` | - | `items[]` | Get all items |
| `GetVehicles(params)` | `{limit,offset,filters}` | `{vehicles,total}` | Get vehicles paginated |
| `GetVehicleByPlate(params)` | `{plate}` | `vehicle` | Get single vehicle |
| `UpdateVehicle(params)` | `{plate,updates}` | `{updated,vehicle}` | Update vehicle data |
| `DeleteVehicle(params)` | `{plate}` | `{deleted}` | Delete vehicle |
| `UpdatePlayerJob(params)` | `{identifier,job,grade}` | `{updated}` | Update player job |
| `UpdatePlayerMetadata(params)` | `{identifier,metadata}` | `{updated}` | Update metadata |
| `UpdatePlayerPosition(params)` | `{identifier,position}` | `{updated}` | Update position |
| `UpdatePlayerCharacter(params)` | `{identifier,fields}` | `{updated}` | Update character info |
| `GetPlayerInventory(params)` | `{identifier}` | `{inventory,items}` | Get inventory from DB |
| `UpdatePlayerInventory(params)` | `{identifier,inventory}` | `{updated}` | Replace inventory |
| `AddInventoryItem(params)` | `{identifier,item}` | `{updated}` | Add item to inventory |
| `RemoveInventoryItem(params)` | `{identifier,slot}` | `{updated}` | Remove item from slot |
| `UpdateInventoryItem(params)` | `{identifier,slot,updates}` | `{updated}` | Update item in slot |

## Adding a New Framework

1. Create `bridges/{framework}.lua`
2. Implement all methods from both tables above
3. Call `MonoAdmin.Bridge.Register('{framework}', YourBridge)` at end
4. Add to fxmanifest.lua server_scripts

## Client-Side Bridges

Client bridges mirror the server pattern for player-facing functionality.

### Client Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `IsPlayerLoaded()` | `boolean` | Check if player data ready |
| `GetPlayerData()` | `table` | Get full player data |
| `GetPlayerJob()` | `table` | Get job info |
| `GetPlayerMoney(type)` | `number` | Get money by type |
| `GetPlayerIdentifier()` | `string` | Get player identifier |
| `GetPlayerName()` | `string` | Get character name |
| `ShowNotification(msg, type, duration)` | - | Display notification |
| `ShowProgressBar(duration, label, cb)` | - | Show progress bar |
| `HasItem(item, count)` | `boolean` | Check inventory |
| `GetItemCount(item)` | `number` | Count item |
| `HasGroup(group)` | `boolean` | Check permission group |
| `GetGroups()` | `table` | Get all groups |

### Usage Example

```lua
-- Client-side code
if MonoAdmin.ClientBridge.IsPlayerLoaded() then
    local job = MonoAdmin.ClientBridge.GetPlayerJob()
    MonoAdmin.ClientBridge.ShowNotification('Your job: ' .. job.label)
end
```

## Files

### Server-Side
- `server/bridges/adapter.lua` — Interface definition (311 lines)
- `server/bridges/esx.lua` — ESX Legacy (1496 lines)
- `server/bridges/qbox.lua` — Qbox/qbx_core (1404 lines)
- `server/bridges/standalone.lua` — Standalone/No framework (311 lines)

### Client-Side
- `client/bridges/adapter.lua` — Unified interface (203 lines)
- `client/bridges/esx.lua` — ESX client (174 lines)
- `client/bridges/qbox.lua` — Qbox client with ox_inventory (160 lines)
- `client/bridges/standalone.lua` — Standalone client (102 lines)
