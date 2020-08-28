ENT.Type = "anim"

ENT.LifeTime = 2.5

ENT.NoPropDamageDuringWave0 = true

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer()
end