SWEP.PrintName 		= "telenigger" 
SWEP.Description    = "primary: teleport to aim pos\n secondary: smack"
SWEP.ViewModelFlip = false
 
SWEP.ViewModelFOV 	= 64 
--SWEP.ViewModel 		= "models/weapons/v_crowbar.mdl" 
--SWEP.WorldModel 	= "models/weapons/w_crowbar.mdl" 
 
SWEP.Slot 	 = 1 
SWEP.SlotPos = 1 
 
SWEP.HoldType = "Melee"
 
SWEP.FiresUnderwater = true 
 
SWEP.DrawCrosshair = true 
 
SWEP.DrawAmmo = false 
 
SWEP.Base = "weapon_zs_zombie" 

 
SWEP.Primary.Sound = "ambient/levels/canals/drip1.wav"
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
 
function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)
		self:SetWeaponHoldType( self.HoldType )
end 
 
function SWEP:PrimaryAttack()

	self.BaseClass.PrimaryAttack(self)
end 
 
 function SWEP:SecondaryAttack()


	local CanTeleport = true
	
	if CanTeleport then
		self:EmitSound(Sound(self.Primary.Sound))
		local trace = self.Owner:GetEyeTraceNoCursor()
		self.Owner:SetPos( trace.HitPos )
		
		return
	end
 end
 

 