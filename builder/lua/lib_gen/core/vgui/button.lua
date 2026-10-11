local PANEL = {}

surface.CreateFont("libgen_button", {
    font = "Roboto",
    size = 18,
    weight = 1500,
    antialias = true,
    shadow = false,
})

function PANEL:Init()
    self:Dock(TOP)
    self:SetText("")
    self:SetPos(0, 0)
    self:SetSize(self:GetParent():GetWide(), 25)
    self:DockMargin(0, 0, 0, 2)
end

function PANEL:SetClickableText(text)
    self.Text = text
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(22, 22, 22, 255))
    draw.SimpleText(tostring(self.Text), "libgen_button", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("libgen_button", PANEL, "DButton")
