dofile_once("mods/mould/files/biome/deadvillage/inherit.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/deadvillage/well_down.png", "", x, y, "", true )
end