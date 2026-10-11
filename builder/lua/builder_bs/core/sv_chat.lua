print("[Builder] Chat commands enabled")
local function HookSay(txt, str, cmd)
    if txt == str then return cmd(txt) end
end

hook.Add("PlayerSay", "Builder_Chat", function(ply, text)
    --This is the chat command for !build 
    local txtz = HookSay(text, "!build", function(txt)
        net.Start("Builder_Menu")
        net.Send(ply)
        return txt
    end)

    if txtz == text then return "" end
end)