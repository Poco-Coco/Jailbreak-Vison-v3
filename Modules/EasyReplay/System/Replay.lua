local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Replay = {
	Variable = {},
	Functions = {},
	Data = {
		Vehicle = require(ReplicatedStorage.Game.Vehicle),
		KeyF = 0,
		PrevData = {},
		LoopArr = {},
		BootRS = nil,
	},
}

local clientPlayer = Workspace:WaitForChild(game.Players.LocalPlayer.Name)

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local function addVehicle(veh)
	local selfDat = {
		RS = nil,
		cycArr = {},
	}

	selfDat.RS = RunService.Heartbeat:Connect(function(deltaTime)
		Replay.Data.LoopArr["Vehicles"][veh.Name .. "|||" .. veh:GetAttribute("ReplayID")] = selfDat.cycArr
	end)
end

LPH_NO_VIRTUALIZE(function()
	local replayObjectArray = {}

	function Replay.Record(Toggle)
		Replay.KeyF = 0

		if not Toggle then
			Replay.Data.BootRS:Disconnect()

			local json = HttpService:JSONEncode(replayObjectArray)

			local replayName = "Untitled"
			makefolder("JailbreakVisionV3/EasyReplays/" .. replayName)
			writefile("JailbreakVisionV3/EasyReplays/" .. replayName .. "/ReplayData.json", json)

			replayObjectArray = {}
		else
			local RpArr = {}
			Replay.Data.BootRS = RunService.Heartbeat:Connect(function(dt)
				Replay.Data.KeyF = Replay.Data.KeyF + 1

				Replay.Data.LoopArr["Delta"] = dt
				RpArr[Replay.Data.KeyF] = Replay.Data.LoopArr
			end)

			writefile(".json", HttpService:JSONEncode(RpArr))
		end
	end

	function Replay.ReplayFrame(Frame) end
end)()

return Replay
