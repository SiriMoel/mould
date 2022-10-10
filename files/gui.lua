local gusgui = dofile_once("mods/mould/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()
function OnWorldPostUpdate()
    Gui:Render()
end
