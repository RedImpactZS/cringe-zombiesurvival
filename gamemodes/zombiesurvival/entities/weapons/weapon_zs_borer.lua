AddCSLuaFile()

SWEP.PrintName = "'Borer' heavy assault rifle"
SWEP.Description = "Relatively accurate, uses only half ammo."

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.galil"
	SWEP.HUD3DPos = Vector(1, 0, 6)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/Irifle/irifle_fire2.wav")
SWEP.Primary.Damage = 43
SWEP.HeadshotMulti = 2
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.65
SWEP.TracerName = "tracer_colossusnew"
SWEP.Primary.ClipSize = 15
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 1.5
SWEP.ConeMin = 0.2



SWEP.IronSightsPos = Vector(-6, -1, 2.25)


function SWEP:SetAltUsage(usage)
	self:SetDTBool(1, usage)
end

function SWEP:GetAltUsage()
	return self:GetDTBool(1)
end




function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitFireSound()
	

	local altuse = self:GetAltUsage()
	if not altuse then
		self:TakeAmmo()
		
	end
	self:SetAltUsage(not altuse)
	
	

	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end


function SWEP.BulletCallback(attacker, tr, dmginfo)

    if tr.HitWorld then
		util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	end
    
	local ent = tr.Entity
	if ent:IsValidZombie() then
		ent:AddLegDamageExt(8, attacker, attacker:GetActiveWeapon(), SLOWTYPE_PULSE)
	end

	if IsFirstTimePredicted() then
		
		
		end
	
	local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.HitNormal)
	util.Effect("hit_orangenew", effectdata)
	
	return {impact = false}
	
end


if not CLIENT then return end

function SWEP:GetDisplayAmmo(clip, spare, maxclip)
	local minus = self:GetAltUsage() and 0 or 1
	return math.max(0, (clip * 2) - minus), spare * 2, maxclip * 1 -- too lazy to do it right
end
