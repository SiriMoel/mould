CHEST_LEVEL = 3
dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffb4a700, "bogstructure" )
RegisterSpawnFunction( 0xffc7a1dc, "enemy_ground") --[[
]]--
RegisterSpawnFunction( 0xffe80000, "enemy_flying" ) --[[
    small gelatinous cube (slightly ominous cube, fast but clunky movement, drops kinda random loot)
    slime-possessed guns (shotgun, pistol, sniper)
]]--
RegisterSpawnFunction( 0xff1635ff, "enemy_miniboss" ) --[[
    large gelatinous cube (very ominous cube, fast but clunky movement, drops very random loot)
]]--

local structures = { -- these are placeholders (for now)
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree1.xml",
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree2.xml",
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree3.xml",
}

function init( x, y, w, h ) end

function bogstructure( x, y )
    local structure = structures[math.random(1,#structures)]
    EntityLoad(structure, x, y)
end

function enemy_ground( x, y ) end

function enemy_flying( x, y ) end

function enemy_miniboss( x, y ) end