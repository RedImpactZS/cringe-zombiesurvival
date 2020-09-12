AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Ricochete' Magnum"
SWEP.Description = "This gun's bullets will bounce off of walls which will then deal extra damage."
SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "Python"
	SWEP.HUD3DPos = Vector(0.85, 0, -2.5)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_357.Single")
SWEP.Primary.Delay = 0.7
SWEP.Primary.Damage = 59
SWEP.Primary.NumShots = 1

SWEP.Primary.ClipSize = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Tier = 2

SWEP.ConeMax = 3.75
SWEP.ConeMin = 2
SWEP.BounceMulti = 1.15
SWEP.Bounces = 30

SWEP.IronSightsPos = Vector(-4.65, 4, 0.25)
SWEP.IronSightsAng = Vector(0, 0, 1)

local function DoRicochet(attacker, hitpos, hitnormal, normal, damage)

	attacker.RicochetBullet = true
	if attacker:IsValid() then
		attacker:FireBulletsLua(hitpos, 2 * hitnormal * hitnormal:Dot(normal * -1) + normal, 0, 1, damage, nil, nil, "tracer_rico", SWEP.BulletCallback, nil, nil, nil, nil, attacker:GetActiveWeapon())
	end
	attacker.RicochetBullet = nil
end

function SWEP:ShootBullets(dmg, numbul, cone)
	self:SetDTInt(9,self.Bounces)
	return self.BaseClass.ShootBullets(self,dmg,numbul,cone)
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	local wep = dmginfo:GetInflictor()
	if SERVER and wep:GetDTInt(9) > 0 then
		wep:SetNextPrimaryFire(CurTime() + wep:GetFireDelay())
		wep:SetDTInt(9, wep:GetDTInt(9) - 1)
		local hitpos, hitnormal, normal, dmg = tr.HitPos, tr.HitNormal, tr.Normal, dmginfo:GetDamage() * attacker:GetActiveWeapon().BounceMulti
		timer.Simple(0.1, function() DoRicochet(attacker, hitpos, hitnormal, normal, dmg) end)
	end
end
