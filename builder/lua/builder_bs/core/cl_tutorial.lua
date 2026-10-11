surface.CreateFont("builder_BigText", {
    font = "Helvetica",
    size = 30,
    weight = 900
})

local steps = {
    [1] = "Radio:",
    [2] = "First spawn the Builder entity in the Q Menu Entities!",
    [3] = "Charge the Radio, With your charger in weapons -> Builder!",
    [4] = "Play the radio and you're done",
}

local ScrHh = ScrH()
hook.Add("OnScreenSizeChanged", "Builder_SizeScreen", function(oldw, oldh, neww, newh) ScrHh = newh end)
local function NewScreenScale(height)
    return ScrHh / 1080 * height
end

net.Receive("Builder_Menu", function()
    local frame = vgui.Create("Library_onyaaa_frame")
    frame:SetTitles("Builder Menu")
    frame:MakePopup()
    local frame2 = vgui.Create("libgen_liniker", frame)
    local scroll = vgui.Create("libgen_scrollpanel", frame2)
    local frame3 = vgui.Create("libgen_liniker", frame)
    frame3:Dock(FILL)
    local dbtn = vgui.Create("libgen_button", scroll)
    dbtn:SetClickableText("Tutorial")
    dbtn.DoClick = function()
        local pnl = lib_gen:BackGroundAdding(frame3, function(pnl, frame) end, dbtn.Text)
        pnl.Paint = function(s, w, h)
            local yPos = 0
            for i = 1, #steps do
                draw.DrawText(steps[i], "builder_BigText", 0, yPos, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
                yPos = yPos + 35
            end
        end
    end

    local dbtn = vgui.Create("libgen_button", scroll)
    dbtn:SetClickableText("Admin")
    dbtn.DoClick = function() local pnl = lib_gen:BackGroundAdding(frame3, function(pnl, frame) end, dbtn.Text) end
end)