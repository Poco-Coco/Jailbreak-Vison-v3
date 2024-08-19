MONGOSTORE_CLUSTER = "RaphsDB"
local MongoStore = {}
local MongoDataStore = {}

local warn = function(...)
	return warn("[MongoStore]", ...)
end
local print = function(...)
	return print("[MongoStore]", ...)
end

local Rongo = import("Modules/Database/Rongo.lua")
local Client = nil
MongoDataStore.__index = MongoDataStore

function MongoStore:Authorize(API_ID, API_KEY, Cluster)
	if Cluster then
		MONGOSTORE_CLUSTER = Cluster
	end

	Client = Rongo.new(API_ID, API_KEY)
	return true
end

function MongoStore:GetDataStore(Name, Scope)
	if not Client then
		repeat
			task.wait()
		until Client
	end

	local DataStore = {}
	setmetatable(DataStore, MongoDataStore)
	DataStore.Name = Name
	DataStore.Scope = Scope
	return DataStore
end

function MongoDataStore:GetAsync(Key)
	local Collection = Client:GetCluster(MONGOSTORE_CLUSTER):GetDatabase(self.Name):GetCollection(self.Scope)
	local Document = Collection:FindOne({ ["key"] = Key })

	if Document then
		return Document["data"]
	else
		return nil
	end
end

function MongoDataStore:RemoveAsync(Key)
	local Collection = Client:GetCluster(MONGOSTORE_CLUSTER):GetDatabase(self.Name):GetCollection(self.Scope)
	local Result = Collection:DeleteOne({ ["key"] = Key })

	if not Result or Result == 0 then
		return false
	end
	return true
end

function MongoDataStore:SetAsync(Key, Value)
	local Collection = Client:GetCluster(MONGOSTORE_CLUSTER):GetDatabase(self.Name):GetCollection(self.Scope)
	local Result = Collection:ReplaceOne({ ["key"] = Key }, { ["key"] = Key, ["data"] = Value }, true)

	if not Result or Result.modifiedCount == 0 then
		return false
	end
	return true
end

function MongoDataStore:UpdateAsync(Key, Value)
	local Collection = Client:GetCluster(MONGOSTORE_CLUSTER):GetDatabase(self.Name):GetCollection(self.Scope)
	local Result = Collection:UpdateOne({ ["key"] = Key }, { ["key"] = Key, ["data"] = Value }, true)

	if not Result or Result.modifiedCount == 0 then
		return false
	end
	return true
end

return MongoStore
