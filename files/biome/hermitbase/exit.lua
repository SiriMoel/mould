CHEST_LEVEL = 3
dofile_once("mods/mould/files/biome/hermitbase/inherit.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/hermitbase/exit.png", "", x, y, "mods/mould/files/biome/hermitbase/exit_background.png", true )
end