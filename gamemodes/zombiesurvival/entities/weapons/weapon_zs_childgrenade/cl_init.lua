INC_CLIENT()

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.VElements = {
    
   ["base"] = { type = "Model", model = "models/props_c17/doll01.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0.375, 0.159, 0.296), angle = Angle(-3.422, 180, 178.132), size = Vector(1.133, 1.133, 1.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
    
	["base"] = { type = "Model", model = "models/props_c17/doll01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.232, 2.076, 0.564), angle = Angle(-26.907, 180, 177.115), size = Vector(1.014, 1.014, 1.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Slot = 4
SWEP.SlotPos = 0

function SWEP:ShootBullets()
	local owner = self:GetOwner()
	self:SendWeaponAnim(ACT_VM_THROW)
	owner:DoAttackEvent()
end

function SWEP:DrawWeaponSelection(x, y, w, h, alpha)
	self:BaseDrawWeaponSelection(x, y, w, h, alpha)
end

local colBG = Color(16, 16, 16, 90)
local colWhite = Color(220, 220, 220, 230)

function SWEP:DrawHUD()
	self:DrawWeaponCrosshair()

	if not GAMEMODE:ShouldDraw2DWeaponHUD() then return end

	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local clip = self:GetPrimaryAmmoCount()

	draw.RoundedBox(16, x, y, wid, hei, colBG)
	draw.SimpleTextBlurry(clip, clip >= 100 and "ZSHUDFont" or "ZSHUDFontBig", x + wid * 0.5, y + hei * 0.5, colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function SWEP:PostDrawViewModel(vm)
	if GAMEMODE.WeaponHUDMode == 1 then return end

	local bone = vm:LookupBone("ValveBiped.Bip01_R_Hand")
	if not bone then return end

	local m = vm:GetBoneMatrix(bone)
	if not m then return end

	local pos, ang = m:GetTranslation(), m:GetAngles()

	pos = pos + ang:Up() * -3

	local time = CurTime()
	ang:RotateAroundAxis(ang:Right(), math.sin(time * math.pi) * 20)
	ang:RotateAroundAxis(ang:Up(), time * 180)

	pos = pos + ang:Forward() * 5

	ang:RotateAroundAxis(ang:Right(), 270)
	ang:RotateAroundAxis(ang:Up(), 270)

	local wid, hei = 144, 144
	local x, y = wid * -0.5, hei * -0.5
	local clip = self:GetPrimaryAmmoCount()

	cam.Start3D2D(pos, ang, 0.01)
		draw.RoundedBox(16, x, y, wid, hei, colBG)
		draw.SimpleText(clip, "ZS3D2DFontBig", x + wid * 0.5, y + hei * 0.5, colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end