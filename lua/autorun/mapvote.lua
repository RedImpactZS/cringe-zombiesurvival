MapVote = {}
MapVote.Config = {}

--Default Config
MapVoteConfigDefault = {
    MapLimit = 24,
    TimeLimit = 28,
    AllowCurrentMap = false,
    EnableCooldown = true,
    MapsBeforeRevote = 3,
    RTVPlayerCount = 3,
    MapPrefixes = {"zs_"},
    AutoGamemode = true
}
--Default Config

hook.Add( "Initialize", "MapVoteConfigSetup", function()
    if not file.Exists( "mapvote", "DATA") then
        file.CreateDir( "mapvote" )
    end
    if not file.Exists( "mapvote/config.txt", "DATA" ) then
        file.Write( "mapvote/config.txt", util.TableToJSON( MapVoteConfigDefault ) )
    end
end )

function MapVote.HasExtraVotePower(ply)
	-- Example that gives admins more voting power
	--[[
    if ply:IsAdmin() then
		return true
	end 
    ]]

	return false
end


MapVote.CurrentMaps = {}
MapVote.Votes = {}

MapVote.Allow = false

MapVote.UPDATE_VOTE = 1
MapVote.UPDATE_WIN = 3

if SERVER then
    AddCSLuaFile()
    AddCSLuaFile("mapvote/cl_mapvote.lua")

    include("mapvote/sv_mapvote.lua")
    include("mapvote/rtv.lua")
else
    include("mapvote/cl_mapvote.lua")
end
