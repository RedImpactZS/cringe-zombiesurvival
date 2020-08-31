AddCSLuaFile()

SWEP.PrintName = "'Interceptor' Plasma Rifle"
SWEP.Description = "An experimental prototype of plasma rifle. Uses chemical ammo, deals massive AOE damage."

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70
	
	SWEP.HUD3DBone = "PPP"
	SWEP.HUD3DPos = Vector(1, -5, -1.5)
	SWEP.HUD3DAng = Angle(0, 180, 180)
	SWEP.HUD3DScale = 0.02
	
	SWEP.VElements = {
	["1"] = { type = "Sprite", sprite = "sprites/glow04", bone = "PPP", rel = "", pos = Vector(0, -7.85, -2), size = { x = 0.5, y = 0.5 }, color = Color(0, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
    }
	
	SWEP.VMPos = Vector(0.5, -3, -0.7)
    SWEP.VMAng = Vector(2, 1, 0)
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/interceptor/c_interceptor_v2.mdl"
SWEP.WorldModel = "models/weapons/interceptor/w_interceptor_v2.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Interceptor.Shoot")
SWEP.Primary.Damage = 55.25
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.2
SWEP.Primary.Projectile = "projectile_plasma"
SWEP.Primary.ProjVelocity = 1500

SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "chemical"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 2.65
SWEP.ConeMin = 1.275

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 6

SWEP.IronSightsPos = Vector(-6, 0, 0.4)

if SERVER then
	function SWEP:ShootProjectile(damage, numshots, cone)
	local owner = self:GetOwner()
	owner:DoAttackEvent()

	for i = 0,numshots-1 do
		local ent = ents.Create(self.Primary.Projectile)
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(owner:EyeAngles())
			ent:SetOwner(owner)
			ent.ProjDamage = damage * (owner.ProjectileDamageMul or 1)
			ent.ProjSource = self
			ent.Team = owner:Team()

			ent:Spawn()

			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()

				local angle = owner:GetAimVector():Angle()
				angle:RotateAroundAxis(angle:Forward(), math.Rand(0, 360))
				angle:RotateAroundAxis(angle:Up(), math.Rand(-cone, cone))
				phys:SetVelocityInstantaneous(angle:Forward() * self.Primary.ProjVelocity * (owner.ProjectileSpeedMul or 1))
			end
		end
	end
end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())
	
	local viewmodel = self:GetOwner():GetViewModel()
	--ParticleEffectAttach( "vortigaunt_glow_beam_cp1", PATTACH_POINT_FOLLOW, viewmodel, viewmodel:LookupAttachment("1") )

	self:EmitFireSound()
	self:TakeAmmo()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	if SERVER then
		self:ShootProjectile(self.Primary.Damage * 1.67, 1, self:GetCone()/3)
	end
	
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.014, 1)

sound.Add({
	name = 			"Interceptor.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/interceptor/interceptor001.wav"
})

sound.Add({
	name = 			"Interceptor.SlidePull",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/interceptor/slidepull.wav"
})

sound.Add({
	name = 			"Interceptor.SlideBack",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/interceptor/slideback.wav"
})

sound.Add({
	name = 			"Interceptor.ClipIn",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/interceptor/clipin.wav"
})

sound.Add({
	name = 			"Interceptor.ClipOut",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/interceptor/clipout.wav"
})

sound.Add({
	name = 			"Interceptor.Inner",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/interceptor/inner.wav"
})

sound.Add({
	name = 			"Interceptor.Outter",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/interceptor/outter.wav"
})
