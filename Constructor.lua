local Loaded = {}

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")
local LogService = game:GetService("LogService")
local PhysicisService = game:GetService("PhysicsService")
local ChatService = game:GetService("Chat")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local request = http_request or request or syn.request
local getasset = getcustomasset or getsynasset

local response = request({
	Url = "https://git.lococto.com/Raphs/Data/raw/branch/main/UsePolicy.md",
	Method = "GET",
})

local selfSettings = {
	forzaType = nil,
	onVehicle = false,
	Library = nil,
}

local CurVehicleData = {
	RPM = nil,
	MPH = nil,
	GEAR = nil,
	Vehicle = nil,
}

local v3UserPolicy = [[By using our service, you agree to the terms and conditions outlined in this Use Policy.

1. Data Collection
   We collect data from our users for the purpose of improving our services and conducting public data analysis. This includes, but is not limited to, information such as your device type, operating system, location, usage patterns, and preferences.

2. Use of Data
   The data we collect from our users will be used to:
   Improve our services - We may use your data to analyze usage patterns and identify areas where we can improve our service.

3. Sharing of Data
   We do not sell or rent your data to third parties. However, we may share your non-sensitive data as analytics or information for contribution towards the public and community, we may also share your data to third parties in order to improve the quality of our service.

4. License Agreement
   You are granted a limited, non-exclusive, non-transferable license to use the service. You may not share, transfer, or sublicense your license to anyone else.

5. Your Consent
   By using our service, you consent to the collection, use, and sharing of your data as described in this Use Policy, and agree not to share, transfer or sublicense your license to anyone else.

6. Responsibility
   We are not responsible for any result for you using this service. There is no guarantee of your account's safety. We will not be to blame for and compensate your loss.

7. Changes to this Agreement
   We reserve the right to modify this Use Policy at any time without prior notification. Any changes will be effective immediately upon posting on our website http://policy.lococto.com/. Your continued use of the service after any changes to this Use Policy will constitute your acceptance of those changes.

8. Termination
   We reserve the right to terminate your use of the service at any time if you violate the terms and conditions outlined in this Use Policy.

If you have any questions about this Use Policy, please contact us via a ticket in https://discord.lococto.com/
]] --response["Body"]
local ExecutionTime = os.date("%Y-%m-%d_%H-%M-%S")

-- Main
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if not LPH_OBFUSCATED then
	LPH_NO_VIRTUALIZE = function(...)
		return (...)
	end
	LPH_JIT_MAX = function(...)
		return (...)
	end
end

getgenv().getcustomasset = getcustomasset or getsynasset

import = function(dir)
	local Split = string.split(dir, "/")
	---@diagnostic disable-next-line: undefined-global
	local Data = JailbreakVisionV3

	Split[#Split] = string.split(Split[#Split], ".")[1]

	for i = 1, #Split do
		Data = Data[Split[i]]
	end

	if not Loaded[dir] and typeof(Data) == "function" then
		Loaded[dir] = Data()
	elseif typeof(Data) == "table" then
		Loaded[dir] = {}
		for i, v in next, Data do
			Loaded[dir][i] = import(dir .. "/" .. i)
		end
	end

	return Loaded[dir]
end

-- File
local Library = import("Modules/UiLibrary/Lib.lua")

makefolder("JailbreakVisionV3")
makefolder("JailbreakVisionV3/.logs")
makefolder("JailbreakVisionV3/Settings")
makefolder("JailbreakVisionV3/SpeedTestResults")
makefolder("JailbreakVisionV3/MapEditor")
makefolder("JailbreakVisionV3/GameExport")
makefolder("JailbreakVisionV3/LightingEditor")
makefolder("JailbreakVisionV3/Policy")
makefolder("JailbreakVisionV3/SpeedtestScenes")
makefolder("JailbreakVisionV3/EngineModifier")

pcall(function()
	delfile("JailbreakVisionV3/Settings/UserPolicy.pem")
end)

pcall(function()
	delfile("JailbreakVisionV3/Policy/UserPolicy.txt")
end)

pcall(function()
	delfile("JailbreakVisionV3/ModelsImporter")
end)

if not isfile("JailbreakVisionV3/Settings/UsePolicy.pem") then
	local json = HttpService:JSONEncode({
		agree = false,
	})

	writefile("JailbreakVisionV3/Settings/UsePolicy.pem", json)
end

if isfile("JailbreakVisionV3/Policy/UsePolicy.md") then
	if v3UserPolicy ~= readfile("JailbreakVisionV3/Policy/UsePolicy.md") then
		Library:ForceNotify({
			Name = "Use Policy",
			Text = "An update for Use Policy has been detected!",
			Icon = "rbxassetid://11401835376",
			Duration = 3,
		})

		writefile("JailbreakVisionV3/Policy/UsePolicy.md", v3UserPolicy)

		local json = HttpService:JSONEncode({
			agree = false,
		})

		writefile("JailbreakVisionV3/Settings/UsePolicy.pem", json)
	end
else
	writefile("JailbreakVisionV3/Policy/UsePolicy.md", v3UserPolicy)
end

-- Load
local DestructibleBind = import("Modules/DestructibleBind.lua")
local ReplayObj = import("Modules/EasyReplay/Utils/ReplayObjects.lua")
local Create = import("Create/Create.lua")
local Tracker = import("Functions/Tracker.lua")
local PlayerHandler = import("Functions/PlayerHandler.lua")
local PlayerRing = import("Functions/PlayerRing.lua")

Create.CreateUI()
ReplayObj.AssignID()
Tracker.Run()
DestructibleBind.init()
PlayerHandler.init()
PlayerRing.init()
