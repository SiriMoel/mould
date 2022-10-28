dofile_once("mods/mould/files/scripts/utils.lua")

local gd = 0 -- Goals displayed
local renderedGoals = {}
local failedGoals = {} -- this could be used when displayind end of run stats

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
        rendergoal(id)
    end
end

function Goals:complete(id)
    GameRemoveFlagRun("goal_" .. id)
    GameAddFlagRun("DONE_goal_" .. id)
    stoprendergoal(id)
end

function Goals:remove(id)
    GameRemoveFlagRun("goal_" .. id)
    stoprendergoal(id)
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
    stoprendergoal(id)
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

local function rendergoal(id)
    gd = gd + 1
    -- render goal
    table.insert(renderedGoals, id)
end

local function stoprendergoal(id)
    if gd > 0 then 
        gd = gd - 1
    end
    -- stop rendering goal
    for i,v in ipairs(renderedGoals) do
        if v == id then
            table.remove(renderedGoals, i)
            break
        end
    end
    for i,v in ipairs(renderedGoals) do
        -- move up in gui location due to free stop
    end
end