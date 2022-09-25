CHEST_LEVEL = 3
dofile_once("mods/mould/files/biome/hiisibase/inherit.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/hiisibase/exit.png", "", x, y, "mods/mould/files/biome/hiisibase/exit_background.png", true )
end