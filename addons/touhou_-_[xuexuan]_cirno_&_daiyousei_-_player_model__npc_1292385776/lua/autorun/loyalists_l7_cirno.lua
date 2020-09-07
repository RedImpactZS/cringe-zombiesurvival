// Codename:cirno
// Seq:7
list.Set( "PlayerOptionsModel", "Cirno V2", "models/loyalists/mmd/cirno/cirno_mp_pm.mdl" )
player_manager.AddValidModel( "Cirno V2", "models/loyalists/mmd/cirno/cirno_mp_pm.mdl" )
player_manager.AddValidHands( "Cirno V2", "models/loyalists/mmd/cirno/cirno_mp_vm.mdl", 0, "0000000" )

list.Set( "PlayerOptionsModel", "Daiyousei", "models/loyalists/mmd/dai/dai_mp_pm.mdl" )
player_manager.AddValidModel( "Daiyousei", "models/loyalists/mmd/dai/dai_mp_pm.mdl" )
player_manager.AddValidHands( "Daiyousei", "models/loyalists/mmd/cirno/cirno_mp_vm.mdl", 0, "0000000" )

local NPC = { 	Name = "Cirno", 
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/loyalists/mmd/cirno/cirno_mp_npc.mdl",
				Health = "300",
				KeyValues = { citizentype = 4 },
                                Category = "Touhou"    }

list.Set( "NPC", "npc_l7_cirno", NPC )

local NPC = { 	Name = "Daiyousei", 
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/loyalists/mmd/dai/dai_mp_npc.mdl",
				Health = "300",
				KeyValues = { citizentype = 4 },
                                Category = "Touhou"    }

list.Set( "NPC", "npc_l7_dai", NPC )

-- http://steamcommunity.com/sharedfiles/filedetails/?id=1143840003
-- if SERVER then
	-- resource.AddWorkshop("1143840003")
-- end