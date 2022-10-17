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
    timer = timer + 1
end
if is_moving == false then
    -- GamePrint("you are not moving")
    timer = 0
end

if cd > 0 then
    cd = cd - 1
end

if ComponentGetValue2(comp_controls, "mButtonDownKick") == true then
    if cd == 0 then
        GamePrint("kick")
        timer = 0
        cd = 60 * 1
        -- shoot_projectile( player, "mods/mould/files/entities/misc/playerkick/kick.xml", x, y, "200", "200" )
        local comp = EntityGetFirstComponent(player, "CharacterDataComponent")
        if comp ~= nil then
            local posX, posY = EntityGetTransform(player)
            local velX, velY = ComponentGetValueVector2(comp, "mVelocity")
            local offsetX = "WHERE TO MOVE TO" - posX
            local offsetY = "WHERE TO MOVE TO" - posY
            local l = math.sqrt((offsetX ^ 2) + (offsetY ^ 2))
            local forceX, forceY = 50, 50 -- how powerful the movement is 
            ComponentSetValue2(comp, "mVelocity", velX + (offsetX / l * forceX), velY + (offsetY / l * forceY))
        end
    end
end

ComponentSetValue2(comp_timer, "value_int", timer)
ComponentSetValue2(comp_cd, "value_int", cd)
