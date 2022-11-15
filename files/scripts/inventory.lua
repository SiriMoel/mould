dofile_once("mods/mould/files/scripts/utils.lua")

local itemspath = "mods/mould/files/entities/items/"
--- @enum Types 
local Types = {
    Normal = 1,
}

--- @class Item
--- @field name string
--- @field desc string
--- @field icon string
--- @field path string
--- @field type Types
--- @type Item[]
items = {
    mappiece = {
        name = "Lost Map Piece",
        desc = "It is now found.",
        icon = itemspath .. "mappiece/sprite/s.png",
        path = itemspath .. "mappiece/piece.xml",
        type = Types.Normal,
    },
}

--- @class Inv
--- @field items table[]
Inv = {
    items = {}
}

function Inv:give(itemid)
    local item = items[itemid]
    if item == nil then error("Attempted to add an unknown item", 2) end
    table.insert(self.items, {
        id = itemid,
        count = 1,
    })
end

function Inv:take(itemid)
    for i, v in ipairs(self.items) do
        if v.id == itemid then
            table.remove(self.items, i)
            return
        end
    end
end

function Inv:has(itemid)
    for i, v in ipairs(self.items) do
        if v.id == itemid then
            return true
        end
    end
end

function Inv:drop(itemid, x, y)
    for i, v in ipairs(self.items) do
        if v.id == itemid then
            local path = items[itemid].path
            Inv:take(itemid)
            EntityLoad(path, x, y)
        end
    end
end
