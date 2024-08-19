local JbvV2Loader = {}

function JbvV2Loader.Load()
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

	JailbreakVisionV2 = {
		spring = function()
			local spring = {}
			local epsilon = 1e-8

			local exp = math.exp
			local cos = math.cos
			local sin = math.sin
			local vec3 = Vector3.new

			function spring.new(initial, target)
				local self = setmetatable({}, { __index = spring })

				self.initial = initial
				self.pos = initial
				self.velocity = vec3()
				self.target = target
				self.ratio = 2
				self.frequency = 50

				return self
			end

			function spring:update(dt)
				local x0 = self.pos - self.target
				if self.ratio > 1 + epsilon then -- Over damped
					local za = -self.frequency * self.ratio
					local zb = self.frequency * (self.ratio * self.ratio - 1) ^ 0.5
					local z0, z1 = za - zb, za + zb
					local expt0, expt1 = exp(z0 * dt), exp(z1 * dt)
					local c1 = (self.velocity - x0 * z1) / (-2 * zb)
					local c2 = x0 - c1

					self.pos = self.target + c1 * expt0 + c2 * expt1
					self.velocity = c1 * z1 * expt0 + c2 * z1 * expt1
				elseif self.ratio > 1 - epsilon then -- Critically damped
					local expt = exp(-self.frequency * dt)
					local c1 = self.velocity + self.frequency * x0
					local c2 = (c1 * dt + x0) * expt

					self.pos = self.target + c2
					self.velocity = (c1 * expt) - (c2 * self.frequency)
				else -- Under damped
					local frequencyratio = self.frequency * self.ratio
					local alpha = self.frequency * (1 - self.ratio * self.ratio) ^ 0.5
					local exp = exp(-dt * frequencyratio)
					local cos = cos(dt * alpha)
					local sin = sin(dt * alpha)
					local c2 = (self.velocity + x0 * frequencyratio) / alpha

					self.pos = self.target + exp * (x0 * cos + c2 * sin)
					self.velocity = -exp
						* ((x0 * frequencyratio - c2 * alpha) * cos + (x0 * alpha + c2 * frequencyratio) * sin)
				end
			end

			return spring
		end,
	}

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
		local Data = JailbreakVisionV2

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

	local m_spring = import("spring.lua")

	repeat
		task.wait(1)
	until game:IsLoaded()

	local getasset = getcustomasset or getsynasset

	--Services
	Library =
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Loco-CTO/Script-Assets/main/UI-Lib/VisionLib.lua"))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/mcKTS/FreeCam/main/FreeCamera.lua"))()

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RunService = game:GetService("RunService")
	local SoundService = game:GetService("SoundService")
	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local HttpService = game:GetService("HttpService")
	local GetLocalVehiclePacket = require(ReplicatedStorage.Vehicle.VehicleUtils).GetLocalVehiclePacket
	local UserInputService = game:GetService("UserInputService")
	local clientPlayer = game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)

	local Camera = workspace.CurrentCamera
	Camera.CameraType = "Scriptable"
	local VehicleModel

	local camPos = Camera.CFrame.Position
	local spring = m_spring.new(camPos, camPos)

	local CamPart = Instance.new("Part")
	CamPart.Anchored = true
	CamPart.Parent = game:GetService("Workspace")
	CamPart.CanCollide = false
	CamPart.Size = Vector3.new(50, 5, 10)
	CamPart.Transparency = 1

	local CustomCameraPart = Instance.new("Part")
	CustomCameraPart.Parent = workspace
	CustomCameraPart.Anchored = true
	CustomCameraPart.Transparency = 1

	local CamPerspective = Instance.new("Part")
	CamPerspective.Parent = workspace
	CamPerspective.Anchored = true
	CamPerspective.Transparency = 1
	CamPerspective.CanCollide = false

	local PerspectiveChosen = ""
	local PerspectiveToggle = false

	--DepthOfField
	local DepthOfField = Instance.new("DepthOfFieldEffect")
	DepthOfField.FarIntensity = 0.75
	DepthOfField.NearIntensity = 0.75
	DepthOfField.Enabled = false
	DepthOfField.Parent = game.Lighting

	--Folders Handle
	local assetFolder = Instance.new("Folder")
	assetFolder.Name = "JailbreakVisionV2"
	assetFolder.Parent = game.Workspace

	makefolder("JailbreakVisionV2")
	makefolder("JailbreakVisionV2/SpeedTestResults")
	makefolder("JailbreakVisionV2/ModelsImporter")
	makefolder("JailbreakVisionV2/MapEditor")
	makefolder("JailbreakVisionV2/GameExport")

	local LocalPlayer = game.Players.LocalPlayer
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

	local Vehichle = {}

	for i, v in next, getgc(true) do
		if type(v) == "table" then
			if rawget(v, "Event") and rawget(v, "GetVehiclePacket") then
				Vehichle.GetVehiclePacket = v.GetVehiclePacket
			end
		end
	end

	--Preload Assets
	local modelFolder = Instance.new("Folder")
	modelFolder.Parent = game.Workspace
	modelFolder.Name = "ModelFolder"

	local mapEditFolder = Instance.new("Folder")
	mapEditFolder.Parent = game.ReplicatedStorage
	mapEditFolder.Name = "mapEditFolder"

	--Screen GUI
	do
		local ScreenGui0 = Instance.new("ScreenGui")
		local Frame1 = Instance.new("Frame")
		local Frame2 = Instance.new("Frame")
		local TextLabel3 = Instance.new("TextLabel")
		local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
		local TextLabel5 = Instance.new("TextLabel")
		local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
		local TextLabel7 = Instance.new("TextLabel")
		local UIAspectRatioConstraint8 = Instance.new("UIAspectRatioConstraint")
		local TextLabel9 = Instance.new("TextLabel")
		local UIAspectRatioConstraint10 = Instance.new("UIAspectRatioConstraint")
		local TextLabel11 = Instance.new("TextLabel")
		local UIAspectRatioConstraint12 = Instance.new("UIAspectRatioConstraint")
		local TextLabel13 = Instance.new("TextLabel")
		local UIAspectRatioConstraint14 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint15 = Instance.new("UIAspectRatioConstraint")
		local Frame16 = Instance.new("Frame")
		local Frame17 = Instance.new("Frame")
		local Frame18 = Instance.new("Frame")
		local Frame19 = Instance.new("Frame")
		local UIAspectRatioConstraint20 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint21 = Instance.new("UIAspectRatioConstraint")
		local Frame22 = Instance.new("Frame")
		local UIAspectRatioConstraint23 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint24 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint25 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint26 = Instance.new("UIAspectRatioConstraint")
		local UIPadding27 = Instance.new("UIPadding")
		local UIGradient = Instance.new("UIGradient")
		ScreenGui0.Parent = assetFolder
		ScreenGui0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		Frame1.Name = "Speedometer"
		Frame1.Parent = ScreenGui0
		Frame1.Position = UDim2.new(0.738756597, 0, 0.771196842, 0)
		Frame1.Size = UDim2.new(0.275862068, 0, 0.228714526, 0)
		Frame1.BackgroundColor = BrickColor.new("Institutional white")
		Frame1.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame1.BackgroundTransparency = 1
		Frame2.Name = "Top"
		Frame2.Parent = Frame1
		Frame2.Position = UDim2.new(0.28125, 0, 0.197080299, 0)
		Frame2.Size = UDim2.new(0.612500012, 0, 0.562043786, 0)
		Frame2.BackgroundColor = BrickColor.new("Olivine")
		Frame2.BackgroundColor3 = Color3.new(0.333333, 1, 0.498039)
		Frame2.BackgroundTransparency = 1
		TextLabel3.Name = "Speed"
		TextLabel3.Parent = Frame2
		TextLabel3.Position = UDim2.new(0.223379642, 0, -0.0519480519, 0)
		TextLabel3.Size = UDim2.new(0.607142866, 0, 1.2337662, 0)
		TextLabel3.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel3.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel3.BorderSizePixel = 16
		TextLabel3.ZIndex = 2
		TextLabel3.Font = Enum.Font.SourceSansLight
		TextLabel3.FontSize = Enum.FontSize.Size96
		TextLabel3.Text = "<i>000</i>"
		TextLabel3.TextColor = BrickColor.new("Institutional white")
		TextLabel3.TextColor3 = Color3.new(1, 1, 1)
		TextLabel3.TextScaled = true
		TextLabel3.TextSize = 100
		TextLabel3.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel3.TextTransparency = 0.20000000298023224
		TextLabel3.TextWrap = true
		TextLabel3.TextWrapped = true
		TextLabel3.RichText = true
		UIAspectRatioConstraint4.Parent = TextLabel3
		UIAspectRatioConstraint4.AspectRatio = 1.2526315450668335
		TextLabel5.Name = "Format"
		TextLabel5.Parent = Frame2
		TextLabel5.Position = UDim2.new(0.783323944, 0, 0.692909122, 0)
		TextLabel5.Size = UDim2.new(0.183673471, 0, 0.324675292, 0)
		TextLabel5.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel5.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel5.BackgroundTransparency = 1
		TextLabel5.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel5.BorderSizePixel = 16
		TextLabel5.Font = Enum.Font.Oswald
		TextLabel5.FontSize = Enum.FontSize.Size24
		TextLabel5.Text = "<i><b>MPH</b></i>"
		TextLabel5.TextColor = BrickColor.new("Institutional white")
		TextLabel5.TextColor3 = Color3.new(1, 1, 1)
		TextLabel5.TextScaled = true
		TextLabel5.TextSize = 19
		TextLabel5.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel5.TextTransparency = 0.20000000298023224
		TextLabel5.TextWrap = true
		TextLabel5.TextWrapped = true
		TextLabel5.RichText = true
		UIAspectRatioConstraint6.Parent = TextLabel5
		UIAspectRatioConstraint6.AspectRatio = 1.440000057220459
		TextLabel7.Name = "Gear"
		TextLabel7.Parent = Frame2
		TextLabel7.Position = UDim2.new(0.0357142873, 0, 0.602000058, 0)
		TextLabel7.Size = UDim2.new(0.183673471, 0, 0.44155845, 0)
		TextLabel7.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel7.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel7.BackgroundTransparency = 1
		TextLabel7.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel7.BorderSizePixel = 16
		TextLabel7.ZIndex = 2
		TextLabel7.Font = Enum.Font.GothamMedium
		TextLabel7.FontSize = Enum.FontSize.Size36
		TextLabel7.LineHeight = 0.8999999761581421
		TextLabel7.Text = "<i>1</i>"
		TextLabel7.TextColor = BrickColor.new("Institutional white")
		TextLabel7.TextColor3 = Color3.new(1, 1, 1)
		TextLabel7.TextScaled = true
		TextLabel7.TextSize = 35
		TextLabel7.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel7.TextTransparency = 0.20000000298023224
		TextLabel7.TextWrap = true
		TextLabel7.TextWrapped = true
		TextLabel7.RichText = true
		UIAspectRatioConstraint8.Parent = TextLabel7
		UIAspectRatioConstraint8.AspectRatio = 1.058823585510254
		TextLabel9.Name = "SpeedShadow"
		TextLabel9.Parent = Frame2
		TextLabel9.Position = UDim2.new(0.233325571, 0, -0.0424566902, 0)
		TextLabel9.Size = UDim2.new(0.607142866, 0, 1.2337662, 0)
		TextLabel9.BackgroundColor = BrickColor.new("Dark grey metallic")
		TextLabel9.BackgroundColor3 = Color3.new(0.329412, 0.329412, 0.329412)
		TextLabel9.BackgroundTransparency = 1
		TextLabel9.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel9.BorderSizePixel = 16
		TextLabel9.Font = Enum.Font.SourceSansLight
		TextLabel9.FontSize = Enum.FontSize.Size96
		TextLabel9.Text = "<i>000</i>"
		TextLabel9.TextColor = BrickColor.new("Really black")
		TextLabel9.TextColor3 = Color3.new(0, 0, 0)
		TextLabel9.TextScaled = true
		TextLabel9.TextSize = 100
		TextLabel9.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel9.TextTransparency = 0.800000011920929
		TextLabel9.TextWrap = true
		TextLabel9.TextWrapped = true
		TextLabel9.RichText = true
		UIAspectRatioConstraint10.Parent = TextLabel9
		UIAspectRatioConstraint10.AspectRatio = 1.2526315450668335
		TextLabel11.Name = "GearShadow"
		TextLabel11.Parent = Frame2
		TextLabel11.Position = UDim2.new(0.045980338, 0, 0.611073673, 0)
		TextLabel11.Size = UDim2.new(0.183673471, 0, 0.44155845, 0)
		TextLabel11.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel11.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel11.BackgroundTransparency = 1
		TextLabel11.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel11.BorderSizePixel = 16
		TextLabel11.Font = Enum.Font.GothamMedium
		TextLabel11.FontSize = Enum.FontSize.Size36
		TextLabel11.LineHeight = 0.8999999761581421
		TextLabel11.Text = "<i>1</i>"
		TextLabel11.TextColor = BrickColor.new("Really black")
		TextLabel11.TextColor3 = Color3.new(0, 0, 0)
		TextLabel11.TextScaled = true
		TextLabel11.TextSize = 35
		TextLabel11.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel11.TextTransparency = 0.800000011920929
		TextLabel11.TextWrap = true
		TextLabel11.TextWrapped = true
		TextLabel11.RichText = true
		UIAspectRatioConstraint12.Parent = TextLabel11
		UIAspectRatioConstraint12.AspectRatio = 1.058823585510254
		TextLabel13.Name = "FormatFormat Shadow"
		TextLabel13.Parent = Frame2
		TextLabel13.Position = UDim2.new(0.779999971, 0, 0.709999979, 0)
		TextLabel13.Size = UDim2.new(0.183673471, 0, 0.324675292, 0)
		TextLabel13.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel13.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel13.BackgroundTransparency = 1
		TextLabel13.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel13.BorderSizePixel = 16
		TextLabel13.Font = Enum.Font.Oswald
		TextLabel13.FontSize = Enum.FontSize.Size24
		TextLabel13.Text = "<i><b>MPH</b></i>"
		TextLabel13.TextColor = BrickColor.new("Really black")
		TextLabel13.TextColor3 = Color3.new(0, 0, 0)
		TextLabel13.TextScaled = true
		TextLabel13.TextSize = 19
		TextLabel13.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel13.TextTransparency = 0.800000011920929
		TextLabel13.TextWrap = true
		TextLabel13.TextWrapped = true
		TextLabel13.RichText = true
		UIAspectRatioConstraint14.Parent = TextLabel13
		UIAspectRatioConstraint14.AspectRatio = 1.440000057220459
		UIAspectRatioConstraint15.Parent = Frame2
		UIAspectRatioConstraint15.AspectRatio = 2.545454502105713
		Frame16.Name = "Bottom"
		Frame16.Parent = Frame1
		Frame16.Position = UDim2.new(0.28125, 0, 0.5182482, 0)
		Frame16.Size = UDim2.new(0.612500012, 0, 0.416058391, 0)
		Frame16.BackgroundColor = BrickColor.new("Institutional white")
		Frame16.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame16.BackgroundTransparency = 1
		Frame17.Name = "Meter"
		Frame17.Parent = Frame16
		Frame17.Position = UDim2.new(-0.0663265288, 0, 0.140350878, 0)
		Frame17.Size = UDim2.new(1.10204077, 0, 0.771929801, 0)
		Frame17.BackgroundColor = BrickColor.new("Institutional white")
		Frame17.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame17.BackgroundTransparency = 1
		Frame18.Name = "BarBackground"
		Frame18.Parent = Frame17
		Frame18.Position = UDim2.new(0.0925925896, 0, 0.681818187, 0)
		Frame18.Size = UDim2.new(0.837962985, 0, 0.227272734, 0)
		Frame18.BackgroundColor = BrickColor.new("Institutional white")
		Frame18.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame18.BackgroundTransparency = 0.75
		Frame18.BorderSizePixel = 0
		UIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(0.6, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(0.85, Color3.new(1, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)),
		})
		UIGradient.Enabled = true
		UIGradient.Parent = Frame18
		Frame19.Name = "Bar"
		Frame19.Parent = Frame18
		Frame19.Size = UDim2.new(1, 0, 1, 0)
		Frame19.BackgroundColor = BrickColor.new("Institutional white")
		Frame19.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame19.BackgroundTransparency = 0.4000000059604645
		Frame19.BorderSizePixel = 0
		Frame19.ZIndex = 2
		UIAspectRatioConstraint20.Parent = Frame19
		UIAspectRatioConstraint20.AspectRatio = 9.5
		UIAspectRatioConstraint21.Parent = Frame18
		UIAspectRatioConstraint21.AspectRatio = 18.100000381469727
		Frame22.Name = "BarBackgroundShadow"
		Frame22.Parent = Frame17
		Frame22.Position = UDim2.new(0.109999999, 0, 0.75, 0)
		Frame22.Size = UDim2.new(0.837962985, 0, 0.227272734, 0)
		Frame22.BackgroundColor = BrickColor.new("Really black")
		Frame22.BackgroundColor3 = Color3.new(0, 0, 0)
		Frame22.BackgroundTransparency = 0.949999988079071
		Frame22.BorderSizePixel = 0
		UIAspectRatioConstraint23.Parent = Frame22
		UIAspectRatioConstraint23.AspectRatio = 18.100000381469727
		UIAspectRatioConstraint24.Parent = Frame17
		UIAspectRatioConstraint24.AspectRatio = 4.909090995788574
		UIAspectRatioConstraint25.Parent = Frame16
		UIAspectRatioConstraint25.AspectRatio = 3.438596487045288
		UIAspectRatioConstraint26.Parent = Frame1
		UIAspectRatioConstraint26.AspectRatio = 2.335766315460205
		UIPadding27.Parent = Frame1
	end

	-- G Var
	local Packet, Env =
		{
			Module = {
				Functions = {},
				Data = {},
			},
			Data = {
				Vehicle = require(ReplicatedStorage.Vehicle.VehicleUtils),
				PrevData = {},
			},
			Functions = {},
		}, {}

	-- Var
	local Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}
	getgenv().freeCamera = false
	local PlayerOnVehicle = false
	local modernspeedometerEnable = false
	local customCameraEnable = false
	local VehicleModEnable = false
	local AutoFocus = false
	local SelectingPart = false
	local SelectingFollowCamPart = false
	local simpleSpeedometer = false
	local playerVehicle = nil
	local TargetPart = nil
	local FollowTargetPart = nil
	local ScreenGUI
	local speedometerOutlineColor
	local SpeedTesting = false
	local CamOffsetX = 0
	local CamOffsetY = 0
	local CamOffsetZ = 0
	local CamAngleX = 0
	local CamAngleY = 0
	local CamAngleZ = 0
	local FocusDistance = 1
	local EasingStyle
	local FreeCamCFrame
	local FreeCamPosMode = false
	local CustomFOV = 70
	local doCustomFOV = false
	local FreeCamFOV
	local mapExportMap = "Untitled"
	local mapImportMap = "Nil"
	local MapExportMode = 1
	local MapImportMode = ".rbxm files"
	local ImportAssetID = { "" }
	local ChosenSpeed = 0
	local doSpeedLock
	local DriftParticles

	--Function
	local function getPlayerVehicle()
		for i, vehicle in pairs(game.Workspace.Vehicles:GetChildren()) do
			pcall(function()
				if vehicle.Seat then
					if vehicle.Seat:WaitForChild("PlayerName").Value == game:GetService("Players").LocalPlayer.Name then
						playerVehicle = vehicle
					end
				end
			end)
		end
	end

	local function modernspeedometer()
		pcall(function()
			if modernspeedometerEnable then
				if PlayerOnVehicle then
					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") then
						game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()
					end
					ScreenGUI = assetFolder.ScreenGui:Clone()
					ScreenGUI.Parent = game.Players.LocalPlayer.PlayerGui

					game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
					game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
					game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
					game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.UIAspectRatioConstraint:Destroy()

					while PlayerOnVehicle do
						pcall(function()
							local CarSpeedDisplay = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
							local CarSpeedNum = VehiclePacket["rpmVisual"]
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.Gear.Text = "<i>"
								.. tostring(VehiclePacket["Gear"])
								.. "</i>"
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.GearShadow.Text = "<i>"
								.. tostring(VehiclePacket["Gear"])
								.. "</i>"
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.Speed.Text = "<i>"
								.. CarSpeedDisplay
								.. "</i>"
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.SpeedShadow.Text = "<i>"
								.. CarSpeedDisplay
								.. "</i>"
							if CarSpeedNum > 1 then
								if CarSpeedNum < 11001 then
									local saturation = 11000 - CarSpeedNum
									local satCal = 1 - saturation / 80
									game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.BackgroundColor3 =
										Color3.fromHSV(0.0, satCal, 0.8)
									game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size =
										UDim2.new(CarSpeedNum / 11200, 0, 1, 0)
								end
							elseif CarSpeedNum < 10001 then
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.BackgroundColor3 =
									Color3.fromHSV(0, 0.0, 1)
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size =
									UDim2.new(CarSpeedNum / 11200, 0, 1, 0)
							elseif
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size
								> UDim2.new(0.9, 0, 1, 0)
							then
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size =
									UDim2.new(CarSpeedNum / 11250, 0, 1, 0)
							end
						end)
						task.wait(1 / 60)
					end
				else
					game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
					game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
					game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
					if game.Players.LocalPlayer.PlayerGui.ScreenGui then
						game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()
					end
				end
			else
				game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
				game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
				game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
				if game.Players.LocalPlayer.PlayerGui.ScreenGui then
					game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()
				end
			end
		end)
	end

	local function applySpeedometeroptions()
		if PlayerOnVehicle == true then
			if simpleSpeedometer then
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Missiles.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.MissileBuy.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Lock.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Plate.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Eject.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Bottom.Meter.Odometer.Visible = false
			end
			game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.UIStroke.Color = speedometerOutlineColor
			game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Bottom.Line1.BackgroundColor3 = speedometerOutlineColor
			game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Bottom.Line0.BackgroundColor3 = speedometerOutlineColor
		end
	end

	local function exportMap()
		if MapExportMode == "Both" then
			makefolder("JailbreakVisionV2/MapEditor/" .. mapExportMap)
			local terrainRegion = workspace.Terrain:CopyRegion(workspace.Terrain.MaxExtents)
			saveinstance(terrainRegion, "JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Terrain")
			require(game.ReplicatedStorage.Game.Notification).new({ Text = "Terrain exported", Duration = 5 })

			if game.Workspace:FindFirstChild("MapExporterModels") then
				saveinstance(
					game.Workspace.MapExporterModels,
					"JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Models"
				)
				require(game.ReplicatedStorage.Game.Notification).new({ Text = "Model exported", Duration = 5 })
			else
				require(game.ReplicatedStorage.Game.Notification).new({
					Text = "Model export failed, model not found",
					Duration = 5,
				})
			end
		elseif MapExportMode == "Model Only" then
			if game.Workspace:FindFirstChild("MapExporterModels") then
				makefolder("JailbreakVisionV2/MapEditor/" .. mapExportMap)
				saveinstance(
					game.Workspace.MapExporterModels,
					"JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Models"
				)
				require(game.ReplicatedStorage.Game.Notification).new({ Text = "Model exported", Duration = 5 })
			else
				require(game.ReplicatedStorage.Game.Notification).new({
					Text = "Model export failed, model not found",
					Duration = 5,
				})
			end
		else
			makefolder("JailbreakVisionV2/MapEditor/" .. mapExportMap)
			local terrainRegion = workspace.Terrain:CopyRegion(workspace.Terrain.MaxExtents)
			saveinstance(terrainRegion, "JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Terrain")
			require(game.ReplicatedStorage.Game.Notification).new({ Text = "Terrain Exported", Duration = 5 })
		end
	end

	local function importMap()
		local mapName = string.gsub(mapImportMap, "JailbreakVisionV2/MapEditor\\", "")
		if isfile("JailbreakVisionV2/MapEditor/" .. mapName .. "/Terrain.rbxm") then
			local terrain =
				game:GetObjects(getcustomasset("JailbreakVisionV2/MapEditor/" .. mapName .. "/Terrain.rbxm"))[1]
			game.Workspace.Terrain:Clear()
			game.Workspace.Terrain:PasteRegion(terrain, workspace.Terrain.MaxExtents.Min, true)
		end
		if isfile("JailbreakVisionV2/MapEditor/" .. mapName .. "/Models.rbxm") then
			if game.Workspace:FindFirstChild("ImportedModel") then
				game.Workspace:FindFirstChild("ImportedModel"):Destroy()
			end
			local model =
				game:GetObjects(getcustomasset("JailbreakVisionV2/MapEditor/" .. mapName .. "/Models.rbxm"))[1]
			model.Parent = game.Workspace
			model.Name = "ImportedModel"
			for i, v in pairs(model:GetDescendants()) do
				if v:IsA("Part") then
					if v.Material == Enum.Material.Asphalt and v.Color == Color3.fromRGB(91, 100, 112) then
						v.MaterialVariant = "BrightAsphalt"
					elseif v.Material == Enum.Material.Sand and v.Color == Color3.fromRGB(243, 194, 157) then
						v.MaterialVariant = "SandFixed"
					end
				end
			end
		end
	end

	local function assetImportMap()
		local data = "rbxassetid://" .. ImportAssetID
		local model = game:GetObjects(data)[1]
		model.Parent = modelFolder
		for i, v in pairs(model:GetDescendants()) do
			if v:IsA("BasePart") then
				if v.Material == Enum.Material.Asphalt and v.Color == Color3.fromRGB(91, 100, 112) then
					v.MaterialVariant = "BrightAsphalt"
				elseif v.Material == Enum.Material.Sand and v.Color == Color3.fromRGB(243, 194, 157) then
					v.MaterialVariant = "SandFixed"
				end
			end
		end
	end

	--Ui
	do
		Gui = Library:Create({
			Name = "Jailbreak Vision v2 Beta",
			ShadowColor = Color3.fromRGB(0, 0, 0),
		})

		-- Visual Tab
		do
			VisualTab = Gui:Tab({
				Name = "Visual",
				Icon = "rbxassetid://11284340239",
			})

			VisualTab:Section({
				Name = "Speedometer",
			})

			VisualTab:Toggle({
				Name = "Forza Speedometer System",
				Default = false,
				Callback = function(bool)
					modernspeedometerEnable = bool
					modernspeedometer()
				end,
			})

			VisualTab:Toggle({
				Name = "Simplified Speedometer",
				Default = false,
				Callback = function(bool)
					simpleSpeedometer = bool
					applySpeedometeroptions()
				end,
			})

			VisualTab:Colorpicker({
				Name = "Speedometer Outline Color",
				DefaultColor = Color3.new(1, 1, 1),
				Callback = function(Color)
					speedometerOutlineColor = Color
					applySpeedometeroptions()
				end,
			})

			VisualTab:Section({
				Name = "Camera System",
			})

			VisualTab:Toggle({
				Name = "Forza Camera System",
				Default = false,
				Callback = function(bool)
					customCameraEnable = bool
					if customCameraEnable == false then
						Camera.CameraType = "Custom"
					end
				end,
			})

			VisualTab:Slider({
				Name = "Angular frequency",
				Min = 0,
				Max = 500,
				Default = 50,
				Callback = function(val)
					spring.frequency = val * 10
				end,
			})

			VisualTab:Slider({
				Name = "Damping ratio",
				Min = 0,
				Max = 100,
				Default = 20,
				Callback = function(val)
					spring.ratio = val
				end,
			})

			VisualTab:Section({
				Name = "UI Hider",
			})

			VisualTab:Toggle({
				Name = "Hide UIs (All)",
				Default = false,
				Callback = function(bool)
					pcall(function()
						if not bool then
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = true
						else
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = false
						end
					end)
				end,
			})

			VisualTab:Toggle({
				Name = "Hide UIs (Except speedmeteer)",
				Default = false,
				Callback = function(bool)
					pcall(function()
						if not bool then
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.DamageIndicators.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = true
						else
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.DamageIndicators.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = false
						end
					end)
				end,
			})
		end

		-- Vehicle Mod
		do
			VehicleModTab = Gui:Tab({
				Name = "Vehicle",
				Icon = "rbxassetid://11360212182",
			})

			VehicleModTab:Section({
				Name = "Vehicle Mod",
			})

			VehicleModTab:Toggle({
				Name = "Enable",
				Default = false,
				Callback = function(bool)
					VehicleModEnable = bool
				end,
			})

			VehichleSpeedSlider = VehicleModTab:Slider({
				Name = "Vehicle Speed",
				Min = 0,
				Max = 100,
				Default = 5,
				Callback = function(val)
					if VehicleModEnable then
						Vehichle.GetVehiclePacket().GarageEngineSpeed = val
					end
				end,
			})

			VehicleTurnSpeedSlider = VehicleModTab:Slider({
				Name = "Vehicle Turn Speed",
				Min = 0,
				Max = 100,
				Default = 2,
				Callback = function(val)
					if VehicleModEnable then
						Vehichle.GetVehiclePacket().TurnSpeed = val
					end
				end,
			})

			VehicleSuspensionHeightSlider = VehicleModTab:Slider({
				Name = "Vehicle Suspension Height",
				Min = 0,
				Max = 100,
				Default = 3,
				Callback = function(val)
					if VehicleModEnable then
						Vehichle.GetVehiclePacket().Height = val
					end
				end,
			})

			SmokeAttach = VehicleModTab:Button({
				Name = "Smoke", -- String
				Callback = function()
					for i, v in next, GetLocalVehiclePacket().Model:GetChildren() do
						if v.Name == "Drift" then
							v.ParticleEmitter.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
								ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
							})
							v.ParticleEmitter.Size = NumberSequence.new({
								NumberSequenceKeypoint.new(0, 4),
								NumberSequenceKeypoint.new(1, 4),
							})
						end
					end
				end, -- Callback
			})

			CRSec = VehicleModTab:Section({
				Name = "Vehicle Mods", -- String
			})

			local ChooseSpeed = VehicleModTab:Slider({
				Name = "Lock Speed", -- String
				Min = 0, -- Int
				Max = 400, -- Int
				Default = 0, -- Int
				Callback = function(val)
					ChosenSpeed = val
				end, -- Callback, int
			})

			LockCarSpeed = VehicleModTab:Toggle({
				Name = "Lock Car Speed", -- String
				Default = false, -- Bool
				Callback = function(bool)
					doSpeedLock = bool
					while doSpeedLock do
						local CarSpeedNum =
							tonumber(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text)
						if CarSpeedNum < ChosenSpeed then
							keypress(0x57)
							task.wait()
						elseif CarSpeedNum > ChosenSpeed then
							keyrelease(0x57)
							task.wait()
						end
						task.wait()
						if not doSpeedLock then
							keyrelease(0x57)
						end
					end
				end, -- Callback, boolean
			})

			VehicleModTab:Section({
				Name = "Vehicle Packets",
			})

			MPHLabel = VehicleModTab:TextLabel({
				Name = "MPH: " .. "nil",
				Color = Color3.new(1, 0, 0),
			})

			GearLabel = VehicleModTab:TextLabel({
				Name = "Gear: " .. tostring(VehiclePacket["Gear"]),
				Color = Color3.new(1, 0, 0),
			})

			VisualRPMLabel = VehicleModTab:TextLabel({
				Name = "Visual RPM: " .. tostring(VehiclePacket["rpmVisual"]),
				Color = Color3.new(1, 0, 0),
			})

			ThrustLabel = VehicleModTab:TextLabel({
				Name = "BodyThrust: " .. "nil",
				Color = Color3.new(1, 0, 0),
			})

			ForceLabel = VehicleModTab:TextLabel({
				Name = "BodyForce: " .. "nil",
				Color = Color3.new(1, 0, 0),
			})

			MassLabel = VehicleModTab:TextLabel({
				Name = "Mass: " .. tostring(VehiclePacket["Mass"]),
				Color = Color3.new(1, 0, 0),
			})
		end

		-- Camera Tab
		do
			CameraTab = Gui:Tab({
				Name = "Camera",
				Icon = "rbxassetid://11346388439",
			})

			CameraTab:Section({
				Name = "Effects",
			})

			CameraTab:Toggle({
				Name = "Depth Of Field",
				Default = false,
				Callback = function(bool)
					DepthOfField.Enabled = bool
				end,
			})

			FocusDistanceSlider = CameraTab:Slider({
				Name = "Focus Distance",
				Min = 0,
				Max = 200,
				Default = 100,
				Callback = function(val)
					DepthOfField.FocusDistance = val
				end,
			})

			CameraTab:Slider({
				Name = "Focus Range",
				Min = 0,
				Max = 500,
				Default = 100,
				Callback = function(val)
					DepthOfField.InFocusRadius = val
				end,
			})

			CameraTab:Section({
				Name = "Track Focus",
			})

			FocusPartLabel = CameraTab:TextLabel({
				Name = "Focused: " .. "nil",
				Color = Color3.new(0.450980, 0.101960, 0.611764),
			})

			CameraTab:Toggle({
				Name = "Auto Focus",
				Default = false,
				Callback = function(bool)
					AutoFocus = bool
				end,
			})

			CameraTab:Button({
				Name = "Select Part",
				Callback = function()
					SelectingPart = true
				end,
			})

			CameraTab:Section({
				Name = "Vehicle Perspective",
			})
			CameraTab:Toggle({
				Name = "Camera Perspective",
				Default = false,
				Callback = function(bool)
					PerspectiveToggle = bool

					if not PerspectiveToggle then
						Camera.CameraType = "Custom"
					end
				end,
			})

			CameraTab:Slider({
				Name = "Custom FOV", -- String
				Min = 1, -- Int
				Max = 120, -- Int
				Default = 70, -- Int
				Callback = function(val)
					CustomFOV = val
				end, -- Callback, int
			})

			CameraTab:Toggle({
				Name = "Activate FOV", -- String
				Default = false, -- Bool
				Callback = function(bool)
					doCustomFOV = bool
					local FOV
					if doCustomFOV and not SpeedTesting then
						task.spawn(function()
							FOV = RunService.RenderStepped:Connect(function()
								Camera.FieldOfView = CustomFOV
							end)
						end)
					end
					repeat
						task.wait()
					until not doCustomFOV
					FOV:Disconnect()
				end,
			})

			CameraTab:Dropdown({
				Name = "Perspective",
				Items = {
					"Default",
					"Top Down",
					"Front",
					"Front Right",
					"Front Left",
					"Back Right",
					"Back Left",
					"Direct Right",
					"Direct Left",
					"Side Right",
					"Side Left",
					"Wheel Right",
					"Wheel Left",
					"Chase High",
					"Chase Low",
					"Hood View",
					"Custom",
					"Follow",
				},

				Callback = function(item)
					if not PlayerOnVehicle then
						require(game.ReplicatedStorage.Game.Notification).new({
							Text = "You are not on a Vehicle",
							Duration = 3,
						})
					elseif PlayerOnVehicle then
						PerspectiveChosen = item
						if item == "Default" then
							Camera.CameraType = "Custom"
						end
					end
				end,
			})

			CameraTab:Button({
				Name = "Select Part (Follow Cam)",
				Callback = function()
					SelectingFollowCamPart = true
				end,
			})

			FollowCamTargetLabel = CameraTab:TextLabel({
				Name = "Focused: " .. "nil",
				Color = Color3.new(0.450980, 0.101960, 0.611764),
			})

			CameraTab:Dropdown({
				Name = "Dropdown", -- String
				Items = { "Use Free Cam Position", "Use Slider Position" }, -- Table
				Callback = function(item)
					if item == "Use Free Cam Position" then
						FreeCamPosMode = true
					elseif item == "Use Slider Position" then
						FreeCamPosMode = false
					end
				end,
			})

			CameraTab:Button({
				Name = "Update Camera Postion", -- String
				Callback = function()
					VehicleModel = GetLocalVehiclePacket().Model
					FreeCamCFrame = VehicleModel.PrimaryPart.CFrame:ToObjectSpace(Camera.CFrame)
						or VehicleModel:FindFirstChild("Engine").CFrame:ToObjectSpace(Camera.CFrame)
					FreeCamFOV = Camera.FieldOfView
				end, -- Callback
			})

			CameraTab:Section({
				Name = "Perspective Customization",
			})

			CameraTab:Slider({
				Name = "X axis offset",
				Min = -50, -- Int
				Max = 50, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamOffsetX = val
				end,
			})

			CameraTab:Slider({
				Name = "Y axis offset",
				Min = -50, -- Int
				Max = 50, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamOffsetY = val
				end,
			})

			CameraTab:Slider({
				Name = "Z axis offset",
				Min = -50, -- Int
				Max = 50, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamOffsetZ = val
				end,
			})

			CameraTab:Slider({
				Name = "X angle",
				Min = -180, -- Int
				Max = 180, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamAngleX = val
				end,
			})

			CameraTab:Slider({
				Name = "Y angle",
				Min = -180, -- Int
				Max = 180, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamAngleY = val
				end,
			})

			CameraTab:Slider({
				Name = "Z angle",
				Min = -180, -- Int
				Max = 180, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamAngleZ = val
				end,
			})

			CameraTab:Section({
				Name = "Free Cam",
			})

			CameraTab:Toggle({
				Name = "Toggle",
				Default = false,
				Callback = function(bool)
					getgenv().freeCamera = bool
				end,
			})
		end

		-- SpeedTest Tab
		do
			local SpeedTestDuration = 60
			local SpeedTestLockVehicle = false
			local VehicleLockerPart = Instance.new("Part")
			local speedTestForwardMode = true

			VehicleLockerPart.Parent = game.Workspace
			VehicleLockerPart.CanCollide = false
			VehicleLockerPart.Anchored = true
			VehicleLockerPart.Transparency = 1
			local Stage

			SpeedTestTab = Gui:Tab({
				Name = "Speed Test",
				Icon = "rbxassetid://12678650413",
			})

			SpeedTestTab:Section({
				Name = "Speed Test",
			})

			SpeedTestTab:Button({
				Name = "Start",
				Callback = function()
					if PlayerOnVehicle and not SpeedTesting then
						SpeedTesting = true
						local CamRS

						task.spawn(function()
							CamRS = RunService.RenderStepped:Connect(function()
								Camera.CameraType = "Scriptable"
								Camera.FieldOfView = 50
							end)
						end)

						Stage = game:GetObjects("rbxassetid://11522200723")[1]
						Stage.Parent = game.Workspace
						Stage.PrimaryPart = Stage:FindFirstChild("Background")
						VehicleModel = GetLocalVehiclePacket().Model
						Stage:SetPrimaryPartCFrame(CFrame.new(VehicleModel.Engine.Position + Vector3.new(0, 400, 0)))
						Stage.Name = "Stage"
						local SurfaceDisplayContainer = Stage.SurfaceDisplay.SurfaceGui.Container
						Stage.ParticlePartForward.Particles.Rate = 0
						Stage.ParticlePartBackward.Particles.Rate = 0

						do
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = false
						end

						VehicleModel:SetPrimaryPartCFrame(Stage.CarLocate.CFrame)
						task.wait(3)
						VehicleModel:SetPrimaryPartCFrame(Stage.CarLocate.CFrame)

						task.wait(5)
						VehicleModel:SetPrimaryPartCFrame(Stage.CarLocate.CFrame)

						task.spawn(function()
							task.wait(3)
							do
								local CampartX = VehicleModel.BoundingBox.Size.X * -18
								local CampartY = VehicleModel.BoundingBox.Size.Y * 3

								Stage.Campart.CFrame = VehicleModel.BoundingBox.CFrame
									+ (VehicleModel.BoundingBox.CFrame.LookVector * Vector3.new(CampartX, 0, 0))
								Stage.Campart.Position = Stage.Campart.Position + Vector3.new(0, CampartY, 0)

								local function lookAt(from, target)
									local forwardVector = (target - from).Unit
									local upVector = Vector3.new(0, 1, 0)
									local rightVector = forwardVector:Cross(upVector)
									local upVector2 = rightVector:Cross(forwardVector)

									return CFrame.fromMatrix(from, rightVector, upVector2)
								end

								Stage.Campart.CFrame = lookAt(Stage.Campart.Position, Stage.CameraViewPoint.Position)
							end

							VehicleLockerPart.CFrame = VehicleModel.PrimaryPart.CFrame
						end)

						task.wait(5)
						Camera.CameraType = Enum.CameraType.Scriptable
						Camera.CFrame = Stage.CameraStartingTween.CFrame

						task.spawn(function()
							local TweenService = game:GetService("TweenService")
							local info = TweenInfo.new(6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
							local tween = TweenService:Create(Camera, info, { CFrame = Stage.Campart.CFrame })
							tween:Play()
						end)

						SurfaceDisplayContainer.VehicleName.Text = VehiclePacket.Model.Name
						SpeedTestLockVehicle = true

						local SpeedTestMode = ""

						if speedTestForwardMode then
							SpeedTestMode = "Forward"
						else
							SpeedTestMode = "Reverse"
						end

						task.spawn(function()
							while SpeedTesting do
								SurfaceDisplayContainer.GearNum.Text = VehiclePacket["Gear"]
								SurfaceDisplayContainer.RPMNum.Text =
									tostring(math.floor(tonumber(VehiclePacket["rpmVisual"])))
								if speedTestForwardMode then
									Stage.ParticlePartForward.Particles.Rate = tonumber(
										game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
									) * 2
								else
									Stage.ParticlePartBackward.Particles.Rate = tonumber(
										game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
									) * 2
								end
								SurfaceDisplayContainer.ModeNum.Text = SpeedTestMode

								task.wait(1 / 60)
							end
						end)

						task.spawn(function()
							local function DecimalsToMinutes(dec)
								local ms = tonumber(dec)
								return math.floor(ms / 60), (ms % 60)
							end

							local minutes, seconds = DecimalsToMinutes(SpeedTestDuration)
							local timer = SurfaceDisplayContainer.Time

							if seconds <= 9 then
								timer.Text = tostring(minutes) .. ":0" .. tostring(seconds)
							else
								timer.Text = tostring(minutes) .. ":" .. tostring(seconds)
							end
						end)

						do
							SurfaceDisplayContainer.Speed.Text = "Starting SpeedTest"
							task.wait(3)
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "3"
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "2"
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "1"
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "0"
							task.wait(1)
						end

						task.spawn(function()
							while SpeedTesting do
								Camera.CFrame = Stage.Campart.CFrame

								task.wait()
							end
						end)

						task.spawn(function()
							while SpeedTesting do
								SurfaceDisplayContainer.Speed.Text = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
									.. " MPH"

								task.wait(1 / 60)
							end
						end)

						task.spawn(function()
							local function DecimalsToMinutes(dec)
								local ms = tonumber(dec)
								return math.floor(ms / 60), (ms % 60)
							end

							local minutes, seconds = DecimalsToMinutes(SpeedTestDuration)
							local timer = SurfaceDisplayContainer.Time

							repeat
								if seconds <= 0 then
									minutes = minutes - 1
									seconds = 59
								else
									seconds = seconds - 1
								end
								if seconds <= 9 then
									timer.Text = tostring(minutes) .. ":0" .. tostring(seconds)
								else
									timer.Text = tostring(minutes) .. ":" .. tostring(seconds)
								end
								task.wait(1)
							until minutes <= 0 and seconds <= 0
						end)

						task.spawn(function()
							local recording = {}
							local sec = 0
							local properties = {}
							local speedTestProp = {}

							properties["Vehicle Name"] = VehiclePacket.Model.Name
							if speedTestForwardMode then
								properties["Test Mode"] = "Forward"
							else
								properties["Test Mode"] = "Reverse"
							end

							while sec ~= (SpeedTestDuration + 1) do
								if not SpeedTesting then
									break
								end

								if speedTestForwardMode then
									keypress(0x57)
								else
									keypress(0x53)
								end
								local prop = {}
								prop["Time"] = sec
								prop["Speed"] = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text

								speedTestProp[sec + 1] = prop

								sec = sec + 1

								task.wait(1)
							end

							recording["Settings"] = properties
							recording["SpeedTest"] = speedTestProp

							local speedTestSheet = HttpService:JSONEncode(recording)
							local speedtestfilename = VehiclePacket.Model.Name
								.. " "
								.. properties["Test Mode"]
								.. " "
								.. tostring(SpeedTestDuration)
								.. "s"
							writefile(
								tostring("JailbreakVisionV2/SpeedTestResults/" .. speedtestfilename .. ".json"),
								tostring(speedTestSheet)
							)

							if SpeedTesting == true then
								SpeedTesting = false
							end
						end)

						repeat
							task.wait()
						until SpeedTesting == false

						task.spawn(function()
							keyrelease(0x53)
							keyrelease(0x57)
						end)

						SurfaceDisplayContainer.Speed.Text = "Ended"

						if game.Players.LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
							repeat
								task.wait()
							until game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text == "000"
						end

						Camera.CameraType = "Custom"
						SpeedTestLockVehicle = false
						Stage:Destroy()
						CamRS:Disconnect()
						do
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = true
						end
					end
				end,
			})

			SpeedTestTab:Dropdown({
				Name = "Duration",
				Items = { 10, 15, 30, 60, 90, 120, 180 },
				Default = 60,
				Callback = function(item)
					SpeedTestDuration = item
				end,
			})

			SpeedTestTab:Dropdown({
				Name = "Mode",
				Items = { "Forward", "Backward" },
				Default = "Forward",
				Callback = function(item)
					if item == "Forward" then
						speedTestForwardMode = true
					else
						speedTestForwardMode = false
					end
				end,
			})

			RunService.Heartbeat:Connect(function()
				pcall(function()
					if SpeedTestLockVehicle then
						pcall(function()
							VehicleModel:SetPrimaryPartCFrame(VehicleLockerPart.CFrame)
						end)
					end
				end)
			end)

			TerrainTab = Gui:Tab({
				Name = "Map Editor",
				Icon = "rbxassetid://12403099678",
			})

			TerrainTab:Section({
				Name = "Import", -- String
			})

			ImportModeSelction = TerrainTab:Dropdown({
				Name = "Import Selection", -- String
				Items = { ".rbxm files", "Roblox Assets" }, -- Table
				Callback = function(item)
					MapImportMode = item
				end, -- Callback, Any (Depend on item)
			})

			Textbox = TerrainTab:Textbox({
				Name = "Asset ID", -- String
				PlaceholderText = "Type here", -- String
				Callback = function(text)
					ImportAssetID = text
					return
				end, -- Callback, String
			})

			ImportSelction = TerrainTab:Dropdown({
				Name = "Import Selection", -- String
				Items = listfiles("JailbreakVisionV2/MapEditor"),
				Callback = function(item)
					mapImportMap = item
				end, -- Callback, Any (Depend on item)
			})

			TerrainTab:Button({
				Name = "Import", -- String
				Callback = function()
					if MapImportMode == ".rbxm files" then
						importMap()
					else
						assetImportMap()
					end
				end, -- Callback
			})

			TerrainTab:Button({
				Name = "Refresh", -- String
				Callback = function()
					ImportSelction:UpdateList({
						Items = listfiles("JailbreakVisionV2/MapEditor"), -- Table
						Replace = true, -- Boolean (Whether you clear the dropdown or not)
					})
				end, -- Callback
			})

			TerrainTab:Section({
				Name = "Edit", -- String
			})

			local ClickDelPart = false

			local SelectionBox = Instance.new("Part")
			SelectionBox.Parent = game:GetService("Workspace")
			SelectionBox.Transparency = 1
			SelectionBox.Position = Vector3.new(0, 0, 0)
			SelectionBox.Anchored = true
			SelectionBox.CanCollide = false

			local Selection = Instance.new("SelectionBox")
			Selection.Parent = SelectionBox
			Selection.Color3 = Color3.fromRGB(255, 255, 255)
			Selection.SurfaceColor3 = Color3.fromRGB(255, 255, 255)
			Selection.Adornee = SelectionBox
			Selection.LineThickness = 0.05
			Selection.SurfaceTransparency = 0.7
			Selection.Transparency = 0

			Mouse.TargetFilter = SelectionBox
			local Target

			RunService.Heartbeat:Connect(function(deltaTime)
				if ClickDelPart then
					Target = Mouse.Target

					if not (Target == nil) then
						if Target:IsA("BasePart") then
							local PartSize = Target.Size
							local PartPos = Target.CFrame

							SelectionBox.Size = PartSize
							SelectionBox.CFrame = PartPos
						end
					end
				else
					SelectionBox.Position = Vector3.new(0, 0, 0)
					SelectionBox.Size = Vector3.new(1, 1, 1)
				end
			end)

			UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
				if ClickDelPart then
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if not (Target == nil) then
							if Target:IsA("BasePart") then
								pcall(function()
									Target.Parent = mapEditFolder
								end)
							end
						end
					end
				end
			end)

			TerrainTab:Toggle({
				Name = "Click Delete Part",
				Default = false,
				Callback = function(bool)
					ClickDelPart = bool
				end,
			})

			TerrainTab:Button({
				Name = "Undo All",
				Callback = function()
					for i, v in next, mapEditFolder:GetChildren() do
						pcall(function()
							v.Parent = game:GetService("Workspace")
						end)
					end
				end,
			})

			ExportTab = Gui:Tab({
				Name = "Export",
				Icon = "rbxassetid://12403097620",
			})

			ExportTab:Button({
				Name = "Save Map", -- String
				Callback = function()
					local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
					saveinstance(game, "JailbreakVisionV2/GameExport/" .. GetName.Name)
				end, -- Callback
			})
		end
	end

	--Connect
	RunService.Heartbeat:Connect(function()
		pcall(function()
			if tostring(VehiclePacket["Gear"]) == "nil" then
				MPHLabel:SetColor(Color3.new(1, 0, 0))
				GearLabel:SetColor(Color3.new(1, 0, 0))
				VisualRPMLabel:SetColor(Color3.new(1, 0, 0))
				MassLabel:SetColor(Color3.new(1, 0, 0))
				ThrustLabel:SetColor(Color3.new(1, 0, 0))
				ForceLabel:SetColor(Color3.new(1, 0, 0))
			else
				MPHLabel:SetColor(Color3.new(0, 1, 0))
				GearLabel:SetColor(Color3.new(0, 1, 0))
				VisualRPMLabel:SetColor(Color3.new(0, 1, 0))
				MassLabel:SetColor(Color3.new(0, 1, 0))
				ThrustLabel:SetColor(Color3.new(0, 1, 0))
				ForceLabel:SetColor(Color3.new(0, 1, 0))
			end

			if game.Players.LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
				MPHLabel:SetText(
					"MPH: " .. tostring(tonumber(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text))
				)
			else
				MPHLabel:SetText("MPH: " .. "nil")
			end

			if playerVehicle ~= nil and PlayerOnVehicle then
				ThrustLabel:SetText("BodyThrust: " .. tostring(playerVehicle.Engine.BodyThrust.Force))
				ForceLabel:SetText("BodyForce: " .. tostring(playerVehicle.Engine.BodyForce.Force))
			else
				ThrustLabel:SetText("BodyThrust: " .. "nil")
				ForceLabel:SetText("BodyForce: " .. "nil")
			end

			GearLabel:SetText("Gear: " .. tostring(VehiclePacket["Gear"]))
			VisualRPMLabel:SetText("Visual RPM: " .. tostring(VehiclePacket["rpmVisual"]))
			MassLabel:SetText("Mass: " .. tostring(VehiclePacket["Mass"]))

			if SelectingPart then
				if Mouse.Target ~= nil then
					FocusPartLabel:SetText("Selecting: " .. tostring(Mouse.Target))
					FocusPartLabel:SetColor(Color3.new(0.823529, 0.596078, 0.925490))
				end
			end

			if SelectingFollowCamPart then
				if Mouse.Target ~= nil then
					FollowCamTargetLabel:SetText("Selecting: " .. tostring(Mouse.Target))
					FollowCamTargetLabel:SetColor(Color3.new(0.823529, 0.596078, 0.925490))
				end
			end

			if TargetPart ~= nil and AutoFocus then
				local Dist = (TargetPart.Position - Character.HumanoidRootPart.Position).magnitude
				Dist = math.floor(Dist)
				if Dist < 201 then
					DepthOfField.FocusDistance = Dist
					-- FocusDistanceSlider:SetValue(Dist)
				end
			end
		end)
	end)

	RunService.Heartbeat:Connect(function()
		pcall(function()
			if game.Players.LocalPlayer.Character.Humanoid.Sit and customCameraEnable then
				Camera.CameraType = "Scriptable"
				Camera.FieldOfView = 80
			elseif game.Players.LocalPlayer.Character.Humanoid.Sit and PerspectiveToggle then
				VehicleModel = GetLocalVehiclePacket().Model

				if PerspectiveChosen == "Default" then
					return
				elseif PerspectiveChosen == "Top Down" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(0, 35, 10)
						* CFrame.Angles(math.rad(-75), 0, 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Front" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(0, 0, -15)
						* CFrame.Angles(math.rad(8), math.rad(-180), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Front Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(8, 3, -15)
						* CFrame.Angles(math.rad(8), math.rad(-215), math.rad(-2))
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Front Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-8, 2, -15)
						* CFrame.Angles(math.rad(8), math.rad(215), math.rad(2))
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Back Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(8, 3, 15)
						* CFrame.Angles(math.rad(-2), math.rad(22), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Back Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-8, 3, 15)
						* CFrame.Angles(math.rad(-2), math.rad(-22), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Direct Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(17, 2, 0)
						* CFrame.Angles(0, math.rad(90), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Direct Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-17, 2, 0)
						* CFrame.Angles(0, math.rad(-90), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Side Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(5, 2, 5)
						* CFrame.Angles(math.rad(-5), math.rad(8), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Side Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-5, 2, 5)
						* CFrame.Angles(math.rad(-5), math.rad(-8), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Wheel Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(5.25, 0.5, -1.5)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Wheel Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(-5.25, 0.5, -1.5)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Chase High" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(0, 7, 15)
						* CFrame.Angles(math.rad(-15), 0, 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Chase Low" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(0, 1, 15)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Hood View" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(0, 2.5, -5)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Custom" and not FreeCamPosMode then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(CamOffsetX, CamOffsetY, CamOffsetZ)
						* CFrame.Angles(math.rad(CamAngleX), math.rad(CamAngleY), math.rad(CamAngleZ))
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Custom" and FreeCamPosMode then
					Camera.CameraType = "Scriptable"
					local NewCamCF = FreeCamCFrame
					NewCamCF = VehicleModel.PrimaryPart.CFrame:ToWorldSpace(NewCamCF)
						or VehicleModel:FindFirstChild("Engine"):ToWorldSpace(NewCamCF)
					Camera.CFrame = NewCamCF
					Camera.FieldOfView = FreeCamFOV
				elseif PerspectiveChosen == "Follow" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(CamOffsetX, CamOffsetY, CamOffsetZ)
						* CFrame.Angles(math.rad(CamAngleX), math.rad(CamAngleY), math.rad(CamAngleZ))
					local function lookAt(from, target)
						local forwardVector = (target - from).Unit
						local upVector = Vector3.new(0, 1, 0)
						local rightVector = forwardVector:Cross(upVector)
						local upVector2 = rightVector:Cross(forwardVector)
						return CFrame.fromMatrix(from, rightVector, upVector2)
					end

					Camera.CFrame = lookAt(CamPerspective.Position, FollowTargetPart.Position)
				end
			else
				Camera.CameraType = "Custom"
			end
		end)
	end)

	local lastFrameDT = 0
	local lastPhyDT
	local CamOffSet = CFrame.new(0, 5, 18) * CFrame.Angles(math.rad(-8), 0, 0)

	RunService:BindToRenderStep("VehicleCam", Enum.RenderPriority.Camera.Value + 50, function()
		if game.Players.LocalPlayer.Character.Humanoid.Sit and customCameraEnable then
			VehicleModel = GetLocalVehiclePacket().Model

			Camera.CameraType = "Scriptable"
			Camera.FieldOfView = 80

			local targetCF = VehicleModel.PrimaryPart.CFrame * CamOffSet
			spring.target = targetCF.Position

			spring:update(lastPhyDT + lastFrameDT)
			local SpringCFrame = CFrame.new(spring.pos) * (targetCF - targetCF.Position)

			Camera.CFrame = SpringCFrame

			lastFrameDT = 0
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if SelectingPart then
				TargetPart = Mouse.Target
				FocusPartLabel:SetText("Focused: " .. tostring(TargetPart))
				FocusPartLabel:SetColor(Color3.new(0.450980, 0.101960, 0.611764))
				SelectingPart = false
			end
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if SelectingFollowCamPart then
				FollowTargetPart = Mouse.Target
				FollowCamTargetLabel:SetText("Focused: " .. tostring(FollowTargetPart))
				FollowCamTargetLabel:SetColor(Color3.new(0.658823, 0.392156, 0.780392))
				SelectingFollowCamPart = false
			end
		end
	end)

	if game.PlaceId == 606849621 then
		game.Players.LocalPlayer.PlayerGui.AppUI.ChildAdded:Connect(function(gui)
			if gui.name == "Speedometer" then
				Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}
				PlayerOnVehicle = true
				getPlayerVehicle()
				modernspeedometer()
				applySpeedometeroptions()

				do
					pcall(function()
						--[[VehichleSpeedSlider:SetValue(Vehichle.GetVehiclePacket().GarageEngineSpeed)
						VehicleTurnSpeedSlider:SetValue(Vehichle.GetVehiclePacket().TurnSpeed)
						VehicleSuspensionHeightSlider:SetValue(Vehichle.GetVehiclePacket().Height)]]
						--
					end)
				end
			end
		end)

		game.Players.LocalPlayer.PlayerGui.AppUI.ChildRemoved:Connect(function(gui)
			if gui.name == "Speedometer" then
				Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}
				PlayerOnVehicle = false
				getPlayerVehicle()
				modernspeedometer()
				applySpeedometeroptions()

				task.spawn(function()
					task.wait(0.1)
					Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
					Camera.CameraType = "Custom"
				end)

				SpeedTesting = false
			elseif gui.name == "Garage" then
				do
					pcall(function()
						--[[VehichleSpeedSlider:SetValue(Vehichle.GetVehiclePacket().GarageEngineSpeed)
						VehicleTurnSpeedSlider:SetValue(Vehichle.GetVehiclePacket().TurnSpeed)
						VehicleSuspensionHeightSlider:SetValue(Vehichle.GetVehiclePacket().Height)]]
						--
					end)
				end
			end
		end)
	end

	task.spawn(function()
		while true do
			local placeholder
			placeholder, lastPhyDT = RunService.Stepped:Wait()
		end
	end)

	Camera.CameraType = "Custom"
	setfpscap(1500)
	for i, v in next, getgc(true) do
		if type(v) == "table" and rawget(v, "MAX_DIST_TO_LOAD") then
			v.MAX_DIST_TO_LOAD = 9e9
		end
	end
end

return JbvV2Loader
