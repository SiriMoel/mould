dofile("data/scripts/lib/utilities.lua")

function table.contains(table, element)
        for _, value in pairs(table) do
            if value == element then
            return true
        end
    end
    return false
end