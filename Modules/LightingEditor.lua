local LightingEditor = {}

function LightingEditor.importLighting(TargetPreset)
    local PresetName = string.gsub(TargetPreset, "JailbreakVisionV3/LightingEditor\\", "")
    if isfile("JailbreakVisionV3/LightingEditor/" .. PresetName) then
        print("JailbreakVisionV3/LightingEditor/" .. PresetName)
        for i, v in next, game:GetService("Lighting"):GetChildren() do
            v:Destroy()
        end
        local Preset = game:GetObjects(getasset("JailbreakVisionV3/LightingEditor/" .. PresetName))[1]
        Preset.Parent = game:GetService("Lighting")
        for i,v in pairs(Preset:GetChildren()) do
            v.Parent = game:GetService("Lighting")
        end
        Preset:Destroy()
        print("Success")
    end
end

return LightingEditor