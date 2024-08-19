local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ReplayObjects = {
	Variable = {
		partID = 0,
	},
}

function ReplayObjects.IntilizeVehicle(Vehicle, Settings) end

function ReplayObjects.FetchVehicle(Name)
	if ReplicatedStorage.Resource.Vehicles:FindFirstChild(Name) then
		return ReplicatedStorage.Resource.Vehicles:FindFirstChild(Name)
	else
		return nil
	end
end

function ReplayObjects.AssignID()
	LPH_NO_VIRTUALIZE(function()
		for i, v in pairs(Workspace:GetDescendants()) do
			v:SetAttribute("ReplayID", i)
			ReplayObjects.Variable.partID = i
		end

		Workspace.DescendantAdded:Connect(function(descendant)
			ReplayObjects.Variable.partID = ReplayObjects.Variable.partID + 1
			descendant:SetAttribute("ReplayID", ReplayObjects.Variable.partID)
		end)
	end)()
end

return ReplayObjects
