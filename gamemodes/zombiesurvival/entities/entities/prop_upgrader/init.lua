INC_SERVER()
local function RefreshupgraderOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_upgrader")) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "upgrader.PlayerDisconnected", RefreshupgraderOwners)
hook.Add("OnPlayerChangedTeam", "upgrader.OnPlayerChangedTeam", RefreshupgraderOwners)

function ENT:Initialize()
	self.Contents = {}
	self.NextUse = {}

	self:SetModel("models/props_c17/gravestone003a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:CollisionRulesChanged()

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	self:SetMaxObjectHealth(999)
	self:SetObjectHealth(self:GetMaxObjectHealth())
end
--