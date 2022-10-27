dofile_once("mods/mould/files/scripts/utils.lua")

local itemspath = "mods/mould/files/entities/items/"
local types = { "normal" }

items = {
    {
        id = "mappiece",
        name = "Lost Map Piece",
        desc = "It is now found.",
        icon = itemspath .. "mappiece/sprite/s.png",
        path = itemspath .. "mappiece/piece.xml",
        type = "normal",
    },
}

Inv = {
    items = {}
}

function Inv:give( itemid ) 
    for i,v in ipairs(items) do
        for i,v in ipairs(v) do
            if v.id == itemid then
                table.insert( self.items, {
                    id = itemid,
                    count = 1,
                } )
            end
        end
    end
end

function Inv:take( itemid )
    for i,v in ipairs(self.items) do
        for i,v in ipairs(v) do
            if v.id == itemid then
                table.remove(self.items, i)
                return
            end
        end   
    end
end

function Inv:has( itemid )
    for i,v in ipairs(self.items) do
        for i,v in ipairs(v) do
            if v.id == itemid then
                return true
            end
        end
    end
end

function Inv:drop( itemid, x, y )
    for i,v in ipairs(self.items) do
        for i,v in ipairs(v) do
            if v.id == itemid then
                local path = ""
                for i,v in ipairs(items) do
                    for i,v in ipairs(v) do
                        if v.id == itemid then
                            path = v.path
                        end
                    end
                end
                Inv:take(itemid)
                EntityLoad(path, x, y)
            end
        end
    end
end