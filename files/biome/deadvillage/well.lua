dofile_once("mods/mould/files/biome/deadvillage/inherit.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/deadvillage/well.png", "mods/mould/files/biome/deadvillage/wellv.png", x, y, "mods/mould/files/biome/deadvillage/wellb.png", true )
end