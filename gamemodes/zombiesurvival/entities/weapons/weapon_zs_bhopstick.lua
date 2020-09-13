AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "Твоя мама"
SWEP.Description = "Can only fire while looking down, instant fire delay and quick reload speed"

if CLIENT then
	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.65, 0, -8)
	SWEP.HUD3DScale = 0.025

	SWEP.ViewModelFlip = false
end

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadDelay = 0.0

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.Primary.Damage = 12
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.6
SWEP.Primary.Automatic = true

SWEP.Recoil = 1

SWEP.Primary.ClipSize = 2
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.DefaultClip = 28

SWEP.ConeMax = 11.5
SWEP.ConeMin = 10

SWEP.Tier = 5

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.FireAnimSpeed = 0.4
SWEP.Knockback = 120

SWEP.PumpActivity = ACT_SHOTGUN_PUMP
SWEP.PumpSound = Sound("Weapon_Shotgun.Special1")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

function SWEP:Reload()

end

function SWEP:CanPrimaryAttack()
	local owner = self:GetOwner()

	if owner:EyeAngles().p < 30 then
		return false
	end

	return self.BaseClass.CanPrimaryAttack(self)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitSound(self.Primary.Sound)

	local clip = self:Clip1()

	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots * clip, self:GetCone())

	self:TakePrimaryAmmo(clip)
	owner:ViewPunch(clip * 0.5 * self.Recoil * Angle(math.Rand(-0.1, -0.1), math.Rand(-0.1, 0.1), 0))

	owner:SetGroundEntity(NULL)
	owner:SetVelocity(-self.Knockback * clip * owner:GetAimVector())

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	self:SetClip1(self.Primary.ClipSize)
end

function SWEP:TakePrimaryAmmo()
end

function SWEP:GetPrimaryAmmoCount()
	return 1 -- infinite ammo
end