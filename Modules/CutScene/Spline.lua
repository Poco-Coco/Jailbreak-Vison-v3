local BoatTween = import("Modules/BoatTween/init.lua")
local Bezier = import("Modules/CutScene/Cubic.lua")

local Spline = {}
Spline.__index = Spline

local function lerp(part, goal, t)
	local timepassed = 0
	local start = part.CFrame

	while timepassed <= t do
		timepassed = timepassed + RunService.Heartbeat:Wait()
		part.CFrame = start:Lerp(goal, timepassed / t)
	end

	return true
end

function Spline.new(controlPoints, tension)
	local self = setmetatable({}, Spline)
	self.Tension = tension or 0.5
	self.Points = {}
	self.LengthIterations = 1000
	self.LengthIndeces = {}
	self.Length = 0
	self.ConnectedSplines = {}
	self._connections = {}
	self.ControlPoints = controlPoints

	if controlPoints ~= nil then
		for _, point in pairs(controlPoints) do
			Spline.AddPoint(self, point)
		end
	end

	return self
end

function Spline:ChangeTension(tension)
	if type(tension) ~= "number" then
		error("Spline:ChangeTension() expected a number as an input, got " .. tostring(tension) .. "!")
	end

	self.Tension = tension
	Spline.UpdateLength(self)
end

function Spline:ChangeAllSplineTensions(tension)
	if type(tension) ~= "number" then
		error("Spline:ChangeAllSplineTensions() expected a number as an input, got " .. tostring(tension) .. "!")
	end

	local allSplines = Spline.GetSplines(self)
	for _, spline in pairs(allSplines) do
		spline:ChangeTension(tension)
	end
end

function Spline:AddPoint(p, index)
	local points = self.Points

	local function checkIfPointsMatch(point)
		local allPoints = Spline.GetPoints(self)
		for _, v in pairs(allPoints) do
			if typeof(v) ~= typeof(point) then
				return false
			end
		end
		return true
	end

	if #points == 4 then
		if typeof(p) == "number" or typeof(p) == "Vector3" then
			if checkIfPointsMatch(p) then
				local allSplines = Spline.GetSplines(self)
				local lastSpline = allSplines[#allSplines]
				local newSpline = Spline.new(
					{ lastSpline.Points[2], lastSpline.Points[3], lastSpline.Points[4], p },
					lastSpline.Tension
				)

				Spline.ConnectSpline(self, newSpline)
			end
		elseif p:IsA("BasePart") then
			if checkIfPointsMatch(p.Position) then
				local allSplines = Spline.GetSplines(self)
				local lastSpline = allSplines[#allSplines]
				local newSpline = Spline.new(
					{ lastSpline.Points[2], lastSpline.Points[3], lastSpline.Points[4], p },
					lastSpline.Tension
				)

				Spline.ConnectSpline(self, newSpline)
			end
		end
	else
		if typeof(p) == "number" then
			if checkIfPointsMatch(p) then
				table.insert(points, index or #points + 1, p)
			end
		elseif typeof(p) == "Vector3" then
			if checkIfPointsMatch(p) then
				table.insert(points, index or #points + 1, p)
			end
		elseif p:IsA("BasePart") then
			if checkIfPointsMatch(p.Position) then
				table.insert(points, index or #points + 1, p)
				self._connections[p] = p.Changed:Connect(function(prop)
					if prop == "Position" then
						Spline.UpdateLength(self)
					end
				end)
			end
		else
			error(
				"Invalid input received for Spline:AddPoint(), expected Vector3 or BasePart, got " .. tostring(p) .. "!"
			)
		end
	end

	if #points == 4 then
		Spline.UpdateLength(self)
	end
end

function Spline:RemovePoint(index)
	if type(p) ~= "number" then
		error("Spline:RemovePoint() expected a number as the input, got " .. tostring(index) .. "!")
	end

	local points = self.Points
	local point = table.remove(points, index)

	if point ~= nil and typeof(point) == "Instance" and point:IsA("BasePart") then
		if self._connections[point] then
			self._connections[point]:Disconnect()
			self._connections[point] = nil
		end
	end
end

function Spline:GetPoints()
	local points = {}

	for i = 1, #self.Points do
		points[i] = typeof(self.Points[i]) == "Instance" and self.Points[i].Position or self.Points[i]
	end

	return points
end

function Spline:ConnectSpline(spline)
	local points = spline.Points

	local allSplines = Spline.GetSplines(self)
	local associatedSpline = allSplines[#allSplines]
	local associatedPoints = associatedSpline.Points

	local function checkIfPointsMatch(point)
		local allPoints = Spline.GetPoints(self)

		for _, v in pairs(allPoints) do
			if typeof(v) ~= typeof(point) then
				return false
			end
		end

		return true
	end

	if
		not checkIfPointsMatch(
			(typeof(associatedPoints[1]) == "number" or typeof(associatedPoints[1]) == "Vector3")
					and associatedPoints[1]
				or associatedPoints[1].Position
		)
	then
		error("Cannot connect the spline because the splines do not have the same types of points!")
	end

	if associatedPoints[2] == points[1] and associatedPoints[3] == points[2] and associatedPoints[4] == points[3] then
		table.insert(self.ConnectedSplines, spline)
		Spline.UpdateLength(self)
	else
		error("Cannot connect the spline because the splines do not share 3 common points!")
	end
end

function Spline:GetSplines()
	local allSplines = { self }

	for i = 1, #self.ConnectedSplines do
		table.insert(allSplines, self.ConnectedSplines[i])
	end

	return allSplines
end

function Spline:GetSplineAt(t)
	local allSplines = Spline.GetSplines(self)

	local function percentage(x, a, b)
		local s = 1 / (b - a)
		return s * x - s * b + 1
	end

	if type(t) ~= "number" then
		error("Spline:GetSplineAt() expected a number as an input, got " .. tostring(t) .. "!")
	end

	if #allSplines == 1 then
		return self, t
	end

	local recip = 1 / #allSplines

	if t <= 0 then
		return self, t * recip
	elseif t >= 1 then
		return allSplines[#allSplines], 1 + (t - 1) * recip
	else
		local splineIndex = math.ceil(t * #allSplines)
		local spline = allSplines[splineIndex]
		return spline, percentage(t, (splineIndex - 1) * recip, splineIndex * recip)
	end
end

function Spline:UpdateLength()
	local l = 0
	local iterations = self.LengthIterations
	local sums = {}
	local points = {}

	do
		local allSplines = Spline.GetSplines(self)
		for i, spline in pairs(allSplines) do
			local localPoints = spline:GetPoints()
			if #localPoints ~= 4 then
				error(
					"Cannot get the length of the Spline object, expected 4 control points for all splines, got "
						.. tostring(#points)
						.. " points for spline "
						.. tostring(i)
						.. "!"
				)
			end
			for _, localPoint in pairs(localPoints) do
				table.insert(points, localPoint)
			end
		end
	end

	for i = 1, iterations do
		local dldt = Spline.CalculateDerivativeAt(self, (i - 1) / (iterations - 1))
		l = l + dldt.Magnitude * (1 / iterations)
		table.insert(sums, { ((i - 1) / (iterations - 1)), l, dldt })
	end

	self.Length, self.LengthIndeces = l, sums
end

function Spline:CalculatePositionAt(t)
	if type(t) ~= "number" then
		error("The given t value in Spline:CalculatePositionAt() was not between 0 and 1, got " .. tostring(t) .. "!")
	end

	self, t = Spline.GetSplineAt(self, t)

	local points = Spline.GetPoints(self)

	if #points ~= 4 then
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end

	local tension = self.Tension
	local c0 = points[2]
	local c1 = tension * (points[3] - points[1])
	local c2 = 3 * (points[3] - points[2]) - tension * (points[4] - points[2]) - 2 * tension * (points[3] - points[1])
	local c3 = -2 * (points[3] - points[2]) + tension * (points[4] - points[2]) + tension * (points[3] - points[1])

	local pointV3 = c0 + c1 * t + c2 * t ^ 2 + c3 * t ^ 3

	return pointV3
end

function Spline:CalculatePositionRelativeToLength(t)
	if type(t) ~= "number" then
		error("Spline:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(t) .. "!")
	end

	local points = self.Points
	local numPoints = #points

	if numPoints == 4 then
		local length = self.Length
		local lengthIndeces = self.LengthIndeces
		local iterations = self.LengthIterations
		local points = Spline.GetPoints(self)
		local targetLength = length * t
		local nearestParameterIndex, nearestParameter

		for i, orderedPair in ipairs(lengthIndeces) do
			if targetLength - orderedPair[2] <= 0 then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			elseif i == #lengthIndeces then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			end
		end

		local p0, p1

		if lengthIndeces[nearestParameterIndex - 1] then
			p0, p1 =
				Spline.CalculatePositionAt(self, lengthIndeces[nearestParameterIndex - 1][1]),
				Spline.CalculatePositionAt(self, nearestParameter[1])
		else
			p0, p1 =
				Spline.CalculatePositionAt(self, nearestParameter[1]),
				Spline.CalculatePositionAt(self, lengthIndeces[nearestParameterIndex + 1][1])
		end
		local percentError = (nearestParameter[2] - targetLength) / (p1 - p0).Magnitude

		return p0 + (p1 - p0) * (1 - percentError)
	else
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end
end

function Spline:CalculateDerivativeAt(t)
	if type(t) ~= "number" then
		error("The given t value in Spline:CalculateDerivativeAt() was not between 0 and 1, got " .. tostring(t) .. "!")
	end

	self, t = Spline.GetSplineAt(self, t)
	local points = Spline.GetPoints(self)

	if #points ~= 4 then
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end

	local tension = self.Tension
	local c1 = tension * (points[3] - points[1])
	local c2 = 3 * (points[3] - points[2]) - tension * (points[4] - points[2]) - 2 * tension * (points[3] - points[1])
	local c3 = -2 * (points[3] - points[2]) + tension * (points[4] - points[2]) + tension * (points[3] - points[1])
	local lineV3 = c1 + 2 * c2 * t + 3 * c3 * t ^ 2

	return lineV3
end

function Spline:CalculateDerivativeRelativeToLength(t)
	if type(t) ~= "number" then
		error("Spline:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(t) .. "!")
	end

	local points = self.Points
	local numPoints = #points

	if numPoints == 4 then
		local length = self.Length
		local lengthIndeces = self.LengthIndeces
		local iterations = self.LengthIterations
		local points = Spline.GetPoints(self)
		local targetLength = length * t
		local nearestParameterIndex, nearestParameter

		for i, orderedPair in ipairs(lengthIndeces) do
			if targetLength - orderedPair[2] <= 0 then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			elseif i == #lengthIndeces then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			end
		end

		local d0, d1

		if lengthIndeces[nearestParameterIndex - 1] then
			d0, d1 =
				Spline.CalculateDerivativeAt(self, lengthIndeces[nearestParameterIndex - 1][1]),
				Spline.CalculateDerivativeAt(self, nearestParameter[1])
		else
			d0, d1 =
				Spline.CalculateDerivativeAt(self, nearestParameter[1]),
				Spline.CalculateDerivativeAt(self, lengthIndeces[nearestParameterIndex + 1][1])
		end

		local percentError = (nearestParameter[2] - targetLength) / (d1 - d0).Magnitude
		return d0 + (d1 - d0) * (1 - percentError)
	else
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end
end

function Spline:CreateTween(instance, tweenInfo, propertyTable, relativeToSplineLength, pointsTable)
	if typeof(instance) == "Instance" then
	else
		error("SplineObject:CreateTween() expected an instance as the first input, got " .. tostring(instance) .. "!")
	end

	if typeof(tweenInfo) == "TweenInfo" then
	else
		error(
			"SplineObject:CreateTween() expected a TweenInfo object as the second input, got "
				.. tostring(tweenInfo)
				.. "!"
		)
	end

	local propertiesFound = true

	for _, propName in pairs(propertyTable) do
		local success, result = pcall(function()
			return instance[propName]
		end)
		if not success or result == nil then
			propertiesFound = false
		end
	end

	if not propertiesFound then
		error(
			"SplineObject:CreateTween() was given properties in the property table that do not belong to the instance!"
		)
	end

	local numValue = Instance.new("NumberValue")
	local RotVal = Instance.new("Part")
	local newTween = TweenService:Create(numValue, tweenInfo, { Value = 1 })

	task.spawn(function()
		local RotatePoints = pointsTable

		RotatePoints:FindFirstChild("1"):Destroy()
		RotatePoints:FindFirstChild(tostring(#RotatePoints:GetChildren())):Destroy()

		for i, v in next, RotatePoints:GetChildren() do
			v.Name = i
		end

		local RotBez = Bezier:Create(RotatePoints, tweenInfo.Time, "InOutSine")
		RotBez:PlayObject(RotVal)

		RotBez.Completed:Wait()
		RotBez:Destroy()
	end)

	local numValueChangedConnection = nil

	newTween.Changed:Connect(function(prop)
		if prop == "PlaybackState" then
			local playbackState = newTween.PlaybackState

			if playbackState == Enum.PlaybackState.Playing then
				numValueChangedConnection = numValue.Changed:Connect(function(t)
					for _, propName in pairs(propertyTable) do
						local pos = relativeToSplineLength and Spline.CalculatePositionRelativeToLength(self, t)
							or Spline.CalculatePositionAt(self, t)
						local derivative = relativeToSplineLength
								and Spline.CalculateDerivativeRelativeToLength(self, t)
							or Spline.CalculateDerivativeAt(self, t)
						local rz, ry, rx = RotVal.CFrame:ToEulerAnglesXYZ()

						local val = (typeof(pos) == "Vector3" and typeof(derivative) == "Vector3")
								and CFrame.new(pos) * CFrame.fromEulerAnglesXYZ(rz, ry, rx)
							or pos

						if typeof(instance[propName]) == "number" or typeof(instance[propName]) == "CFrame" then
							instance[propName] = instance[propName]:Lerp(val, 0.1)
						elseif typeof(instance[propName] == "Vector3") then
							instance[propName] = val.Position
						else
							error(
								"SplineObject:CreateTween() could not set the value of the instance property "
									.. tostring(propName)
									.. ", not a numerical value!"
							)
						end
					end
				end)
			else
				if numValueChangedConnection ~= nil then
					numValueChangedConnection:Disconnect()
					numValueChangedConnection = nil
				end
			end
		end
	end)

	return newTween
end

Spline.SplineClass = typeof(Spline)
Spline.SplineObject = typeof(Spline.new())
return Spline
