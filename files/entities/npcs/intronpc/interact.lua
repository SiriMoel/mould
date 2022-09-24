local dialog_system = dofile_once("mods/mould/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    dialog_system.open_dialog( {
        name = "Tuoli",
        portrait = "mods/mould/files/entities/npcs/intronpc/portrait.png",
        typing_sound = "two",
        text = "Lorem ipsum dolor sit amet.",
    } )
end