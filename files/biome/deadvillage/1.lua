dofile_once("mods/mould/files/biome/deadvillage/inherit.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/mould/files/biome/deadvillage/1.png", "mods/mould/files/biome/deadvillage/1v.png", x, y, "mods/mould/files/biome/deadvillage/1b.png", true )
end