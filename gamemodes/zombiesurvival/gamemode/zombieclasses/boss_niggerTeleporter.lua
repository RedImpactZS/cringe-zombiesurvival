CLASS.Name = "NIGGER TELEPORTER"
CLASS.TranslationName = "class_telenigga"
CLASS.Description = "description_telenigga"
CLASS.Help = "controls_telenigga"
CLASS.Model = Model("models/player/zombie_classic_hbfix.mdl")
CLASS.Boss = true

CLASS.Health = 1600
CLASS.Speed = 200

CLASS.CanTaunt = true

CLASS.FearPerInstance = 1
  
CLASS.Points = 30

CLASS.SWEP = "weapon_zs_telenigga"

if SERVER then
	function CLASS:OnSpawned(pl)
		pl:CreateAmbience("gravediggerambience")
	end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/zombie"
CLASS.IconColor = Color(0, 0, 0)

local render_ModelMaterialOverride = render.ModelMaterialOverride
local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation
local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld

local colGlow = Color(255, 0, 0)
local colBlack = Color(0, 0, 0, 255)
local matGlow = Material("sprites/glow04_noz")
local matBlack = CreateMaterial("shadowlurkersheet", "UnlitGeneric", {["$basetexture"] = "Tools/toolsblack", ["$model"] = 1})
local vecEyeLeft = Vector(8, -5.5, -1.5)
local vecEyeRight = Vector(8, -5.5, 1.5)


function CLASS:PrePlayerDraw(pl)
	render_SetBlend(1)
	self:GetOwner():SetModel("models/props_junk/wood_crate001a.mdl")
	self:GetOwner():SetColor(colBlack) 
	self:GetOwner():SetRenderMode( RENDERMODE_TRANSCOLOR )
	render_SetColorModulation(0, 0, 0)
end

function CLASS:PostPlayerDraw(pl)
	render_SetBlend(1)
	self:GetOwner():SetModel("models/props_junk/wood_crate001a.mdl")
	self:GetOwner():SetColor(colBlack) 
	self:GetOwner():SetRenderMode( RENDERMODE_TRANSCOLOR )
	render_SetColorModulation(0, 0, 0)
end

function CLASS:PrePlayerDrawOverrideModel(pl)
	render_ModelMaterialOverride(matBlack)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
	render_ModelMaterialOverride(nil)

	if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

	local pos, ang = pl:GetBonePositionMatrixed(6)
	if pos then
		render_SetMaterial(matGlow)
		render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 4, 4, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 4, 4, colGlow)
	end
end
