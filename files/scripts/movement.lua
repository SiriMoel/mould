dofile_once("mods/mould/files/scripts/utils.lua")

local player = GetUpdatedEntityID()
local comp_cp = EntityGetFirstComponentIncludingDisabled(player, "CharacterPlatformingComponent")
local comp_timer = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "movetimer")
local comp_cd = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "kickcd")
local x, y = EntityGetTransform(player)

if comp_cp == nil or comp_timer == nil then
    return
end

local startframe = GameGetFrameNum()
local timer = ComponentGetValue2(comp_timer, "value_int")
local cd = ComponentGetValue2(comp_cd, "value_int")
local is_moving = false
local yes = 0

local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
if ComponentGetValue2(comp_controls, "mButtonDownUp") == true or ComponentGetValue2(comp_controls, "mButtonDownLeft") ==
    true or ComponentGetValue2(comp_controls, "mButtonDownRight") == true then
    is_moving = true
else
    is_moving = false
end

if is_moving ~= false then
    if timer < 500 then
        timer = timer + 1
    end
end
if is_moving == false then
    -- GamePrint("you are not moving")
    timer = 0
end

if cd > 0 then
    cd = cd - 1
end

if ComponentGetValue2(comp_controls, "mButtonDownKick") == true then
    if cd <= 0 then
        --GamePrint("kick")
        timer = 0
        cd = 30
        -- shoot_projectile( player, "mods/mould/files/entities/misc/playerkick/kick.xml", x, y, "200", "200" )
        --[[local comp = EntityGetFirstComponent(player, "CharacterDataComponent")
        if comp ~= nil then
            local posX, posY, angle, sclX, sclY = EntityGetTransform(player)
            local velX, velY = ComponentGetValueVector2(comp, "mVelocity")
            local offsetX = (sclX < 0) and posX - 100 or posX + 100
            local offsetY = posY + 3
            local l = math.sqrt((offsetX ^ 2) + (offsetY ^ 2))
            local forceX, forceY = 50, 50 -- how powerful the movement is 
            ComponentSetValue2(comp, "mVelocity", velX + (offsetX / l * forceX), velY + (offsetY / l * forceY))
        end]]--

        --[[
            this is a copi thing
        ]]--
        local entity_id = GetUpdatedEntityID()
            local controls_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
            if controls_comp ~= nil then

                local character_data_comp = EntityGetFirstComponent(entity_id, "CharacterDataComponent")
                if character_data_comp ~= nil then

                    local caster = {
                        velocity = {x = 0, y = 0},
                        position = {x = 0, y = 0},
                    }
                    local mouse = {
                        position = {x = 0, y = 0},
                    }

                    caster.position.x,  caster.position.y   = EntityGetTransform(entity_id)
                    caster.velocity.x,  caster.velocity.y   = ComponentGetValueVector2(character_data_comp, "mVelocity")
                    mouse.position.x,   mouse.position.y    = ComponentGetValueVector2(controls_comp, "mMousePosition")

                    local offset = {
                        x = mouse.position.x - caster.position.x,
                        y = mouse.position.y - caster.position.y,
                    }
                    local force = {
                        x = 400,
                        y = 200,
                    }

                    local len = math.sqrt((offset.x ^ 2) + (offset.y ^ 2))
                    caster.velocity.x = caster.velocity.x + (offset.x / len * force.x)
                    caster.velocity.y = caster.velocity.y + (offset.y / len * force.y)

                    ComponentSetValue2(character_data_comp, "mVelocity", caster.velocity.x, caster.velocity.y)
                end
            end
    end
end

ComponentSetValue2(comp_timer, "value_int", timer)
ComponentSetValue2(comp_cd, "value_int", cd)
