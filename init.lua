ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/mould/files/actions.lua" )
ModMagicNumbersFileAdd( "mods/mould/files/magic_numbers.xml" ) 
dofile_once("mods/mould/lib/DialogSystem/init.lua")("mods/mould/lib/DialogSystem")

local nxml = dofile_once("mods/mould/lib/nxml.lua")

-- biomes
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
    <Biome height_index="0" color="ff6649d8" biome_filename="mods/mould/files/biome/hiisibase/main.xml" />
    <Biome height_index="0" color="ff4e46ff" biome_filename="mods/mould/files/biome/hiisibase/other.xml" /> 
    <Biome height_index="0" color="ff4e67d5" biome_filename="mods/mould/files/biome/hiisibase/exit.xml" />

    <Biome height_index="0" color="ff3d4229" biome_filename="mods/mould/files/biome/solid/cave.xml" />
    <Biome height_index="0" color="ff020202" biome_filename="mods/mould/files/biome/solid/empty.xml" />
    
    <Biome height_index="0" color="ff5d9135" biome_filename="mods/mould/files/biome/surface/grassy.xml" />

    <Biome height_index="0" color="ffffa35b" biome_filename="mods/mould/files/biome/deadvillage/well.xml" />
]])
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

-- set
ModTextFileSetContent( "data/biome/_pixel_scenes.xml", ModTextFileGetContent("mods/mould/files/set/_pixel_scenes.xml") )

-- player
function OnPlayerSpawned( player ) 
    
    if GameHasFlagRun("mouldplayer") then return end

    local dx = 1732
    local dy = 1764

    EntitySetTransform(player, dx, dy)

    GameAddFlagRun("mouldplayer")
end