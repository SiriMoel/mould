CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffe6250e, "dead" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/ocean/water/water.png", "", x, y, "", true )
end

function dead( x, y )
    --EntityLoad()    
end