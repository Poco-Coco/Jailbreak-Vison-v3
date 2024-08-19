local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CutSceneService = {
	renderingPath = false,
	CurrentPath = {},
}

local Spline = import("Modules/CutScene/Spline.lua")
local Bezier = import("Modules/CutScene/Cubic.lua")
local Library = import("Modules/UiLibrary/Lib.lua")

local BezierFolder
local PointsFolder
local LinesFolder

local function getCF(points, t)
	local copy = { unpack(points) }
	repeat
		for i, v in ipairs(copy) do
			if i ~= 1 then
				copy[i - 1] = copy[i - 1]:Lerp(v, t)
			end
		end
		if #copy ~= 1 then
			copy[#copy] = nil
		end
	until #copy == 1
	return copy[1]
end

local function update(parts, path)
	local instances = path:GetChildren()

	if #instances > 0 then
		local points = {}

		for _, v in ipairs(instances) do
			if not tonumber(v.Name) then
				warn("A point in the cutscene has an invalid name")
				return
			end
		end

		table.sort(instances, function(a, b)
			return tonumber(a.Name) < tonumber(b.Name)
		end)

		for _, v in ipairs(instances) do
			table.insert(points, v.CFrame)
		end

		for i, v in ipairs(parts) do
			v.CFrame = getCF(points, i * 0.002)
		end
	end
end

function CutSceneService.render(path, interp, pathFolder)
	local success, err = pcall(function()
		pcall(function()
			BezierFolder:Destroy()
			PointsFolder:Destroy()
			LinesFolder:Destroy()
		end)

		if interp == "Spline" then
			local CurrentSpline = Spline.new(path, 0.4)

			BezierFolder = Instance.new("Folder", Workspace)
			PointsFolder = Instance.new("Folder", Workspace)
			LinesFolder = Instance.new("Folder", Workspace)
			BezierFolder.Name = "Bezier"
			PointsFolder.Name = "Points"
			LinesFolder.Name = "Lines"

			local n = 10
			local resolution = 1 / 40

			local DefaultPoints, EquidistantPoints, Lines = {}, {}, {}
			for i = 1, n - 1, resolution do
				local Point = Instance.new("Part", PointsFolder)
				Point.Name = "Default" .. tostring(i)
				Point.Shape = Enum.PartType.Ball
				Point.Size = Vector3.new(0.5, 0.5, 0.5)
				Point.Color = Color3.fromRGB(0, 179, 255)
				Point.Material = Enum.Material.Neon
				Point.Transparency = 1
				Point.Anchored = true
				Point.CanCollide = false
				Point.BottomSurface = Enum.SurfaceType.Smooth
				Point.TopSurface = Enum.SurfaceType.Smooth
				Point.Locked = true

				table.insert(DefaultPoints, Point)
			end

			for i = 1, n - 1, resolution do
				local Point = Instance.new("Part", PointsFolder)
				Point.Name = "Default" .. tostring(i)
				Point.Shape = Enum.PartType.Ball
				Point.Size = Vector3.new(1, 1, 1)
				Point.Color = Color3.fromRGB(0, 179, 255)
				Point.Material = Enum.Material.Neon
				Point.Transparency = 1
				Point.Anchored = true
				Point.CanCollide = false
				Point.BottomSurface = Enum.SurfaceType.Smooth
				Point.TopSurface = Enum.SurfaceType.Smooth
				Point.Locked = true

				table.insert(EquidistantPoints, Point)
			end

			for i = 1, n - 1, resolution do
				local TargetPart = Instance.new("Part", LinesFolder)
				TargetPart.Size = Vector3.new(0.15, 0.15, 1)
				TargetPart.Color = Color3.fromRGB(255, 255, 255)
				TargetPart.Material = Enum.Material.Neon
				TargetPart.CanCollide = false
				TargetPart.Anchored = true
				TargetPart.Locked = true
				TargetPart.Name = tostring(i)
				TargetPart.CastShadow = false

				table.insert(Lines, TargetPart)
			end

			for i = 1, #EquidistantPoints do
				local t = (i - 1) / (#DefaultPoints - 1)
				local p1 = CurrentSpline:CalculatePositionAt(t)
				local d1 = CurrentSpline:CalculateDerivativeAt(t)
				local p2 = CurrentSpline:CalculatePositionRelativeToLength(t)
				local d2 = CurrentSpline:CalculateDerivativeRelativeToLength(t)
				DefaultPoints[i].CFrame = CFrame.new(p1, p1 + d1)
				EquidistantPoints[i].CFrame = CFrame.new(p2, p2 + d2)
			end

			for i = 1, #Lines do
				pcall(function()
					local line = Lines[i]
					local p1, p2 = DefaultPoints[i].Position, DefaultPoints[i + 1].Position
					line.Size = Vector3.new(line.Size.X, line.Size.Y, (p2 - p1).Magnitude)
					line.CFrame = CFrame.new(0.5 * (p1 + p2), p2)
				end)
			end
		else
			BezierFolder = Instance.new("Folder", Workspace)
			PointsFolder = Instance.new("Folder", Workspace)
			LinesFolder = Instance.new("Folder", Workspace)
			BezierFolder.Name = "Bezier"
			PointsFolder.Name = "Points"
			LinesFolder.Name = "Lines"

			local Point = Instance.new("Part")
			Point.Name = "PathPoint"
			Point.Shape = Enum.PartType.Ball
			Point.Size = Vector3.new(0.3, 0.3, 0.3)
			Point.Color = Color3.fromRGB(255, 255, 255)
			Point.Material = Enum.Material.Plastic
			Point.Locked = true
			Point.Anchored = true
			Point.CanCollide = false
			Point.BottomSurface = Enum.SurfaceType.Smooth
			Point.TopSurface = Enum.SurfaceType.Smooth
			Point.CastShadow = false
			Point.CanTouch = false
			Point.Transparency = 1

			for i = 1, 500 do
				Point.Name = tostring(i)
				Point:Clone().Parent = BezierFolder
			end

			local parts = BezierFolder:GetChildren()
			update(parts, pathFolder)

			for i = 1, (#BezierFolder:GetChildren() - 1) do
				local One = BezierFolder:FindFirstChild(i)
				local Two = BezierFolder:FindFirstChild(i + 1)

				local TargetPart = Instance.new("Part", LinesFolder)
				TargetPart.Size = Vector3.new(0.15, 0.15, 0.15)
				TargetPart.Color = Color3.fromRGB(255, 255, 255)
				TargetPart.Material = Enum.Material.Neon
				TargetPart.CanCollide = false
				TargetPart.Anchored = true
				TargetPart.Locked = true
				TargetPart.Name = tostring(i)
				TargetPart.CastShadow = false

				local dist = (One.Position - Two.Position).Magnitude
				TargetPart.Size = Vector3.new(0.05, 0.5, dist)
				TargetPart.CFrame = CFrame.new(One.Position, Two.Position) * CFrame.new(0, 0, -dist / 2)
			end
		end
	end)

	if not success then
		Library:Notify({
			Name = "Error",
			Text = tostring(err),
			Icon = "rbxassetid://11401835376",
			Duration = 3,
		})
	end
end

function CutSceneService.derender()
	for i, v in next, LinesFolder:GetChildren() do
		local Info = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		TweenService:Create(v, Info, { Transparency = 1 }):Play()
	end

	task.wait(2)

	pcall(function()
		BezierFolder:Destroy()
		PointsFolder:Destroy()
		LinesFolder:Destroy()
	end)
end

local FocusRS

function CutSceneService.play(path, interp, duration, pathFolder)
	local PreviousCameraType = Camera.CameraType
	Camera.CameraType = Enum.CameraType.Scriptable

	task.spawn(function()
		FocusRS = RunService.RenderStepped:Connect(function()
			Camera.Focus = Camera.CFrame
		end)
	end)

	if interp == "Spline" then
		local NewSpline = Spline.new(path, 0.4)

		local CameraTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		local CamTween = NewSpline:CreateTween(Camera, CameraTweenInfo, { "CFrame" }, true, pathFolder)
		CamTween:Play()

		CamTween.Completed:Wait()
	else
		local CamTween = Bezier:Create(pathFolder, duration, "InOutSine")
		CamTween:Play()

		CamTween.Completed:Wait()
		CamTween:Destroy()
	end

	Camera.CameraType = PreviousCameraType
	FocusRS:Disconnect()
end

return CutSceneService
