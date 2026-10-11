include("shared.lua")
function ENT:Initialize()
end

local function Draw3DText(pos, ang, scale, text, flipView)
    if flipView then ang:RotateAroundAxis(Vector(0, 0, 1), 180) end
    cam.Start3D2D(pos, ang, scale)
    draw.SimpleTextOutlined(text, "Default", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)
    cam.End3D2D()
end

function ENT:Draw()
    self:DrawModel()
    if self.BuilderPoints == nil then self.BuilderPoints = 0 end
    if math.Round(self.BuilderPoints, 0) >= 100 then
        local text = "Voltage: " .. math.Round(self.Voltage, 0) .. "/100"
        local mins, maxs = self:GetModelBounds()
        local pos = self:GetPos() + Vector(0, 0, maxs.z + 5)
        local ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90)
        Draw3DText(pos, ang, 0.2, text, false)
        Draw3DText(pos, ang, 0.2, text, true)
        return
    end

    local text = "Built: " .. math.Round(self.BuilderPoints, 0) .. "/100"
    local mins, maxs = self:GetModelBounds()
    local pos = self:GetPos() + Vector(0, 0, maxs.z + 5)
    local ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90)
    Draw3DText(pos, ang, 0.2, text, false)
    Draw3DText(pos, ang, 0.2, text, true)
end