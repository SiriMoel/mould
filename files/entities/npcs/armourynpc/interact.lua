local dialog_system = dofile_once("mods/mould/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local pname = ModSettingGet("mould.name")
    dialog_system.open_dialog( {
        name = "Pallo",
        portrait = "mods/mould/files/entities/npcs/armourynpc/portrait.png",
        typing_sound = "two",
        text = "Ah! Hello ~" .. pname .. "~. What can I do for you today?",
        options = {
            {
                text="I need a weapon.",
                func = function(dialogue)
                    local flag = "objective_intro_armoury"
                    if GameHasFlagRun(flag) == true then
                        dialogue.show( {
                            text="I see. I can give you the choice of three. \nThe ~shotgun~, the ~pistol~ or the ~sniper~."
                        } )
                        -- spawn starting weapons
                        GameRemoveFlagRun(flag)
                        GameAddFlagRun("DONE_" .. flag)
                    else
                        dialogue.show( {
                            text="You already have a weapon, do you not?"
                        } )
                    end
                end,
            },
            {
                text="Show me your stock.", -- weapons shop
                func = function(dialogue)
                    dialogue.show( {
                        text="NYI"
                    } )
                end,
            },
            {
                text="Ok.",
            }
        },
    } )
end