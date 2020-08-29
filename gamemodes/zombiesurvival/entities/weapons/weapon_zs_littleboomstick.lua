AddCSLuaFile()

SWEP.PrintName = "Little Boom Stick"
SWEP.Description = "cock"

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_combine/headcrabcannister01a.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(0.052, 1.702, -7.329), angle = Angle(-54.559, -90, -180), size = Vector(0.057, 0.035, 0.041), color = Color(190, 150, 95, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(-5.421, -0.101, -0.819), angle = Angle(-52.792, 0, 0), size = Vector(0.187, 0.382, 0.035), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_pipes/concrete_pipe001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "break", pos = Vector(-1.89, 0.186, 1.929), angle = Angle(0, 36.453, 0), size = Vector(0.1, 0.019, 0.019), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["break"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(-1.063, 0.196, 2.507), angle = Angle(-126.469, 90, 90), size = Vector(0.019, 0.019, 0.045), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(-6.325, -0.13, -4.14), angle = Angle(0, 90, -36.279), size = Vector(0.211, 0.05, 0.014), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["barrel+"] = { type = "Model", model = "models/props_pipes/concrete_pipe001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "break", pos = Vector(-1.89, 0.186, 0.338), angle = Angle(0, 36.453, 0), size = Vector(0.1, 0.019, 0.019), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_interface003.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(-2.258, 0, -1.691), angle = Angle(35.486, 0, 0), size = Vector(0.097, 0.041, 0.071), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/combine_dropship_container.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "break", pos = Vector(-1.009, 1.552, 1.004), angle = Angle(0, 37.951, -90), size = Vector(0.018, 0.019, 0.014), color = Color(190, 150, 95, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["break"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-8.749, -1.099, -4.579), angle = Angle(135, 0, 90), size = Vector(0.019, 0.019, 0.045), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-5.421, -0.101, -0.819), angle = Angle(-52.792, 0, 0), size = Vector(0.187, 0.382, 0.035), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_pipes/concrete_pipe001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-10.634, 0.66, -4.819), angle = Angle(37.5, 0, 0), size = Vector(0.1, 0.019, 0.019), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/combine_dropship_container.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-9.98, -0.201, -6.435), angle = Angle(39.694, 0, 0), size = Vector(0.018, 0.019, 0.014), color = Color(190, 150, 95, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/headcrabcannister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.888, 1.406, -0.543), angle = Angle(130.128, 5.808, 0), size = Vector(0.057, 0.035, 0.041), color = Color(190, 150, 95, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },
		["barrel+"] = { type = "Model", model = "models/props_pipes/concrete_pipe001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-10.634, -0.854, -4.819), angle = Angle(37.5, 0, 0), size = Vector(0.1, 0.019, 0.019), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_interface003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-2.258, 0, -1.691), angle = Angle(35.486, 0, 0), size = Vector(0.097, 0.041, 0.071), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-6.325, -0.13, -4.14), angle = Angle(0, 90, -36.279), size = Vector(0.211, 0.05, 0.014), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }
	}

	SWEP.HUD3DBone = "ValveBiped.Crossbow_base"
	SWEP.HUD3DPos = Vector(1.8, -0.65, -3.3)
	SWEP.HUD3DScale = 0.015
end

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("weapons/zs_sawnoff/sawnoff_fire1.ogg")
SWEP.Primary.Damage = 11.35
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.6
SWEP.Primary.ClipSize = 2
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ReloadSound = Sound("weapons/zs_sawnoff/barrelup.ogg")
SWEP.ReloadFinishSound = Sound("weapons/zs_sawnoff/barreldown.ogg")
SWEP.ReloadPlugSound = Sound("Weapon_Shotgun.Reload")

SWEP.ConeMax = 9
SWEP.ConeMin = 7.75
SWEP.Recoil = 7.5

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.FireAnimSpeed = 0.4
SWEP.Knockback = 100

SWEP.Tier = 3

SWEP.DryFireSound = Sound("Weapon_Shotgun.Empty")

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.07)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Lithe", "Decreased damage but faster reload, more knockback", function(wept)
    wept.ReloadSpeed = wept.ReloadSpeed * 1.25
    wept.Knockback = 150
end)

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
end