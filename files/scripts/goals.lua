dofile_once("mods/mould/files/scripts/utils.lua")

local gd = 0 -- Goals displayed
local failedGoals = {} -- this could be used when displaying end of run stats

Goals = {
    {
        id = "intro_armoury",
        name = "Acquire weapon",
        desc = "go to the armoury and select a weapon",
    },
    {
        id = "intro_maproom",
        name = "Talk to Sormi",
        desc = "go to the map room and talk to Sormi for your task",
    },
    {
        id = "retrievemap",
        name = "Retrieve Lost Map Piece",
        desc = "Head west to find Sormi\'s lost map piece",
    },
}

function Goals:assign(id)
    if GameHasFlagRun("goal_" .. id) ~= true and GameHasFlagRun("DONE_goal_" .. id) ~= true then
        GameAddFlagRun("goal_" .. id)
    end
end

function Goals:complete(id)
    GameRemoveFlagRun("goal_" .. id)
    GameAddFlagRun("DONE_goal_" .. id)
end

function Goals:remove(id)
    GameRemoveFlagRun("goal_" .. id)
end

function Goals:fail(id, addflag)
    GameRemoveFlagRun("goal_" .. id)
    for i,v in ipairs(Goals) do
        if v == id then
            if v["failfunc"] ~= nil then
                failed = v["failfunc"]
                failed()
            end
            if v["failmessage"] ~= nil then
                GamePrint(v["failmessage"])
            else
               GamePrint("Goal failed.") 
            end
            break
        end
    end
    if addflag == true then
        GameAddFlagRun("FAILED_goal_" .. id)
        if table.contains(failedGoals, id) ~= true then
            table.insert(failedGoals, id)
        end
    end
end

function Goals:iscompleted(id)
    if GameHasFlagRun("DONE_goal_" .. id) then
        return true
    else
       return false 
    end
end

function Goals:isactive(id)
    if GameHasFlagRun("goal_" .. id) then
        return true
    else
        return false
    end
end