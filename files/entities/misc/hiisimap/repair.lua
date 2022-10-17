dofile_once("mods/mould/files/scripts/inventory.lua")

local map = GetUpdatedEntityID()
local x, y = EntityGetTransform(map)
local radius = 80
local player = EntityGetInRadiusWithTag( x, y, radius, "player_unit" )[1]

if player ~= nil then
    if EntityHasTag(map, "fixed") ~= true and Inv.has("mappiece") then
        Inv.take("mappiece")
        local spritecomp = EntityGetFirstComponent( map, "SpriteComponent" )
        ComponentSetValue2( spritecomp, "image_file", "mods/mould/files/entities/misc/hiisimap/map_fixed.xml" )
        EntityRefreshSprite(map, spritecomp)
        GamePrint("Fixed!")
        EntityAddTag(map, "fixed")
        local flag = "objective_retrievemap"
        GameRemoveFlagRun(flag)
        GameAddFlagRun("DONE_" .. flag)
    end
end

