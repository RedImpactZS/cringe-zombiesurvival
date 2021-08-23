ENT.Type = "anim"

ENT.MaxHealth = 2000
ENT.HealthRegen = 40
ENT.RegenDelay = 2

ENT.PosePitch = 0
ENT.PoseYaw = 0

ENT.ModelScale = 1

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true
ENT.IsBarricadeObject = true

AccessorFuncDT(ENT, "SigilHealthBase", "Float", 0)
AccessorFuncDT(ENT, "SigilHealthRegen", "Float", 1)
AccessorFuncDT(ENT, "SigilLastDamaged", "Float", 2)

function ENT:SetSigilCorrupted(corrupt)
	self.IsBarricadeObject = not corrupt

	if SERVER then
		self:SetCollisionGroup(corrupt and COLLISION_GROUP_DEBRIS_TRIGGER or COLLISION_GROUP_NONE)
	end
	self:CollisionRulesChanged()
	self:EnableCollisions(false)

	self:SetDTBool(0, corrupt)
end

function ENT:GetLocalAnglesToTarget(target)
	return self:WorldToLocalAngles(self:GetAnglesToTarget(target))
end

function ENT:GetAnglesToTarget(target)
	return self:GetAnglesToPos(self:GetTargetPos(target))
end

function ENT:GetLocalAnglesToPos(pos)
	return self:WorldToLocalAngles(self:GetAnglesToPos(pos))
end

function ENT:GetAnglesToPos(pos)
	return (pos - self:ShootPos()):Angle()
end

function ENT:ShootPos()
	local attachid = self:LookupAttachment("eyes")
	if attachid then
		local attach = self:GetAttachment(attachid)
		if attach then return attach.Pos end
	end

	return self:DefaultPos()
end

function ENT:CalculatePoseAngles()
	local target = LocalPlayer()
	local angm = self:GetScanMaxAngle()
	if target:IsValid() then
		local ang = self:GetLocalAnglesToTarget(target)
		self.PoseYaw = math.Approach(self.PoseYaw, math.Clamp(math.NormalizeAngle(ang.yaw), -60 * angm, 60 * angm), deltatime * 140)
		self.PosePitch = math.Approach(self.PosePitch, math.Clamp(math.NormalizeAngle(ang.pitch), -15 * angm, 15 * angm), deltatime * 100)
	end
end

function ENT:GetSigilCorrupted()
	return self:GetDTBool(0)
end

function ENT:SetSigilHealth(health)
	self:SetSigilHealthBase(health)

	self:SetSigilLastDamaged(math.max(self:GetSigilLastDamaged(), self:GetSigilHealthRegen() - self.RegenDelay))
end

function ENT:GetSigilHealth()
	local base = self:GetSigilHealthBase()
	if base == 0 then return 0 end

	return math.Clamp(base + self:GetSigilHealthRegen() * math.max(0, CurTime() - (self:GetSigilLastDamaged() + self.RegenDelay)), 0, self.MaxHealth)
end

function ENT:GetSigilMaxHealth()
	return self.MaxHealth
end

function ENT:CanBeDamagedByTeam(teamid)
	if self:GetSigilCorrupted() then
		return teamid == TEAM_HUMAN
	end

	return teamid == TEAM_UNDEAD
end
