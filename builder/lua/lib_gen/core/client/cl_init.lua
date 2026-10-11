local function OnClickableTxt(pnl, txt)
    if IsValid(pnl) then pnl:Clear() end
    local lbl = vgui.Create("libgen_label", pnl)
    lbl:SetClickableText(txt)
end

function lib_gen:BackGroundAdding(pnl, doFunc, text)
    if IsValid(frame4) then frame4:Remove() end
    frame4 = vgui.Create("libgen_liniker", pnl)
    frame4:Dock(TOP)
    frame4:SetSize(pnl:GetWide(), pnl:GetTall() - 10)
    frame4.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
        --draw.DrawText(text, "Library_onyaaa", w / 2 - 100, h / 2 - 15, color_white, TEXT_ALIGN_LEFT)
    end

    doFunc(pnl, frame4)
    return frame4
end

hook.Add("OnLoaded", "libgen", function()
    if not LocalPlayer():HasAccess() then return end
    local frame = vgui.Create("Library_onyaaa_frame")
    frame:SetTitles("Nyaaa Library")
    frame:MakePopup()
    local frame2 = vgui.Create("libgen_liniker", frame)
    local scroll = vgui.Create("libgen_scrollpanel", frame2)
    local frame3 = vgui.Create("libgen_liniker", frame)
    frame3:Dock(FILL)
    local dbtn = vgui.Create("libgen_button", scroll)
    dbtn:SetClickableText("Modules")
    dbtn.DoClick = function()
        local pnl = lib_gen:BackGroundAdding(frame3, function(pnl, frame) end, dbtn.Text)
        -- OnClickableTxt(pnl, dbtn.Text)
    end

    local dbtn = vgui.Create("libgen_button", scroll)
    dbtn:SetClickableText("Admin")
    dbtn.DoClick = function()
        local pnl = lib_gen:BackGroundAdding(frame3, function(pnl, frame) end, dbtn.Text)
        -- OnClickableTxt(pnl, dbtn.Text)
    end
end)

concommand.Add("libgen", function() hook.Run("OnLoaded", "libgen") end)