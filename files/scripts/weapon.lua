dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local entity = GetUpdatedEntityID()
local z, i, c, v, b, n = GameGetDateAndTimeLocal()
local x, y = EntityGetTransform(entity)
math.randomseed(z+i+c+v+b+n+x+y)

local hiisiquirks = { -- PLACEHOLDERS
    "ELECTRIC_CHARGE",
    "SPEED",
    "SPREAD_REDUCE",
}

function init( weapon )
    EntityAddComponent( weapon, "LuaComponent", {
        _tags="enabled_in_hand",
        script_source_file="mods/mould/files/scripts/weaponthrow.lua",
        execute_every_n_frame="1",
    } )
end

function hgun( weapon, capacity, actions, statsm, doquirks ) -- hiisi gun
    -- weapon id, weapon capacity (to set), #actions in gun, quirk chance multiplier, stats max multiplier
    local mqc = capacity - actions -- max quirks count

    if statsm == nil then
        statsm = 2
    end

    local ac = EntityGetComponent( weapon, "AbilityComponent" )[1] -- abilitycomponent

    if ac ~= nil then
        --capacity
        w( capacity )

        --stats
        local sm = r(statsm)
        s( sm )

        --quirks
        local cqc = 0 -- current quirk count
        local cqt = 0 -- current quirk tries
        while cqt <= mqc do
            if not doquirks then return end
            if cqt == mqc then return end
            local quirk = hiisiquirks[math.random(1, #hiisiquirks + (math.floor((#hiisiquirks * 1.3) - 1 )))]
            if quirk ~= nil then
                AddGunAction( weapon, quirk )
                cqc = cqc + 1
            end
            cqt = cqt + 1
        end 
    end
end

function frisbee( weapon, capacity, statsm )
    w( capacity )
    local sm = r(statsm)
    s( sm )
    EntityAddComponent( weapon, "LuaComponent", {
        _tags="enabled_in_hand",
        script_source_file="mods/mould/files/scripts/frisbee.lua",
		execute_every_n_frame="3",
		execute_times="-1",
    } )
end

function w( capacity )
    local weapon = GetUpdatedEntityID()
    local acs = EntityGetComponentIncludingDisabled( weapon, "AbilityComponent" ) -- abilitycomponent
    if acs == nil then return end
    for i,ac in ipairs(acs) do
        local dc = tonumber( ComponentObjectGetValue( ac, "gun_config", "deck_capacity" ) ) -- deck capacity 
        local dc = capacity
        ComponentObjectSetValue( ac, "gun_config", "deck_capacity", tostring(dc) )
        --print("capacity set")
    end
end

function s( m )
    local weapon = GetUpdatedEntityID()
    local acs = EntityGetComponentIncludingDisabled( weapon, "AbilityComponent" )

    -- base stats should be the LOWEST possible
    if acs == nil then return end
    for i,ac in ipairs(acs) do
        local rt = tonumber( ComponentObjectGetValue( ac, "gun_config", "reload_time" ) ) -- reload time
        --local sm = tonumber( ComponentObjectGetValue( ac, "gun_config", "speed_multiplier" ) ) -- speed multiplier
        --local sd = tonumber( ComponentObjectGetValue( ac, "gun_config", "spread_degrees" ) ) -- spread degrees
        local frw = tonumber( ComponentObjectGetValue( ac, "gunaction_config", "fire_rate_wait" ) ) -- fire rate wait

        --print("old rt " .. rt)
        --print("old frw " .. frw)

        rt = math.floor( ( rt / (m * 0.8) + 0.5 ) )
        --sm = sm * (m * 0.3)
        --sd = sd * (m * 0.5)
        frw = math.floor( ( frw / (m * 0.8) + 0.5 ) )

        --print("new rt " .. rt)
        --print("new frw " .. frw)

        ComponentObjectSetValue( ac, "gun_config", "reload_time", tostring(rt) )
        --ComponentObjectSetValue( ac, "gun_config", "speed_multiplier", tostring(sm) )
        --omponentObjectSetValue( ac, "gun_config", "spread_degrees", tostring(sd) )
        ComponentObjectSetValue( ac, "gunaction_config", "fire_rate_wait", tostring(frw) )

        --print("stats set")
    end
    --print("Weapon created with " .. m .. "x stats multiplier.") 
end

function r( sm )
    local variable = 0
    variable = math.random( 100, (sm * 100) )
    variable = variable / 100
    return variable
end