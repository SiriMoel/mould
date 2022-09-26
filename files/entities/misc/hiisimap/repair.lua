dofile_once("data/scripts/lib/utilities.lua")

local map = GetUpdatedEntityID()
local x, y = EntityGetTransform(map)
local radius = 80
local piece = EntityGetInRadiusWithTag( x, y, radius, "mould_mappiece" )[1]

if piece ~= nil and EntityHasTag(map, "fixed") ~= true then
    local spritecomp = EntityGetFirstComponent( map, "SpriteComponent" )
    ComponentSetValue2( spritecomp, "image_file", "mods/mould/files/entities/misc/hiisimap/map_fixed.xml" )
    EntityRefreshSprite(map, spritecomp)
    GamePrint("Fixed!")
    EntityKill(piece)
    EntityAddTag(map, "fixed")
    local flag = "objective_retrievemap"
    GameRemoveFlagRun(flag)
    GameAddFlagRun("DONE_" .. flag)
end