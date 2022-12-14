dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/gun_actions.lua")

function flipbool(boolean) -- the real function flipbool()
    return not boolean
end

---@param bool boolean
---this is the greatest function of all time, it flips a boolean. true -> false and false -> true.
function flipboolean(bool) -- honestly quite incredible.
    if string.sub(tostring(bool), 1, 1) == "t" then
        bool = false
        return bool
    elseif string.sub(tostring(bool), 1, 1) == "f" then
        bool = true
        return bool
    end
end

function table.contains(table, element)
        for _, value in pairs(table) do
            if value == element then
            return true
        end
    end
    return false
end

function GetActionsOnWand(entity_id)
    local wand_deck = {}
    local wand_deck_children = EntityGetAllChildren(entity_id)
    if wand_deck_children == nil then return {} end
    for i,v in ipairs(wand_deck_children) do
        local item = EntityGetFirstComponentIncludingDisabled(v, "ItemComponent")
        local item_action = EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent")
        if item and item_action then
            local action_id = ComponentGetValue2(item_action, "action_id")
            wand_deck[i] = action_id
        end
    end
    return wand_deck
end

function GetActionInfo(action_id, info)
    for i,v in ipairs(actions) do
        if v.id == action_id then
            if v[info] ~= nil then
                return v[info]
            end
        end
    end
end

local shardpath = "mods/mould/files/entities/misc/shard/shard.xml"
shards_list = { 
    { id = 1, collected = false, path = shardpath, },
    { id = 2, collected = false, path = shardpath, },
    { id = 3, collected = false, path = shardpath, },
    { id = 4, collected = false, path = shardpath, },
    { id = 5, collected = false, path = shardpath, },
    { id = 6, collected = false, path = shardpath, },
    { id = 7, collected = false, path = shardpath, },
    { id = 8, collected = false, path = shardpath, },
    { id = 9, collected = false, path = shardpath, },
}

function SpawnShard(id, x, y)
    local pathtoload = ""
    for i,v in ipairs(shards_list) do
        if v.id == id then
            pathtoload = v.path
        end
    end
    local shard = EntityLoad( pathtoload, x, y )
    local comp = EntityGetFirstComponentIncludingDisabled( shard, "VariableStorageComponent", "shard_id" )
    if comp == nil then 
        error("could not store shard id")
    end
    ComponentSetValue2( comp, "value_int", id )
end

function DropShard(id, sendmessage)
    local x, y = EntityGetTransform(EntityGetWithTag("player_unit")[1])
    for i,v in ipairs(shards_list) do
        if v.id == id then
            if v.collected == true then
                SpawnShard( id, x, y )
                v.collected = false
                if sendmessage then
                    GamePrint("Shard dropped.")
                end
            else
                if sendmessage then
                    GamePrint("You do not have this shard collected.")
                end
            end
        end
    end
end

function DropShards( all, todrop)
    if all then
        for i,v in ipairs(shards_list) do
            DropShard(v.id, false)
        end
    else
        if todrop ~= nil and #todrop ~= 0 then
            for i,b in ipairs(todrop) do
                for i,v in ipairs(shards_list) do
                    if b == v.id then
                        DropShard(v.id, false)
                    end
                end
            end
        end
    end
end

---@return integer
function GetMoney()
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    return money
end

---@param amount integer
function SetMoney(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    ComponentSetValue2(comp_wallet, "money", amount)
end

---@param amount integer
---@return boolean
function CanAfford(amount)
    if GetMoney() >= amount then
        return true
    else
        return false
    end
end

---@param amount integer
---@param spent boolean if money_spent in WalletComponent should be increased.
function ReduceMoney(amount, spent)
    if CanAfford(amount) == false then
        GamePrint("Cannot afford.")
        return
    end
    SetMoney(GetMoney() - amount)
    if spent == true then
        local player = EntityGetWithTag("player_unit")[1]
        local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
        local moneyspent = ComponentGetValue2(comp_wallet, "money_spent")    
        moneyspent = moneyspent + amount
        ComponentSetValue2(comp_wallet, "money_spent", moneyspent)
    end
end

---@param amount integer
function AddMoney(amount)
    SetMoney(GetMoney() + amount)
end

---@class shopItem
---@field name string
---@field price number
---@field desc string
---@field entity string
---@field onBought function?

---@param forsale shopItem[] the items that are for sale.
---@param x number x coordinate.
---@param y number y coordinate.
function shop(forsale, x, y )
    local options = {}
    for i=1, #forsale do
        local v = forsale[i]
        table.insert( options, {
            text = v.name .. " $" .. v.price,
            func = function(dialog)
                dialog.show({
                    text = v.name .. ". " .. v.desc,
                    options = {
                        {
                            text = "Buy. $" .. v.price,
                            func = function(dialog)
                                if CanAfford(v.price) then
                                    ReduceMoney(v.price, true)
                                    EntityLoad(v.entity, x, y)
                                    if v.onBought then v.onBought() end
                                    dialog.show({
                                        text = "Transaction successful."
                                    })
                                else
                                    dialog.show({
                                        text = "You cannot afford this.",
                                        options = {
                                            text = "Ok.",
                                        },
                                    })
                                end
                            end,
                        },
                        {
                            text = "Go back.",
                            func = function(dialog)
                                dialog.back()
                            end,
                        },
                    },
                })
            end,
        } )
    end
    return options
end