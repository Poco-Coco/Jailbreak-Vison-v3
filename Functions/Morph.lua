local Players = game:GetService("Players")
local Morph = {}

function Morph.Run(Target, UserId)
	local appearance = Players:GetCharacterAppearanceAsync(UserId)

	for i, v in pairs(Target.Character:GetChildren()) do
		if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") or v:IsA("BodyColors") then
			v:Destroy()
		end
	end

	if Target.Character.Head:FindFirstChild("face") then
		Target.Character.Head.face:Destroy()
	end

	for i, v in pairs(appearance:GetChildren()) do
		if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
			v.Parent = Target.Character
		elseif v:IsA("Accessory") then
			Target.Character.Humanoid:AddAccessory(v)
		elseif v.Name == "R6" then
			if Target.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
				v:FindFirstChildOfClass("CharacterMesh").Parent = Target.Character
			end
		elseif v.Name == "R15" then
			if Target.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
				v:FindFirstChildOfClass("CharacterMesh").Parent = Target.Character
			end
		end
	end

	if appearance:FindFirstChild("face") then
		appearance.face.Parent = Target.Character.Head
	else
		local face = Instance.new("Decal")
		face.Face = "Front"
		face.Name = "face"
		face.Texture = "rbxasset://textures/face.png"
		face.Transparency = 0
		face.Parent = Target.Character.Head
	end

	local parent = Target.Character.Parent
	Target.Character.Parent = nil
	Target.Character.Parent = parent

	--[[
    Target.Character.Animate.fall.FallAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).FallAnimation
	Target.Character.Animate.run.RunAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).RunAnimation
	Target.Character.Animate.climb.ClimbAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).ClimbAnimation
	Target.Character.Animate.idle.Animation1.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).IdleAnimation
	Target.Character.Animate.jump["!ID!"].AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).JumpAnimation
	Target.Character.Animate.mood.Animation1.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).MoodAnimation
	Target.Character.Animate.swim.Swim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).SwimAnimation
	Target.Character.Animate.walk.WalkAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).WalkAnimation
    ]]
	--
end

return Morph
