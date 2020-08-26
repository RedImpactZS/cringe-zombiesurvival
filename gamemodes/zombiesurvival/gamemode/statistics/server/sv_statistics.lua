GM.StatTracking = {}

local stattrack = GM.StatTracking
stattrack.Folder = "stat_tracking"
stattrack.BlackList = false

STATTRACK_TYPE_WEAPON = 1
STATTRACK_TYPE_ZOMBIECLASS = 2
STATTRACK_TYPE_ROUND = 3
STATTRACK_TYPE_SKILL = 4

hook.Add("Initialize", "ZSProfiler", function()
end)

local ttypetblnames = {
	[STATTRACK_TYPE_WEAPON] = "Weapon",
	[STATTRACK_TYPE_ZOMBIECLASS] = "ZombieClass",
	[STATTRACK_TYPE_ROUND] = "Game",
	[STATTRACK_TYPE_SKILL] = "Skill",
}

function stattrack:GetTypeTbl(ttype)
	return ttypetblnames[ttype] .. "Data"
end

function stattrack:GetTrackTypeStatFile(ttype)
	return self.Folder.."/".. string.lower(ttypetblnames[ttype]) .."s.txt"
end


function stattrack:SafeElementUpdateCreate(type, elem, key, value)
end

function stattrack:ElementRead(type, elem, key)
end

function stattrack:IncreaseElementKV(type, elem, key, incr)
end

function stattrack:SaveStatTrackingFiles()
end
