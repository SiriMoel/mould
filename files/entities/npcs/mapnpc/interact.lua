local dialog_system = dofile_once("mods/mould/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    dialog_system.open_dialog( {
        name = "Tuoli",
        portrait = "mods/mould/files/entities/npcs/intronpc/portrait.png",
        typing_sound = "two",
        text = "Hello #Minä#.",
        options = {
            {
                text="I was told you had a task for me?",
                func = function(dialogue)
                    local flag = "objective_intro_maproom"
                    local objtext = "I need you to retrieve the #lost part of my map# from our old village before we were forced underground. If you go left from the exit to our base you should find the village's location easily."
                    if GameHasFlagRun(flag) == true then
                        dialogue.show( {
                            text=objtext,
                        } )
                        GameAddFlagRun("objective_retrievemap")

                        GameRemoveFlagRun(flag)
                        GameAddFlagRun("DONE_" .. flag)
                    elseif GameHasFlagRun("objective_retrievemap") then
                        dialogue.show( {
                            text="I have told you this. " .. objtext,
                        } )
                    elseif GameHasFlagRun("DONE_objective_retrievemap") then
                        dialogue.show( {
                            text="Thanks for retrieving my #mp!",
                        } )
                    else
                        dialogue.show( {
                            text="Noted.",
                        } )
                    end
                end,
            },
            {
                text="Anything I can do?", -- archaeology quests n things
                func = function(dialogue)
                    dialogue.show( {
                        text="NYI", 
                    } )
                end,
            },
            {
                text="Ok.",
                
            },
        },
    } )
end