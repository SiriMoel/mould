dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/inventory.lua")
dofile_once("mods/mould/files/scripts/status_list.lua")
dofile_once("mods/mould/files/scripts/goals.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
local gusgui = dofile_once("mods/mould/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_pdm, comp_controls
local hp = 0
local max_hp = 0
local max_hp_old = 0
local hpbar = 0
local active_item = 0
local moveTimeVSC = 0

function OnWorldPreUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
        comp_pdm = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
        local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent")
        local comp_inv2 = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
        local comp_kickcd = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "kickcd")
        if comp_pdm ~= nil then
            hp = ComponentGetValue2(comp_pdm, "hp")
            max_hp = ComponentGetValue2(comp_pdm, "max_hp")
            max_hp_old = ComponentGetValue2(comp_pdm, "max_hp_old")
            hpbar = (math.floor((hp * 25) + 0.5) / (max_hp * 25)) * 100
            Gui.state.hpbar = hpbar
            Gui.state.hp = math.floor((hp * 25) + 0.5)
            Gui.state.maxhp = max_hp * 25
            Gui.state.maxhpold = max_hp_old * 25
        end
        if comp_inv2 ~= nil and ComponentGetValue2(comp_inv2, "mActiveItem") ~= 0 then
            active_item = ComponentGetValue2(comp_inv2, "mActiveItem")
            --Gui.state.helditemname = EntityGetName(active_item)[1] or ""
            local comp_activeitemsprite = EntityGetFirstComponentIncludingDisabled(active_item,
                "VariableStorageComponent", "sprite_file")
            if comp_activeitemsprite ~= nil then
                local sprite = ComponentGetValue2(comp_activeitemsprite, "value_string")
                Gui.state.helditem = sprite
            end
            local comp_ammocount = EntityGetFirstComponentIncludingDisabled(active_item, "VariableStorageComponent",
                "ammo_count")
            local comp_ammomax = EntityGetFirstComponentIncludingDisabled(active_item, "VariableStorageComponent",
                "ammo_max")
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
        if comp_wallet then
            Gui.state.wallet = ComponentGetValue2(comp_wallet, "money")
        end
        moveTimeVSC = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "movetimer") or 0
        if moveTimeVSC then Gui.state.movetimer = ComponentGetValue2(moveTimeVSC, "value_int") end
        if comp_kickcd then
            Gui.state.kickcd = ComponentGetValue2(comp_kickcd, "value_int")
            Gui.state.kickbar = (ComponentGetValue2(comp_kickcd, "value_int") / 30) * 100
        end
        --Gui.state.movebar = (ComponentGetValue2( comp_mt, "value_int" ) / 500) * 100
        local pchildren = EntityGetAllChildren(player)
        if pchildren == nil then return end
        for i,v in ipairs(pchildren) do
            if EntityGetName(v) == "inventory_quick" then
                local we = EntityGetAllChildren(v)
                if we == nil then we = {} end
                for weapon = 1, 8 do
                    local wp = we[weapon]
                    local comp_ability = EntityGetFirstComponentIncludingDisabled(wp, "AbilityComponent")
                    if comp_ability ~= nil then
                        local rt = ComponentObjectGetValue2(comp_ability, "gun_config", "reload_time")
                        local cd = ComponentObjectGetValue2(comp_ability, "gunaction_config", "fire_rate_wait")
                        local actions = ""
                        local deck = GetActionsOnWand(wp)
                        for i,v in ipairs(deck) do
                            actions = actions .. (GetActionInfo(v, "name") or "") .. ", "
                        end
                        Gui.state["weapon" .. tostring(weapon)] = EntityGetName(wp) or ""
                        Gui.state["weapon" .. tostring(weapon) .. "_rt"] = "RT: " .. (rt or "")
                        Gui.state["weapon" .. tostring(weapon) .. "_cd"] = "CD: " .. (cd or "")
                        Gui.state["weapon" .. tostring(weapon) .. "_ac"] = (actions or "")
                    else
                        Gui.state["weapon" .. tostring(weapon)] = "No item in slot " .. tostring(weapon)
                        Gui.state["weapon" .. tostring(weapon) .. "_rt"] = ""
                        Gui.state["weapon" .. tostring(weapon) .. "_cd"] = ""
                        Gui.state["weapon" .. tostring(weapon) .. "_ac"] = ""
                    end
                end
            end
        end
    end
end

function dropitem(slot) end

function OnWorldPostUpdate()
    if EntityGetWithTag("player_unit")[1] ~= nil then
        Gui:Render()
    end
end

--[[Gui:AddElement(gusgui.Elements.VLayout({
    id = "goals",
    margin = {},
    overideZ = 18,
    onBeforeRender = function (element)
        element.config.children = {}
        for i,v in ipairs(Goals) do
            if Goals:isactive(v.id) then
                table.insert(element.config.children, {
                    gusgui.Elements.Text({
                        id = "goal_" .. i,
                        overrideZ = 19,
                        value = v.name,
                        padding = 1,
                        drawBorder = true,
                        drawBackground = true,
                    }),
               })
            end
        end
    end,
    children = {},
}))]]--

Gui:AddElement(gusgui.Elements.VLayout({
    id = "TheThings",
    margin = { bottom = 10, left = 130 },
    overideZ = 18,
    onBeforeRender = function(element)
        local e = true
        if active_item ~= 0 then
            e = false
        end
        element.config.hidden = e
    end,
    children = {
        gusgui.Elements.HLayout({
            id = "HeldItem",
            overideZ = 18,
            children = {
                gusgui.Elements.ImageButton({
                    id = "HeldItemImage",
                    margin = { left = 0, top = 0, },
                    overrideZ = 19,
                    scaleX = 5,
                    scaleY = 5,
                    drawBackground = true,
                    drawBorder = true,
                    padding = 5,
                    src = Gui:StateValue("helditem"),
                    onBeforeRender = function(element)
                        element.config.hidden = active_item == 0
                    end,
                    onClick = function(element, state)
                    end,
                }),
                gusgui.Elements.Text({
                    id = "HeldItemText",
                    value = "", --"${helditemname}",
                    drawBackground = true,
                    drawBorder = true,
                }),
            },
        }),
        gusgui.Elements.HLayout({
            id = "Things",
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
                    onBeforeRender = function(element)
                        element.config.hidden = active_item == 0
                    end,
                }),
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
                    },
                }),
                gusgui.Elements.VLayout({
                    id = "MovementStuff",
                    overrideZ = 17,
                    children = {
                        gusgui.Elements.ProgressBar({
                            id = "KickCDbar",
                            width = 100,
                            height = 15,
                            overrideZ = 18,
                            barColour = "white",
                            value = Gui:StateValue("kickbar")
                        }),
                        --[[gusgui.Elements.Text({
                            id = "movetimertext",
                            overrideZ = 17,
                            value = "${movetimer}",
                        }),]]--
                    },
                }),
                --[[gusgui.Elements.Text({
                    id = "StatusEffects",
                    margin = { left = 10, },
                    overrideZ = 20,
                    value = "",
                    onBeforeRender = function(element)          
                        statuses = ""
                        for i,v in ipairs(status_list) do
                            if v.on == true then
                                statuses = statuses .. v.name .. " " .. v.duration .. " " .. v.stacks .. ", "
                                element.config.value = statuses
                            end
                        end
                    end,
                }),]]--
            },
        })
    },
}))

local circuitrysize = 2
Gui:AddElement(gusgui.Elements.VLayout({
    id = "circuitry",
    margin = { top = 25, right = 25, },
    overrideZ = 49,
    hidden = Gui:StateValue("showinv"),
    onBeforeRender = function(element)
        element.config.hidden = not GameIsInventoryOpen()
    end,
    children = {
        gusgui.Elements.Image({
            id = "background",
            margin = {},
            overrideZ = 50,
            src = "mods/mould/files/gui/inv_background.png",
            scaleX = circuitrysize,
            scaleY = circuitrysize,
        }),
        gusgui.Elements.HLayout({
            id = "shards",
            margin = { left = 6, top = -305, },
            overrideZ = 51,
            scaleX = circuitrysize,
            scaleY = circuitrysize,
            children = {
                gusgui.Elements.ImageButton({
                    id = "shard_1",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 1 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(1, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_2",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 2 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(2, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_3",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 3 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(3, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_4",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 4 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(4, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_5",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 5 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(5, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_6",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 6 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(6, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_7",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 7 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(7, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_8",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 8 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(8, true)
                    end,
                }),
                gusgui.Elements.ImageButton({
                    id = "shard_9",
                    margin = {},
                    overrideZ = 52,
                    src = "",
                    scaleX = circuitrysize,
                    scaleY = circuitrysize,
                    onBeforeRender = function(element)
                        for i,v in ipairs(shards_list) do
                            if v.id == 9 then
                                if v.collected == true then
                                    element.config.src = "mods/mould/files/gui/shard_yes.png"
                                else
                                    element.config.src = "mods/mould/files/gui/shard_no.png"
                                end
                            end
                        end
                    end,
                    onClick = function(element, state)
                        DropShard(9, true)
                    end,
                }),
            },
        }),
        gusgui.Elements.Image({
            id = "shardicons",
            margin = { top = -90, left = 6, },
            overrideZ = 55,
            src = "mods/mould/files/gui/shard_icons.png",
            scaleX = circuitrysize,
            scaleY = circuitrysize,
        }),
    },
}))

Gui:AddElement(gusgui.Elements.HLayout({
    id = "Inventory",
    margin = {},
    overrideZ = 30,
    hidden = Gui:StateValue("showinv"),
    onBeforeRender = function(element)
        element.config.hidden = not GameIsInventoryOpen()
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
                    text = "${weapon1} ${weapon1_rt} ${weapon1_cd} ${weapon1_ac}",
                    onClick = function(element, state)
                        dropitem(1)
                    end,
                }),
                gusgui.Elements.Button({
                    id = "WeaponTwo",
                    margin = { top = 0, left = 0, },
                    overrideZ = 17,
                    text = "${weapon2} ${weapon2_rt} ${weapon2_cd} ${weapon2_ac}",
                    onClick = function(element, state)
                        dropitem(2)
                    end,
                }),
                gusgui.Elements.Button({
                    id = "WeaponThree",
                    margin = { top = 0, left = 0, },
                    overrideZ = 17,
                    text = "${weapon3} ${weapon3_rt} ${weapon3_cd} ${weapon3_ac}",
                    onClick = function(element, state)
                        dropitem(3)
                    end,
                }),
                gusgui.Elements.Button({
                    id = "WeaponFour",
                    margin = { top = 0, left = 0, },
                    overrideZ = 17,
                    text = "${weapon4} ${weapon4_rt} ${weapon4_cd} ${weapon4_ac}",
                    onClick = function(element, state)
                        dropitem(4)
                    end,
                }),
                gusgui.Elements.Button({ -- not a weapon
                    id = "WeaponFive",
                    overrideZ = 17,
                    text = "${weapon5}",
                    onClick = function(element, state)
                        dropitem(5)
                    end,
                }),
                gusgui.Elements.Button({ -- not a weapon
                    id = "WeaponSix",
                    overrideZ = 17,
                    text = "${weapon6}",
                    onClick = function(element, state)
                        dropitem(6)
                    end,
                }),
                gusgui.Elements.Button({ -- not a weapon
                    id = "WeaponSeven",
                    overrideZ = 17,
                    text = "${weapon7}",
                    onClick = function(element, state)
                        dropitem(7)
                    end,
                }),
                gusgui.Elements.Button({ -- not a weapon
                    id = "WeaponEight",
                    overrideZ = 17,
                    text = "${weapon8}",
                    onClick = function(element, state)
                        dropitem(8)
                    end,
                }),
            },
        }),
    },
}))