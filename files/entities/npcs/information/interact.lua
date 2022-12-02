dofile_once("mods/mould/files/scripts/goals.lua")
local dialog_system = dofile_once("mods/mould/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local pname = ModSettingGet("mould.name")
    dialog_system.open_dialog( {
        name = "Information",
        portrait = "mods/mould/files/entities/npcs/information/portrait.png",
        typing_sound = "two",
        text = "",
        options = {
            {
                text = "INFORMATION",
                func = function(dialogue)
                    dialogue.show( {
                        text = "Text.",
                    } )
                end,
            },
            {
                text = "KNOWN ISSUES",
                func = function(dialogue)
                    dialogue.show( {
                        text = "THERE ARE NO ISSUES IN THIS MOD.",
                    } )
                end,
            },
            {
                text = "PATCH NOTES",
                func = function(dialogue)
                    dialogue.show( {
                        text = "",
                        options = {
                            {
                                text = "v1.0",
                                func = function(dialogue)
                                    dialogue.show( {
                                        text = "Not yet released."
                                    } )
                                end,
                            },
                        }
                    } )
                end,
            },
        },
    } )
end