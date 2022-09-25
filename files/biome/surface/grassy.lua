CHEST_LEVEL = 3

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/surface/grassy.png", "", x, y, "mods/mould/files/biome/hiisibase/exit_background.png", true )
end