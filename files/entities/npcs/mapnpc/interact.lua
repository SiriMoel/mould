local dialog_system = dofile_once("mods/mould/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local pname = ModSettingGet("mould.name")
    if GameHasFlagRun("mapnpc_unlocked") == true then
        dialog_system.open_dialog( {
            name="Sormi",
            portrait = "mods/mould/files/entities/npcs/mapnpc/portrait.png",
            typing_sound = "two",
            text = "Hello ~" .. pname .. "~.",
            options = {
                {
                    text = "Do you have any tasks for me?",
                    func = function(dialogue)
                        dialogue.show( { 
                            text="NYI"
                        } )
                    end,
                },
                {
                    text = "Ok.",
                },
            }
        } )
    else
        dialog_system.open_dialog( {
            name = "Sormi",
            portrait = "mods/mould/files/entities/npcs/mapnpc/portrait.png",
            typing_sound = "two",
            text = "Hello ~" .. pname .. "~.",
            options = {
                {
                    text="I was told you had a task for me?",
                    func = function(dialogue)
                        local flag = "objective_intro_maproom"
                        local objtext = "I need you to retrieve the ~lost part of my map~ from \nour old village before we were forced underground. \nIf you go left from the exit to our base \nyou should find the village's location easily."
                        if GameHasFlagRun(flag) == true then
                            dialogue.show( {
                                text=objtext,
                            } )
                            GameAddFlagRun("objective_retrievemap")
    
                            GameRemoveFlagRun(flag)
                            GameAddFlagRun("DONE_" .. flag)
                        elseif GameHasFlagRun("objective_retrievemap") then
                            dialogue.show( {
                                text="I have told you this.\n " .. objtext,
                            } )
                        elseif GameHasFlagRun("DONE_objective_retrievemap") then
                            dialogue.show( {
                                text="Thanks for retrieving my ~map~!",
                            } )
                            GameAddFlagRun("mapnpc_unlocked")
                        else
                            dialogue.show( {
                                text="What?",
                            } )
                        end
                    end,
                },
                {
                    text="Here is what you requested!",
                    func = function(dialogue)
                        if GameHasFlagRun("DONE_objective_retrievemap") ~= true then
                            dialogue.show( {
                                text="What?", 
                            } ) 
                        else
                            dialogue.show( {
                                text="Thanks for retrieving my ~map~!", 
                            } ) 
                            GameAddFlagRun("mapnpc_unlocked")
                        end                        
                    end,
                },
                {
                    text="Ok.",
                },
            },
        } ) 
    end
end