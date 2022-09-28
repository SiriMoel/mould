dofile_once("mods/mould/files/biome/deadvillage/inherit.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/deadvillage/2.png", "mods/mould/files/biome/deadvillage/2v.png", x, y, "mods/mould/files/biome/deadvillage/2b.png", true )
end