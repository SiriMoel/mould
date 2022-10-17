dofile("mods/mould/files/scripts/Goals.lua")
local dialog_system = dofile_once("mods/mould/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local pname = ModSettingGet("mould.name")
    local x, y = EntityGetTransform(entity_interacted)
    dialog_system.open_dialog( {
        name="???",
        portrait = "mods/mould/files/entities/npcs/wanderer/portrait.png",
        typing_sound = "two",
        text = "What do you want, #construct#?",
        options = {
            {
                text = "Hello?",
                func = function(dialogue)
                    if BiomeMapGetName(x, y) == "Ruumishuone" then
                        dialogue.show( { 
                            text="Down this well before us are #the Caverns#. \nA network of tunnels that many have tried to tame, \nbut none have succeeded."
                        } )
                    else
                        dialogue.show( { 
                            text="This isn't right."
                        } )
                    end
                end,
            },
        }
    } )
end