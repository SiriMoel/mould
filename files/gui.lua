dofile_once("mods/mould/files/scripts/utils.lua")
local gusgui = dofile_once("mods/mould/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_pdm = 0
local hp = 0
local max_hp = 0
local max_hp_old = 0

--[[function OnPlayerSpawned(player) -- this isnt necessary
    comps_pdm = EntityGetComponentIncludingDisabled( player, "DamageModelComponent" )
    print("the thing is " .. #comps_pdm)
    for i,comp in ipairs(comps_pdm) do
        if ComponentGetValue2(comp_pdm, "hp") ~= nil then
            hp = ComponentGetValue2(comp_pdm, "hp")
        end
        if ComponentGetValue2(comp_pdm, "max_hp") ~= nil then
            max_hp = ComponentGetValue2(comp_pdm, "max_hp")
            max_hp_old = max_hp
        end
        if ComponentGetValue2(comp_pdm, "max_hp_old") ~= nil then
            max_hp_old = ComponentGetValue2(comp_pdm, "max_hp")
        end
    end
    if comp_pdm ~= nil then
        print("comp_pdm isnt nil!")
    else
        print("comp_pdm is nil.")
    end
    hp = ComponentGetValue2(comp_pdm, "hp") )
    max_hp = ComponentGetValue2(comp_pdm, "max_hp_old") )
    max_hp_old = max_hp
end]]--

function OnWorldPreUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        comp_pdm = EntityGetFirstComponentIncludingDisabled( player, "DamageModelComponent" )
        if comp_pdm ~= nil then
            hp = ComponentGetValue2(comp_pdm, "hp")
            max_hp = ComponentGetValue2(comp_pdm, "max_hp")
            max_hp_old = ComponentGetValue2(comp_pdm, "max_hp_old") 
            Gui.state.hpbar = (hp / max_hp_old) * 100
            Gui.state.hp = hp * 25
            Gui.state.maxhp = max_hp * 25
            Gui.state.maxhpold = max_hp_old * 25
            GamePrint(hp)
        end
    end
end

function OnWorldPostUpdate()
    Gui:Render()
end

--[[Gui:AddElement(gusgui.Elements.HLayout({
    id = "Hotbar",
    margin = { top = 50, left = 50 },
    overrideZ = 1,
    children = {gusgui.Elements.Image({
        id = "HotbarBackground",
        overrideZ = 1,
        src = "mods/mould/files/gui/HotbarBackground.png",
    })}
}))]]--

Gui:AddElement(gusgui.Elements.VLayout({
    id = "HotbarSlots",
    margin = { top = 30, left = 30 },
    overrideZ = 15,
    children = {
        gusgui.Elements.ImageButton({
            id = "HotbarSlot1",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarSlot2",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarSlot3",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarSlot4",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarSlot5",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarSlot6",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarSlot7",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarSlot8",
            margin = { left = 0, bottom = 10, },
            overrideZ = 17,
            src = "mods/mould/files/gui/HotbarSlot.png",
            onClick = function(element, state) 
                GamePrint("test")
            end,
        }),
    },
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "HotbarItems",
    margin = { top = 30, left = 30 },
    overrideZ = 18,
    children = {
        gusgui.Elements.ImageButton({
            id = "HotbarItem1",
            margin = { left = 0, bottom = 10, },
            overrideZ = 20,
            src = "",
            onClick = function(element, state) 
                GamePrint("test")
            end,
            onBeforeRender = function(element, state) 
                ShowItem(element, 1)
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarItem2",
            margin = { left = 0, bottom = 10, },
            overrideZ = 20,
            src = "",
            onClick = function(element, state) 
                GamePrint("test")
            end,
            onBeforeRender = function(element, state) 
                ShowItem(element, 2)
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarItem3",
            margin = { left = 0, bottom = 10, },
            overrideZ = 20,
            src = "",
            onClick = function(element, state) 
                GamePrint("test")
            end,
            onBeforeRender = function(element, state) 
                ShowItem(element, 3)
            end,
        }),
        gusgui.Elements.ImageButton({
            id = "HotbarItem4",
            margin = { left = 0, bottom = 10, },
            overrideZ = 20,
            src = "",
            onClick = function(element, state) 
                GamePrint("test")
            end,
            onBeforeRender = function(element, state) 
                ShowItem(element, 4)
            end,
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
            barColour = "green",
            value = Gui:StateValue("hpbar"),
        })
    },
}))

function ShowItem(elem, slot)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_invgui = EntityGetFirstComponentIncludingDisabled(player, "InventoryGuiComponent")
    local comp_inv2 = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
    local active_item = ComponentGetValue2(comp_inv2, "mActiveItem")

    local inventory_quick = EntityGetWithName("inventory_quick")
    local inventory_open = ComponentGetValue2(comp_invgui, "mActive")

    --local item = EntityGetAllChildren(inventory_quick)[slot]

    --[[if item ~= nil then
        --GamePrint(EntityGetName(item))
        local comp_ability = EntityGetFirstComponentIncludingDisabled(item, "AbilityComponent")
        local sprite = ComponentGetValue2(comp_ability, "sprite_file")
        if sprite ~= "" then
            elem.config.scr = sprite
        end
    end]]--
    if active_item ~= nil then
        local comp_ability = EntityGetFirstComponentIncludingDisabled(active_item, "AbilityComponent")
        local sprite = ComponentGetValue2(comp_ability, "sprite_file")
        if sprite ~= "" then
            GamePrint("sprite should work")
            elem.config.scr = sprite
        end
    end
end