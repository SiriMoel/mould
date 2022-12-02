dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/status_list.lua")

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)

local path = "mods/mould/files/player/status/"
for i,v in ipairs(status_list) do
    if v.stainable == true then
        local entity = EntityLoad(path .. "entity.xml")
        local comp = EntityGetFirstComponentIncludingDisabled( entity, "MaterialAreaCheckerComponent" ) or 0
        EntityAddChild( player, entity )
        ComponentSetValue2( comp, "material", v.material )
        EntityAddComponent( entity, "VariableStorageComponent", {
            _tags="statuseffect",
            name="statuseffect",
            value_string=v.material,
        } )
        EntityAddComponent( entity, "LuaComponent", {
            script_material_area_checker_success="mods/mould/files/scripts/status_stain_apply.lua",
        } )
    end
end