local Players = game:GetService("Players")
local PlayerHandler = {}
local Signal = import("Modules/Signal.lua")

-- Signals

function PlayerHandler.init()
	local PlayerJoin = Signal.Get("PlayerJoin")
	local PlayerLeave = Signal.Get("PlayerLeave")

	Players.PlayerAdded:Connect(function(player)
		PlayerJoin:Fire(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		PlayerLeave:Fire(player)
	end)
end

return PlayerHandler
