util.AddNetworkString("Builder_Menu")
util.AddNetworkString("Builder_Built")
util.AddNetworkString("Builder_StopHeat")
local Builder = {
    Core = {}
}

function Builder.Core.Add(ply, ent, points, maxpointer)
    local max = math.Clamp(points, 0, maxpointer)
    ent.AddScore = max
    net.Start("Builder_Built")
    net.WriteEntity(ent)
    net.WriteFloat(ent.AddScore)
    net.Send(ply)
end
return Builder