CHEST_LEVEL = 3
dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffb4a700, "bogstructure" )
RegisterSpawnFunction( 0xffc7a1dc, "enemy_ground") --[[
    slime-possessed hiisi shotgunner
    slimey mass
]]--
RegisterSpawnFunction( 0xffe80000, "enemy_flying" ) --[[
    slightly ominous cube (fast but clunky movement, drops kinda random loot)
    slime-possessed guns (shotgun, pistol, sniper)
]]--
RegisterSpawnFunction( 0xff1635ff, "enemy_miniboss" ) --[[
    very ominous cube (fast but clunky movement, drops very random loot)
]]--

local structures = { -- these are placeholders (for now)
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree1.xml",
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree2.xml",
    "mods/mould/files/biome/caverns/swamp/bogstructures/tree3.xml",
}

g_enemy_ground = {}

g_enemy_flying = {
    total_prob = 0,
    {
        prob = 0.5,
        min_count = 0,
        max_count = 0,
        entity = ""
    },
    {
        prob = 1,
        min_count = 1,
        max_count = 2,
        entity = "mods/mould/files/entities/animals/slime_shotgun/entity.xml"
    },
}

g_enemy_minoboss = {}

function init( x, y, w, h ) end

function bogstructure( x, y )
    local structure = structures[math.random(1,#structures)]
    EntityLoad(structure, x, y)
end

function enemy_ground( x, y ) end

function enemy_flying( x, y ) end

function enemy_miniboss( x, y ) end