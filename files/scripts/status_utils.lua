dofile_once("mods/mould/files/scripts/utils.lua")
dofile_once("mods/mould/files/scripts/status_list.lua")

function ApplyStatus(status, duration, stacks)
    for i,v in ipairs(status_list) do
        if v.id == status then
            if duration == nil or duration == 0 or duration == -1 then
                duration = v.defaultDuration
            end
            if v.stackable == true then
                v.on = true
                v.stacks = stacks
                v.duration = duration
            else
                v.on = true
                v.stacks = 1
                v.duration = duration
            end
        end
    end
end