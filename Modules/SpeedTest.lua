local SpeedTest = {}

function SpeedTest.SpeedtestStart(Scene, Duration, Mode)
	local VehiclePacket = require(game:GetService("ReplicatedStorage").Game.Vehicle).GetLocalVehiclePacket
	local PlayerCamera = workspace.CurrentCamera
	local Speedtesting = false
	local TimeLeft
	local TotalTime
	local TeleportOffset
	CurVehicleData.Vehicle = VehiclePacket().Model
	local VehicleModel = VehiclePacket().Model

	if not Scene then
		Library:Notify({
			Name = "Scene not found bruh", -- String
			Text = "bros stupid", -- String
			Icon = "rbxassetid://11401835376", -- String
			Duration = 5, -- Integer
			Callback = function()
				-- Function
			end,
		})
	end

	local mapName = string.gsub(Scene, "JailbreakVisionV3/SpeedtestScenes\\", "")

	if isfile("JailbreakVisionV3/SpeedtestScenes/" .. mapName .. "/Models.rbxm") then
		if game.Workspace:FindFirstChild("SpeedtestScene") then
			game.Workspace:FindFirstChild("SpeedtestScene"):Destroy()
		end

		model = game:GetObjects(getasset("JailbreakVisionV3/SpeedtestScenes/" .. mapName .. "/Models.rbxm"))[1]
		model.Parent = game.Workspace
		model.Name = "SpeedtestScene"

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

	model:PivotTo(VehicleModel.PrimaryPart:GetPivot() * CFrame.new(0, 300, 0))

	Speedtesting = true
	TimeLeft = Duration
	TotalTime = Duration

	local CarLock = model:FindFirstChild("Platform")

	local CameraPart = model:FindFirstChild("Campart")

	local RaycastParam = RaycastParams.new()
	RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
	RaycastParam.FilterDescendantsInstances = { VehicleModel }

	local castRay =
		workspace:Raycast(VehicleModel.Engine.CFrame * CFrame.new(0, 0, 0).Position, Vector3.yAxis * -1e2, RaycastParam)

	if castRay and castRay.Material == Enum.Material.Asphalt then
		task.spawn(function()
			Cam = RunService.RenderStepped:Connect(function()
				PlayerCamera.CameraType = Enum.CameraType.Scriptable
				PlayerCamera.CFrame = CameraPart.CFrame
				PlayerCamera.FieldOfView = 50
			end)

			LockCar = RunService.Heartbeat:Connect(function()
				VehicleModel:PivotTo(CarLock:GetPivot() * CFrame.new(0, castRay.Distance, 0))
			end)
		end)

		task.spawn(function()
			local recording = {}
			local properties = {}
			local speedTestProp = {}

			while true do
				if TimeLeft == 0 then
					Speedtesting = false
					break
				end

				TimeLeft = TimeLeft - 1
				properties["Vehicle Name"] = VehicleModel.Name

				if Mode == "Forwards" then
					properties["Test Mode"] = "Forward"
				else
					properties["Test Mode"] = "Reverse"
				end

				local prop = {}
				prop["Time"] = TotalTime - TimeLeft
				prop["Speed"] = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
				speedTestProp[TimeLeft + 1] = prop
				task.wait(1)
			end

			recording["Settings"] = properties
			recording["SpeedTest"] = speedTestProp
			local speedTestSheet = HttpService:JSONEncode(recording)
			local speedtestfilename = VehiclePacket().Model.Name
				.. " "
				.. properties["Test Mode"]
				.. " "
				.. tostring(TotalTime)
				.. "s"
			writefile(
				tostring("JailbreakVisionV3/SpeedTestResults/" .. speedtestfilename .. ".json"),
				tostring(speedTestSheet)
			)
		end)

		task.spawn(function()
			checks = RunService.Heartbeat:Connect(function()
				if not Speedtesting then
					if Mode == "Forwards" then
						keyrelease(0x57)
					else
						keyrelease(0x53)
					end

					if game.Players.LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
						repeat
							task.wait()
						until game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text == "000"
					end

					Cam:Disconnect()
					PlayerCamera.CameraType = Enum.CameraType.Custom
					LockCar:Disconnect()
					model:Destroy()

					checks:Disconnect()
				else
					if Mode == "Forwards" then
						keypress(0x57)
					else
						keypress(0x53)
					end
				end
			end)

			task.wait()
		end)
	else
		selfSettings.Library:Notify({
			Name = "Speed Test",
			Text = "You are not on a road!",
			Icon = "rbxassetid://11401835376",
			Duration = 5,
		})
	end
end

return SpeedTest
