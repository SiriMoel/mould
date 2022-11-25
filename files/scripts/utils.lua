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

function setbool(toset)
    bool = toset
    return bool
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
            if v.info ~= nil then
                return v.info
            end
        end
    end
end

local shardpath = "mods/mould/files/entities/misc/shard/shard.xml"
shards_list = {
    {
        id = 1,
        collected = true,
        path = shardpath,
    },
    {
        id = 2,
        collected = false,
        path = shardpath,
    },
    {
        id = 3,
        collected = false,
        path = shardpath,
    },
    {
        id = 4,
        collected = false,
        path = shardpath,
    },
    {
        id = 5,
        collected = false,
        path = shardpath,
    },
    {
        id = 6,
        collected = false,
        path = shardpath,
    },
    {
        id = 7,
        collected = false,
        path = shardpath,
    },
    {
        id = 8,
        collected = false,
        path = shardpath,
    },
    {
        id = 9,
        collected = false,
        path = shardpath,
    },
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
        error("Couldn't find shard id VSC")
    end
    ComponentSetValue2( comp, "value_int", id )
end

function DropShards()
    local x, y = EntityGetTransform(EntityGetWithTag("player_unit")[1])
    for i,v in ipairs(shards_list) do
        if v.collected == true then
            SpawnShard( v.id, x, y )
            x = x + 5
            v.collected = false
        end
    end
end