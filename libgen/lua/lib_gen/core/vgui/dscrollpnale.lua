local PANEL = {}

function PANEL:Init()
    self:Dock(FILL)
    //self:SetPos(12, 25)
    //self:SetSize(200, self:GetParent():GetTall() - 35)
    self.VBar.Paint = function(s,w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(12, 12, 12, 255))
    end
end

vgui.Register("libgen_scrollpanel", PANEL, "DScrollPanel")
