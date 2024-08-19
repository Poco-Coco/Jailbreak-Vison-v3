local SpTDB = {}
local MongoStore = import("Modules/Database/MongoDB.lua")
local DataStore = MongoStore:GetDataStore("DataStore", "SpeedTestData")

function SpTDB:Write()
	return
end

return SpTDB
