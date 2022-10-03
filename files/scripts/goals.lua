dofile("mods/mould/files/scripts/utils.lua")

local gd = 0 -- goals displayed
local renderedgoals = {}
local failedgoals = {} -- this could be used when displayind end of run stats

goals = {
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

function assigngoal(id)
    if GameHasFlagRun("goal_" .. id) ~= true and GameHasFlagRun("DONE_goal_" .. id) ~= true then
        GameAddFlagRun("goal_" .. id)
        rendergoal(id)
    end
end

function completegoal(id)
    GameRemoveFlagRun("goal_" .. id)
    GameAddFlagRun("DONE_goal_" .. id)
    stoprendergoal(id)
end

function removegoal(id)
    GameRemoveFlagRun("goal_" .. id)
    stoprendergoal(id)
end

function failgoal(id, addflag)
    GameRemoveFlagRun("goal_" .. id)
    for i,v in ipairs(goals) do
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
        if table.contains(failedgoals, id) ~= true then
            table.insert(failedgoals, id)
        end
    end
    stoprendergoal(id)
end

function checkcompleted(id)
    if GameHasFlagRun("DONE_goal_" .. id) then
        return true
    else
       return false 
    end
end

function checkactive(id)
    if GameHasFlagRun("goal_" .. id) then
        return true
    else
        return false
    end
end

function rendergoal(id)
    gd = gd + 1
    -- render goal
    table.insert(renderedgoals, id)
end

function stoprendergoal(id)
    if gd > 0 then 
        gd = gd - 1
    end
    -- stop rendering goal
    for i,v in ipairs(renderedgoals) do
        if v == id then
            table.remove(renderedgoals, i)
            break
        end
    end
    for i,v in ipairs(renderedgoals) do
        -- move up in gui location due to free stop
    end
end