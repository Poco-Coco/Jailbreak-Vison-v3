local DestructibleBind = import("Modules/DestructibleBind.lua")
local Importer = {}

function Importer.importMap(mapImportMap)
	local mapName = string.gsub(mapImportMap, "JailbreakVisionV3/MapEditor\\", "")
	if isfile("JailbreakVisionV3/MapEditor/" .. mapName .. "/Terrain.rbxm") then
		local terrain = game:GetObjects(getasset("JailbreakVisionV3/MapEditor/" .. mapName .. "/Terrain.rbxm"))[1]

		game.Workspace.Terrain:Clear()
		game.Workspace.Terrain:PasteRegion(terrain, workspace.Terrain.MaxExtents.Min, true)
	end

	if isfile("JailbreakVisionV3/MapEditor/" .. mapName .. "/Models.rbxm") then
		if game.Workspace:FindFirstChild("ImportedModel") then
			game.Workspace:FindFirstChild("ImportedModel"):Destroy()
		end

		local model = game:GetObjects(getasset("JailbreakVisionV3/MapEditor/" .. mapName .. "/Models.rbxm"))[1]
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

		if model:FindFirstChild("Destructibles") then
			for i, v in next, model:FindFirstChild("Destructibles"):GetChildren() do
				isTree = v:GetAttribute("IsTree")
				if v:IsA("Model") then
					for _, part in next, v:GetChildren() do
						if part.Name == "Base" then
							DestructibleBind.add(part, isTree)
						else
							part.CanCollide = false
							part.CanTouch = false
							part.Anchored = false
							part.Massless = true
						end
					end
				end
			end
		end
	end
end

function Importer.assetImportMap(ImportAssetID)
	local data = "" .. ImportAssetID
	local model = game:GetObjects(data)[1]
	model.Parent = modelFolder
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

return Importer
