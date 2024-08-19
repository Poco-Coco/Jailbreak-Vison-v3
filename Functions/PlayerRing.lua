local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Signal = import("Modules/Signal.lua")
local PlayerRing = {}

local function makeRing()
	local Ring = game:GetObjects("rbxassetid://13120474439")[1]
	Ring.Parent = Workspace

	return Ring
end

local Enabled = false

local function initRing(ringPlayer, Ring)
	while not ringPlayer.Character do
		RunService.RenderStepped:Wait()
	end

	local PlayerLeave = Signal.Get("PlayerLeave")

	local RootPart = ringPlayer.Character:FindFirstChild("HumanoidRootPart")
	local rayParam = RaycastParams.new()

	local MoveRingRS

	local list = {}
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Character then
			table.insert(list, v.Character)
		end
	end

	table.insert(list, Workspace.Vehicles)
	table.insert(list, Ring)
	table.insert(list, ringPlayer.Character)

	rayParam.FilterType = Enum.RaycastFilterType.Blacklist
	rayParam.FilterDescendantsInstances = list

	local effect1 = Ring:FindFirstChild("Effect  1")
	local effect2 = Ring:FindFirstChild("Effect  2")
	local pointlight = Ring:FindFirstChild("SurfaceLight")

	local lightColor = ringPlayer.TeamColor.Color
	local teamColorSeq = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, lightColor),
		ColorSequenceKeypoint.new(1.000, lightColor),
	})

	MoveRingRS = RunService.RenderStepped:Connect(function()
		pcall(function()
			if not Enabled then
				MoveRingRS:Disconnect()
				Ring:Destroy()
			end

			lightColor = ringPlayer.TeamColor.Color

			teamColorSeq = ColorSequence.new({
				ColorSequenceKeypoint.new(0.000, lightColor),
				ColorSequenceKeypoint.new(1.000, lightColor),
			})

			effect1.Color = teamColorSeq
			effect2.Color = teamColorSeq
			pointlight.Color = lightColor

			if RootPart and RootPart.Parent then
				local castedRay = Workspace:Raycast(RootPart.CFrame.Position, Vector3.yAxis * -2e2, rayParam)

				if castedRay then
					local intersect = castedRay.Normal
					local upVector = intersect:Cross(Vector3.xAxis).Unit
					Ring.CFrame = Ring.CFrame:Lerp(
						CFrame.lookAt(castedRay.Position, castedRay.Position + intersect, upVector)
							* CFrame.Angles(math.rad(90), 0, 0)
							* CFrame.new(0, -0.7, 0),
						0.6
					)
				end
			end
		end)
	end)

	PlayerLeave:Connect(function(leftPlayer)
		if leftPlayer.Name == ringPlayer.Name then
			MoveRingRS:Disconnect()
			Ring:Destroy()
		end
	end)
end

local function giveRings()
	for i, v in next, Players:GetPlayers() do
		local selfRing = makeRing()

		initRing(v, selfRing)
	end

	return
end

function PlayerRing.start()
	Enabled = true
	giveRings()

	return
end

function PlayerRing.stop()
	Enabled = false

	return
end

function PlayerRing.init()
	local PlayerJoin = Signal.Get("PlayerJoin")

	PlayerJoin:Connect(function(player)
		if Enabled then
			local selfRing = makeRing()
			initRing(player, selfRing)
		end
	end)

	return
end

return PlayerRing
