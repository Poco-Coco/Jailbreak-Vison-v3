local EngineModifier = {}

function EngineModifier.ImportElectric(Sound)
    local GetLocalVehiclePacket = require(ReplicatedStorage.Vehicle.VehicleUtils).GetLocalVehiclePacket
    local VehiclePacket = GetLocalVehiclePacket() or {}
    local SoundName = string.gsub(Sound, "JailbreakVisionV3/EngineModifier\\", "")
    if isfile("JailbreakVisionV3/EngineModifier/" .. IdleName .. "/Idle.mp3") then
        VehiclePacket.Sounds.Idle.SoundId = getasset("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/Idle.mp3")
    end
end
    
function EngineModifier.ImportEngine(Sound)
    local SoundName = string.gsub(Sound, "JailbreakVisionV3/EngineModifier\\", "")
    local GetLocalVehiclePacket = require(ReplicatedStorage.Vehicle.VehicleUtils).GetLocalVehiclePacket
    local VehiclePacket = GetLocalVehiclePacket() or {}
    for i,v in next, VehiclePacket.Sounds do
        if i == "Idle" then
            if isfile("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/Idle.mp3") then
                VehiclePacket.Sounds.Idle.SoundId = getasset("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/Idle.mp3")
            end
        elseif i == "OffLow" then
            if isfile("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OffLow.mp3") then
                VehiclePacket.Sounds.OffLow.SoundId = getasset("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OffLow.mp3")
            end
        elseif i == "OnLow" then
            if isfile("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OnLow.mp3") then
                VehiclePacket.Sounds.OnLow.SoundId = getasset("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OnLow.mp3")
            end
        elseif i == "OnMid" then
            if isfile("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OnMid.mp3") then
                VehiclePacket.Sounds.OnMid.SoundId = getasset("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OnMid.mp3")
            end
        elseif i == "OnHigh" then
            if isfile("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OnHigh.mp3") then
                VehiclePacket.Sounds.OnHigh.SoundId = getasset("JailbreakVisionV3/EngineModifier/" .. SoundName .. "/OnHigh.mp3")
            end
        end
    end
end

return EngineModifier