AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "pogostick"
SWEP.Description = "Can only fire while you on ground, no damage, funny"

if CLIENT then
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_wasteland/dockplank01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "",
		 pos = Vector(10, 7, 35), angle = Angle(-10, 100, 90), size = Vector(0.5, 0.5, 0.5),
		  color = Color(255, 255, 255, 255), surpresslightning = false, material = "",
		  skin = 0, bodygroup = {} 
		}
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_wasteland/dockplank01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "",
		 pos = Vector(10, 2, 37), angle = Angle(0, 90, 90), size = Vector(0.5, 0.5, 0.5),
		  color = Color(255, 255, 255, 255), surpresslightning = false, material = "",
		  skin = 0, bodygroup = {} 
		}
	}
end

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props_wasteland/dockplank01b.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadDelay = 0.0

SWEP.Primary.Sound = Sound("physics/body/body_medium_break4.wav")
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 0
SWEP.Primary.Delay = 0.4
SWEP.Primary.Automatic = true

SWEP.Recoil = 1

SWEP.Primary.ClipSize = 2
SWEP.Primary.Ammo = "dummy"
SWEP.Primary.DefaultClip = 28

SWEP.ConeMax = 11.5
SWEP.ConeMin = 10

SWEP.Tier = 1

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.FireAnimSpeed = 0.4
SWEP.Knockback = 120

SWEP.PumpActivity = ACT_SHOTGUN_PUMP
SWEP.PumpSound = Sound("physics/body/body_medium_break4.wav")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

function SWEP:Reload()

end

function SWEP:CanPrimaryAttack()
	local owner = self:GetOwner()

	if owner:IsOnGround() == false then
		return false
	end

	return self.BaseClass.CanPrimaryAttack(self)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitSound("physics/body/body_medium_break4.wav")

	local clip = self:Clip1()

	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots * clip, self:GetCone())

	self:TakePrimaryAmmo(clip)
	owner:ViewPunch(clip * 0.5 * self.Recoil * Angle(math.Rand(-0.1, -0.1), math.Rand(-0.1, 0.1), 0))

	owner:SetGroundEntity(null)
	owner:SetVelocity(self.Knockback * 5 * owner:GetAimVector())

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	self:SetClip1(self.Primary.ClipSize)
end

function SWEP:TakePrimaryAmmo()
end

function SWEP:GetPrimaryAmmoCount()
	return 1 -- infinite ammo
end