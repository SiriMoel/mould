dofile_once("data/scripts/lib/utilities.lua")

local hiisiquirks = { -- PLACEHOLDERS
    "ELECTRIC_CHARGE",
    "SPEED",
    "SPREAD_REDUCE",
}

function hgun( capacity, actions, quirkm, statsm ) -- hiisi gun
    -- weapon capacity (to set), #actions in gun, quirk chance multiplier, stats max multiplier
    local weapon = GetUpdatedEntityID()
    local mqc = capacity - actions -- max quirks count

    if statsm == nil then
        statsm = 2
    end

    local ac = EntityGetComponent( weapon, "AbilityComponent" )[1] -- abilitycomponent

    if ac ~= nil then
        --capacity
        w( capacity )

        --quirks
        local cqc = 0 -- current quirk count
        while cqc <= mqc do
            quirkm = quirkm + math.floor( ( 1.1 ^ ( cqc + 1 ) ) + 0.5 )
            local quirk = hiisiquirks[math.random(1, #hiisiquirks)]
            local qc = math.floor( ( 3 * quirkm ) + 0.5 ) -- quirk chance
            Print("quirk chance is " .. qc)
            local ifquirk = math.random(1, qc)
            if ifquirk == 2 then
                AddGunAction( weapon, quirk )
                cqc = cqc + 1
            end
        end

        --stats
        statsm = math.random( 100, (statsm * 100) )
        statsm = statsm / 100
        s( statsm )
    end
end

function w( capacity )
    local weapon = GetUpdatedEntityID()
    local ac = EntityGetComponent( weapon, "AbilityComponent" )[1] -- abilitycomponent
    local dc = tonumber( ComponentObjectGetValue( ac, "gun_config", "deck_capacity" ) ) -- deck capacity 
    local dc = capacity
    ComponentObjectSetValue( ac, "gun_config", "deck_capacity", tostring(dc) )
end

function s( m )
    local weapon = GetUpdatedEntityID()
    local ac = EntityGetComponent( weapon, "AbilityComponent" )[1]

    -- base stats should be the LOWEST possible

    local rt = tonumber( ComponentObjectGetValue( ac, "gun_config", "reload_time" ) ) -- reload time
    local sm = tonumber( ComponentObjectGetValue( ac, "gun_config", "speed_multiplier" ) ) -- speed multiplier
    --local sd = tonumber( ComponentObjectGetValue( ac, "gun_config", "spread_degrees" ) ) -- spread degrees
    local frw = tonumber( ComponentObjectGetValue( ac, "gunaction_config", "fire_rate_wait" ) ) -- fire rate wait

    rt = rt / (m * 0.6)
    sm = sm * (m * 0.3)
    --sd = sd * (m * 0.5)
    frw = frw / (m * 0.6)

    ComponentObjectSetValue( ac, "gun_config", "reload_time", tostring(rt) )
    ComponentObjectSetValue( ac, "gun_config", "speed_multiplier", tostring(sm) )
    --omponentObjectSetValue( ac, "gun_config", "spread_degrees", tostring(sd) )
    ComponentObjectSetValue( ac, "gunaction_config", "fire_rate_wait", tostring(frw) )

    Print("Weapon created with " .. m .. "x stats multiplier.") 
end