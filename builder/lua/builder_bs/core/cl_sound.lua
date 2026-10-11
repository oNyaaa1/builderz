local music = {"stop", "music/HL1_song10.mp3", "music/HL1_song11.mp3", "music/HL1_song14.mp3", "music/HL1_song15.mp3", "music/HL1_song17.mp3", "music/HL1_song19.mp3", "music/HL1_song20.mp3", "music/HL1_song21.mp3", "music/HL1_song24.mp3", "music/HL1_song25_REMIX3.mp3", "music/HL1_song26.mp3", "music/HL1_song3.mp3", "music/HL1_song5.mp3", "music/HL1_song6.mp3", "music/HL1_song9.mp3", "music/HL2_intro.mp3", "music/HL2_song0.mp3", "music/HL2_song1.mp3", "music/HL2_song10.mp3", "music/HL2_song11.mp3", "music/HL2_song12_long.mp3", "music/HL2_song13.mp3", "music/HL2_song14.mp3", "music/HL2_song15.mp3", "music/HL2_song16.mp3", "music/HL2_song17.mp3", "music/HL2_song19.mp3", "music/HL2_song2.mp3", "music/HL2_song20_submix0.mp3", "music/HL2_song20_submix4.mp3", "music/HL2_song23_SuitSong3.mp3", "music/HL2_song25_Teleporter.mp3", "music/HL2_song26.mp3", "music/HL2_song26_trainstation1.mp3", "music/HL2_song27_trainstation2.mp3", "music/HL2_song28.mp3", "music/HL2_song29.mp3", "music/HL2_song3.mp3", "music/HL2_song30.mp3", "music/HL2_song31.mp3", "music/HL2_song32.mp3", "music/HL2_song33.mp3", "music/HL2_song4.mp3", "music/HL2_song6.mp3", "music/HL2_song7.mp3", "music/HL2_song8.mp3", "music/radio1.mp3", "music/Ravenholm_1.mp3", "music/stingers/HL1_stinger_song16.mp3", "music/stingers/HL1_stinger_song27.mp3", "music/stingers/HL1_stinger_song28.mp3", "music/stingers/HL1_stinger_song7.mp3", "music/stingers/HL1_stinger_song8.mp3", "music/stingers/industrial_suspense1.wav", "music/stingers/industrial_suspense2.wav",}
local function BuilderOpenMenu(str)
    local BuilderF = vgui.Create("DFrame")
    BuilderF:SetPos(50, 50)
    BuilderF:SetSize(300, 200)
    BuilderF:SetTitle("Builder Menu")
    BuilderF:SizeToContents()
    BuilderF:MakePopup()
    BuilderF.Paint = function() draw.RoundedBox(0, 0, 0, BuilderF:GetWide(), BuilderF:GetTall(), Color(0, 0, 0, 150)) end
    local BuilderCombo = vgui.Create("DComboBox", BuilderF)
    BuilderCombo:SetPos(10, 35)
    BuilderCombo:SetSize(200, 50)
    for k, v in ipairs(music) do
        BuilderCombo:AddChoice(v)
    end

    BuilderCombo:SetWide(280)
    BuilderCombo:SetHeight(150)
    BuilderCombo:PerformLayout()
    BuilderCombo.OnSelect = function(i, v, d)
        net.Start("Builder_Music")
        net.WriteEntity(str)
        net.WriteString(tostring(d))
        net.SendToServer()
    end
end

net.Receive("Builder_SendMusic", function()
    local ent = net.ReadEntity()
    local str = net.ReadString()
    if IsValid(ent.Sound) then ent.Sound:Stop() end
    ent.Sound = NULL
    ent.Sound = CreateSound(ent, str)
    ent.Sound:Play()
end)

net.Receive("Builder_StopMusic", function()
    local ent = net.ReadEntity()
    if IsValid(ent) and ent.Sound ~= NULL and ent.Sound ~= nil then ent.Sound:Stop() end
end)

net.Receive("BuilderUse", function(len, ply) BuilderOpenMenu(net.ReadEntity()) end)