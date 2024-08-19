local RunService = game:GetService("RunService")
local VehicleData = {}
local GetLocalVehiclePacket = require(ReplicatedStorage.Vehicle.VehicleUtils).GetLocalVehiclePacket

local Signal = import("Modules/Signal.lua")

local VehicleModel = nil

-- Signals

local VehiclePacket = GetLocalVehiclePacket() or {}

function VehicleData.init()
	local UpdateDataRS = nil
	local EnterVehSig = Signal.Get("EnterVehicle")
	local ExitVehSig = Signal.Get("ExitVehicle")
	local destroyForza = Signal.Get("destroyForza")

	LocalPlayer.PlayerGui.AppUI.ChildAdded:Connect(function(gui)
		if gui.name == "Speedometer" then
			selfSettings.onVehicle = true
			VehiclePacket = GetLocalVehiclePacket() or {}

			EnterVehSig:Fire(VehiclePacket.Model)

			CurVehicleData.Vehicle = VehiclePacket.Model

			UpdateDataRS = RunService.Heartbeat:Connect(function()
				CurVehicleData.GEAR = tostring(VehiclePacket["Gear"])
				CurVehicleData.MPH = tostring(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text)
				CurVehicleData.RPM = tostring(VehiclePacket["rpmVisual"])
			end)
		end
	end)

	LocalPlayer.PlayerGui.AppUI.ChildRemoved:Connect(function(gui)
		if gui.name == "Speedometer" then
			selfSettings.onVehicle = false

			ExitVehSig:Fire()
			destroyForza:Fire()

			VehicleModel = nil

			pcall(function()
				UpdateDataRS:Disconnect()
			end)
		end
	end)

	if LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
		selfSettings.onVehicle = true
		VehiclePacket = GetLocalVehiclePacket() or {}

		EnterVehSig:Fire(VehiclePacket.Model)

		UpdateDataRS = RunService.Heartbeat:Connect(function()
			CurVehicleData.GEAR = tostring(VehiclePacket["Gear"])
			CurVehicleData.MPH = tostring(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text)
			CurVehicleData.RPM = tostring(VehiclePacket["rpmVisual"])
		end)
	end
end

return VehicleData
