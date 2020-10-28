SWEP.PrintName	   = "zmain gun"
SWEP.Description = "hmmm, today im gonna KILL MYSELF"
SWEP.Slot			= 4
SWEP.SlotPos		 = 10
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair   = true

SWEP.ViewModel	   = "models/weapons/c_rpg.mdl"
SWEP.WorldModel	  = "models/weapons/w_rocket_launcher.mdl"
SWEP.UseHands	= true

SWEP.Primary.ClipSize	   = 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic	  = true
SWEP.Primary.Ammo		   = "none"
SWEP.Primary.Delay		  = 1.5

SWEP.Secondary.ClipSize	 = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		 = "none"


SWEP.HoldType = "rpg"
SWEP.Tier = 1
SWEP.FailSound	 = Sound("physics/metal/metal_sheet_impact_bullet1.wav")

function SWEP:Initialize()
	if CLIENT then self.RocketEntity = ClientsideModel("models/Weapons/W_missile_closed.mdl", RENDERGROUP_OPAQUE) end
	self:SetHoldType("rpg")
end

function SWEP:Deploy()

end

function SWEP:OnRemove()
	if CLIENT and self.RocketEntity then self.RocketEntity:Remove() end
end

function SWEP:Explode()
	util.BlastDamage( self, self:GetOwner(), self:GetPos(), 256, 255 ) -- rad, dmg
	local effect = EffectData()
	effect:SetOrigin( self:GetPos() )
	util.Effect( "Explosion", effect )
	self:SetDTBool( 0, false )
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return false end
	if self:GetDTBool( 0 ) then return end
	self:EmitSound( self.FailSound )
	if SERVER then
		self:SetDTBool( 0, true )
		local time = 0.7
		if self.Owner:EyeAngles().p > 45 then time = 0.25 end
		timer.Simple(time, function() if IsValid(self) then self.Explode(self) end end)
	end
	self:ShootEffects()
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	return true
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:ViewModelDrawn()
	local vm = self.Owner:GetViewModel()
	if not vm then return end
	if self:GetDTBool( 0 ) then
		if not self.RocketEntity then return end
		if not self.StartTime then self.StartTime = CurTime() end
		local attach = vm:GetAttachment( 1 )
		if not attach then return end
		local pos = attach.Pos
		local ang = attach.Ang
		local time = 0.001 + (CurTime() - self.StartTime)
		local dir = time * 50 * ang:Forward() + (time * 1.5) ^ 2 * 90 * ang:Right() ----
		local angle = dir:Angle()
		self.RocketEntity:SetPos( pos + dir )
		self.RocketEntity:SetAngles( angle )
	else
		self.StartTime = nil
	end
	return false
end