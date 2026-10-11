AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
util.AddNetworkString("rust_WriteVoltage")
function ENT:Initialize()
    self:SetModel("models/items/car_battery01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
    self.Charge = 0
    self.MaxCharge = 100
    self.Cool = 0
    self.HasBuilderAccess = true
    self.Builder_Create = 0
    self:SetAngles(Angle(0, 0, 0))
    net.Start("rust_WriteVoltage")
    net.WriteEntity(self)
    net.WriteFloat(self.Charge)
    net.Broadcast()
end

function ENT:Think()
    if self.Builder_Create < 100 then return end
    self.Charge = math.Clamp(self.Charge, 0, self.MaxCharge)
    if self.Cool <= CurTime() and self.Connected and self.Charge > 0 then
        self.Charge = self.Charge - 0.2
        self.Cool = CurTime() + 1
    end

    net.Start("rust_WriteVoltage")
    net.WriteEntity(self)
    net.WriteFloat(math.Clamp(self.Charge, 0, self.MaxCharge))
    net.Broadcast()
    self:NextThink(CurTime() + 0.1)
end

function ENT:StartTouch(ent)
    self.Connected = ent
end

function ENT:EndTouch(ent)
    self.Connected = NULL
end

function ENT:OnRemove()
    net.Start("Builder_StopMusic")
    net.WriteEntity(self.Connected)
    net.Broadcast()
end