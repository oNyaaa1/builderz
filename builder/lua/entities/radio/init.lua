AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
util.AddNetworkString("BuilderUse")
util.AddNetworkString("Builder_Music")
util.AddNetworkString("Builder_SendMusic")
util.AddNetworkString("Builder_StopMusic")
function ENT:Initialize()
    if SERVER then
        self:SetModel("models/props_lab/citizenradio.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then phys:Wake() end
        self:SetUseType(SIMPLE_USE)
        self.MaxCharge = 100
        self.HasBuilderAccess = true
        self.Builder_Create = 0
    end
end

net.Receive("Builder_Music", function(len, ply)
    local ent = net.ReadEntity()
    local str = net.ReadString()
    if str == "stop" then
        net.Start("Builder_StopMusic")
        net.WriteEntity(ent)
        net.Broadcast()
        return
    end

    if not IsValid(ent.Battery) then return end
    if ent.Battery.Builder_Create < 100 then return end
    if IsValid(ent) and ent.Battery == ent and ent.Battery.Charge <= 0 then return end
    net.Start("Builder_SendMusic")
    net.WriteEntity(ent)
    net.WriteString(str)
    net.Broadcast()
end)

function ENT:Think(ent)
    if IsValid(self.Battery) and self.Battery.Charge <= 0 then
        net.Start("Builder_StopMusic")
        net.WriteEntity(self.Battery)
        net.Broadcast()
    end
end

function ENT:StartTouch(ent)
    local battery = ent
    if ent:GetClass() == "battery" then self.Battery = battery end
end

function ENT:EntTouch(ent)
    self.Battery = NULL
    net.Start("Builder_StopMusic")
    net.WriteEntity(self.Battery)
    net.Broadcast()
end

function ENT:Use(act, ply)
    net.Start("BuilderUse")
    net.WriteEntity(self)
    net.Broadcast()
end