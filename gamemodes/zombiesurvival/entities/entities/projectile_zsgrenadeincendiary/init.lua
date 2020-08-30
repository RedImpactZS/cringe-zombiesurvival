INC_SERVER()

function ENT:Initialize()
	self.DieTime = CurTime() + self.LifeTime

	self:SetModel("models/weapons/w_grenade_incendiary.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCustomCollisionCheck(true)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	
	--self:Fire("kill", "", 30)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(4)
		phys:SetMaterial("metal")
	end
end

function ENT:PhysicsCollide(data, phys)

	self.PhysicsData = data
	self.Owner = self:GetOwner()
	self:NextThink(CurTime())

	if 20 < data.Speed and 0.25 < data.DeltaTime then
		self:EmitSound("physics/metal/metal_grenade_impact_hard"..math.random(3)..".wav")
	end
end

function ENT:Think()
	if self.Exploded then
		self:Remove()
	elseif self.DieTime <= CurTime() then
		self:Explode()
	end
end

function ENT:Explode(hitpos, hitnormal)
	if self.Exploded then return end
	self.Exploded = true
	
	self:Fire("kill", "", 0.01)

	local owner = self:GetOwner()
	
	hitpos = hitpos or self:GetPos()
	if not hitnormal then
		hitnormal = self:GetVelocity():GetNormalized() * -1
	end
	
	if owner:IsValidHuman() then

		local effectdata = EffectData()
			effectdata:SetOrigin(hitpos)
			effectdata:SetNormal(hitnormal)
		util.Effect("HelicopterMegaBomb", effectdata)

		self:EmitSound("weapons/explosions/incendiarygrenade.wav", 85, 100)
		
		incflames = ents.Create("env_molotovflame")
		local downtrace = util.QuickTrace( hitpos, Vector(0,0,-72), self)
		if not downtrace.Hit then
			ParticleEffect("explosion_flash", hitpos, angle_zero)
			ParticleEffect("g_f_flash_1", hitpos, angle_zero)
			ParticleEffect("g_f_fireball_2", hitpos, angle_zero)
			ParticleEffect("g_f_fireball_3", hitpos, angle_zero)
			ParticleEffect("g_f_smoke", hitpos, angle_zero)
			ParticleEffect("g_f_sparks", hitpos, angle_zero)
			ParticleEffect("molo_embers_2", hitpos, angle_zero)
		elseif incflames:IsValid() then
			hitpos = downtrace.HitPos
			incflames.Ticks = 40
			incflames.Damage = 9
			incflames:SetOwner(self.Owner or self:GetOwner())
			incflames:SetPos(hitpos)
			incflames:Spawn()
		ParticleEffect("nmrih_molotov_explosion", hitpos, angle_zero)
		ParticleEffect("explosion_flash", hitpos, angle_zero)
		end
			
		for ent, dmg in pairs(util.BlastDamageExAlloc(self, owner, hitpos, self.GrenadeRadius or 200, 66, DMG_SLASH)) do
			if ent:IsValidLivingPlayer() and (ent:Team() == TEAM_UNDEAD or ent == owner) then
				ent:Ignite(dmg / 7)
				for __, fire in pairs(ents.FindByClass("entityflame")) do
					if fire:IsValid() and fire:GetParent() == ent then
						fire:SetOwner(owner)
						fire:SetPhysicsAttacker(owner)
						fire.AttackerForward = owner
					end
				end
			end
		end
		
	end
end
