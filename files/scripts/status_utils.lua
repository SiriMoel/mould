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
                v.stacks = v.stacks + stacks
                v.duration = duration
            else
                v.on = true
                v.stacks = 1
                v.duration = duration
            end
            for _=1,stacks do
                v.onAdded()
            end
        end
    end
end

function RemoveStatus(status, dofunc)
    for i,v in ipairs(status_list) do
        if v.id == status then
            v.on = false
            v.stacks = 0
            v.duration = 0
            if dofunc == true then
                v.onRemoved(v.stacks)
            end
        end
    end
end

function ClearStatuses( dofunc )
    for i,v in ipairs(status_list) do
        v.on = false
        v.stacks = 0
        v.duration = 0
        if dofunc == true then
            v.onRemoved(v.stacks)
        end
    end
end