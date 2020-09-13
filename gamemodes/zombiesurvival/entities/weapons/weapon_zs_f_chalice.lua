AddCSLuaFile()

SWEP.Base = "weapon_zs_basefood"

SWEP.PrintName = "Bottomless cum chalice"

if CLIENT then
	SWEP.ViewModelBoneMods = {
		["ValveBiped.Bip01_R_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 59, 0) },
		["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(1, 6.2, 2), angle = Angle(30, 0, 0) },

	}

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/xqm/afterburner1big.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.596, 2.596), angle = Angle(180, 3.506, 0), size = Vector(0.079, 0.079, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "environment maps/pipemetal001a", skin = 0, bodygroup = {} },
		["cum"] = { type = "Model", model = "models/xqm/airplanewheel1large.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.099, -5.715), angle = Angle(86, -3.507, -3.507), size = Vector(0.107, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "lights/white", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/xqm/pistontype1big.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.596, 0.518), angle = Angle(-180, -3.507, -3.507), size = Vector(0.3, 0.3, 0.2), color = Color(255, 255, 255, 70), surpresslightning = true, material = "glass/offlightcover", skin = 0, bodygroup = {} }
	}

end

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/xqm/afterburner1big.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.596, 2.596), angle = Angle(180, 3.506, 0), size = Vector(0.079, 0.079, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "environment maps/pipemetal001a", skin = 0, bodygroup = {} },
		["cum"] = { type = "Model", model = "models/xqm/airplanewheel1large.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.099, -5.715), angle = Angle(86, -3.507, -3.507), size = Vector(0.107, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "lights/white", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/xqm/pistontype1big.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.596, 0.518), angle = Angle(-180, -3.507, -3.507), size = Vector(0.3, 0.3, 0.2), color = Color(255, 255, 255, 70), surpresslightning = true, material = "glass/offlightcover", skin = 0, bodygroup = {} }
	}

SWEP.EatViewOffset = Vector(-8, -40, -10)
SWEP.EatViewAngles = Angle(80, 0, 0)

SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/props_c17/pottery04a.mdl"

SWEP.Primary.Ammo = "none"

SWEP.FoodHealth = 3
SWEP.FoodEatTime = (SERVER and 3.6 or 21)
SWEP.FoodIsLiquid = true

function SWEP:TakePrimaryAmmo()
end

function SWEP:GetPrimaryAmmoCount()
	return 1 -- infinite ammo
end

function SWEP:GetFoodEatTime()
	return self.FoodEatTime
end
