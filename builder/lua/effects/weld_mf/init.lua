function EFFECT:Init(data)
	local emitter = ParticleEmitter(data:GetStart())
	for i = 1, 2 do
		local particle = emitter:Add("effects/muzzleflash" .. math.random(1, 4), data:GetOrigin())
		particle:SetVelocity(self:GetForward() * 1)
		particle:SetAirResistance(160)
		particle:SetDieTime(1)
		particle:SetStartAlpha(160)
		particle:SetEndAlpha(0)
		particle:SetStartSize(12 * i)
		particle:SetEndSize(11 * i)
		particle:SetRoll(math.Rand(180, 480))
		particle:SetRollDelta(math.Rand(-1, 1))
		particle:SetColor(255, 255, 255)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end