dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/status_list.lua")

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)

local path = "mods/mould/files/player/status/"
for i,v in ipairs(status_list) do
    if v.stainable == true then
        local entity = EntityLoad(path .. "entity.xml")
        EntityAddChild( player, entity )
        EntityAddComponent( entity, "MaterialAreaCheckerComponent", {
            update_every_x_frame="2",
            kill_after_message=false,
            ["area_aabb.min_x"]=-1,
            ["area_aabb.max_x"]=1,
            ["area_aabb.min_y"]=-1,   
            ["area_aabb.max_y"]=1,
            material=v.material,
            material2="",
        } )
        EntityAddComponent( entity, "LuaComponent", {
            script_material_area_checker_success="mods/mould/files/scripts/status_stain_apply.lua",
        } )
    end
end