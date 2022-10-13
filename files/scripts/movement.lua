dofile_once("mods/mould/files/scripts/utils.lua")

local player = GetUpdatedEntityID()
local comp_cp = EntityGetFirstComponentIncludingDisabled( player, "CharacterPlatformingComponent" )
local comp_timer = EntityGetFirstComponentIncludingDisabled( player, "VariableStorageComponent", "movetimer" )

if comp_cp == nil or comp_timer == nil then return end

local startframe = GameGetFrameNum()
local timer = ComponentGetValue2( comp_timer, "value_int" )
local is_moving = false
local yes = 0

local comp_controls = EntityGetFirstComponentIncludingDisabled( player, "ControlsComponent" )
if ComponentGetValue2(comp_controls, "mButtonDownUp") == true or ComponentGetValue2(comp_controls, "mButtonDownLeft") == true or ComponentGetValue2(comp_controls, "mButtonDownRight") == true then
    is_moving = true
else
    is_moving = false
end

if is_moving ~= false then
    timer = timer + 1
end
if is_moving == false then
    --GamePrint("you are not moving")
    timer = 0
end

if ComponentGetValue2( comp_controls, "mButtonDownKick" ) == true then
    GamePrint("kick")
    timer = 0
end

ComponentSetValue2( comp_timer, "value_int", timer )