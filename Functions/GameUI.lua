local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIHandler = {
	Hiding = false,
}

local Signal = import("Modules/Signal.lua")

local HideAllUi = Signal.Get("HideAllUi")
local UnHideAllUi = Signal.Get("UnHideAllUi")

local function run()
	if not UIHandler.Hiding then
		UIHandler.Hiding = true
		local RSHide = RunService.Heartbeat:Connect(function(deltaTime)
			game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
			game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
			game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
			game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
			game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
			game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
			game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = false
		end)

		UnHideAllUi:Wait()

		do
			game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
			game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
			game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
			game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
			game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
			game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = true
		end

		RSHide:Disconnect()
		UIHandler.Hiding = false
	end
end

local HideUserNames
function UIHandler.HideUserNames(bool)
	HideUserNames = bool
	game:GetService("TextChatService").BubbleChatConfiguration.Enabled = not bool

	if bool then
		while HideUserNames do
			for i, player in next, Players:GetPlayers() do
				pcall(function()
					player.Character.Humanoid.NameDisplayDistance = 0
				end)

				pcall(function()
					player.Character:FindFirstChild("Head"):FindFirstChild("PlayerHeadGui").Enabled = false
				end)
				pcall(function()
					player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("PlayerBillboard").Enabled =
						false
				end)
			end

			RunService.RenderStepped:Wait()
		end
	else
		for i, player in next, Players:GetPlayers() do
			if not (player == LocalPlayer) then
				player.Character.Humanoid.NameDisplayDistance = 100

				pcall(function()
					player.Character:FindFirstChild("Head"):FindFirstChild("PlayerHeadGui").Enabled = true
				end)
				pcall(function()
					player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("PlayerBillboard").Enabled = true
				end)
			end
		end
	end
end

function UIHandler.init()
	HideAllUi:Connect(run)
end

return UIHandler
