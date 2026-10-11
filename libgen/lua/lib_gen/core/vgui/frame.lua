local PANEL = {}
local Library_onyaaa = Material("libnya/library_logo.png", "noclamp smooth mips")
surface.CreateFont("Library_onyaaa", {
    font = "Roboto",
    size = 26,
    weight = 180
})

function PANEL:Init()
    self.Panel = vgui.Create("Panel", self)
    self.Panel:Dock(TOP)
    self.Panel:SetTall(162)
    self.Panel.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(64, 64, 64, 255))
        draw.DrawText(self.TextTitle, "Library_onyaaa", w / 2 - 97, 0, color_white, TEXT_ALIGN_LEFT)
        surface.SetMaterial(Library_onyaaa)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(self:GetWide() / 2 - 100, 30, 128, 128)
    end

    self:SetTitle("")
    self:SetPos(100, 100)
    self:SetSize(ScrW() - 200, ScrH() - 200)
end

function PANEL:SetTitles(txt)
    self.TextTitle = txt
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(64, 64, 64, 255))
end

vgui.Register("Library_onyaaa_frame", PANEL, "DFrame")