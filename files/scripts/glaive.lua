dofile("mods/mould/files/scripts/utils.lua")

local weapon = GetUpdatedEntityID()
local x, y = EntityGetTransform( weapon )
local tg = EntityGetInRadiusWithTag(  x, y, 50, "thrownglaive" ) -- thrown glaive
local thrown = false

if tg ~= nil then
    thrown = true
    -- hide sprite
end

if tg == nil then
    thrown = false
    -- show sprite
end

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    if thrown == true then
        -- explode and return
    end
    if thrown == false then
        -- this shouldnt happen
    end
end