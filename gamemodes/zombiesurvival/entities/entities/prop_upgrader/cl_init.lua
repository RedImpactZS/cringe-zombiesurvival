INC_CLIENT()
local vOffset = Vector(11.75, 0, 13)
local vOffset2 = Vector(-12.75, 0, 13)
local aOffset = Angle(0, 90, 90)
local aOffset2 = Angle(0, 270, 90)
function ENT:Initialize()
	self:SetRenderBounds(Vector(-50, -50, -50), Vector(50, 50, 128))
end
function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end
function ENT:RenderInfo(pos, ang, owner)
	cam.Start3D2D(pos, ang, 0.055)
		draw.SimpleText(translate.Get("weapon_upgrader"), "ZS3D2DFont2", 0, -50, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if owner:IsValid() and owner:IsPlayer() then
			draw.SimpleText(owner:ClippedName(), "ZS3D2DFont2", 0, 160, owner == MySelf and COLOR_LBLUE or COLOR_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		self:Draw3DHealthBar(math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 1), nil, 570, 0.85)
        cam.End3D2D()
end
function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() or MySelf:Team() ~= TEAM_HUMAN then return end

	local owner = self:GetObjectOwner()
	self:RenderInfo(self:LocalToWorld(vOffset), self:LocalToWorldAngles(aOffset), owner)
	self:RenderInfo(self:LocalToWorld(vOffset2), self:LocalToWorldAngles(aOffset2), owner)
end
net.Receive("zs_upgradercontent", function(length)
	local ent = net.ReadEntity()
	local readstring = net.ReadString()

	ent.WepClass = readstring ~= "" and readstring or nil
	ent.Contents = readstring ~= "" and weapons.Get(readstring).PrintName or "EMPTY"
end)
