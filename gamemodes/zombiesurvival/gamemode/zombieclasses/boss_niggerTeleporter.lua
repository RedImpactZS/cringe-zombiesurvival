CLASS.Base = "boss_niggerTeleporter"

CLASS.Name = "NIGGER TELEPORTER"
CLASS.TranslationName = "class_telenigga"
CLASS.Description = "description_telenigga"
CLASS.Help = "controls_telenigga"

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

CLASS.Icon = "zombiesurvival/killicons/butcher"
CLASS.IconColor = Color(100, 0, 220)

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld

local colGlow = Color(180, 0, 255)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0.4, 0.1, 0.6)
end

function CLASS:PostPlayerDraw(pl)
	render.SetColorModulation(1, 1, 1)

	if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

	local id = pl:LookupBone("ValveBiped.Bip01_Head1")
	if id and id > 0 then
		local pos, ang = pl:GetBonePositionMatrixed(id)
		if pos then
			render_SetMaterial(matGlow)
			render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 4, 4, colGlow)
			render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 4, 4, colGlow)
		end
	end
end
