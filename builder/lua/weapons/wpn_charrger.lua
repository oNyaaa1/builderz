AddCSLuaFile()
SWEP.PrintName = "Builder Charger"
SWEP.Category = "Builder"
SWEP.Instructions = "Charges batterys"
SWEP.ViewModel = "models/weapons/c_toolgun.mdl" -- Fallback model string
SWEP.WorldModel = "models/weapons/w_toolgun.mdl" -- Fallback model string
SWEP.DrawCrosshair = true
SWEP.UseHands = true
SWEP.Primary.Automatic = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
-- Taken from GMOD Stool [in Gmod Source Sandbox/weapons/stools/] i need this part for my toolgun :) as it wouldn't be possible otherwise' start
if CLIENT then
    local matScreen = Material("models/weapons/v_toolgun/screen")
    local txBackground = surface.GetTextureID("models/weapons/v_toolgun/screen_bg")
    local TEX_SIZE = 256
    -- GetRenderTarget returns the texture if it exists, or creates it if it doesn't
    local RTTexture = GetRenderTarget("GModToolgunScreen", TEX_SIZE, TEX_SIZE)
    surface.CreateFont("GModToolScreen", {
        font = "Helvetica",
        size = 40,
        weight = 900
    })

    local function DrawScrollingText(text, y, texwide)
        local w, h = surface.GetTextSize(text)
        w = w + 64
        y = y - h / 2 -- Center text to y position
        local x = 0
        surface.SetTextColor(0, 0, 0, 255)
        surface.SetTextPos(x + 3, y + 3)
        surface.DrawText(text)
        surface.SetTextColor(255, 255, 255, 255)
        surface.SetTextPos(x, y)
        surface.DrawText(text)
    end

    function SWEP:RenderScreen()
        -- Set the material of the screen to our render target
        matScreen:SetTexture("$basetexture", RTTexture)
        -- Set up our view for drawing to the texture
        render.PushRenderTarget(RTTexture)
        cam.Start2D()
        -- Background
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetTexture(txBackground)
        surface.DrawTexturedRect(0, 0, TEX_SIZE, TEX_SIZE)
        -- Give our toolmode the opportunity to override the drawing
        surface.SetFont("GModToolScreen")
        DrawScrollingText("  Charge: " .. tostring(self.Heat) .. "%", 104, TEX_SIZE)
        cam.End2D()
        render.PopRenderTarget()
    end
end

-- Taken from GMOD Stool i need this part for my toolgun :) as it wouldn't be possible otherwise' end
function SWEP:Initialize()
    self:SetHoldType("revolver")
    self.Heat = 0
    self.CoolDownHeat = 0
end

function SWEP:PrimaryAttack()
    if self.Heat < 3 then -- Exploit protection no inf loop :)
        self.Heat = 0
        return
    end

    local pl = self:GetOwner()
    local trace = pl:GetEyeTrace()
    pl:SetAnimation(PLAYER_ATTACK1)
    self:EmitSound("ambient/energy/weld1.wav")
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    local eff = EffectData()
    eff:SetStart(pl:GetShootPos())
    eff:SetOrigin(trace.HitPos)
    util.Effect("weld_mf", eff)
    self.Heat = self.Heat - 1
    local ent = trace.Entity
    self:SetNextPrimaryFire(CurTime() + 0.1)
    if CLIENT then return end
    if IsValid(ent) and ent:GetClass() == "battery" then ent.Charge = ent.Charge + 1 end
end

function SWEP:Think()
    if self.CoolDownHeat >= CurTime() then return end
    self.CoolDownHeat = CurTime() + 0.1
    if self.Heat < 100 then self.Heat = self.Heat + 1 end
end

function SWEP:SecondaryAttack()
end