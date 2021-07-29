function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	self.Pos = pos
	local normal = effectdata:GetNormal()

	self.Alpha = 255
	self.Life = 0

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)

	for i=1, 25 do
		local particle = emitter:Add("sprites/glow04_noz", pos)
		particle:SetDieTime(0.8)
		particle:SetColor(200,120,70)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(2)
		particle:SetEndSize(4)
		particle:SetVelocity((normal + VectorRand()):GetNormal() * 650)
		particle:SetCollide(true)
		particle:SetBounce(0.75)
		particle:SetAirResistance(700)
	end
	emitter:Finish() emitter = nil collectgarbage("step", 64)
end

function EFFECT:Think()
	self.Life = self.Life + FrameTime() * 1
	self.Alpha = 255 * (1 - self.Life)
	return (self.Life < 1)
end

local glowmat = Material("sprites/glow04_noz")
function EFFECT:Render()
	local pos = self.Pos

	render.SetMaterial(glowmat)
	render.DrawSprite(pos, 35, 35, Color(200, 120, 70, self.Alpha))
end
