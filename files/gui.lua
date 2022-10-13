dofile_once("mods/mould/files/scripts/utils.lua")
local gusgui = dofile_once("mods/mould/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_pdm = 0
local hp = 0
local max_hp = 0
local max_hp_old = 0

function OnWorldPreUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        --print("player is not nil")
        comp_pdm = EntityGetFirstComponentIncludingDisabled( player, "DamageModelComponent" )
        if comp_pdm ~= nil then
            --print("comp is not nil")
            hp = ComponentGetValue2(comp_pdm, "hp")
            max_hp = ComponentGetValue2(comp_pdm, "max_hp")
            max_hp_old = ComponentGetValue2(comp_pdm, "max_hp_old") 
            Gui.state.hpbar = (hp / max_hp_old) * 100
            Gui.state.hp = hp * 25
            Gui.state.maxhp = max_hp * 25
            Gui.state.maxhpold = max_hp_old * 25
            --GamePrint(hp)
        end
    end
end

function OnWorldPostUpdate()
    Gui:Render()
end

Gui:AddElement(gusgui.Elements.VLayout({
    id = "HeldItem",
    margin = { top = 30, left = 30 },
    overrideZ = 18,
    children = {
        gusgui.Elements.ImageButton({
            id = "ItemDisplayImage",
            margin = { left = 0, bottom = 70, },
            overrideZ = 17,
            scaleX = 5,
            scaleY = 5,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
            onBeforeRender = function(element, state)
                local player = EntityGetWithTag("player_unit")[1]
                local comp_inv2 = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
                local active_item = ComponentGetValue2(comp_inv2, "mActiveItem")
                local player_children = EntityGetAllChildren(player)
                local invquick_children = {}
                if player_children ~= nil then
                    for i,v in ipairs(player_children) do
                        if EntityGetName(v) == "inventory_quick" then
                            invquick_children = EntityGetAllChildren(v)
                        end
                    end
                end
                if active_item ~=  nil then
                    local comp_ability = EntityGetFirstComponentIncludingDisabled(active_item, "AbilityComponent")
                    local sprite = ComponentGetValue2(comp_ability, "sprite_file")
                    if sprite ~= "" then
                        --GamePrint("sprite should work")
                        element.config.src = sprite
                    end
                end
            end
        }),
    },
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "Bars",
    margin = { top = 390, left = 340, },
    overrideZ = 15,
    children = {
        gusgui.Elements.ProgressBar({
            id = "HealthBar",
            width = 400,
            height = 20,
            overrideZ = 16,
            barColour = "green",
            value = Gui:StateValue("hpbar"),
        }),
        gusgui.Elements.Text({
            id = "HealthText",
            overrideZ = 17,
            value = "Health: ${hp} / ${maxhp}",
            drawBorder = true,
            drawBackground = true,  
        })
    },
}))

--[[ 
gui plan

WHEN INV CLOSED
bars bottom right
held weapon and ammo bottom left
objectives top right

WHEN INV OPEN
inv screen
equipped cloak/other accessories
current fracture

]]--