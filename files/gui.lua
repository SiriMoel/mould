dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/inventory.lua")
local gusgui = dofile_once("mods/mould/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_pdm = 0
local hp = 0
local max_hp = 0
local max_hp_old = 0
local hpbar = 0
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
            hpbar = (math.floor((hp * 25) + 0.5) / (max_hp * 25)) * 100
            --GamePrint("h " .. tostring(hpbar))
            Gui.state.hpbar = hpbar
            Gui.state.hp = math.floor((hp * 25) + 0.5)
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
                Gui.state.hideammo = false
            else
                Gui.state.AmmoMax = "" 
                Gui.state.AmmoCount = ""
                Gui.state.hideammo = false
            end
        else 
            Gui.state.helditem = ""
            Gui.state.AmmoMax = ""
            Gui.state.AmmoCount = ""
            Gui.state.hideammo = false
        end
        local comp_wallet = EntityGetFirstComponentIncludingDisabled( player, "WalletComponent" ) 
        Gui.state.wallet = ComponentGetValue2(comp_wallet, "money")
        Gui.state.movetimer = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( player, "VariableStorageComponent", "movetimer" ), "value_int" )
        local comp_kickcd = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "kickcd")
        Gui.state.kickcd = ComponentGetValue2( comp_kickcd, "value_int" )
        Gui.state.kickbar = (ComponentGetValue2( comp_kickcd, "value_int" ) / 30) * 100
        local comp_mt = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "movetimer")
        --Gui.state.movebar = (ComponentGetValue2( comp_mt, "value_int" ) / 500) * 100

        local pchildren = EntityGetAllChildren(player)
        for i,v in ipairs(pchildren) do
            if EntityGetName(v) == "inventory_quick" then
                local we = EntityGetAllChildren(v)
                if we ~= nil and #we ~= 0 then
                    Gui.state.weaponone = EntityGetName(we[1]) or ""
                    Gui.state.weapontwo = EntityGetName(we[2]) or ""
                    Gui.state.weaponthree = EntityGetName(we[3]) or ""
                    Gui.state.weaponfour = EntityGetName(we[4]) or ""
                end
            end
        end
    end
end

function dropitem(slot)
    local player = EntityGetWithTag("player_unit")[1]
    local x, y = EntityGetTransform(player)
    local pchildren = EntityGetAllChildren(player)
    for i,v in ipairs(pchildren) do
        if EntityGetName(v) == "inventory_quick" then
            local we = EntityGetAllChildren(v)
            if we ~= nil and #we ~= 0 then
                EntityRemoveFromParent(we[slot])
                --GameDropPlayerInventoryItems(we[slot])
                EntitySetTransform( we[slot], x, y )
            end
        end
    end
end

function OnWorldPostUpdate()
    if EntityGetWithTag("player_unit")[1] ~= nil then
        Gui:Render()
    end
end

Gui:AddElement(gusgui.Elements.VLayout({
    id = "TheThings",
    margin = { bottom = 10, left = 130},
    overideZ = 18,
    children = {
        gusgui.Elements.ImageButton({
            id = "HeldItemImage",
            margin = { left = 0, top = 0, },
            overrideZ = 17,
            scaleX = 5,
            scaleY = 5,
            drawBackground = true,
            drawBorder = true,
            padding = 5,
            src = Gui:StateValue("helditem"),
            onClick = function(element, state)
            end,
        }),
        gusgui.Elements.HLayout({
            id = "Things",
            margin = {},
            overideZ = 19,
            children = {
                gusgui.Elements.ProgressBar({
                    id = "HealthBar",
                    width = 100,
                    height = 15,
                    overrideZ = 21,
                    barColour = "green",
                    value = Gui:StateValue("hpbar"),
                }),
                gusgui.Elements.Text({
                    id = "HealthText",
                    overrideZ = 1000000000,
                    margin = { left = -100, },
                    value = "${hp}",
                    --colour = { 148, 128, 100 },
                    padding = 1,
                    drawBorder = false,
                    drawBackground = false,  
                }), 
                gusgui.Elements.Text({
                    id = "AmmoText",
                    overrideZ = 19,
                    margin = { left = 100, },
                    value = "Ammo: ${AmmoCount} / ${AmmoMax}",
                    --hidden = Gui:StateValue("hideammo"),
                    padding = 1,
                    drawBorder = true,
                    drawBackground = true,
                }),    
            },
        })
    },
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "TheStuff",
    margin = { left = 600, top = 380, },
    overrizeZ = 15,
    children = {
        gusgui.Elements.HLayout({
            id = "wallet",
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
                --[[gusgui.Elements.Text({
                    id = "MoveTimerText",
                    margin = { top = 0, left = 50, },
                    overrideZ = 17,
                    value = "${movetimer}",
                }),]]--
            },
        }),
        gusgui.Elements.ProgressBar({
            id = "KickCDbar",
            width = 100,
            height = 15,
            overrideZ = 18,
            barColour = "white",
            value = Gui:StateValue("kickbar")
        }),
        --[[gusgui.Elements.ProgressBar({
            id = "MoveTimeBar",
            width = 50,
            height = 5,
            overrideZ = 18,
            barColour = "blue",
            value = Gui:StateValue("movebar")
        }),]]--
       --[[gusgui.Elements.Text({
            id = "KickCDText",
            overrideZ = 17,
            value = " Dash Cooldown: ${kickcd}",
        }),]]--
    },
}))

Gui:AddElement(gusgui.Elements.HLayout({
    id = "Inventory",
    margin = {},
    overrideZ = 30,
    hidden = Gui:StateValue("showinv"),
    onBeforeRender = function(element)
        element.config.hidden = flipbool(GameIsInventoryOpen())
    end,
    children = {
            gusgui.Elements.VLayout({
            id = "WeaponsEquipped",
            margin = { top = 30, left = 10, },
            overrideZ = 31,
            children = {
                gusgui.Elements.Button({
                    id = "WeaponOne",
                    margin = { top = 30, left = 0, },
                    overrideZ = 17,
                    text = "Slot 1: ${weaponone}",
                    --hidden = (Gui:StateValue("weaponone") == ""),
                    onClick = function(element, state)
                        dropitem(1)
                    end,
                }),
                gusgui.Elements.Button({
                    id = "WeaponTwo",
                    margin = { top = 0, left = 0, },
                    overrideZ = 17,
                    text = "Slot 2: ${weapontwo}",
                    --hidden = (Gui:StateValue("weapontwo") == ""),
                    onClick = function(element, state)
                        dropitem(2)
                    end,
                }),
                gusgui.Elements.Button({
                    id = "WeaponThree",
                    margin = { top = 0, left = 0, },
                    overrideZ = 17,
                    text = "Slot 3: ${weaponthree}",
                    --hidden = (Gui:StateValue("weaponthree") == ""),
                    onClick = function(element, state)
                        dropitem(3)
                    end,
                }),
                gusgui.Elements.Button({
                    id = "WeaponFour",
                    margin = { top = 0, left = 0, },
                    overrideZ = 17,
                    text = "Slot 4: ${weaponfour}",
                    --hidden = (Gui:StateValue("weaponfour") == ""),
                    onClick = function(element, state)
                        dropitem(4)
                    end,
                }),
            },
        }),
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