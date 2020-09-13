AddCSLuaFile()

SWEP.Base = "weapon_zs_basemelee"

SWEP.PrintName = "Chin Cheng hanji"


if CLIENT then

SWEP.HUD3DBone = "ValveBiped.Bip01_R_Hand"
SWEP.HUD3DPos = Vector(2.596, 6.414, -3.636)
SWEP.HUD3DAng = Angle(180, -120,80)
SWEP.HUD3DScale = 0.05

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.VElements = {
	["radio"] = { type = "Model", model = "models/props_lab/reciever01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.714, 6.752, -1.558), angle = Angle(-33.896, 180, -17.532), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

end

SWEP.WElements = {
	["plate"] = { type = "Model", model = "models/props_c17/furnituretable001a.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(5.714, 0, 0), angle = Angle(-90, 0, 0), size = Vector(0.5, 0.5, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/combine_helicopter/helicopter_bomb01", skin = 0, bodygroup = {} },
	["radio"] = { type = "Model", model = "models/props_lab/reciever01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.714, 6.752, -1.558), angle = Angle(-33.896, 180, -17.532), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/error.mdl"
SWEP.UseHands = true

SWEP.Primary.Ammo = "none"
SWEP.HoldType = "normal"

SWEP.InitialChinCheng = 0.05
SWEP.ChinChengBuild = 0.05
SWEP.Primary.Delay = 0.09
SWEP.Primary.Automatic = true

SWEP.MeleeDamage = 800
SWEP.MeleeSize = 5
SWEP.MeleRange = 72

SWEP.ChinChengSpeed = 500

function SWEP:Initialize()
	self.BaseClass.Initialize(self)

	local enty = self
	local ENTC = tostring(enty)

	if CLIENT then

		local yrot = Angle(0,360*10,0)

		hook.Add("PrePlayerDraw", ENTC, function(pl)
			if pl ~= self:GetOwner() then return end

			if self:GetGunState() == 1 then

				local mat = self.Matrix
				mat:Rotate( yrot * FrameTime() )

				pl:EnableMatrix("RenderMultiply", mat)

			end

		end)
		hook.Add("PostPlayerDraw", ENTC,  function(pl)
			if pl ~= self:GetOwner() then return end

			pl:DisableMatrix("RenderMultiply")
		end)
	end

	hook.Add("CalcMainActivity", ENTC, function(pl, velocity)
	if pl == self:GetOwner() and self:GetGunState() == 1 then
		return ACT_STAND, -1
	end
	end)
	hook.Add("Move", ENTC, function(pl, mv)
	if pl ~= self:GetOwner() then return end

	if self:GetGunState() == 1 then
		local newbuttons = bit.band(mv:GetButtons(), bit.bnot(IN_DUCK))
		newbuttons = bit.band(newbuttons, bit.bnot(IN_JUMP))
		mv:SetButtons(newbuttons)

		mv:SetForwardSpeed(10000)

		local mul = 1 + self:GetChinCheng() * 0.5

		mv:SetMaxSpeed(self.ChinChengSpeed * mul)
		mv:SetMaxClientSpeed(self.ChinChengSpeed * mul)
	end

	end)
end

function SWEP:OnRemove()
	local ENTC = tostring(self)
	if CLIENT then
		hook.Remove("PrePlayerDraw", ENTC)
		hook.Remove("PostPlayerDraw", ENTC)
	end

	hook.Remove("Move", ENTC)
	hook.Remove("CalcMainActivity", ENTC)

	self.BaseClass.OnRemove(self)
end

function SWEP:Holster()
	self:SetGunState(0)

	return self.BaseClass.Holster(self)
end

SWEP.Matrix =  Matrix()

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetReloadFinish() > 0 then return false end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if self:GetGunState() ~= 1 then

		-- We prevent a bit of tapping fire by doing this.
		self:SetChinCheng(math.min(self:GetChinCheng() + self.InitialChinCheng, 1))
		self:SetGunState(1)
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(75, 80))
end

function SWEP:PlayHitSound()
	self:EmitSound("npc/manhack/grind"..math.random(5)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav")
end

function SWEP:SecondaryAttack()
end

function SWEP:ManageChinCheng()
	local owner = self:GetOwner()
	if owner and owner:IsValid() then
		local frametime = FrameTime()
		if self:GetGunState() == 1 then
			self:SetChinCheng(math.min(self:GetChinCheng() + frametime * self.ChinChengBuild, 1))

			if CLIENT then owner.GunSway = true end
		else
			owner.GunSway = false
			self:SetChinCheng(math.max(self:GetChinCheng() - frametime * self.ChinChengBuild, 0))
		end
	end
end

function SWEP:Think()
	self.BaseClass.Think(self)

	local owner = self:GetOwner()

	local overheat = self:GetChinCheng() >= 1
	if self:GetGunState() == 1 and CurTime() >= self:GetNextPrimaryFire() + 0.1 or overheat then

		if overheat and not self.Exploded then

		local pos = self:GetPos()

		if SERVER then

		util.BlastDamagePlayer(self, owner, pos, 256, 480, DMG_ALWAYSGIB)

		end

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetNormal(self:GetUp() * -1)
		util.Effect("decal_scorch", effectdata)

		for i=1, 3 do
			self:EmitSound("npc/env_headcrabcanister/explosion.wav", 75 + i * 5, 100)
		end
		for i=1, 2 do
			ParticleEffect("dusty_explosion_rockets", pos, angle_zero)
		end

		if owner:Alive() then
			owner:Kill()
		end

		self.Exploded = true
		if SERVER then
			self:Remove()
		end
		end

		self:SetGunState(0)
		self:SetNextPrimaryFire(CurTime() + 2)
	elseif self:GetGunState() == 1 then
		if owner:WaterLevel() >= 2 then
			self:SetGunState(0)
			self:SetNextPrimaryFire(CurTime() + 2)	
			return
		end

		self:MeleeSwing()

	end

	self:ManageChinCheng()
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end

	if self.HUD3DPos and GAMEMODE:ShouldDraw3DWeaponHUD() then
		local pos, ang = self:GetHUD3DPos(vm)
		if pos then
			self:Draw3DHUD(vm, pos, ang)
		end
	end
end

function SWEP:DrawHUD()

	if GAMEMODE:ShouldDraw2DWeaponHUD() then
		self:Draw2DHUD()
	end
end

function SWEP:GetHUD3DPos(vm)
	local bone = vm:LookupBone(self.HUD3DBone)
	if not bone then return end

	local m = vm:GetBoneMatrix(bone)
	if not m then return end

	local pos, ang = m:GetTranslation(), m:GetAngles()

	if self.ViewModelFlip then
		ang.r = -ang.r
	end

	local offset = self.HUD3DPos
	local aoffset = self.HUD3DAng

	pos = pos + ang:Forward() * offset.x + ang:Right() * offset.y + ang:Up() * offset.z

	if aoffset.yaw ~= 0 then ang:RotateAroundAxis(ang:Up(), aoffset.yaw) end
	if aoffset.pitch ~= 0 then ang:RotateAroundAxis(ang:Right(), aoffset.pitch) end
	if aoffset.roll ~= 0 then ang:RotateAroundAxis(ang:Forward(), aoffset.roll) end

	return pos, ang
end

local colBG = Color(16, 16, 16, 90)
local colRed = Color(220, 0, 0, 230)
local colWhite = Color(220, 220, 220, 230)

local function DrawHeatBar(self, x, y, wid, hei, is3d)
	local heatcolor = (1 - (self:GetChinCheng())) * 220
	colWhite.g = heatcolor
	colWhite.b = heatcolor
	colWhite.a = 230

	local shortdiv = self:GetChinCheng()
	local barheight = 20
	local bary = y + hei * 0.6
	local barshortwid = math.max(wid * shortdiv - 8, 0)

	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawRect(x, bary, wid - 8, barheight)
	surface.SetDrawColor(255, 0, 0, 220)
	surface.DrawRect(x + 4, bary + 4, barshortwid, barheight - 8)

	if self:GetGunState() == 1 then

		colWhite.b = 0
		colWhite.g = 0
		if ((CurTime() * 4) % 2) > 1 then
			colWhite.a = 0
		else
			draw.SimpleTextBlurry("CHINCHENG CHINCHENG CHINCHENG", is3d and "ZS3D2DFontSmaller" or "ZSHUDFontSmaller", x + wid/2, bary + hei * 0.15, colRed, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

	end
end

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local spare = self:GetPrimaryAmmoCount()

	local yy = ScrH() - hei * 2 - screenscale * 84

	DrawHeatBar(self, x + wid * 0.25 - wid/4, yy + hei * 0.2, wid, hei)
end

function SWEP:Draw3DHUD(vm, pos, ang)
	local wid, hei = 180, 64
	local x, y = wid * -0.6, hei * -0.5
	local spare = self:GetPrimaryAmmoCount()

	cam.Start3D2D(pos, ang, self.HUD3DScale / 2)
		DrawHeatBar(self, x + wid * 0.25 - wid/4, y - hei * 1, wid, hei, true)
	cam.End3D2D()
end

function SWEP:SetChinCheng(heat)
	self:SetDTFloat(8, heat)
end

function SWEP:GetChinCheng()
	return self:GetDTFloat(8)
end

function SWEP:SetGunState(state)
	self:SetDTInt(1, state)
end

function SWEP:GetGunState(state)
	return self:GetDTInt(1)
end