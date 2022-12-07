dofile("mods/mould/files/scripts/Goals.lua")
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
                func = function(dialog)
                    local flag = "intro_armoury"
                    if Goals:isactive(flag) then
                        dialog.show( {
                            text="I see. I can give you the choice of three. \nThe ~shotgun~, the ~pistol~ or the ~sniper~."
                        } )
                        -- spawn starting weapons
                        local sx = 1850 -- spawn x
                        local sy = 1890 -- spawn y

                        EntityLoad("mods/mould/files/entities/items/_starter/hiisishotgun/weapon.xml", sx, sy)
                        EntityLoad("mods/mould/files/entities/items/_starter/hiisisniper/weapon.xml", sx+30, sy)
                        EntityLoad("mods/mould/files/entities/items/_starter/hiisipistol/weapon.xml", sx+60, sy)

                        Goals:complete(flag)
                    else
                        dialog.show( {
                            text="Hm?"
                        } )
                    end
                end,
            },
            {
                text="Show me your stock.", -- weapons shop
                func = function(dialog)
                    dialog.show( {
                        text="NYI",
                        func = function(dialog)
                            shop( dialog.options, {
                                {
                                    name = "Hiisi Shotgun",
                                    desc = "A fine weapon.",
                                    price = 150,
                                    entity = "mods/mould/files/entities/items/hiisishotgun/weapon.xml"
                                },
                                {
                                    name = "Hiisi Sniper",
                                    desc = "A fine weapon.",
                                    price = 150,
                                    entity = "mods/mould/files/entities/items/hiisisniper/weapon.xml"
                                },
                                {
                                    name = "Hiisi Pistol",
                                    desc = "A fine weapon.",
                                    price = 150,
                                    entity = "mods/mould/files/entities/items/hiisipistol/weapon.xml"
                                },
                            }, x, y-20 )
                        end,
                        options = {},
                    } )
                end,
            },
            {
                text="Ok.",
            }
        },
    } )
end