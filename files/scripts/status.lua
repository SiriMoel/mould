dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/status_list.lua")

for i,v in ipairs(status_list) do
    if v.duration < 0 then
        v.duration = 0
        v.on = false
        v.onRemoved(v.stacks)
        v.stacks = 0
    end
    if v.on == true then
        v.perFrame(v.stacks)
        v.duration = v.duration - 1
    end
end