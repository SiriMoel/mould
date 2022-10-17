dofile("mods/mould/files/scripts/Goals.lua")
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
                        local flag = "intro_maproom"
                        local objtext = "I need you to retrieve the ~lost part of my map~ from \nour old village before we were forced underground. \nIf you go west from the exit to our base \nyou should find the village's location easily."
                        if Goals:isactive(flag) then
                            dialogue.show( {
                                text=objtext,
                            } )
                            Goals:assign("retrievemap")
                            Goals:complete(flag)
                        elseif Goals:isactive("retrievemap") then
                            dialogue.show( {
                                text="I have told you this.\n " .. objtext,
                            } )
                        elseif Goals:iscompleted("retrivemap") then
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
                        if Goals:iscompleted("retrievemap") ~= true then
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