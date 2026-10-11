local PANEL = {}

function PANEL:Init()
    self:Dock(LEFT)
    self:SetPos(12, 25)
    self:SetSize(200, self:GetParent():GetTall() - 35)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(52, 52, 52, 255))
end

vgui.Register("libgen_liniker", PANEL, "DPanel")
