-- Partially based on the Railgun from AS:S, and the Gluon

EFFECT.LifeTime = 0.3

function EFFECT:GetDelta()
	return math.Clamp(self.DieTime - CurTime(), 0, self.LifeTime) / self.LifeTime
end

function EFFECT:Init(data)
	self.StartPos = self:GetTracerShootPos(data:GetStart(), data:GetEntity(), data:GetAttachment())
	self.EndPos = data:GetOrigin()
	self.HitNormal = data:GetNormal() * -1
	self.Color = Color(200,120,70)
	self.LifeTime = 0.15 + 0.013 * ((self.StartPos - self.EndPos):Length() ^ 0.5) -- Keep the particle relatively constant speed
	self.DieTime = CurTime() + self.LifeTime

	local emitter = ParticleEmitter(self.EndPos)
	emitter:SetNearClip(24, 32)

	local r, g, b = self.Color.r, self.Color.g, self.Color.b
	local randmin, randmax = -40, 40
	local normal = (self.EndPos - self.StartPos)
	normal:Normalize()


	self.QuadPos = self.EndPos + self.HitNormal

	for i=1, 7 do
		local particle = emitter:Add("effects/blueflare1", self.QuadPos)
		local vel = VectorRand():GetNormal() * 160
		particle:SetDieTime(1.5)
		particle:SetColor(200,120,70)
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(11)
		particle:SetEndSize(0)
		particle:SetVelocity(vel)
		particle:SetGravity(vel * -0.7)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return CurTime() < self.DieTime
end

local matBeam2 = Material("trails/laser")
local matGlow = Material("sprites/light_glow02_add")
local matFlare = Material("sprites/glow04_noz")
function EFFECT:Render()
	local delta = self:GetDelta()
	if delta <= 0 then return end
	self.Color.a = delta * 155

	local startpos = self.StartPos
	local endpos = self.QuadPos

	local size = delta * 50
	render.SetMaterial(matBeam2)
	render.DrawBeam(startpos, endpos, size * 0.5, 1, 0, self.Color)
	render.DrawBeam(startpos, endpos, size, 1, 0, self.Color)

	local texcoord = math.Rand( 0, 1 )

	local distancevector = (startpos - endpos)
	local dir = distancevector:Angle()
	local dfwd = dir:Forward()
	local dup = dir:Up()
	local drgt = dir:Right()
	local nlen = distancevector:Length()
	local prevspinpos, prevspinpos2 = startpos, startpos

	

	
end
