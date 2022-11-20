dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/status_list.lua")

local entity = GetUpdatedEntityID()
local player = EntityGetWithTag("player_unit")[1]
local comp = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "statuseffect" )
local effect = ComponentGetValue2( comp, "value_string" )

function material_area_checker_success( pos_x, pos_y )
    if player ~= nil and effect ~= nil then
        for i,v in ipairs(status_list) do
            if v.id == effect then
                if v.stackable == true then
                    if v.stacks < v.maxStacks then
                        v.on = true
                        v.onAdded()
                        v.stacks = v.stacks + 1
                        v.duration = v.defaultDuration
                    end
                else
                   v.on = true
                   v.onAdded()
                   v.stacks = 1
                   v.duration = v.defaultDuration
                end
            end
        end
    end
end