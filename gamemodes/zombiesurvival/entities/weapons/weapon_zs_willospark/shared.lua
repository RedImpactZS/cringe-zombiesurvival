SWEP.PrintName = (translate.Get("wep_wilosparkgun"))
SWEP.Description = (translate.Get("desc_gluon"))

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "physgun"

SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_physics.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.UseHands = true

SWEP.Primary.Damage = 7.5
SWEP.Primary.NumShots = 12
SWEP.Primary.Delay = 0.09
SWEP.Primary.KnockbackScale = 0.1
SWEP.Primary.MaxDistance = 764

SWEP.Primary.DefaultClip = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0
SWEP.ConeMin = 0

SWEP.Tier = 6
SWEP.MaxStock = 2

SWEP.HeatBuildShort = 0.075 * 4
SWEP.HeatVentShort = 0.135
SWEP.HeatDecayShort = 0.05
SWEP.HeatInitialLong = 0.05

SWEP.WalkSpeed = SPEED_SLOWEST * 0.9
SWEP.FireAnimSpeed = 0.24
SWEP.FireSoundPitch = 80

SWEP.TracerName = "tracer_spark"

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_SHORT_TEAM_HEAT, -0.01, 1)

function SWEP:Initialize()
	self.FiringSound = CreateSound(self, "weapons/zs_masterspunk/master_spark.ogg")
	self.FiringSound:SetSoundLevel(85)

	self.ChargingSound = CreateSound(self, "^weapons/zs_masterspunk/master_spark.ogg")
	self.ChargingSound:SetSoundLevel(85)

	self.BaseClass.Initialize(self)
end

function SWEP:GetCone()
	return ((1-self:GetHeat())^3)*6
end

function SWEP:Deploy()
	--local owner = self:GetOwner()
	--if not self.PostOwner then
	--	self.PostOwner = owner
	--end
	--local timediff = owner.GluonInactiveTime and CurTime() - owner.GluonInactiveTime or 0
	--self:SetHeat(math.Clamp((owner.ShortGluonHeat or 0) - timediff * self.HeatDecayShort, 0, 1))

	self:SetGunState(0)
	self:SetHeat(0)

	return self.BaseClass.Deploy(self)
end

function SWEP:Holster()
	self:EndGluonState()

	return self.BaseClass.Holster(self)
end

function SWEP:OnRemove()
	self.BaseClass.OnRemove(self)
	self:EndGluonState()
end

function SWEP:EmitStartFiringSound()
	self:EmitSound("weapons/zs_masterspunk/master_spark.ogg", 75, 50)
end

function SWEP:GluonDamage()
	return self.Primary.Damage*(1+(1-self:GetHeat())*2)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

	-- Move this to DT vars because predicted at high pings
	local altuse = self:GetAltUsage()
	if altuse then
		--self:TakeCombinedPrimaryAmmo(1)
	end
	self:SetAltUsage(not altuse)

	if self:GetGunState() < 1 then
		-- We prevent a bit of tapping fire by doing this.

		self.ChargingSound:PlayEx(1, 70 - (50*self:GetHeat()))
		self.ChargingSound:ChangePitch( 20, (1-self:GetHeat())/self.HeatBuildShort ) 

		self:SetGunState(1)
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetPrimaryAmmoCount() <= 0 then
		return false
	end

	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetReloadFinish() > 0 then return false end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	dmginfo:SetDamageType(DMG_DISSOLVE)

	--if tr.HitWorld then
	--	util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	--end

	if attacker:GetActiveWeapon().LegDamage then
		local ent = tr.Entity
		if ent:IsValidZombie() then
			ent:AddLegDamageExt(0.5, attacker, attacker:GetActiveWeapon(), SLOWTYPE_PULSE) --increase resonance chance
		end
	end

	return {impact = false}
end

function SWEP:Reload()
	--if self:GetGunState() == 0 then
	--	self:SetGunState(2)
	--	self:EmitSound("npc/scanner/scanner_siren1.wav")
	--end
end

function SWEP:SecondaryAttack()
end

function SWEP:StopGluonSounds()
	self.FiringSound:Stop()
	self.ChargingSound:Stop()
end

function SWEP:EndGluonState()
	--local owner = self.PostOwner or self:GetOwner()
	--if owner:IsValid() then
	--	owner.ShortGluonHeat = self:GetHeat()
	--	owner.GluonInactiveTime = CurTime()
	--	owner.GunSway = false
	--end

	self:StopGluonSounds()
end

function SWEP:SetGunState(state)
	self:SetDTInt(1, state)
end

function SWEP:GetGunState(state)
	return self:GetDTInt(1)
end

function SWEP:SetAltUsage(usage)
	self:SetDTBool(1, usage)
end

function SWEP:GetAltUsage()
	return self:GetDTBool(1)
end

function SWEP:SetHeat(heat)
	self:SetDTFloat(8, heat)
end

function SWEP:GetHeat()
	return self:GetDTFloat(8)
end

function SWEP:ManageHeat()
	local owner = self:GetOwner()
	if owner and owner:IsValid() then
		local frametime = FrameTime()
		if self:GetGunState() == 1 then
			--local frametimeadj = frametime * self:GetReloadSpeedMultiplier()
			--self.FiringSound:PlayEx(1, self.FireSoundPitch + CurTime() % 1)
			self:SetHeat(math.min(self:GetHeat() + frametime * self.HeatBuildShort, 1))

			--if CLIENT then owner.GunSway = true end
		else--if self:GetGunState() == 2 then
			--self.FiringSound:Stop()
			if CLIENT then
				--owner.GunSway = false
			end

			if self:GetGunState() == 2 then 
				self:SetHeat(math.max(self:GetHeat() - frametime * self.HeatVentShort, 0)) 
			else
				self.ChargingSound:Stop()
				self:SetHeat(math.max(self:GetHeat() - frametime * self.HeatDecayShort, 0))
			end
			--self:SetNextPrimaryFire(CurTime() + 0.25)

			if self:GetHeat() == 0 and self:GetGunState() > 0 then
				self.FiringSound:Stop()
				self:SetNextPrimaryFire(CurTime()+3)
				--self:EmitSound("vehicles/APC/apc_shutdown.wav", 95,45)
				self:SetGunState(0)
				self:EmitSound("npc/scanner/scanner_siren1.wav", 65, 90)
			end

		--else
			--owner.GunSway = false
			--self:StopGluonSounds()
			--self:SetHeat(math.max(self:GetHeat() - frametime * self.HeatDecayShort, 0))
		end
	else
		self:StopGluonSounds()
	end
end

function SWEP:Think()
	self.BaseClass.Think(self)

	local overheat = self:GetHeat() >= 1
	if self:GetGunState() == 1 and CurTime() >= self:GetNextPrimaryFire() + 0.1 or overheat then
		self:SetGunState(overheat and 2 or 0)
		--self:SetNextPrimaryFire(CurTime() + 0.15)

		if overheat then
			if IsFirstTimePredicted() then
				self.ChargingSound:Stop()
				self:EmitStartFiringSound()
				self:GetOwner():ViewPunch(Angle(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-10, 10)))
				self.FiringSound:PlayEx(1, self.FireSoundPitch + CurTime() % 1)
			end
			if self.Overheat then
				self:GetOwner():TakeSpecialDamage(15, DMG_BURN, self:GetOwner(), self)
			end
		end
		--self:EmitSound("weapons/zs_gluon/egon_off1.wav", 75, 115, 0.9, CHAN_WEAPON + 20)
	end

	if self:GetGunState() == 2 and self:CanPrimaryAttack() then
		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())
		self:ShootBullets(self:GluonDamage(), self.Primary.NumShots, self:GetCone())
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end

	self:ManageHeat()
end