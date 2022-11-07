dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/gun_actions.lua")

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
        if v["id"] == action_id then
            if v[info] ~= nil then
                return v[info]
            end
        end
    end
end

function DropShards()
    local shardcount = GlobalsGetValue("shardcount")
    local x, y = EntityGetTransform(EntityGetWithTag("player_unit")[1])
    for i=1,shardcount do
        EntityLoad("", x, y)
        x = x + 5
    end
    GlobalsSetValue("shardcount", "0")
    GameAddFlagRun("mould_noshards")
end