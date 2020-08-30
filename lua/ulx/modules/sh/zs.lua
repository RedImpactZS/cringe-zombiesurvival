--redeem-----
function ulx.redeem( caller, targets )
	local affected = {}

	for i = 1, #targets do
		local target = targets[ i ]

		if target:Team() == TEAM_UNDEAD then
			target:Redeem()
			table.insert( affected, target )
		else
			ULib.tsayError( caller, target:Nick() .. " isn't a zombie!", true )
		end
	end

	ulx.fancyLogAdmin( caller, "#A redeemed #T", affected )
end

local redeem = ulx.command( "ZS ULX Commands", "ulx redeem", ulx.redeem, "!redeem" )
redeem:addParam{ type = ULib.cmds.PlayersArg }
redeem:defaultAccess( ULib.ACCESS_ADMIN )
redeem:help( "Redeem target(s)" )

--force zombie to boss------
function ulx.forceboss( caller, targets, silent, inPlace )
	local affected = {}

	for i = 1, #targets do
		local target = targets[ i ]

		if target:Team() == TEAM_UNDEAD then
			if inPlace then
				local pos = target:GetPos()
				local ang = target:GetAngles()

				gamemode.Call( "SpawnBossZombie", target, silent )

				target:SetPos( pos )
				-- setting the angles right after spawning doesn't work
				timer.Simple( 0, function() target:SetEyeAngles( ang ) end )
			else
				gamemode.Call( "SpawnBossZombie", target, silent )
			end

			table.insert( affected, target )
		else
			ULib.tsayError( caller, target:Nick() .. " isn't a zombie!", true )
		end
	end

	ulx.fancyLogAdmin( caller, "#A forced #T to be boss", affected )
end

local forceboss = ulx.command( "ZS ULX Commands", "ulx forceboss", ulx.forceboss, "!forceboss" )
forceboss:addParam{ type = ULib.cmds.PlayersArg }
forceboss:addParam{ type = ULib.cmds.BoolArg, default = false, hint = "silent", ULib.cmds.optional }
forceboss:addParam{ type = ULib.cmds.BoolArg, default = false, hint = "respawn in place", ULib.cmds.optional }
forceboss:defaultAccess( ULib.ACCESS_ADMIN )
forceboss:help( "Respawn target(s) as boss" )

--force zombie class-----
local ZombieClasses

function ulx.forceclass( caller, targets, className, inPlace )
	local class = ZombieClasses[ className ]
	if not class then
		ULib.tsayError( caller, "No such class \"" .. className .. "\"!" )
		return
	end

	local classIndex = class.Index

	local affected = {}

	for i = 1, #targets do
		local target = targets[ i ]

		if target:Team() == TEAM_UNDEAD then
			if inPlace then
				local pos = target:GetPos()
				local ang = target:GetAngles()

				-- copied from GM:SpawnBossZombie
				target:KillSilent()
				target:SetZombieClass( classIndex )
				target:DoHulls( classIndex, TEAM_UNDEAD )
				target:UnSpectateAndSpawn()

				target:SetPos( pos )
				-- setting the angles right after spawning doesn't work
				timer.Simple( 0, function() target:SetEyeAngles( ang ) end )
			else
				target:KillSilent()
				target:SetZombieClass( classIndex )
				target:DoHulls( classIndex, TEAM_UNDEAD )
				target:UnSpectateAndSpawn()
			end

			table.insert( affected, target )
		else
			ULib.tsayError( caller, target:Nick() .. " isn't a zombie!", true )
		end
	end

	ulx.fancyLogAdmin( caller, "#A forced #T to be #s", affected, className )
end

--wave active-------
function ulx.waveactive( caller, active )
	if active ~= gamemode.Call( "GetWaveActive" ) then
		gamemode.Call( "SetWaveActive", active )

		ulx.fancyLogAdmin( caller, "#A #s the wave", active and "started" or "ended" )
	end
end

local waveactive = ulx.command( "ZS ULX Commands", "ulx waveactive", ulx.waveactive, "!waveactive" )
waveactive:addParam{ type = ULib.cmds.BoolArg, default = false, hint = "active" }
waveactive:defaultAccess( ULib.ACCESS_ADMIN )
waveactive:help( "Start or end the wave" )

--set wave time------
function ulx.wavetime( caller, time )
	time = time * 60

	gamemode.Call(
		gamemode.Call( "GetWaveActive" ) and "SetWaveEnd" or "SetWaveStart",
		CurTime() + time
	);

	ulx.fancyLogAdmin( caller, "#A set time until wave start/end to #s", ULib.secondsToStringTime( time ) or "0 seconds" )
end

local wavetime = ulx.command( "ZS ULX Commands", "ulx wavetime", ulx.wavetime, "!wavetime" )
wavetime:addParam{ type = ULib.cmds.NumArg, hint = "time", max = 60, ULib.cmds.allowTimeString }
wavetime:defaultAccess( ULib.ACCESS_ADMIN )
wavetime:help( "Set time until wave start/end" )
--give points--------
function ulx.givepoints( caller, targets, points )
	for i = 1, #targets do
		targets[ i ]:AddFrags( points )
	end

	ulx.fancyLogAdmin( caller, "#A gave #i points to #T", points, targets )
end

local givepoints = ulx.command( "ZS ULX Commands", "ulx givepoints", ulx.givepoints, "!givepoints" )
givepoints:addParam{ type = ULib.cmds.PlayersArg }
givepoints:addParam{ type = ULib.cmds.NumArg, hint = "points" }
givepoints:defaultAccess( ULib.ACCESS_ADMIN )
givepoints:help( "Give points to target(s)" )
--give ammo------
function ulx.giveammo(calling_ply, amount, ammotype, target_plys)
	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ]
		if v:IsValid() and then
			v:GiveAmmo(amount, ammotype)
		end
	end
end

local giveammo = ulx.command("ZS ULX Commands", "ulx giveammo", ulx.giveammo, "!giveammo" )
giveammo:addParam{ type=ULib.cmds.NumArg, hint="Ammo Amount"}
giveammo:addParam{ type=ULib.cmds.StringArg, hint="Ammo Type"}
giveammo:addParam{ type=ULib.cmds.PlayersArg }
giveammo:defaultAccess(ULib.ACCESS_ADMIN)
giveammo:help( "Gives the specified ammo to the target player(s)." )
--give weapon------
function ulx.giveweapon( caller, targets, weapon, giveAmmo )
	hook.Add("PlayerCanPickupWeapon", "PlayerCanPickupWeapon.AcceptAll", function(pl, ent) return true end)
	local affected = {}

	for i = 1, #targets do
		local target = targets[ i ]

		if target:Alive() then
			target:Give( weapon, not giveAmmo )

			table.insert( affected, target )
		else
			ULib.tsayError( caller, target:Nick() .. " is dead!", true )
		end
	end

	ulx.fancyLogAdmin( caller, "#A gave #s to #T", weapon, targets )
	hook.Remove("PlayerCanPickupWeapon", "PlayerCanPickupWeapon.AcceptAll")
end


-- these commands depend on data that doesn't exist until the gamemode is fully loaded
hook.Add( "Initialize", "zs_ulx_cmds",
	function()
		local GAMEMODE = gmod.GetGamemode()

		ZombieClasses = GAMEMODE.ZombieClasses

		local forceclassCompletes
		if ZombieClasses then
			forceclassCompletes = {}

			for k in pairs( ZombieClasses ) do
				if isstring( k ) then
					table.insert( forceclassCompletes, k )
				end
			end
		end

		local forceclass = ulx.command( "ZS ULX Commands", "ulx forceclass", ulx.forceclass, "!forceclass" )
		forceclass:addParam{ type = ULib.cmds.PlayersArg }
		forceclass:addParam{ type = ULib.cmds.StringArg, hint = "class", completes = forceclassCompletes, ULib.cmds.restrictToCompletes }
		forceclass:addParam{ type = ULib.cmds.BoolArg, default = false, hint = "respawn in place", ULib.cmds.optional }
		forceclass:defaultAccess( ULib.ACCESS_ADMIN )
		forceclass:help( "Respawn target(s) as the specified class" )


		local weaponClasses = {}
		for _, tbl in pairs( weapons.GetList() ) do
			table.insert( weaponClasses, tbl.ClassName )
		end

		local giveweapon = ulx.command( "ZS ULX Commands", "ulx giveweapon", ulx.giveweapon, "!giveweapon" )
		giveweapon:addParam{ type = ULib.cmds.PlayersArg }
		giveweapon:addParam{ type = ULib.cmds.StringArg, hint = "weapon class name", completes = weaponClasses, ULib.cmds.restrictToCompletes }
		giveweapon:addParam{ type = ULib.cmds.BoolArg, default = true, hint = "give ammo", ULib.cmds.optional }
		giveweapon:defaultAccess( ULib.ACCESS_ADMIN )
		giveweapon:help( "Give weapon to target(s)" )
	end
)
-----respawn dead --------

function ulx.respawn( calling_ply, target_plys )

    local affected_plys = {}
    for i=1, #target_plys do
        local pl = target_plys[ i ]

        if ulx.getExclusive( pl, calling_ply ) then
            ULib.tsayError( calling_ply, ulx.getExclusive( pl, calling_ply ), true )
        else
            hook.Call( "PlayerRespawn", GAMEMODE, pl )
            table.insert( affected_plys, pl )
        end
    end

    ulx.fancyLogAdmin( calling_ply, "#A respawn #T", affected_plys )
end
local respawn = ulx.command( "ZS ULX Commands", "ulx respawn", ulx.respawn, "!respawn" )
respawn:addParam{ type=ULib.cmds.PlayersArg }
respawn:defaultAccess( ULib.ACCESS_ADMIN )
respawn:help( "Redeems target(s)." )
--restart map--------
function ulx.restartmap(calling_ply)
	ulx.fancyLogAdmin( calling_ply, "#A restarted the map.")
	game.ConsoleCommand("changelevel "..string.format(game.GetMap(),".bsp").."\n")
end
local restartmap = ulx.command("ZS ULX Commands", "ulx restartmap", ulx.restartmap, "!restartmap")
restartmap:defaultAccess( ULib.ACCESS_SUPERADMIN )
restartmap:help( "Reloads the level." )
--