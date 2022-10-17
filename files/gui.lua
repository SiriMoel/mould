dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/inventory.lua")
local gusgui = dofile_once("mods/mould/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_pdm = 0
local hp = 0
local max_hp = 0
local max_hp_old = 0
local comp_controls = 0
local showinv = false

function OnWorldPreUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        comp_controls = EntityGetFirstComponentIncludingDisabled( player, "ControlsComponent" )
        comp_pdm = EntityGetFirstComponentIncludingDisabled( player, "DamageModelComponent" )
        if comp_pdm ~= nil then
            hp = ComponentGetValue2(comp_pdm, "hp")
            max_hp = ComponentGetValue2(comp_pdm, "max_hp")
            max_hp_old = ComponentGetValue2(comp_pdm, "max_hp_old") 
            Gui.state.hpbar = (hp / max_hp_old) * 100
            Gui.state.hp = hp * 25
            Gui.state.maxhp = max_hp * 25
            Gui.state.maxhpold = max_hp_old * 25
        end
        local comp_inv2 = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
        local active_item = ComponentGetValue2(comp_inv2, "mActiveItem")
        if active_item ~= 0 then
            local comp_activeitemsprite = EntityGetFirstComponentIncludingDisabled(active_item, "VariableStorageComponent", "sprite_file")
            local sprite = ComponentGetValue2(comp_activeitemsprite, "value_string")
            Gui.state.helditem = sprite
            local comp_ammocount = EntityGetFirstComponentIncludingDisabled(active_item, "VariableStorageComponent", "ammo_count")
            local comp_ammomax = EntityGetFirstComponentIncludingDisabled(active_item, "VariableStorageComponent", "ammo_max")
            if comp_ammocount ~= nil and comp_ammomax ~= nil then
                Gui.state.AmmoMax = ComponentGetValue2(comp_ammomax, "value_int")
                Gui.state.AmmoCount = ComponentGetValue2(comp_ammocount, "value_int")
            else
                Gui.state.AmmoMax = "" 
                Gui.state.AmmoCount = ""
            end
        else 
            Gui.state.helditem = ""
            Gui.state.AmmoMax = ""
            Gui.state.AmmoCount = ""
        end
        local comp_wallet = EntityGetFirstComponentIncludingDisabled( player, "WalletComponent" ) 
        Gui.state.wallet = ComponentGetValue2(comp_wallet, "money")
        Gui.state.movetimer = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( player, "VariableStorageComponent", "movetimer" ), "value_int" )
        Gui.state.kickcd = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( player, "VariableStorageComponent", "kickcd" ), "value_int" )
        if comp_controls ~= nil then
            if ComponentGetValue2(comp_controls, "mButtonDownInventory") == true then
                if showinv == false then
                    showinv = true
                elseif showinv == true then
                    showinv = false
                end
            end
        end
        Gui.state.showinv = showinv
    end
end

function OnWorldPostUpdate()
    if EntityGetWithTag("player_unit")[1] ~= nil then
        Gui:Render()
    end
end

Gui:AddElement(gusgui.Elements.VLayout({
    id = "HeldItem",
    margin = { top = 50, left = 250 },
    overrideZ = 18,
    children = {
        gusgui.Elements.ImageButton({
            id = "HeldItemImage",
            margin = { left = 0, top = 0, },
            overrideZ = 17,
            scaleX = 10,
            scaleY = 10,
            src = Gui:StateValue("helditem"),
            onClick = function(element, state)
            end,
        }),
        gusgui.Elements.Text({
            id = "AmmoText",
            margin = {},
            overrideZ = 19,
            value = "Ammo: ${AmmoCount} / ${AmmoMax}",
            drawBorder = true,
            drawBackground = true,
        }),
    },
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "Health",
    margin = { top = 390, left = 340, },
    overrideZ = 15,
    children = {
        gusgui.Elements.ProgressBar({
            id = "HealthBar",
            width = 200,
            height = 20,
            overrideZ = 16,
            barColour = "green",
            value = Gui:StateValue("hpbar"),
        }),
        gusgui.Elements.Text({
            id = "HealthText",
            margin = { left = 120, top = 0, },
            overrideZ = 17,
            value = "Health: ${hp} / ${maxhp}",
            drawBorder = false,
            drawBackground = false,  
        })
    },
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "TopRight",
    margin = { left = 420, top = 20, },
    overrizeZ = 15,
    children = {
        gusgui.Elements.HLayout({
            id = "wallet",
            margin = {},
            overrideZ = 17,
            children = {
                gusgui.Elements.Text({
                    id = "WalletText",
                    margin = { left = 10, },
                    overrideZ = 17,
                    value = "${wallet}",
                }),
                gusgui.Elements.Image({
                    id = "WalletIcon",
                    margin = { left = 0, },
                    overrideZ = 17,
                    src = "data/ui_gfx/hud/money.png",
                }),
            },
        }),
        gusgui.Elements.Text({
            id = "MoveTimerText",
            margin = { top = 30, left = 10, },
            overrideZ = 17,
            value = "${movetimer}",
        }),
        gusgui.Elements.Text({
            id = "KickCDText",
            margin = { top = 35, left = 10, },
            overrideZ = 17,
            value = "${kickcd}",
        }),
    },
}))

Gui:AddElement(gusgui.Elements.HLayout({
    id = "Inventory",
    margin = {},
    overrideZ = 19,
    hidden = GuiState("showinv"),
    children = {},
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