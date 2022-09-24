ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/mould/files/actions.lua" )
ModMagicNumbersFileAdd( "mods/mould/files/magic_numbers.xml" ) 
dofile_once("mods/mould/lib/DialogSystem/init.lua")("mods/mould/lib/DialogSystem")

local nxml = dofile_once("mods/mould/lib/nxml.lua")

--biomes
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
    <Biome height_index="0" color="ff6649d8" biome_filename="mods/mould/files/biome/hiisibase/main.xml" />
    <Biome height_index="0" color="ff4e46ff" biome_filename="mods/mould/files/biome/hiisibase/other.xml" /> 
    <Biome height_index="0" color="ff3d4229" biome_filename="mods/mould/files/biome/solid/cave.xml" /> 
]])
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

ModTextFileSetContent( "data/biome/_pixel_scenes.xml", ModTextFileGetContent("mods/mould/files/set/_pixel_scenes.xml") )

function OnPlayerSpawned( player ) 
    
    if GameHasFlagRun("mouldplayer") then return end

    local dx = 1732
    local dy = 1764

    EntitySetTransform(player, dx, dy)

    GameAddFlagRun("mouldplayer")
end