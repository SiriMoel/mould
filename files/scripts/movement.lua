dofile_once("mods/mould/files/scripts/utils.lua")

local player = GetUpdatedEntityID()
local comp_cp = EntityGetFirstComponentIncludingDisabled( player, "CharacterPlatformingComponent" )
local comp_timer = EntityGetFirstComponentIncludingDisabled( player, "VariableStorageComponent", "movetimer" )

if comp_cp == nil or comp_timer == nil then return end

local startframe = GameGetFrameNum()
local timer = ComponentGetValue2( comp_timer, "value_int" )
local is_moving = false

local comp_controls = EntityGetFirstComponentIncludingDisabled( player, "ControlsComponent" )
if ComponentGetValue2(comp_controls, "mButtonDownUp") == true or ComponentGetValue2(comp_controls, "mButtonDownLeft") == true or ComponentGetValue2(comp_controls, "mButtonDownRight") == true then
    is_moving = true
else
    --is_moving = false
end

timer = math.min( timer + 1, 160 )

if is_moving == false then
    GamePrint("you are not moving")
end

if is_moving ~= false then
    GamePrint("you are moving")
    local velocity_min_x = ComponentGetValue2( comp_cp, "velocity_min_x" )
    local velocity_max_x = ComponentGetValue2( comp_cp, "velocity_max_x" )
    local velocity_min_y = ComponentGetValue2( comp_cp, "velocity_min_y" )
    local velocity_max_y = ComponentGetValue2( comp_cp, "velocity_max_y" )

    local old_velocity_min_x = ComponentGetValue2( comp_cp, "velocity_min_x" )
    local old_velocity_max_x = ComponentGetValue2( comp_cp, "velocity_max_x" )
    local old_velocity_min_y = ComponentGetValue2( comp_cp, "velocity_min_y" )
    local old_velocity_max_y = ComponentGetValue2( comp_cp, "velocity_max_y" )

    local velocity_x = {
        velocity_min_x,
        velocity_max_x,
    }
    local velocity_y = {
        velocity_min_y,
        velocity_max_y,
    }

    if timer > 120 then
        for i,v in ipairs(velocity_x) do
            if v < 103 and v > -103 then
            v = v * 1.1
        end
        for i,v in ipairs(velocity_y) do
            if v < 450 and v > -200 then
            v = v * 1.1
        end
    end

    ComponentSetValue2( comp_cp, "velocity_min_x", velocity_x[1])
    ComponentSetValue2( comp_cp, "velocity_max_x", velocity_x[2])
    ComponentSetValue2( comp_cp, "velocity_min_y", velocity_y[1])
    ComponentSetValue2( comp_cp, "velocity_max_y", velocity_y[2])
end
else
    timer = 0
    ComponentSetValue2( comp_cp, "velocity_min_x", old_velocity_min_x)
    ComponentSetValue2( comp_cp, "velocity_max_x", old_velocity_max_x)
    ComponentSetValue2( comp_cp, "velocity_min_y", old_velocity_min_y)
    ComponentSetValue2( comp_cp, "velocity_max_y", old_velocity_max_y)
end
end

ComponentSetValue2( comp_timer, "value_int", timer )