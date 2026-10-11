local PANEL = {}

function PANEL:Init()
    self.Text = ""

    self:SetText("")
    self:SizeToContents()

    self:SetSize(self:GetClickableText(), 100)
end

function PANEL:SetClickableText(text)
    self.Text = tostring(text or "")

    surface.SetFont("libgen_button")
    self:SetWide(surface.GetTextSize(self.Text))
end

function PANEL:GetClickableText()
    surface.SetFont("libgen_button")
    return surface.GetTextSize(self.Text or "")
end

function PANEL:Paint(w, h)
    draw.RoundedBox(12, 0, 0, w, h, Color(22, 22, 22, 0))

    draw.SimpleText(
        self.Text,
        "libgen_button",
        w / 2,
        h / 2 - 40,
        color_white,
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )
end

vgui.Register("libgen_label", PANEL, "DPanel")
