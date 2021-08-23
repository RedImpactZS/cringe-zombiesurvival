AddCSLuaFile()

SWEP.PrintName = "SUPER Shovel"
SWEP.Description = ""

SWEP.ViewModelFOV = 70

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel	= "models/weapons/c_shovel.mdl"
SWEP.WorldModel	= "models/weapons/w_shovel.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 100
SWEP.MeleeRange = 68
SWEP.MeleeSize = 1.5
SWEP.MeleeKnockBack = 230

SWEP.Secondary.Damage = 400

SWEP.Primary.Delay = 1.2

SWEP.Tier = 2

SWEP.SwingRotation = Angle(0, -90, -60)
SWEP.SwingOffset = Vector(0, 30, -40)
SWEP.SwingTime = 0.65
SWEP.SwingHoldType = "melee"

SWEP.AllowQualityWeapons = true
SWEP.DismantleDiv = 6

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.09, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.06, 1)

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/shovel/shovel_fire.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/shovel/shovel_hit"..math.random(1, 3)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() and hitent.Revive and hitent.Revive:IsValid() and gamemode.Call("PlayerShouldTakeDamage", hitent, self:GetOwner()) then
		hitent:TakeSpecialDamage(hitent:Health(), DMG_DIRECT, self:GetOwner(), self, tr.HitPos)
	end
end
function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 105 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	if !self.Owner:IsNPC() then
		self.Owner:ViewPunch(Angle( -2, -2, 0 ))
	end

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			
			local HitNum = math.random(1,2)
			if HitNum == 1 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_4 )
			elseif HitNum == 2 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_5 )
			end
		
		else
			--self.Weapon:EmitSound( Sound("weapons/shovel/shovel_hit"..math.random(1,3)..".wav"),100,math.random(80,120) )
			local HitNum2 = math.random(1,2)
			if HitNum2 == 1 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_4 )
			elseif HitNum2 == 2 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_5 )
			end
		end
	else
		local MissNum = math.random(1,2)
		if MissNum == 1 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_1 )
		elseif MissNum == 2 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_2 )
		end
	end

end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.5) 
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_3 )
	timer.Simple(0.4,
	function()
		local tr = {}
		tr.start = self.Owner:GetShootPos()
		tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 105 )
		tr.filter = self.Owner
		tr.mask = MASK_SHOT
		local trace = util.TraceLine( tr )

		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		if !self.Owner:IsNPC() then
			self.Owner:ViewPunch(Angle( -2, -2, 0 ))
		end
	end)

end