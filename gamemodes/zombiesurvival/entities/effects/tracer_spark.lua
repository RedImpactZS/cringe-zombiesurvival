function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Heat = IsValid(self.WeaponEnt) and math.max(self.WeaponEnt:GetHeat(),0.05) or 1

	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()

	self.Life = 0

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
end

function EFFECT:Think( )
	self.Life = self.Life + FrameTime() * 6 -- Effect should dissipate before the next one.
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )

	return self.Life < 1
end

local beammat = Material("trails/physbeam")
local glowmat = Material("sprites/light_glow02_add")
function EFFECT:Render()
	local texcoord = math.Rand( 0, 1 )

	local norm = (self.StartPos - self.EndPos) * self.Life
	local dir = (self.StartPos - self.EndPos):Angle()
	local dfwd = dir:Forward()
	local dup = dir:Up()
	local drgt = dir:Right()
	local nlen = norm:Length()

	local prevspinpos = self.StartPos
	local alpha = 1 - self.Life

	local offsetspark = dfwd * - 28

	render.SetMaterial(beammat)
	--[[for i = 0, nlen, 32 do
		if i > 704 then break end -- Limit the range on the spin beam effect...otherwise might be expensive.

		local set = i - CurTime() * 4

		local basebeampos = self.StartPos - dfwd * i
		local spinbeampos = basebeampos + dup * math.sin(set) * 24 + drgt * math.cos(set) * 24

		if i == 704 then spinbeampos = basebeampos end -- Tie the spin back into the main beam at the end of the spin beams

		render.DrawBeam(prevspinpos, spinbeampos, 100, texcoord + i, texcoord + nlen / 128 + i, Color(96, 150, 255, 255 * alpha))

		prevspinpos = spinbeampos
	end--]]


	for i = 0, 8 do
		local offset = dup * math.sin(i*2.75)*12*(1-self.Heat)^3 + drgt*math.cos(i*2.75)*12*(1-self.Heat)^3
		render.DrawBeam(self.StartPos+offsetspark*2, self.EndPos+offset, 24, texcoord, texcoord + nlen / 128, HSVToColor(i*22.5+CurTime()*360,1,0.8)) -- Color(250, 156, 54, 150 * alpha))
	end

	local mainc = HSVToColor(CurTime()*360,1,0.8)

	render.DrawBeam(self.StartPos+offsetspark*2, self.EndPos, 32, texcoord, texcoord + nlen / 128, mainc)

	render.SetMaterial(glowmat)
	render.DrawSprite(self.StartPos+offsetspark, 54, 54, mainc)
	render.DrawSprite(self.StartPos+offsetspark, 54, 54, Color(100, 100, 100, 148 * alpha))
	--render.DrawSprite(self.EndPos, 24, 24, Color(250, 156, 54, 148 * alpha))
end
