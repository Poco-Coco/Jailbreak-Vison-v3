local HttpService = game:GetService("HttpService")

local APIVersion = "v1"
local URI = "https://data.mongodb-api.com/app/%s/endpoint/data/" .. APIVersion

local ENDPOINTS = {
	POST = {
		["FindOne"] = "/action/findOne",
		["FindMany"] = "/action/find",
		["InsertOne"] = "/action/insertOne",
		["InsertMany"] = "/action/insertMany",
		["UpdateOne"] = "/action/updateOne",
		["UpdateMany"] = "/action/updateMany",
		["ReplaceOne"] = "/action/replaceOne",
		["DeleteOne"] = "/action/deleteOne",
		["DeleteMany"] = "/action/deleteMany",
	},
}

local Rongo = {}

local RongoClient = {}
RongoClient.__index = RongoClient

local RongoCluster = {}
RongoCluster.__index = RongoCluster

local RongoDatabase = {}
RongoDatabase.__index = RongoDatabase

local RongoCollection = {}
RongoCollection.__index = RongoCollection

local RongoDocument = {}
RongoDocument.__index = RongoDocument

function Rongo.new(AppId, Key)
	local Client = {}
	setmetatable(Client, RongoClient)

	Client["AppId"] = AppId
	Client["Key"] = Key

	return Client
end

function RongoClient:SetVersion(Version)
	URI = "https://data.mongodb-api.com/app/%s/endpoint/data/" .. Version
end

function RongoClient:GetCluster(Name)
	local Cluster = {}
	setmetatable(Cluster, RongoCluster)

	Cluster["Client"] = self
	Cluster["Name"] = Name

	return Cluster
end

function RongoCluster:GetDatabase(Name)
	local Database = {}
	setmetatable(Database, RongoDatabase)

	Database["Client"] = self["Client"]
	Database["Cluster"] = self
	Database["Name"] = Name

	return Database
end

function RongoDatabase:GetCollection(Name)
	local Collection = {}
	setmetatable(Collection, RongoCollection)

	Collection["Client"] = self["Client"]
	Collection["Cluster"] = self["Cluster"]
	Collection["Database"] = self
	Collection["Name"] = Name

	return Collection
end

function RongoCollection:FindOne(Filter)
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["filter"] = Filter or nil,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.FindOne,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	if not Response["document"] then
		return nil
	end
	return Response["document"]
end

function RongoCollection:FindMany(Filter, Limit, Sort)
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["filter"] = Filter or nil,
		["limit"] = Limit or nil,
		["sort"] = Sort or nil,
		["skip"] = Skip or nil,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.FindMany,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	if not Response["documents"] then
		return nil
	end
	return Response["documents"]
end

function RongoCollection:InsertOne(Document)
	if not Document then
		warn("[RONGO] Document argument cannot be empty")
		return nil
	end
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["document"] = Document,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.InsertOne,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	if not Response["insertedId"] then
		return nil
	end
	return Response["insertedId"]
end

function RongoCollection:InsertMany(Documents)
	if not Documents then
		warn("[RONGO] Documents argument cannot be empty")
		return nil
	end
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["documents"] = Documents,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.InsertMany,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	if not Response["insertedIds"] then
		return nil
	end
	return Response["insertedIds"]
end

function RongoCollection:UpdateOne(Filter, Update, Upsert)
	if not Filter then
		warn("[RONGO] Filter argument cannot be empty")
		return nil
	end
	if not Update then
		warn("[RONGO] Update argument cannot be empty")
		return nil
	end
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["filter"] = Filter or nil,
		["update"] = Update or nil,
		["upsert"] = Upsert or nil,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.UpdateOne,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	return Response
end

function RongoCollection:UpdateMany(Filter, Update, Upsert)
	if not Filter then
		warn("[RONGO] Filter argument cannot be empty")
		return nil
	end
	if not Update then
		warn("[RONGO] Update argument cannot be empty")
		return nil
	end
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["filter"] = Filter or nil,
		["update"] = Update or nil,
		["upsert"] = Upsert or nil,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.UpdateMany,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	return Response
end

function RongoCollection:ReplaceOne(Filter, Replacement, Upsert)
	if not Filter then
		warn("[RONGO] Filter argument cannot be empty")
		return nil
	end
	if not Replacement then
		warn("[RONGO] Update argument cannot be empty")
		return nil
	end
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["filter"] = Filter or nil,
		["replacement"] = Replacement,
		["upsert"] = Upsert,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.ReplaceOne,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	return Response
end

function RongoCollection:DeleteOne(Filter)
	if not Filter then
		warn("[RONGO] Filter argument cannot be empty")
		return nil
	end
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["filter"] = Filter or nil,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.DeleteOne,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	if not Response["deletedCount"] then
		return 0
	end
	return Response["deletedCount"]
end

function RongoCollection:DeleteMany(Filter)
	if not Filter then
		warn("[RONGO] Filter argument cannot be empty")
		return nil
	end
	local RequestData = {
		["dataSource"] = self["Cluster"]["Name"],
		["database"] = self["Database"]["Name"],
		["collection"] = self["Name"],
		["filter"] = Filter or nil,
	}
	local RequestHeaders = {
		["Access-Control-Request-Headers"] = "*",
		["api-key"] = self["Client"]["Key"],
	}
	RequestData = HttpService:JSONEncode(RequestData)
	local Success, Response = pcall(function()
		return HttpService:PostAsync(
			string.format(URI, self["Client"]["AppId"]) .. ENDPOINTS.POST.DeleteMany,
			RequestData,
			Enum.HttpContentType.ApplicationJson,
			false,
			RequestHeaders
		)
	end)
	if not Success then
		warn("[RONGO] Request Failed:", Response)
		return
	end
	Response = HttpService:JSONDecode(Response)
	if not Response["deletedCount"] then
		return 0
	end
	return Response["deletedCount"]
end

return Rongo
