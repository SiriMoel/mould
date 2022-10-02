dofile("mods/mould/files/misc/goals.lua")
local dialog_system = dofile_once("mods/mould/lib/DialogSystem/dialog_system.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetInRadiusWithTag(x, y, 10, "player_unit")[1]

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local pname = ModSettingGet("mould.name")
    dialog_system.open_dialog( {
        name = "Tuoli",
        portrait = "mods/mould/files/entities/npcs/intronpc/portrait.png",
        typing_sound = "two",
        text = "Hello ~" .. pname .. "~. Do not worry yourself about the loss of the\n ~Throngler~, atleast the mages do not have it now eh? As for \nthe hearts... I may have a lead on how we can deal with them \nbut thats for future discussion.",
        options = {
            {
                text="What should I be doing?", -- maybe expand this for a large portion of the story?
                func = function(dialogue)
                    local flag = "intro_armoury"
                    local flagtwo = "intro_maproom"
                    assigngoal(flag)
                    assigngoal(flagtwo)
                    if checkcompleted(flag) and checkcompleted(flagtwo) then
                        dialogue.show( { 
                            text="Oh... something?",
                       } ) 
                    else
                        dialogue.show( {
                            text="You need a weapon. The armoury is west and down. \nOnce you have selected a weapon I think ~Sormi~ in the \nmap room has a task for you. \nThe map room is just across from here.",
                        } )
                    end
                end,
            },
            {
                text="Ok.",
            }
        },
    } )
end