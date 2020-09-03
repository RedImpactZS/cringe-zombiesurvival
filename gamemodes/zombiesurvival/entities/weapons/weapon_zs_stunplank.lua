AddCSLuaFile()

SWEP.PrintName = "Stun Plank"
SWEP.Description = "weapon for the boss"

if CLIENT then
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl++++++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.257, 1.429, -30.052), angle = Angle(-6.836, -1.183, 87.401), size = Vector(0.386, 0.529, 0.386), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl+"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.748, 1.263, -22.63), angle = Angle(-32.674, -6.019, -7.798), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.748, 1.263, -20.55), angle = Angle(-32.674, -6.019, -7.798), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl+++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.748, 1.263, -26.792), angle = Angle(-32.674, -6.019, -7.798), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl+++++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.4, 1.429, -30.052), angle = Angle(-6.836, -1.183, 87.401), size = Vector(0.386, 0.564, 0.386), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl++++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.748, 1.263, -28.934), angle = Angle(-32.674, -6.019, -7.798), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_lab/teleportring.mdl+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.811, 0.6, -24.108), angle = Angle(-7.163, 82.623, 99.018), size = Vector(0.194, 0.284, 0.245), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.748, 1.263, -24.63), angle = Angle(-32.674, -6.019, -7.798), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_lab/teleportring.mdl"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.795, 0.802, -24.114), angle = Angle(175.638, 75.097, 82.806), size = Vector(0.194, 0.284, 0.245), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_debris/wood_chunk03a.mdl"] = { type = "Model", model = "models/props_debris/wood_chunk03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.363, 1.363, -11.365), angle = Angle(180, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
        
    }
	SWEP.WElements = {
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl++++++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.2, 1.371, -31.828), angle = Angle(0, 0, 89.299), size = Vector(0.386, 0.529, 0.386), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl+"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.404, 1.43, -26.526), angle = Angle(0, 0, 0), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.404, 1.43, -29.066), angle = Angle(0, 0, 0), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl+++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.404, 1.43, -21.719), angle = Angle(0, 0, 0), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl+++++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.396, 1.371, -31.605), angle = Angle(0, 0, 89.299), size = Vector(0.386, 0.564, 0.386), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl++++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.404, 1.43, -19.157), angle = Angle(0, 0, 0), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_lab/teleportring.mdl+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.601, 1.463, -24.191), angle = Angle(179.283, -89.636, 89.675), size = Vector(0.194, 0.294, 0.245), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_c17/FurnitureDrawer001a_Shard01.mdl++"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.404, 1.43, -24.091), angle = Angle(0, 0, 0), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_debris/wood_chunk03a.mdl"] = { type = "Model", model = "models/props_debris/wood_chunk03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.273, 1.363, -12.273), angle = Angle(180, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["models/props_lab/teleportring.mdl"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.218, 1.304, -24.191), angle = Angle(180, 89.323, 90.861), size = Vector(0.194, 0.294, 0.245), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
    }
    
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/props_debris/wood_chunk03a.mdl"
SWEP.ModelScale = 0.5
SWEP.UseHands = true
SWEP.HoldType = "melee"

SWEP.MeleeDamage = 35
SWEP.LegDamage = 25
SWEP.MeleeRange = 55
SWEP.MeleeSize = 1.5
SWEP.Primary.Delay = 0.9

SWEP.SwingTime = 0.25
SWEP.SwingRotation = Angle(60, 0, 0)
SWEP.SwingOffset = Vector(0, -50, 0)
SWEP.SwingHoldType = "grenade"

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.09)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_LEG_DAMAGE, 2)

function SWEP:PlaySwingSound()
	self:EmitSound("Weapon_StunStick.Swing")
end

function SWEP:PlayHitSound()
	self:EmitSound("Weapon_StunStick.Melee_HitWorld")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_StunStick.Melee_Hit")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() then
		hitent:AddLegDamageExt(self.LegDamage, self:GetOwner(), self, SLOWTYPE_PULSE)
	end
end

