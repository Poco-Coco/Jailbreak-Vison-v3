local Destructible = {}
local DestructibleEvents = {}
local baseFolder

local function CrashParticle()
	local ParticleEmitter0 = Instance.new("ParticleEmitter")
	ParticleEmitter0.Name = "CrashParticle"
	ParticleEmitter0.Orientation = Enum.ParticleOrientation.VelocityParallel
	ParticleEmitter0.Rotation = NumberRange.new(70, 100)
	ParticleEmitter0.Color =
		ColorSequence.new(Color3.new(0.995682, 0.838529, 0.8663), Color3.new(0.995682, 0.838529, 0.8663))
	ParticleEmitter0.Enabled = true
	ParticleEmitter0.LightEmission = 1
	ParticleEmitter0.LightInfluence = 1
	ParticleEmitter0.Texture = "http://www.roblox.com/asset/?id=6740271308"
	ParticleEmitter0.ZOffset = 1
	ParticleEmitter0.Size = NumberSequence.new(5, 5)
	ParticleEmitter0.EmissionDirection = Enum.NormalId.Back
	ParticleEmitter0.Lifetime = NumberRange.new(1, 1)
	ParticleEmitter0.Rate = 25

	task.spawn(function()
		ParticleEmitter0.Enabled = true
		task.wait(0.5)
		ParticleEmitter0.Enabled = false
		task.wait(0.5)
		ParticleEmitter0:Destroy()
	end)

	return ParticleEmitter0
end

local function leaveParticle()
	local ParticleEmitter0 = Instance.new("ParticleEmitter")
	ParticleEmitter0.Name = "LeavesParticle"
	ParticleEmitter0.Speed = NumberRange.new(2, 2)
	ParticleEmitter0.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
	ParticleEmitter0.Rotation = NumberRange.new(70, 100)
	ParticleEmitter0.Color =
		ColorSequence.new(Color3.new(0.203922, 0.556863, 0.25098), Color3.new(0.203922, 0.556863, 0.25098))
	ParticleEmitter0.Enabled = true
	ParticleEmitter0.LightEmission = 0.5
	ParticleEmitter0.LightInfluence = 1
	ParticleEmitter0.Texture = "http://www.roblox.com/asset/?id=7018929807"
	ParticleEmitter0.Transparency = NumberSequence.new(1, 0, 0, 1)
	ParticleEmitter0.Size = NumberSequence.new(10, 10)
	ParticleEmitter0.Acceleration = Vector3.new(0, -3, 0)
	ParticleEmitter0.Lifetime = NumberRange.new(3, 3)
	ParticleEmitter0.Rate = 8
	ParticleEmitter0.RotSpeed = NumberRange.new(-40, 40)
	ParticleEmitter0.SpreadAngle = Vector2.new(-180, 180)
	ParticleEmitter0.VelocitySpread = -180

	task.spawn(function()
		ParticleEmitter0.Enabled = true
		task.wait(2)
		ParticleEmitter0:Destroy()
	end)

	return ParticleEmitter0
end

local function CrashSound(object)
	local CrashSound0 = Instance.new("Sound")
	CrashSound0.SoundId = "rbxassetid://7018764077"
	CrashSound0.Parent = object
	CrashSound0.Volume = 0.15
	CrashSound0.RollOffMaxDistance = 128
	CrashSound0.PlaybackSpeed = math.random() * 0.1 + 0.95

	task.spawn(function()
		CrashSound0:Play()

		task.wait(2)
		CrashSound0:Destroy()
	end)
end

local function lookAt(from, target)
	local forwardVector = (target - from).Unit
	local upVector = Vector3.new(0, 1, 0)
	local rightVector = forwardVector:Cross(upVector)
	local upVector2 = rightVector:Cross(forwardVector)

	return CFrame.fromMatrix(from, rightVector, upVector2)
end

local function giveEffect(object, attachment, pos, touchPart, isTree)
	local Particles = {}
	local RelativeCF = touchPart.CFrame:ToObjectSpace(object.CFrame)
	local z, y, x = RelativeCF:ToEulerAnglesXYZ()

	attachment.CFrame = CFrame.new(0, RelativeCF.Position.Y, 0) * CFrame.fromEulerAnglesXYZ(0, y, 0)
	attachment.Parent = object
	local crashParti = CrashParticle()

	crashParti.Parent = attachment
	table.insert(Particles, crashParti)

	if isTree then
		local leaveParti = leaveParticle()
		leaveParti.Parent = attachment
		table.insert(Particles, leaveParti)
	end

	if object.Anchored then
		pcall(function()
			object.CanCollide = true
			object.Anchored = false
			object.CanTouch = false
			CrashSound(object)
		end)
	end

	task.delay(3, function()
		pcall(function()
			object.Anchored = true
			object.CanCollide = false
			object.CanTouch = true
			object.CFrame = object:FindFirstChild("PartCF").Value
		end)
	end)
end

function Destructible.init()
	baseFolder = Instance.new("Folder")
	baseFolder.Parent = Workspace
	baseFolder.Name = "Destructibles"
end

function Destructible.add(obj, isTree)
	if obj:IsA("BasePart") then
		local cfVal = Instance.new("CFrameValue")
		cfVal.Parent = obj
		cfVal.Value = obj.CFrame
		cfVal.Name = "PartCF"

		local touch = obj.Touched:Connect(function(touchPart)
			--[[if touchPart:IsDescendantOf(Workspace.Destructibles) then
					print(touchPart.Name.." failed basefolder check")
					return
				end]]
			--

			if touchPart:IsDescendantOf(Workspace:FindFirstChild("Vehicles")) then
				local attach = Instance.new("Attachment")
				local attachRootPos = Vector3.new(obj.Position.X, touchPart.Position.Y, obj.Position.Z)

				giveEffect(obj, attach, attachRootPos, touchPart, isTree)
				return
			end
		end)
		table.insert(DestructibleEvents, touch)
	end
end

function Destructible.DestroyAll()
	for i, v in next, DestructibleEvents do
		v:Disconnect()
	end
end

return Destructible
