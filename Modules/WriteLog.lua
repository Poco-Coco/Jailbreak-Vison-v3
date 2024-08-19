local WriteLog = {}

local LogPath = "JailbreakVisionV3/.logs/" .. ExecutionTime .. ".log"

function WriteLog.Write(Content)
	Content = "[" .. os.date("%X") .. "] " .. Content .. "\n"

	if not isfile(LogPath) then
		writefile(LogPath, Content)
	else
		appendfile(LogPath, Content)
	end
end

return WriteLog
