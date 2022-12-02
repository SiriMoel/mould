dofile_once("mods/mould/files/scripts/utils.lua")

local player = EntityGetWithTag("player_unit")[1]

local iconpath = "/"
status_list = {
    {
        id = "toxic_slimed",
        name = "Toxic Slimed",
        icon = iconpath .. "" .. ".png",
        on = false,
        stackable = false,
        duration = 0,
        defaultDuration = 240,
        stacks = 0,
        maxStacks = 1,
        stained = true,
        material = "mould_toxic_slime",
        perFrame = function(stacks) 
            GamePrint("toxic slimed " .. v.duration)
        end,
        onAdded = function() end,
        onRemoved = function(stacks) end,
    },
}