CHEST_LEVEL = 3

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
	LoadPixelScene( "mods/mould/files/biome/solid/solid.png", "", x, y, "", true )
end