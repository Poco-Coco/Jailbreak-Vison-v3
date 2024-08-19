local HttpService = game:GetService("HttpService")

return function(link)
	local ret = {}

	function ret.send(body, emb)
		if typeof(body) == "table" then
			emb = body
			body = ""
		end

		if emb then
			if emb["customembed"] then
				emb = emb.getAllValues()
			end
		end

		local data = {
			["embeds"] = {
				emb,
			},
			["content"] = body,
		}

		local headers = {
			["content-type"] = "application/json",
		}

		local webhook = { Url = link, Body = HttpService:JSONEncode(data), Method = "POST", Headers = headers }
		return request(webhook)
	end

	return ret
end
