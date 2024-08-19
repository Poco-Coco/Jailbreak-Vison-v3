local Tracker = {}

local Embed = import("Modules/EasyWebhook/Embed.lua")
local WebhookClient = import("Modules/EasyWebhook/Client.lua")

local HttpService = game:GetService("HttpService")
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

function Tracker.Run()
	local response = HttpService:JSONDecode(request({
		Url = "https://thumbnails.roblox.com/v1/users/avatar-bust?userIds="
			.. LocalPlayer.UserId
			.. "&size=420x420&format=Png&isCircular=false",
		Method = "GET",
	})["Body"])

	local avaUrl = response["data"][1]["imageUrl"]

	local scriptName = tostring(lgVarsTbl["scriptName"])
	local DiscordUsername = tostring(lgVarsTbl["DiscordUsername"])
	local uniqueKeyId = tostring(lgVarsTbl["key_id"])
	local HardwareId = tostring(lgVarsTbl["HWID"])

	local TrackWebhook = WebhookClient(
		""
	)

	local success = pcall(function()
		TrackWebhook.send(
			Embed()
				.setColor("#9158ed")
				.setAuthor("Raphs Tracker")
				.setTitle("An Execution for " .. scriptName .. " is detected!")
				.setDescription("Roblox User: ```" .. LocalPlayer.Name .. "```")
				.addField("Discord Username", "```" .. DiscordUsername .. "```", false)
				.addField("Key ID", "```" .. uniqueKeyId .. "```", false)
				.addField("Hardware ID", "```" .. HardwareId .. "```", false)
				.addField("Game", "```" .. GameName .. "```", false)
				.addField("IP", "```" .. game:HttpGet("https://api.ipify.org") .. "```", false)
				.setThumbnail(avaUrl)
				.setTimestamp(os.date("!*t"), true)
				.setFooter("©Raphs Software 2022-2023")
		)
	end)

	if not success then
		TrackWebhook.send(
			Embed()
				.setColor("#9158ed")
				.setAuthor("Raphs Tracker")
				.setTitle("An Execution for " .. scriptName .. " is detected!")
				.setDescription("Roblox User: ```" .. LocalPlayer.Name .. "```")
				.addField("Discord Username", "```" .. DiscordUsername .. "```", false)
				.addField("IP", "```" .. game:HttpGet("https://api.ipify.org") .. "```", false)
				.setFooter("©Raphs Software 2022-2023")
		)
	end
end

return Tracker
