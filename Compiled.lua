JailbreakVisionV3 = {Create = {
Create = function()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Create = {}

local CutSceneService = import("Modules/CutScene/CutSceneService.lua")
local Library = import("Modules/UiLibrary/Lib.lua")
local Streaming = import("Functions/Streaming.lua")
local PlayerRing = import("Functions/PlayerRing.lua")
local Morph = import("Functions/Morph.lua")

selfSettings.Library = Library
local Signal = import("Modules/Signal.lua")
local ModelImporter = import("Modules/ModelImporter.lua")
local LightingEditor = import("Modules/LightingEditor.lua")
local EngineModifier = import("Modules/EngineModifier.lua")

local CutSceneFolder = Instance.new("Folder")
CutSceneFolder.Parent = Workspace
CutSceneFolder.Name = "CutSceneFolder"

loadstring(game:HttpGet("https://raw.githubusercontent.com/Loco-Poco/FreeCam/main/FreeCamera.lua"))()
getgenv().freeCamera = true
getgenv().freeCamMouse = true

Library:SetTheme({
	Main = Color3.fromRGB(45, 45, 45),
	Secondary = Color3.fromRGB(31, 31, 31),
	Tertiary = Color3.fromRGB(31, 31, 31),
	Text = Color3.fromRGB(255, 255, 255),
	PlaceholderText = Color3.fromRGB(175, 175, 175),
	Textbox = Color3.fromRGB(61, 61, 61),
	NavBar = Color3.fromRGB(35, 35, 35),
	Theme = Color3.fromRGB(232, 202, 35),
})

local function decodeCFrame(CFrameString)
	local splitString = string.split(CFrameString, ",")
	local newCFrame = CFrame.new(
		splitString[1],
		splitString[2],
		splitString[3],
		splitString[4],
		splitString[5],
		splitString[6],
		splitString[7],
		splitString[8],
		splitString[9],
		splitString[10],
		splitString[11],
		splitString[12]
	)
	return newCFrame
end

if not LPH_OBFUSCATED then
	lgVarsTbl = {}
	lgVarsTbl["scriptName"] = "Hidden for developer"
	lgVarsTbl["hoursRemaining"] = "Hidden for developer"
	lgVarsTbl["DiscordId"] = "Hidden for developer"
	lgVarsTbl["DiscordUsername"] = "Hidden for developer"
	lgVarsTbl["key_id"] = "Hidden for developer"
	lgVarsTbl["HWID"] = "Hidden for developer"
end

Library:ForceNotify({
	Name = "User Policy",
	Text = "Checking user policy state.",
	Icon = "rbxassetid://11401835376",
	Duration = 3,
})

task.wait(3)

local log = {
	warnin = 0,
	err = 0,
}

local Agree = HttpService:JSONDecode(readfile("JailbreakVisionV3/Settings/UsePolicy.pem")).agree

if not Agree then
	Library:UserAgreement()

	repeat
		task.wait()
	until HttpService:JSONDecode(readfile("JailbreakVisionV3/Settings/UsePolicy.pem")).agree
end

Library:ForceNotify({
	Name = "User Policy",
	Text = "Policy agreed, loading script now!",
	Icon = "rbxassetid://11401835376",
	Duration = 3,
})

if KRNL_LOADED then
	Library:ForceNotify({
		Name = "KRNL",
		Text = "Detected KRNL as your exectuor, be aware that KRNL is not fully supported.",
		Icon = "rbxassetid://11401835376",
		Duration = 3,
	})
end

task.wait(2)

function Create.CreateUI()
	if game.PlaceId == 606849621 then
		for i, v in next, getgc(true) do
			if type(v) == "table" and rawget(v, "MAX_DIST_TO_LOAD") then
				setreadonly(v, false)

				v.MAX_DIST_TO_LOAD = 9e9
			end
		end

		local suc, err = pcall(function()
			local MongoStore = import("Modules/Database/MongoDB.lua")
			MongoStore:Authorize("", "")

			Library:Notify({
				Name = "DB Manager",
				Text = "Successfully connected to the databse!",
				Icon = "rbxassetid://11401835376",
				Duration = 3,
			})
		end)

		if not suc then
			Library:Notify({
				Name = "DB Manager",
				Text = "Unable to connect to the databse!",
				Icon = "rbxassetid://11401835376",
				Duration = 3,
			})
		end

		local Window = Library:Create({
			Name = "Jailbreak Vision V3",
			Footer = "By Loco, SamiRozen, Anson",
			ToggleKey = Enum.KeyCode.K,
		})

		-- Create Signals
		local HideAllUi = Signal.new("HideAllUi")
		local UnHideAllUi = Signal.new("UnHideAllUi")
		local makeForza = Signal.new("makeForza")
		local destroyForza = Signal.new("destroyForza")

		-- Unused Signals
		Signal.new("EnterVehicle")
		Signal.new("ExitVehicle")
		Signal.new("PlayerJoin")
		Signal.new("PlayerLeave")

		-- Loading handlers
		local VehicleData = import("Functions/VehicleData.lua")
		local GameUI = import("Functions/GameUI.lua")
		local ForzaUI = import("Modules/forzaUI.lua")

		VehicleData.init()
		GameUI.init()
		ForzaUI.init()

		-- Info Tab
		do
			local Tab = Window:Tab({
				Name = "Info Tab",
				Icon = "rbxassetid://12823896596",
				Color = Color3.new(0.254901, 1, 0.352941),
			})

			if lgVarsTbl then
				local InfoSection = Tab:Section({
					Name = "Info",
				})

				local scriptName = tostring(lgVarsTbl["scriptName"])
				local hoursRemaining = tostring(lgVarsTbl["hoursRemaining"])
				local DiscordId = tostring(lgVarsTbl["DiscordId"])
				local DiscordUsername = tostring(lgVarsTbl["DiscordUsername"])
				local uniqueKeyId = tostring(lgVarsTbl["key_id"])
				local HardwareId = tostring(lgVarsTbl["HWID"])

				InfoSection:Label({
					Name = 'Script Name: <font color="rgb(87, 255, 115)">'
						.. scriptName
						.. '\n</font>Hours Remaining: <font color="rgb(87, 255, 115)">'
						.. hoursRemaining
						.. '\n</font>Discord ID: <font color="rgb(87, 255, 115)">'
						.. DiscordId
						.. '\n</font>Discord Username: <font color="rgb(87, 255, 115)">'
						.. DiscordUsername
						.. '\n</font>KeyId: <font color="rgb(87, 255, 115)">'
						.. uniqueKeyId
						.. '\n</font>HWID: <font color="rgb(87, 255, 115)">'
						.. HardwareId
						.. "</font>",
				})
			end

			local UserPolicySection = Tab:Section({
				Name = "User Policy",
			})

			UserPolicySection:Label({
				Name = v3UserPolicy,
			})
		end

		-- Visual Tab
		do
			local Tab = Window:Tab({
				Name = "Visual",
				Icon = "rbxassetid://12910867309",
				Color = Color3.new(0.368627, 0.360784, 1),
			})

			local ForzaSection = Tab:Section({
				Name = "Forza Speedometer",
			})

			local fhType = nil
			local fhEnable = false

			ForzaSection:Dropdown({
				Name = "Forza Speedometer Type",
				Items = { "Mech8K", "Mech10K", "Mech12K" },
				Callback = function(item)
					fhType = item

					if fhEnable then
						selfSettings.forzaType = fhType
						makeForza:Fire()
					end
				end,
			})

			ForzaSection:Toggle({
				Name = "Enable Forza Speedometer",
				Default = false,
				Callback = function(Bool)
					fhEnable = Bool

					if Bool then
						selfSettings.forzaType = fhType
						makeForza:Fire()
					else
						selfSettings.forzaType = nil
						destroyForza:Fire()
					end
				end,
			})

			local UISection = Tab:Section({
				Name = "User Interface",
			})

			UISection:Toggle({
				Name = "Hide all UIs",
				Default = false,
				Callback = function(Bool)
					if Bool then
						HideAllUi:Fire()
					else
						UnHideAllUi:Fire()
					end
				end,
			})

			UISection:Toggle({
				Name = "Hide all user billboard guis",
				Default = false,
				Callback = function(Bool)
					GameUI.HideUserNames(Bool)
				end,
			})

			local StreamingSection = Tab:Section({
				Name = "Content Streaming",
			})

			StreamingSection:Button({
				Name = "Stream In All Content",
				Callback = function()
					local t, index = Streaming.StreamAll()

					Library:Notify({
						Name = "Finished!",
						Text = "Time Taken: " .. t .. "s",
						Icon = "rbxassetid://11401835376",
						Duration = 5,
					})
				end,
			})
		end

		-- CutScene System
		do
			local TimeLineData
			local JsonHolder
			local CutSceneDuration

			local function decodeCFrame(CFrameString)
				local splitString = string.split(CFrameString, ",")
				local newCFrame = CFrame.new(
					splitString[1],
					splitString[2],
					splitString[3],
					splitString[4],
					splitString[5],
					splitString[6],
					splitString[7],
					splitString[8],
					splitString[9],
					splitString[10],
					splitString[11],
					splitString[12]
				)
				return newCFrame
			end

			local Tab = Window:Tab({
				Name = "Camera CutScene",
				Icon = "rbxassetid://12988784483",
				Color = Color3.new(0.905882, 0.772549, 0.003921),
			})

			local EditorSection = Tab:Section({
				Name = "Timeline Editor",
			})

			EditorSection:Toggle({
				Name = "Enable Freecam Mouse Icon",
				Default = false,
				Callback = function(Bool)
					getgenv().freeCamMouse = Bool
				end,
			})

			local PointsFolder = Instance.new("Folder", Workspace)
			PointsFolder.Name = "Points"

			local CutScene = {
				Style = "Spline",
				Data = {},
				Duration = 10,
			}

			local function extractFirstValue(tbl)
				if tbl[0] ~= nil then
					return tbl[0], 0
				else
					return tbl[1], 1
				end
			end

			EditorSection:Button({
				Name = "Create Timeline Editor",
				Callback = function()
					Library:TimeLineEditor({
						FinishCallback = function(Points, Interpretation)
							CutScene.Style = Interpretation
							local Data = {}

							for i, v in next, PointsFolder:GetChildren() do
								v:Destroy()
							end

							local NewPoints = {}

							local firstpoint = extractFirstValue(Points)
							local lastpoint = Points[#Points]

							table.insert(NewPoints, firstpoint)

							for i, v in next, Points do
								table.insert(NewPoints, v)
							end

							table.insert(NewPoints, lastpoint)

							for i, v in next, NewPoints do
								local Point = Instance.new("Part", PointsFolder)
								Point.Name = i
								Point.CFrame = decodeCFrame(v)
								Point.Shape = Enum.PartType.Ball
								Point.Size = Vector3.new(3, 3, 3)
								Point.Color = Color3.fromRGB(252, 230, 107)
								Point.Material = Enum.Material.Neon
								Point.Transparency = 0.5
								Point.Anchored = true
								Point.CanCollide = false
								Point.BottomSurface = Enum.SurfaceType.Smooth
								Point.TopSurface = Enum.SurfaceType.Smooth
								Point.Locked = true
								Point.CastShadow = false

								Data[i] = Point
							end

							CutScene.Data = Data

							local CloneData = CutScene.Data
							local TempPointsFolder = Instance.new("Folder")

							for i, v in next, CloneData do
								pt = v:Clone()
								pt.Parent = TempPointsFolder
							end

							CutSceneService.render(Data, Interpretation, TempPointsFolder)

							task.spawn(function()
								CutSceneService.derender(Data, Interpretation)
							end)

							task.spawn(function()
								for i, v in next, PointsFolder:GetChildren() do
									local Info = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									TweenService:Create(v, Info, { Transparency = 1 }):Play()
								end
							end)

							JsonHolder:SetText(HttpService:JSONEncode(Points))
						end,
						UpdatePointCallback = function(Points, Interpretation)
							CutScene.Style = Interpretation
							local Data = {}

							for i, v in next, PointsFolder:GetChildren() do
								v:Destroy()
							end

							local NewPoints = {}

							local firstpoint = extractFirstValue(Points)
							local lastpoint = Points[#Points]

							table.insert(NewPoints, firstpoint)

							for i, v in next, Points do
								table.insert(NewPoints, v)
							end

							table.insert(NewPoints, lastpoint)

							for i, v in next, NewPoints do
								local Point = Instance.new("Part", PointsFolder)
								Point.Name = i
								Point.CFrame = decodeCFrame(v)
								Point.Shape = Enum.PartType.Ball
								Point.Size = Vector3.new(3, 3, 3)
								Point.Color = Color3.fromRGB(252, 230, 107)
								Point.Material = Enum.Material.Neon
								Point.Transparency = 0.35
								Point.Anchored = true
								Point.CanCollide = false
								Point.BottomSurface = Enum.SurfaceType.Smooth
								Point.TopSurface = Enum.SurfaceType.Smooth
								Point.Locked = true
								Point.CastShadow = false

								Data[i] = Point
							end

							CutScene.Data = Data

							local CloneData = CutScene.Data
							local TempPointsFolder = Instance.new("Folder")

							for i, v in next, CloneData do
								pt = v:Clone()
								pt.Parent = TempPointsFolder
							end

							CutSceneService.render(Data, Interpretation, TempPointsFolder)
							JsonHolder:SetText(HttpService:JSONEncode(Points))
						end,
					})
				end,
			})

			JsonHolder = EditorSection:BigTextbox({
				Name = "Timeline JSON",
				Default = "",
				PlaceHolderText = "SceneData | JSON",
				ResetOnFocus = false,
				Callback = function(Text)
					local success = pcall(function()
						local Points = HttpService:JSONDecode(Text)
						local Data = {}

						for i, v in next, PointsFolder:GetChildren() do
							v:Destroy()
						end

						local NewPoints = {}

						local firstpoint = extractFirstValue(Points)
						local lastpoint = Points[#Points]

						table.insert(NewPoints, firstpoint)

						for i, v in next, Points do
							table.insert(NewPoints, v)
						end

						table.insert(NewPoints, lastpoint)

						for i, v in next, NewPoints do
							local Point = Instance.new("Part", PointsFolder)
							Point.Name = i
							Point.CFrame = decodeCFrame(v)
							Point.Shape = Enum.PartType.Ball
							Point.Size = Vector3.new(3, 3, 3)
							Point.Color = Color3.fromRGB(252, 230, 107)
							Point.Material = Enum.Material.Neon
							Point.Transparency = 0.5
							Point.Anchored = true
							Point.CanCollide = false
							Point.BottomSurface = Enum.SurfaceType.Smooth
							Point.TopSurface = Enum.SurfaceType.Smooth
							Point.Locked = true
							Point.CastShadow = false

							Data[i] = Point
						end

						CutScene.Data = Data

						local CloneData = CutScene.Data
						local TempPointsFolder = Instance.new("Folder")

						for i, v in next, CloneData do
							pt = v:Clone()
							pt.Parent = TempPointsFolder
						end

						CutSceneService.render(Data, CutScene.Style, TempPointsFolder)

						task.wait(8)

						task.spawn(function()
							CutSceneService.derender()
						end)

						task.spawn(function()
							for i, v in next, PointsFolder:GetChildren() do
								local Info = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
								TweenService:Create(v, Info, { Transparency = 1 }):Play()
							end
						end)
					end)

					if not success then
						Library:Notify({
							Name = "Timeline Editor",
							Text = "Invalid JSON",
							Icon = "rbxassetid://11401835376",
							Duration = 3,
						})
					end
				end,
			})

			local PlaybackSection = Tab:Section({
				Name = "Playback",
			})

			PlaybackSection:Slider({
				Name = "CutScene Duration",
				Max = 60,
				Min = 1,
				Default = 10,
				Callback = function(Number)
					CutScene.Duration = Number
				end,
			})

			PlaybackSection:Dropdown({
				Name = "Playback Interpretation",
				Items = { "Spline", "Cubic" },
				Callback = function(item)
					CutScene.Style = item
				end,
			})

			PlaybackSection:Keybind({
				Name = "Playback Keybind",
				Default = Enum.KeyCode.LeftBracket,
				Callback = function()
					local success, error = pcall(function()
						local CloneData = CutScene.Data
						local TempPointsFolder = Instance.new("Folder")

						for i, v in next, CloneData do
							pt = v:Clone()
							pt.Parent = TempPointsFolder
						end

						CutSceneService.play(CloneData, CutScene.Style, CutScene.Duration, TempPointsFolder)
						task.wait(1)
						TempPointsFolder:Destroy()
					end)

					if not success then
						Library:Notify({
							Name = "Error!",
							Text = error,
							Icon = "rbxassetid://11401835376",
							Duration = 5,
						})
					end
				end,
				UpdateKeyCallback = function(Key)
					Library:Notify({
						Name = "Playback Keybind Updated!",
						Text = tostring(Key),
						Icon = "rbxassetid://11401835376",
						Duration = 3,
					})
				end,
			})
		end

		-- Terrain Tab
		do
			local Materials = {
				"WoodPlanks",
				"Basalt",
				"Slate",
				"CrackedLava",
				"Concrete",
				"Limestone",
				"Pavement",
				"Brick",
				"Cobblestone",
				"Rock",
				"Sandstone",
				"Grass",
				"LeafyGrass",
				"Sand",
				"Snow",
				"Mud",
				"Ground",
				"Asphalt",
				"Salt",
				"Ice",
				"Glacier",
			}

			local TerrainTab = Window:Tab({
				Name = "Terrain",
				Icon = "rbxassetid://13209280972",
				Color = Color3.new(0.266666, 0.847058, 0.392156),
				ActivationCallback = function()
					Library:Popup({
						Name = "DANGER!",
						Text = "The system has detected that this particular tab poses a potential security risk. Utilizing its functions may result in the suspension of your account. It is advised to use an alt account to avoid any adverse consequences.",
						Options = { "Ok" },
					})
				end,
			})

			local TerrainSec = TerrainTab:Section({
				Name = "Terrain Recolor",
			})

			TerrainSec:Colorpicker({
				Name = "Water", -- String
				DefaultColor = game:GetService("Workspace").Terrain.WaterColor, -- Color3
				Callback = function(Color)
					game:GetService("Workspace").Terrain.WaterColor = Color
				end,
			})

			for i, v in next, Materials do
				TerrainSec:Colorpicker({
					Name = tostring(v), -- String
					DefaultColor = game:GetService("Workspace").Terrain:GetMaterialColor(Enum.Material[v]), -- Color3
					Callback = function(Color)
						game:GetService("Workspace").Terrain:SetMaterialColor(Enum.Material[v], Color)
					end,
				})
			end
		end

		-- Model Importer
		do
			local ModelImportSettings = {
				mapImportMap = "Nil",
				MapImportMode = 1,
				ImportAssetID = { "" },
			}

			local ImportTab = Window:Tab({
				Name = "Model Importer",
				Icon = "rbxassetid://12988752403",
				Color = Color3.new(0.882352, 0, 1),
				ActivationCallback = function()
					print("Model tab activated ")
					Library:Popup({
						Name = "DANGER!",
						Text = "The system has detected that this particular tab poses a potential security risk. Utilizing its functions may result in the suspension of your account. It is advised to use an alt account to avoid any adverse consequences.",
						Options = { "Ok" },
					})
				end,
			})

			local ImportSection = ImportTab:Section({
				Name = "Import",
			})

			ImportSection:Dropdown({
				Name = "Importer Settings",
				Items = { "Local Files", "Roblox Asset ID" },
				Callback = function(item)
					if item == "Local Files" then
						ModelImportSettings.MapImportMode = 1
					else
						ModelImportSettings.MapImportMode = 2
					end
				end,
			})

			ImportSection:SmallTextbox({
				Name = "Asset ID",
				Default = "ID",
				Callback = function(Text)
					ModelImportSettings.ImportAssetID = text
					return
				end,
			})

			local ImportSelction = ImportSection:Dropdown({
				Name = "Import Select",
				Items = listfiles("JailbreakVisionV3/MapEditor"),
				Callback = function(item)
					ModelImportSettings.mapImportMap = item
					print(item)
				end,
			})

			ImportSection:Button({
				Name = "Import",
				Callback = function()
					if ModelImportSettings.MapImportMode == 1 then
						ModelImporter.importMap(ModelImportSettings.mapImportMap)
					else
						ModelImporter.assetImportMap(ModelImportSettings.ImportAssetID)
					end
				end,
			})

			ImportSection:Button({
				Name = "Refresh",
				Callback = function()
					ImportSelction:UpdateList({
						Items = listfiles("JailbreakVisionV3/MapEditor"),
						Replace = true,
					})
				end,
			})
		end

		-- Lighting Editor
		do
			local LightingEditorSettings = {
				SelectedPreset = "nil",
			}

			local LightingTab = Window:Tab({
				Name = "Lighting Editor",
				Icon = "rbxassetid://14592100137",
				Color = Color3.new(1, 0.733333, 0),
			})

			local LightingSection = LightingTab:Section({
				Name = "Lighting Editor",
			})

			local PresetSelector = LightingSection:Dropdown({
				Name = "Preset Select",
				Items = listfiles("JailbreakVisionV3/LightingEditor"),
				Callback = function(item)
					LightingEditorSettings.SelectedPreset = item
				end,
			})

			LightingSection:Button({
				Name = "Import",
				Callback = function()
					LightingEditor.importLighting(LightingEditorSettings.SelectedPreset)
				end,
			})

			LightingSection:Button({
				Name = "Refresh",
				Callback = function()
					PresetSelector:UpdateList({
						Items = listfiles("JailbreakVisionV3/LightingEditor"),
						Replace = true,
					})
				end,
			})
		end
		-- Engine Modifier
		do
			local EngineModifierSettings = {
				SelectedFolder = "nil",
			}

			local SoundTab = Window:Tab({
				Name = "Engine Modifier",
				Icon = "rbxassetid://14649969154",
				Color = Color3.new(0.168627, 0.588235, 0.564705),
			})

			local SoundSec = SoundTab:Section({
				Name = "Engine Modifier",
			})

			local FolderSelector = SoundSec:Dropdown({
				Name = "Preset Select",
				Items = listfiles("JailbreakVisionV3/EngineModifier"),
				Callback = function(item)
					EngineModifierSettings.SelectedFolder = item
				end,
			})

			SoundSec:Button({
				Name = "Import",
				Callback = function()
					local GetLocalVehiclePacket = require(ReplicatedStorage.Vehicle.VehicleUtils).GetLocalVehiclePacket
					local VehiclePacket = GetLocalVehiclePacket() or {}
					if VehiclePacket.SoundType == "Electric" then
						EngineModifier.ImportElectric(EngineModifierSettings.SelectedFolder)
					else
						EngineModifier.ImportEngine(EngineModifierSettings.SelectedFolder)
					end
				end,
			})

			SoundSec:Button({
				Name = "Refresh",
				Callback = function()
					FolderSelector:UpdateList({
						Items = listfiles("JailbreakVisionV3/EngineModifier"),
						Replace = true,
					})
				end,
			})
		end

		-- Speed Test Tab
		do
			local SpeedtestSettings = {
				Scene = nil,
				Duration = 60,
				Mode = "Forwards",
			}

			local Tab = Window:Tab({
				Name = "Dyno Speedtest",
				Icon = "rbxassetid://13209278369",
				Color = Color3.new(1, 0, 0),
				ActivationCallback = function()
					Library:Popup({
						Name = "DANGER!",
						Text = "The system has detected that this particular tab poses a potential security risk. Utilizing its functions may result in the suspension of your account. It is advised to use an alt account to avoid any adverse consequences.",
						Options = { "Ok" },
					})
				end,
			})

			local LoaderSection = Tab:Section({
				Name = "Custom Speedtest Scene",
			})

			local SceneSelction = LoaderSection:Dropdown({
				Name = "Import Select",
				Items = listfiles("JailbreakVisionV3/SpeedtestScenes"),
				Callback = function(item)
					SpeedtestSettings.Scene = item
				end,
			})

			LoaderSection:Button({
				Name = "Refresh",
				Callback = function()
					SceneSelction:UpdateList({
						Items = listfiles("JailbreakVisionV3/SpeedtestScenes"),
						Replace = true,
					})
				end,
			})

			local SpeedtestSec = Tab:Section({
				Name = "Speedtest",
			})

			SpeedtestSec:Dropdown({
				Name = "Duration",
				Items = { 30, 60 },
				Callback = function(item)
					SpeedtestSettings.Duration = item
				end,
			})

			SpeedtestSec:Dropdown({
				Name = "Mode",
				Items = { "Forwards", "Reverse" },
				Callback = function(item)
					SpeedtestSettings.Mode = item
				end,
			})

			SpeedtestSec:Button({
				Name = "Start Speedtest",
				Callback = function()
					SpeedtestStart(SpeedtestSettings.Scene, SpeedtestSettings.Duration, SpeedtestSettings.Mode)
				end,
			})
		end

		-- Magic Tab
		do
			local Tab = Window:Tab({
				Name = "Magic Tab",
				Icon = "rbxassetid://13120101304",
				Color = Color3.new(0.419607, 0.231372, 0.858823),
			})

			local DescriptionSection = Tab:Section({
				Name = "Description",
			})

			DescriptionSection:Label({
				Name = "This tab simply exist because it can :D",
			})

			local MagicSection = Tab:Section({
				Name = "Wizardry - Abracadabra!!",
			})

			MagicSection:Toggle({
				Name = "Player Rings",
				Default = false,
				Callback = function(Bool)
					if Bool then
						PlayerRing.start()
					else
						PlayerRing.stop()
					end
				end,
			})

			local MorphData = {
				Username = "",
				Target = Players.LocalPlayer,
			}

			local MorphSection = Tab:Section({
				Name = "Morph",
			})

			local MorphTarget = MorphSection:Dropdown({
				Name = "Target",
				Items = { Players.LocalPlayer },
				Callback = function(item)
					MorphData.Target = item
				end,
			})

			MorphSection:BigTextbox({
				Name = "Morph Target",
				Default = "",
				PlaceHolderText = "String | Username",
				ResetOnFocus = false,
				Callback = function(Text)
					MorphData.Username = Text
				end,
			})

			MorphSection:Button({
				Name = "Submit",
				Callback = function()
					Morph.Run(MorphData.Target, Players:GetUserIdFromNameAsync(MorphData.Username))
				end,
			})

			MorphSection:Button({
				Name = "Reload Target List",
				Callback = function()
					MorphTarget:UpdateList({
						Items = Players:GetChildren(),
						Replace = true,
					})
				end,
			})

			for i, v in next, Players:GetChildren() do
				if v.Name ~= Players.LocalPlayer.Name then
					MorphTarget:AddItem(v)
				end
			end
		end

		-- v2 Loader
		do
			local Tab = Window:Tab({
				Name = "Script Loader",
				Icon = "rbxassetid://12705903132",
				Color = Color3.new(0, 0.682352, 1),
			})

			local LoaderSection = Tab:Section({
				Name = "Loaders",
			})

			LoaderSection:Button({
				Name = "Load Jailbreak Vision v2",
				Callback = function()
					local JbvV2Loader = import("Modules/JbvV2Loader.lua")

					JbvV2Loader.Load()
				end,
			})

			LoaderSection:Button({
				Name = "Load PayPal Importer",
				Callback = function()
					loadstring(
						game:HttpGet("https://raw.githubusercontent.com/HazeWasTaken/PayPal_Importer/main/Compiled.lua")
					)()
				end,
			})
		end

		-- Debug Tab
		do
			local Tab = Window:Tab({
				Name = "Debug Tab",
				Icon = "rbxassetid://12988744896",
				Color = Color3.new(0.733333, 0.231372, 0.231372),
			})

			local Catcher = {
				Notify = true,
			}

			local CatcherSection = Tab:Section({
				Name = "Catcher",
			})

			local LogsLabel = CatcherSection:Label({
				Name = ' Errors Caught: <font color="rgb(232, 32, 32)">'
					.. log.err
					.. '\n</font>Warnings Caught: <font color="rgb(252, 173, 3)">'
					.. log.warnin
					.. "</font>",
			})

			CatcherSection:Toggle({
				Name = "Enable catcher notification",
				Default = true,
				Callback = function(Bool)
					Catcher.Notify = Bool
				end,
			})

			local LatestErrorSection = Tab:Section({
				Name = "Latest Error",
			})

			local LatestError = LatestErrorSection:Label({
				Name = "None",
			})

			local WriteLogService = import("Modules/WriteLog.lua")

			local function MessageOut(message, messageType)
				if messageType == 2 or messageType == 3 then
					if messageType == 2 then
						log.warnin = log.warnin + 1
					elseif messageType == 3 then
						log.err = log.err + 1
					end

					LogsLabel:SetName(
						' Errors Caught: <font color="rgb(232, 32, 32)">'
							.. log.err
							.. '\n</font>Warnings Caught: <font color="rgb(252, 173, 3)">'
							.. log.warnin
							.. "</font>"
					)

					WriteLogService.Write(message)
					LatestError:SetName(message)
				end
			end

			task.spawn(function()
				LogService.ServerMessageOut:Connect(MessageOut)

				game:GetService("ScriptContext").ErrorDetailed:Connect(function(message)
					MessageOut(message, 3)

					if Catcher.Notify then
						Library:ForceNotify({
							Name = "Error Caught!",
							Text = message,
							Icon = "rbxassetid://11401835376",
							Duration = 3,
						})
					end
				end)
			end)
		end

		-- Settings
		do
			local Tab = Window:Tab({
				Name = "Settings",
				Icon = "rbxassetid://11476626403",
				Color = Color3.new(0.6, 0.6, 0.6),
			})

			local MiscSection = Tab:Section({
				Name = "Miscs",
			})

			MiscSection:Toggle({
				Name = "Darkmode",
				Default = true,
				Callback = function(Bool)
					if Bool then
						Library:SetTheme({
							Main = Color3.fromRGB(45, 45, 45),
							Secondary = Color3.fromRGB(31, 31, 31),
							Tertiary = Color3.fromRGB(31, 31, 31),
							Text = Color3.fromRGB(255, 255, 255),
							PlaceholderText = Color3.fromRGB(175, 175, 175),
							Textbox = Color3.fromRGB(61, 61, 61),
							NavBar = Color3.fromRGB(35, 35, 35),
							Theme = Color3.fromRGB(232, 202, 35),
						})
					else
						Library:SetTheme({
							Main = Color3.fromRGB(238, 238, 238),
							Secondary = Color3.fromRGB(194, 194, 194),
							Tertiary = Color3.fromRGB(163, 163, 163),
							Text = Color3.fromRGB(0, 0, 0),
							PlaceholderText = Color3.fromRGB(15, 15, 15),
							Textbox = Color3.fromRGB(255, 255, 255),
							NavBar = Color3.fromRGB(239, 239, 239),
							Theme = Color3.fromRGB(232, 55, 55),
						})
					end
				end,
			})

			MiscSection:Slider({
				Name = "SFX Volume",
				Max = 100,
				Min = 1,
				Default = 50,
				Callback = function(Number)
					Library:SetVolume(Number)
				end,
			})

			MiscSection:Slider({
				Name = "UI DragSpeed",
				Max = 100,
				Min = 1,
				Default = 7,
				Callback = function(Number)
					Library:SetDragSpeed(Number)
				end,
			})

			MiscSection:Button({
				Name = "Hide UI",
				Callback = function()
					Window:Toggled(false)
				end,
			})

			MiscSection:Button({
				Name = "Task Bar Only",
				Callback = function()
					Window:TaskBarOnly(true)
				end,
			})

			MiscSection:Keybind({
				Name = "Playback Keybind",
				Default = Enum.KeyCode.K,
				Callback = function()
					return
				end,
				UpdateKeyCallback = function(Key)
					Window:ChangeTogglekey(Key)
				end,
			})

			MiscSection:Button({
				Name = "Destroy library",
				Callback = function()
					Library:Destroy()
				end,
			})
		end
	end
end

return Create

end,
},
Functions = {
GameUI = function()
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

end,
Morph = function()
local Players = game:GetService("Players")
local Morph = {}

function Morph.Run(Target, UserId)
	local appearance = Players:GetCharacterAppearanceAsync(UserId)

	for i, v in pairs(Target.Character:GetChildren()) do
		if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") or v:IsA("BodyColors") then
			v:Destroy()
		end
	end

	if Target.Character.Head:FindFirstChild("face") then
		Target.Character.Head.face:Destroy()
	end

	for i, v in pairs(appearance:GetChildren()) do
		if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
			v.Parent = Target.Character
		elseif v:IsA("Accessory") then
			Target.Character.Humanoid:AddAccessory(v)
		elseif v.Name == "R6" then
			if Target.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
				v:FindFirstChildOfClass("CharacterMesh").Parent = Target.Character
			end
		elseif v.Name == "R15" then
			if Target.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
				v:FindFirstChildOfClass("CharacterMesh").Parent = Target.Character
			end
		end
	end

	if appearance:FindFirstChild("face") then
		appearance.face.Parent = Target.Character.Head
	else
		local face = Instance.new("Decal")
		face.Face = "Front"
		face.Name = "face"
		face.Texture = "rbxasset://textures/face.png"
		face.Transparency = 0
		face.Parent = Target.Character.Head
	end

	local parent = Target.Character.Parent
	Target.Character.Parent = nil
	Target.Character.Parent = parent

	--[[
    Target.Character.Animate.fall.FallAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).FallAnimation
	Target.Character.Animate.run.RunAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).RunAnimation
	Target.Character.Animate.climb.ClimbAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).ClimbAnimation
	Target.Character.Animate.idle.Animation1.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).IdleAnimation
	Target.Character.Animate.jump["!ID!"].AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).JumpAnimation
	Target.Character.Animate.mood.Animation1.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).MoodAnimation
	Target.Character.Animate.swim.Swim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).SwimAnimation
	Target.Character.Animate.walk.WalkAnim.AnimationId = "rbxassetid://"..Players:GetHumanoidDescriptionFromUserId(UserId).WalkAnimation
    ]]
	--
end

return Morph

end,
PlayerHandler = function()
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

end,
PlayerRing = function()
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Signal = import("Modules/Signal.lua")
local PlayerRing = {}

local function makeRing()
	local Ring = game:GetObjects("rbxassetid://13120474439")[1]
	Ring.Parent = Workspace

	return Ring
end

local Enabled = false

local function initRing(ringPlayer, Ring)
	while not ringPlayer.Character do
		RunService.RenderStepped:Wait()
	end

	local PlayerLeave = Signal.Get("PlayerLeave")

	local RootPart = ringPlayer.Character:FindFirstChild("HumanoidRootPart")
	local rayParam = RaycastParams.new()

	local MoveRingRS

	local list = {}
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Character then
			table.insert(list, v.Character)
		end
	end

	table.insert(list, Workspace.Vehicles)
	table.insert(list, Ring)
	table.insert(list, ringPlayer.Character)

	rayParam.FilterType = Enum.RaycastFilterType.Blacklist
	rayParam.FilterDescendantsInstances = list

	local effect1 = Ring:FindFirstChild("Effect  1")
	local effect2 = Ring:FindFirstChild("Effect  2")
	local pointlight = Ring:FindFirstChild("SurfaceLight")

	local lightColor = ringPlayer.TeamColor.Color
	local teamColorSeq = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, lightColor),
		ColorSequenceKeypoint.new(1.000, lightColor),
	})

	MoveRingRS = RunService.RenderStepped:Connect(function()
		pcall(function()
			if not Enabled then
				MoveRingRS:Disconnect()
				Ring:Destroy()
			end

			lightColor = ringPlayer.TeamColor.Color

			teamColorSeq = ColorSequence.new({
				ColorSequenceKeypoint.new(0.000, lightColor),
				ColorSequenceKeypoint.new(1.000, lightColor),
			})

			effect1.Color = teamColorSeq
			effect2.Color = teamColorSeq
			pointlight.Color = lightColor

			if RootPart and RootPart.Parent then
				local castedRay = Workspace:Raycast(RootPart.CFrame.Position, Vector3.yAxis * -2e2, rayParam)

				if castedRay then
					local intersect = castedRay.Normal
					local upVector = intersect:Cross(Vector3.xAxis).Unit
					Ring.CFrame = Ring.CFrame:Lerp(
						CFrame.lookAt(castedRay.Position, castedRay.Position + intersect, upVector)
							* CFrame.Angles(math.rad(90), 0, 0)
							* CFrame.new(0, -0.7, 0),
						0.6
					)
				end
			end
		end)
	end)

	PlayerLeave:Connect(function(leftPlayer)
		if leftPlayer.Name == ringPlayer.Name then
			MoveRingRS:Disconnect()
			Ring:Destroy()
		end
	end)
end

local function giveRings()
	for i, v in next, Players:GetPlayers() do
		local selfRing = makeRing()

		initRing(v, selfRing)
	end

	return
end

function PlayerRing.start()
	Enabled = true
	giveRings()

	return
end

function PlayerRing.stop()
	Enabled = false

	return
end

function PlayerRing.init()
	local PlayerJoin = Signal.Get("PlayerJoin")

	PlayerJoin:Connect(function(player)
		if Enabled then
			local selfRing = makeRing()
			initRing(player, selfRing)
		end
	end)

	return
end

return PlayerRing

end,
SpeedTestDB = function()
local SpTDB = {}
local MongoStore = import("Modules/Database/MongoDB.lua")
local DataStore = MongoStore:GetDataStore("DataStore", "SpeedTestData")

function SpTDB:Write()
	return
end

return SpTDB

end,
Streaming = function()
local Streaming = {
	Enabled = true,
}

local function createGrid()
	local Model = {}

	Model["Model0"] = Instance.new("Model")
	Model["Part1"] = Instance.new("Part")
	Model["Part2"] = Instance.new("Part")
	Model["Part3"] = Instance.new("Part")
	Model["Part4"] = Instance.new("Part")
	Model["Part5"] = Instance.new("Part")
	Model["Part6"] = Instance.new("Part")
	Model["Part7"] = Instance.new("Part")
	Model["Part8"] = Instance.new("Part")
	Model["Part9"] = Instance.new("Part")
	Model["Part10"] = Instance.new("Part")
	Model["Part11"] = Instance.new("Part")
	Model["Part12"] = Instance.new("Part")
	Model["Part13"] = Instance.new("Part")
	Model["Part14"] = Instance.new("Part")
	Model["Part15"] = Instance.new("Part")
	Model["Part16"] = Instance.new("Part")
	Model["Part17"] = Instance.new("Part")
	Model["Part18"] = Instance.new("Part")
	Model["Part19"] = Instance.new("Part")
	Model["Part20"] = Instance.new("Part")
	Model["Part21"] = Instance.new("Part")
	Model["Part22"] = Instance.new("Part")
	Model["Part23"] = Instance.new("Part")
	Model["Part24"] = Instance.new("Part")
	Model["Part25"] = Instance.new("Part")
	Model["Part26"] = Instance.new("Part")
	Model["Part27"] = Instance.new("Part")
	Model["Part28"] = Instance.new("Part")
	Model["Part29"] = Instance.new("Part")
	Model["Part30"] = Instance.new("Part")
	Model["Part31"] = Instance.new("Part")
	Model["Part32"] = Instance.new("Part")
	Model["Part33"] = Instance.new("Part")
	Model["Part34"] = Instance.new("Part")
	Model["Part35"] = Instance.new("Part")
	Model["Part36"] = Instance.new("Part")
	Model["Part37"] = Instance.new("Part")
	Model["Part38"] = Instance.new("Part")
	Model["Part39"] = Instance.new("Part")
	Model["Part40"] = Instance.new("Part")
	Model["Part41"] = Instance.new("Part")
	Model["Part42"] = Instance.new("Part")
	Model["Part43"] = Instance.new("Part")
	Model["Part44"] = Instance.new("Part")
	Model["Part45"] = Instance.new("Part")
	Model["Part46"] = Instance.new("Part")
	Model["Part47"] = Instance.new("Part")
	Model["Part48"] = Instance.new("Part")
	Model["Part49"] = Instance.new("Part")
	Model["Part50"] = Instance.new("Part")
	Model["Part51"] = Instance.new("Part")
	Model["Part52"] = Instance.new("Part")
	Model["Part53"] = Instance.new("Part")
	Model["Part54"] = Instance.new("Part")
	Model["Part55"] = Instance.new("Part")
	Model["Part56"] = Instance.new("Part")
	Model["Part57"] = Instance.new("Part")
	Model["Part58"] = Instance.new("Part")
	Model["Part59"] = Instance.new("Part")
	Model["Part60"] = Instance.new("Part")
	Model["Part61"] = Instance.new("Part")
	Model["Part62"] = Instance.new("Part")
	Model["Part63"] = Instance.new("Part")
	Model["Part64"] = Instance.new("Part")
	Model["Part65"] = Instance.new("Part")
	Model["Part66"] = Instance.new("Part")
	Model["Part67"] = Instance.new("Part")
	Model["Part68"] = Instance.new("Part")
	Model["Part69"] = Instance.new("Part")
	Model["Part70"] = Instance.new("Part")
	Model["Part71"] = Instance.new("Part")
	Model["Part72"] = Instance.new("Part")
	Model["Part73"] = Instance.new("Part")
	Model["Part74"] = Instance.new("Part")
	Model["Part75"] = Instance.new("Part")
	Model["Part76"] = Instance.new("Part")
	Model["Part77"] = Instance.new("Part")
	Model["Part78"] = Instance.new("Part")
	Model["Part79"] = Instance.new("Part")
	Model["Part80"] = Instance.new("Part")
	Model["Part81"] = Instance.new("Part")
	Model["Part82"] = Instance.new("Part")
	Model["Part83"] = Instance.new("Part")
	Model["Part84"] = Instance.new("Part")
	Model["Part85"] = Instance.new("Part")
	Model["Part86"] = Instance.new("Part")
	Model["Part87"] = Instance.new("Part")
	Model["Part88"] = Instance.new("Part")
	Model["Part89"] = Instance.new("Part")
	Model["Part90"] = Instance.new("Part")
	Model["Part91"] = Instance.new("Part")
	Model["Part92"] = Instance.new("Part")
	Model["Part93"] = Instance.new("Part")
	Model["Part94"] = Instance.new("Part")
	Model["Part95"] = Instance.new("Part")
	Model["Part96"] = Instance.new("Part")
	Model["Part97"] = Instance.new("Part")
	Model["Part98"] = Instance.new("Part")
	Model["Part99"] = Instance.new("Part")
	Model["Part100"] = Instance.new("Part")
	Model["Part101"] = Instance.new("Part")
	Model["Part102"] = Instance.new("Part")
	Model["Part103"] = Instance.new("Part")
	Model["Part104"] = Instance.new("Part")
	Model["Part105"] = Instance.new("Part")
	Model["Part106"] = Instance.new("Part")
	Model["Part107"] = Instance.new("Part")
	Model["Part108"] = Instance.new("Part")
	Model["Part109"] = Instance.new("Part")
	Model["Part110"] = Instance.new("Part")
	Model["Part111"] = Instance.new("Part")
	Model["Part112"] = Instance.new("Part")
	Model["Part113"] = Instance.new("Part")
	Model["Part114"] = Instance.new("Part")
	Model["Part115"] = Instance.new("Part")
	Model["Part116"] = Instance.new("Part")
	Model["Part117"] = Instance.new("Part")
	Model["Part118"] = Instance.new("Part")
	Model["Part119"] = Instance.new("Part")
	Model["Part120"] = Instance.new("Part")
	Model["Part121"] = Instance.new("Part")
	Model["Part122"] = Instance.new("Part")
	Model["Part123"] = Instance.new("Part")
	Model["Part124"] = Instance.new("Part")
	Model["Part125"] = Instance.new("Part")
	Model["Part126"] = Instance.new("Part")
	Model["Part127"] = Instance.new("Part")
	Model["Part128"] = Instance.new("Part")
	Model["Part129"] = Instance.new("Part")
	Model["Part130"] = Instance.new("Part")
	Model["Part131"] = Instance.new("Part")
	Model["Part132"] = Instance.new("Part")
	Model["Part133"] = Instance.new("Part")
	Model["Part134"] = Instance.new("Part")
	Model["Part135"] = Instance.new("Part")
	Model["Part136"] = Instance.new("Part")
	Model["Part137"] = Instance.new("Part")
	Model["Part138"] = Instance.new("Part")
	Model["Part139"] = Instance.new("Part")
	Model["Part140"] = Instance.new("Part")
	Model["Part141"] = Instance.new("Part")
	Model["Part142"] = Instance.new("Part")
	Model["Part143"] = Instance.new("Part")
	Model["Part144"] = Instance.new("Part")
	Model["Part145"] = Instance.new("Part")
	Model["Part146"] = Instance.new("Part")
	Model["Part147"] = Instance.new("Part")
	Model["Part148"] = Instance.new("Part")
	Model["Part149"] = Instance.new("Part")
	Model["Part150"] = Instance.new("Part")
	Model["Part151"] = Instance.new("Part")
	Model["Part152"] = Instance.new("Part")
	Model["Part153"] = Instance.new("Part")
	Model["Part154"] = Instance.new("Part")
	Model["Part155"] = Instance.new("Part")
	Model["Part156"] = Instance.new("Part")
	Model["Part157"] = Instance.new("Part")
	Model["Part158"] = Instance.new("Part")
	Model["Part159"] = Instance.new("Part")
	Model["Part160"] = Instance.new("Part")
	Model["Part161"] = Instance.new("Part")
	Model["Part162"] = Instance.new("Part")
	Model["Part163"] = Instance.new("Part")
	Model["Part164"] = Instance.new("Part")
	Model["Part165"] = Instance.new("Part")
	Model["Part166"] = Instance.new("Part")
	Model["Part167"] = Instance.new("Part")
	Model["Part168"] = Instance.new("Part")
	Model["Part169"] = Instance.new("Part")
	Model["Part170"] = Instance.new("Part")
	Model["Part171"] = Instance.new("Part")
	Model["Part172"] = Instance.new("Part")
	Model["Part173"] = Instance.new("Part")
	Model["Part174"] = Instance.new("Part")
	Model["Part175"] = Instance.new("Part")
	Model["Part176"] = Instance.new("Part")
	Model["Part177"] = Instance.new("Part")
	Model["Part178"] = Instance.new("Part")
	Model["Part179"] = Instance.new("Part")
	Model["Part180"] = Instance.new("Part")
	Model["Part181"] = Instance.new("Part")
	Model["Part182"] = Instance.new("Part")
	Model["Part183"] = Instance.new("Part")
	Model["Part184"] = Instance.new("Part")
	Model["Part185"] = Instance.new("Part")
	Model["Part186"] = Instance.new("Part")
	Model["Part187"] = Instance.new("Part")
	Model["Part188"] = Instance.new("Part")
	Model["Part189"] = Instance.new("Part")
	Model["Part190"] = Instance.new("Part")
	Model["Part191"] = Instance.new("Part")
	Model["Part192"] = Instance.new("Part")
	Model["Part193"] = Instance.new("Part")
	Model["Part194"] = Instance.new("Part")
	Model["Part195"] = Instance.new("Part")
	Model["Part196"] = Instance.new("Part")
	Model["Part197"] = Instance.new("Part")
	Model["Part198"] = Instance.new("Part")
	Model["Part199"] = Instance.new("Part")
	Model["Part200"] = Instance.new("Part")
	Model["Part201"] = Instance.new("Part")
	Model["Part202"] = Instance.new("Part")
	Model["Part203"] = Instance.new("Part")
	Model["Part204"] = Instance.new("Part")
	Model["Part205"] = Instance.new("Part")
	Model["Part206"] = Instance.new("Part")
	Model["Part207"] = Instance.new("Part")
	Model["Part208"] = Instance.new("Part")
	Model["Part209"] = Instance.new("Part")
	Model["Part210"] = Instance.new("Part")
	Model["Part211"] = Instance.new("Part")
	Model["Part212"] = Instance.new("Part")
	Model["Part213"] = Instance.new("Part")
	Model["Part214"] = Instance.new("Part")
	Model["Part215"] = Instance.new("Part")
	Model["Part216"] = Instance.new("Part")
	Model["Part217"] = Instance.new("Part")
	Model["Part218"] = Instance.new("Part")
	Model["Part219"] = Instance.new("Part")
	Model["Part220"] = Instance.new("Part")
	Model["Part221"] = Instance.new("Part")
	Model["Part222"] = Instance.new("Part")
	Model["Part223"] = Instance.new("Part")
	Model["Part224"] = Instance.new("Part")
	Model["Part225"] = Instance.new("Part")
	Model["Part226"] = Instance.new("Part")
	Model["Part227"] = Instance.new("Part")
	Model["Part228"] = Instance.new("Part")
	Model["Part229"] = Instance.new("Part")
	Model["Part230"] = Instance.new("Part")
	Model["Part231"] = Instance.new("Part")
	Model["Part232"] = Instance.new("Part")
	Model["Part233"] = Instance.new("Part")
	Model["Part234"] = Instance.new("Part")
	Model["Part235"] = Instance.new("Part")
	Model["Part236"] = Instance.new("Part")
	Model["Part237"] = Instance.new("Part")
	Model["Part238"] = Instance.new("Part")
	Model["Part239"] = Instance.new("Part")
	Model["Part240"] = Instance.new("Part")
	Model["Part241"] = Instance.new("Part")
	Model["Part242"] = Instance.new("Part")
	Model["Part243"] = Instance.new("Part")
	Model["Part244"] = Instance.new("Part")
	Model["Part245"] = Instance.new("Part")
	Model["Part246"] = Instance.new("Part")
	Model["Part247"] = Instance.new("Part")
	Model["Part248"] = Instance.new("Part")
	Model["Part249"] = Instance.new("Part")
	Model["Part250"] = Instance.new("Part")
	Model["Part251"] = Instance.new("Part")
	Model["Part252"] = Instance.new("Part")
	Model["Part253"] = Instance.new("Part")
	Model["Part254"] = Instance.new("Part")
	Model["Part255"] = Instance.new("Part")
	Model["Part256"] = Instance.new("Part")
	Model["Part257"] = Instance.new("Part")
	Model["Part258"] = Instance.new("Part")
	Model["Part259"] = Instance.new("Part")
	Model["Part260"] = Instance.new("Part")
	Model["Part261"] = Instance.new("Part")
	Model["Part262"] = Instance.new("Part")
	Model["Part263"] = Instance.new("Part")
	Model["Part264"] = Instance.new("Part")
	Model["Part265"] = Instance.new("Part")
	Model["Part266"] = Instance.new("Part")
	Model["Part267"] = Instance.new("Part")
	Model["Part268"] = Instance.new("Part")
	Model["Part269"] = Instance.new("Part")
	Model["Part270"] = Instance.new("Part")
	Model["Part271"] = Instance.new("Part")
	Model["Part272"] = Instance.new("Part")
	Model["Part273"] = Instance.new("Part")
	Model["Part274"] = Instance.new("Part")
	Model["Part275"] = Instance.new("Part")
	Model["Part276"] = Instance.new("Part")
	Model["Part277"] = Instance.new("Part")
	Model["Part278"] = Instance.new("Part")
	Model["Part279"] = Instance.new("Part")
	Model["Part280"] = Instance.new("Part")
	Model["Part281"] = Instance.new("Part")
	Model["Part282"] = Instance.new("Part")
	Model["Part283"] = Instance.new("Part")
	Model["Part284"] = Instance.new("Part")
	Model["Part285"] = Instance.new("Part")
	Model["Part286"] = Instance.new("Part")
	Model["Part287"] = Instance.new("Part")
	Model["Part288"] = Instance.new("Part")
	Model["Part289"] = Instance.new("Part")
	Model["Part290"] = Instance.new("Part")
	Model["Part291"] = Instance.new("Part")
	Model["Part292"] = Instance.new("Part")
	Model["Part293"] = Instance.new("Part")
	Model["Part294"] = Instance.new("Part")
	Model["Part295"] = Instance.new("Part")
	Model["Part296"] = Instance.new("Part")
	Model["Part297"] = Instance.new("Part")
	Model["Part298"] = Instance.new("Part")
	Model["Part299"] = Instance.new("Part")
	Model["Part300"] = Instance.new("Part")
	Model["Part301"] = Instance.new("Part")
	Model["Part302"] = Instance.new("Part")
	Model["Part303"] = Instance.new("Part")
	Model["Part304"] = Instance.new("Part")
	Model["Part305"] = Instance.new("Part")
	Model["Part306"] = Instance.new("Part")
	Model["Part307"] = Instance.new("Part")
	Model["Part308"] = Instance.new("Part")
	Model["Part309"] = Instance.new("Part")
	Model["Part310"] = Instance.new("Part")
	Model["Part311"] = Instance.new("Part")
	Model["Part312"] = Instance.new("Part")
	Model["Part313"] = Instance.new("Part")
	Model["Part314"] = Instance.new("Part")
	Model["Part315"] = Instance.new("Part")
	Model["Part316"] = Instance.new("Part")
	Model["Part317"] = Instance.new("Part")
	Model["Part318"] = Instance.new("Part")
	Model["Part319"] = Instance.new("Part")
	Model["Part320"] = Instance.new("Part")
	Model["Part321"] = Instance.new("Part")
	Model["Part322"] = Instance.new("Part")
	Model["Part323"] = Instance.new("Part")
	Model["Part324"] = Instance.new("Part")
	Model["Part325"] = Instance.new("Part")
	Model["Part326"] = Instance.new("Part")
	Model["Part327"] = Instance.new("Part")
	Model["Part328"] = Instance.new("Part")
	Model["Part329"] = Instance.new("Part")
	Model["Part330"] = Instance.new("Part")

	Model["Model0"].Parent = Workspace
	Model["Part1"].Parent = Model["Model0"]
	Model["Part1"].CFrame = CFrame.new(3398.29102, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part1"].Position = Vector3.new(3398.291015625, 85.60882568359375, 3875.9599609375)
	Model["Part1"].Size = Vector3.new(500, 1, 500)
	Model["Part1"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part1"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part2"].Parent = Model["Model0"]
	Model["Part2"].CFrame = CFrame.new(2898.29102, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part2"].Position = Vector3.new(2898.291015625, 85.60882568359375, 3875.9599609375)
	Model["Part2"].Size = Vector3.new(500, 1, 500)
	Model["Part2"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part2"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part3"].Parent = Model["Model0"]
	Model["Part3"].CFrame = CFrame.new(3898.29102, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part3"].Position = Vector3.new(3898.291015625, 85.60882568359375, 3875.9599609375)
	Model["Part3"].Size = Vector3.new(500, 1, 500)
	Model["Part3"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part3"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part4"].Parent = Model["Model0"]
	Model["Part4"].CFrame = CFrame.new(2398.29102, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part4"].Position = Vector3.new(2398.291015625, 85.60882568359375, 3875.9599609375)
	Model["Part4"].Size = Vector3.new(500, 1, 500)
	Model["Part4"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part4"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part5"].Parent = Model["Model0"]
	Model["Part5"].CFrame = CFrame.new(1898.29102, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part5"].Position = Vector3.new(1898.291015625, 85.60882568359375, 3875.9599609375)
	Model["Part5"].Size = Vector3.new(500, 1, 500)
	Model["Part5"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part5"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part6"].Parent = Model["Model0"]
	Model["Part6"].CFrame = CFrame.new(898.291016, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part6"].Position = Vector3.new(898.291015625, 85.60882568359375, 3875.9599609375)
	Model["Part6"].Size = Vector3.new(500, 1, 500)
	Model["Part6"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part6"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part7"].Parent = Model["Model0"]
	Model["Part7"].CFrame = CFrame.new(1398.29102, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part7"].Position = Vector3.new(1398.291015625, 85.60882568359375, 3875.9599609375)
	Model["Part7"].Size = Vector3.new(500, 1, 500)
	Model["Part7"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part7"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part8"].Parent = Model["Model0"]
	Model["Part8"].CFrame = CFrame.new(-2101.70898, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part8"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 3875.9599609375)
	Model["Part8"].Size = Vector3.new(500, 1, 500)
	Model["Part8"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part8"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part9"].Parent = Model["Model0"]
	Model["Part9"].CFrame = CFrame.new(-1601.70898, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part9"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 3875.9599609375)
	Model["Part9"].Size = Vector3.new(500, 1, 500)
	Model["Part9"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part9"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part10"].Parent = Model["Model0"]
	Model["Part10"].CFrame = CFrame.new(-1101.70898, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part10"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 3875.9599609375)
	Model["Part10"].Size = Vector3.new(500, 1, 500)
	Model["Part10"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part10"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part11"].Parent = Model["Model0"]
	Model["Part11"].CFrame = CFrame.new(-601.708984, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part11"].Position = Vector3.new(-601.708984375, 85.60882568359375, 3875.9599609375)
	Model["Part11"].Size = Vector3.new(500, 1, 500)
	Model["Part11"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part11"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part12"].Parent = Model["Model0"]
	Model["Part12"].CFrame = CFrame.new(-101.709015, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part12"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 3875.9599609375)
	Model["Part12"].Size = Vector3.new(500, 1, 500)
	Model["Part12"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part12"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part13"].Parent = Model["Model0"]
	Model["Part13"].CFrame = CFrame.new(398.290985, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part13"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 3875.9599609375)
	Model["Part13"].Size = Vector3.new(500, 1, 500)
	Model["Part13"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part13"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part14"].Parent = Model["Model0"]
	Model["Part14"].CFrame = CFrame.new(-3101.70898, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part14"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 3875.9599609375)
	Model["Part14"].Size = Vector3.new(500, 1, 500)
	Model["Part14"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part14"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part15"].Parent = Model["Model0"]
	Model["Part15"].CFrame = CFrame.new(-2601.70898, 85.6088257, 3875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part15"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 3875.9599609375)
	Model["Part15"].Size = Vector3.new(500, 1, 500)
	Model["Part15"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part15"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part16"].Parent = Model["Model0"]
	Model["Part16"].CFrame = CFrame.new(-2601.70898, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part16"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 3375.9599609375)
	Model["Part16"].Size = Vector3.new(500, 1, 500)
	Model["Part16"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part16"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part17"].Parent = Model["Model0"]
	Model["Part17"].CFrame = CFrame.new(-1601.70898, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part17"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 3375.9599609375)
	Model["Part17"].Size = Vector3.new(500, 1, 500)
	Model["Part17"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part17"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part18"].Parent = Model["Model0"]
	Model["Part18"].CFrame = CFrame.new(3898.29102, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part18"].Position = Vector3.new(3898.291015625, 85.60882568359375, 3375.9599609375)
	Model["Part18"].Size = Vector3.new(500, 1, 500)
	Model["Part18"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part18"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part19"].Parent = Model["Model0"]
	Model["Part19"].CFrame = CFrame.new(-1101.70898, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part19"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 3375.9599609375)
	Model["Part19"].Size = Vector3.new(500, 1, 500)
	Model["Part19"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part19"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part20"].Parent = Model["Model0"]
	Model["Part20"].CFrame = CFrame.new(1398.29102, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part20"].Position = Vector3.new(1398.291015625, 85.60882568359375, 3375.9599609375)
	Model["Part20"].Size = Vector3.new(500, 1, 500)
	Model["Part20"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part20"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part21"].Parent = Model["Model0"]
	Model["Part21"].CFrame = CFrame.new(1898.29102, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part21"].Position = Vector3.new(1898.291015625, 85.60882568359375, 3375.9599609375)
	Model["Part21"].Size = Vector3.new(500, 1, 500)
	Model["Part21"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part21"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part22"].Parent = Model["Model0"]
	Model["Part22"].CFrame = CFrame.new(398.290985, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part22"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 3375.9599609375)
	Model["Part22"].Size = Vector3.new(500, 1, 500)
	Model["Part22"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part22"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part23"].Parent = Model["Model0"]
	Model["Part23"].CFrame = CFrame.new(-2101.70898, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part23"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 3375.9599609375)
	Model["Part23"].Size = Vector3.new(500, 1, 500)
	Model["Part23"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part23"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part24"].Parent = Model["Model0"]
	Model["Part24"].CFrame = CFrame.new(-3101.70898, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part24"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 3375.9599609375)
	Model["Part24"].Size = Vector3.new(500, 1, 500)
	Model["Part24"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part24"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part25"].Parent = Model["Model0"]
	Model["Part25"].CFrame = CFrame.new(2898.29102, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part25"].Position = Vector3.new(2898.291015625, 85.60882568359375, 3375.9599609375)
	Model["Part25"].Size = Vector3.new(500, 1, 500)
	Model["Part25"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part25"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part26"].Parent = Model["Model0"]
	Model["Part26"].CFrame = CFrame.new(3398.29102, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part26"].Position = Vector3.new(3398.291015625, 85.60882568359375, 3375.9599609375)
	Model["Part26"].Size = Vector3.new(500, 1, 500)
	Model["Part26"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part26"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part27"].Parent = Model["Model0"]
	Model["Part27"].CFrame = CFrame.new(898.291016, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part27"].Position = Vector3.new(898.291015625, 85.60882568359375, 3375.9599609375)
	Model["Part27"].Size = Vector3.new(500, 1, 500)
	Model["Part27"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part27"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part28"].Parent = Model["Model0"]
	Model["Part28"].CFrame = CFrame.new(2398.29102, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part28"].Position = Vector3.new(2398.291015625, 85.60882568359375, 3375.9599609375)
	Model["Part28"].Size = Vector3.new(500, 1, 500)
	Model["Part28"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part28"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part29"].Parent = Model["Model0"]
	Model["Part29"].CFrame = CFrame.new(-101.709015, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part29"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 3375.9599609375)
	Model["Part29"].Size = Vector3.new(500, 1, 500)
	Model["Part29"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part29"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part30"].Parent = Model["Model0"]
	Model["Part30"].CFrame = CFrame.new(-601.708984, 85.6088257, 3375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part30"].Position = Vector3.new(-601.708984375, 85.60882568359375, 3375.9599609375)
	Model["Part30"].Size = Vector3.new(500, 1, 500)
	Model["Part30"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part30"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part31"].Parent = Model["Model0"]
	Model["Part31"].CFrame = CFrame.new(898.291016, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part31"].Position = Vector3.new(898.291015625, 85.60882568359375, 2875.9599609375)
	Model["Part31"].Size = Vector3.new(500, 1, 500)
	Model["Part31"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part31"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part32"].Parent = Model["Model0"]
	Model["Part32"].CFrame = CFrame.new(2898.29102, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part32"].Position = Vector3.new(2898.291015625, 85.60882568359375, 2875.9599609375)
	Model["Part32"].Size = Vector3.new(500, 1, 500)
	Model["Part32"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part32"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part33"].Parent = Model["Model0"]
	Model["Part33"].CFrame = CFrame.new(3898.29102, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part33"].Position = Vector3.new(3898.291015625, 85.60882568359375, 2875.9599609375)
	Model["Part33"].Size = Vector3.new(500, 1, 500)
	Model["Part33"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part33"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part34"].Parent = Model["Model0"]
	Model["Part34"].CFrame = CFrame.new(1398.29102, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part34"].Position = Vector3.new(1398.291015625, 85.60882568359375, 2875.9599609375)
	Model["Part34"].Size = Vector3.new(500, 1, 500)
	Model["Part34"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part34"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part35"].Parent = Model["Model0"]
	Model["Part35"].CFrame = CFrame.new(2398.29102, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part35"].Position = Vector3.new(2398.291015625, 85.60882568359375, 2875.9599609375)
	Model["Part35"].Size = Vector3.new(500, 1, 500)
	Model["Part35"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part35"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part36"].Parent = Model["Model0"]
	Model["Part36"].CFrame = CFrame.new(-1601.70898, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part36"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 2875.9599609375)
	Model["Part36"].Size = Vector3.new(500, 1, 500)
	Model["Part36"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part36"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part37"].Parent = Model["Model0"]
	Model["Part37"].CFrame = CFrame.new(1898.29102, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part37"].Position = Vector3.new(1898.291015625, 85.60882568359375, 2875.9599609375)
	Model["Part37"].Size = Vector3.new(500, 1, 500)
	Model["Part37"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part37"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part38"].Parent = Model["Model0"]
	Model["Part38"].CFrame = CFrame.new(-101.709015, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part38"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 2875.9599609375)
	Model["Part38"].Size = Vector3.new(500, 1, 500)
	Model["Part38"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part38"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part39"].Parent = Model["Model0"]
	Model["Part39"].CFrame = CFrame.new(398.290985, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part39"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 2875.9599609375)
	Model["Part39"].Size = Vector3.new(500, 1, 500)
	Model["Part39"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part39"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part40"].Parent = Model["Model0"]
	Model["Part40"].CFrame = CFrame.new(-2601.70898, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part40"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 2875.9599609375)
	Model["Part40"].Size = Vector3.new(500, 1, 500)
	Model["Part40"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part40"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part41"].Parent = Model["Model0"]
	Model["Part41"].CFrame = CFrame.new(-1101.70898, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part41"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 2875.9599609375)
	Model["Part41"].Size = Vector3.new(500, 1, 500)
	Model["Part41"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part41"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part42"].Parent = Model["Model0"]
	Model["Part42"].CFrame = CFrame.new(-2101.70898, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part42"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 2875.9599609375)
	Model["Part42"].Size = Vector3.new(500, 1, 500)
	Model["Part42"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part42"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part43"].Parent = Model["Model0"]
	Model["Part43"].CFrame = CFrame.new(-601.708984, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part43"].Position = Vector3.new(-601.708984375, 85.60882568359375, 2875.9599609375)
	Model["Part43"].Size = Vector3.new(500, 1, 500)
	Model["Part43"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part43"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part44"].Parent = Model["Model0"]
	Model["Part44"].CFrame = CFrame.new(3398.29102, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part44"].Position = Vector3.new(3398.291015625, 85.60882568359375, 2875.9599609375)
	Model["Part44"].Size = Vector3.new(500, 1, 500)
	Model["Part44"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part44"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part45"].Parent = Model["Model0"]
	Model["Part45"].CFrame = CFrame.new(-3101.70898, 85.6088257, 2875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part45"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 2875.9599609375)
	Model["Part45"].Size = Vector3.new(500, 1, 500)
	Model["Part45"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part45"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part46"].Parent = Model["Model0"]
	Model["Part46"].CFrame = CFrame.new(-1101.70898, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part46"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 2375.9599609375)
	Model["Part46"].Size = Vector3.new(500, 1, 500)
	Model["Part46"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part46"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part47"].Parent = Model["Model0"]
	Model["Part47"].CFrame = CFrame.new(1898.29102, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part47"].Position = Vector3.new(1898.291015625, 85.60882568359375, 2375.9599609375)
	Model["Part47"].Size = Vector3.new(500, 1, 500)
	Model["Part47"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part47"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part48"].Parent = Model["Model0"]
	Model["Part48"].CFrame = CFrame.new(3398.29102, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part48"].Position = Vector3.new(3398.291015625, 85.60882568359375, 2375.9599609375)
	Model["Part48"].Size = Vector3.new(500, 1, 500)
	Model["Part48"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part48"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part49"].Parent = Model["Model0"]
	Model["Part49"].CFrame = CFrame.new(-601.708984, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part49"].Position = Vector3.new(-601.708984375, 85.60882568359375, 2375.9599609375)
	Model["Part49"].Size = Vector3.new(500, 1, 500)
	Model["Part49"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part49"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part50"].Parent = Model["Model0"]
	Model["Part50"].CFrame = CFrame.new(2398.29102, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part50"].Position = Vector3.new(2398.291015625, 85.60882568359375, 2375.9599609375)
	Model["Part50"].Size = Vector3.new(500, 1, 500)
	Model["Part50"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part50"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part51"].Parent = Model["Model0"]
	Model["Part51"].CFrame = CFrame.new(-1601.70898, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part51"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 2375.9599609375)
	Model["Part51"].Size = Vector3.new(500, 1, 500)
	Model["Part51"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part51"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part52"].Parent = Model["Model0"]
	Model["Part52"].CFrame = CFrame.new(898.291016, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part52"].Position = Vector3.new(898.291015625, 85.60882568359375, 2375.9599609375)
	Model["Part52"].Size = Vector3.new(500, 1, 500)
	Model["Part52"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part52"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part53"].Parent = Model["Model0"]
	Model["Part53"].CFrame = CFrame.new(1398.29102, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part53"].Position = Vector3.new(1398.291015625, 85.60882568359375, 2375.9599609375)
	Model["Part53"].Size = Vector3.new(500, 1, 500)
	Model["Part53"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part53"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part54"].Parent = Model["Model0"]
	Model["Part54"].CFrame = CFrame.new(-2601.70898, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part54"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 2375.9599609375)
	Model["Part54"].Size = Vector3.new(500, 1, 500)
	Model["Part54"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part54"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part55"].Parent = Model["Model0"]
	Model["Part55"].CFrame = CFrame.new(-2101.70898, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part55"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 2375.9599609375)
	Model["Part55"].Size = Vector3.new(500, 1, 500)
	Model["Part55"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part55"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part56"].Parent = Model["Model0"]
	Model["Part56"].CFrame = CFrame.new(-101.709015, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part56"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 2375.9599609375)
	Model["Part56"].Size = Vector3.new(500, 1, 500)
	Model["Part56"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part56"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part57"].Parent = Model["Model0"]
	Model["Part57"].CFrame = CFrame.new(2898.29102, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part57"].Position = Vector3.new(2898.291015625, 85.60882568359375, 2375.9599609375)
	Model["Part57"].Size = Vector3.new(500, 1, 500)
	Model["Part57"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part57"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part58"].Parent = Model["Model0"]
	Model["Part58"].CFrame = CFrame.new(-3101.70898, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part58"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 2375.9599609375)
	Model["Part58"].Size = Vector3.new(500, 1, 500)
	Model["Part58"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part58"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part59"].Parent = Model["Model0"]
	Model["Part59"].CFrame = CFrame.new(3898.29102, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part59"].Position = Vector3.new(3898.291015625, 85.60882568359375, 2375.9599609375)
	Model["Part59"].Size = Vector3.new(500, 1, 500)
	Model["Part59"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part59"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part60"].Parent = Model["Model0"]
	Model["Part60"].CFrame = CFrame.new(398.290985, 85.6088257, 2375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part60"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 2375.9599609375)
	Model["Part60"].Size = Vector3.new(500, 1, 500)
	Model["Part60"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part60"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part61"].Parent = Model["Model0"]
	Model["Part61"].CFrame = CFrame.new(-601.708984, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part61"].Position = Vector3.new(-601.708984375, 85.60882568359375, 1875.9599609375)
	Model["Part61"].Size = Vector3.new(500, 1, 500)
	Model["Part61"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part61"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part62"].Parent = Model["Model0"]
	Model["Part62"].CFrame = CFrame.new(1898.29102, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part62"].Position = Vector3.new(1898.291015625, 85.60882568359375, 1875.9599609375)
	Model["Part62"].Size = Vector3.new(500, 1, 500)
	Model["Part62"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part62"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part63"].Parent = Model["Model0"]
	Model["Part63"].CFrame = CFrame.new(898.291016, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part63"].Position = Vector3.new(898.291015625, 85.60882568359375, 1875.9599609375)
	Model["Part63"].Size = Vector3.new(500, 1, 500)
	Model["Part63"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part63"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part64"].Parent = Model["Model0"]
	Model["Part64"].CFrame = CFrame.new(-1101.70898, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part64"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 1875.9599609375)
	Model["Part64"].Size = Vector3.new(500, 1, 500)
	Model["Part64"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part64"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part65"].Parent = Model["Model0"]
	Model["Part65"].CFrame = CFrame.new(1398.29102, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part65"].Position = Vector3.new(1398.291015625, 85.60882568359375, 1875.9599609375)
	Model["Part65"].Size = Vector3.new(500, 1, 500)
	Model["Part65"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part65"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part66"].Parent = Model["Model0"]
	Model["Part66"].CFrame = CFrame.new(2898.29102, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part66"].Position = Vector3.new(2898.291015625, 85.60882568359375, 1875.9599609375)
	Model["Part66"].Size = Vector3.new(500, 1, 500)
	Model["Part66"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part66"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part67"].Parent = Model["Model0"]
	Model["Part67"].CFrame = CFrame.new(3898.29102, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part67"].Position = Vector3.new(3898.291015625, 85.60882568359375, 1875.9599609375)
	Model["Part67"].Size = Vector3.new(500, 1, 500)
	Model["Part67"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part67"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part68"].Parent = Model["Model0"]
	Model["Part68"].CFrame = CFrame.new(-2601.70898, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part68"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 1875.9599609375)
	Model["Part68"].Size = Vector3.new(500, 1, 500)
	Model["Part68"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part68"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part69"].Parent = Model["Model0"]
	Model["Part69"].CFrame = CFrame.new(398.290985, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part69"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 1875.9599609375)
	Model["Part69"].Size = Vector3.new(500, 1, 500)
	Model["Part69"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part69"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part70"].Parent = Model["Model0"]
	Model["Part70"].CFrame = CFrame.new(3398.29102, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part70"].Position = Vector3.new(3398.291015625, 85.60882568359375, 1875.9599609375)
	Model["Part70"].Size = Vector3.new(500, 1, 500)
	Model["Part70"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part70"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part71"].Parent = Model["Model0"]
	Model["Part71"].CFrame = CFrame.new(-3101.70898, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part71"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 1875.9599609375)
	Model["Part71"].Size = Vector3.new(500, 1, 500)
	Model["Part71"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part71"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part72"].Parent = Model["Model0"]
	Model["Part72"].CFrame = CFrame.new(-2101.70898, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part72"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 1875.9599609375)
	Model["Part72"].Size = Vector3.new(500, 1, 500)
	Model["Part72"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part72"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part73"].Parent = Model["Model0"]
	Model["Part73"].CFrame = CFrame.new(-1601.70898, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part73"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 1875.9599609375)
	Model["Part73"].Size = Vector3.new(500, 1, 500)
	Model["Part73"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part73"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part74"].Parent = Model["Model0"]
	Model["Part74"].CFrame = CFrame.new(2398.29102, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part74"].Position = Vector3.new(2398.291015625, 85.60882568359375, 1875.9599609375)
	Model["Part74"].Size = Vector3.new(500, 1, 500)
	Model["Part74"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part74"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part75"].Parent = Model["Model0"]
	Model["Part75"].CFrame = CFrame.new(-101.709015, 85.6088257, 1875.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part75"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 1875.9599609375)
	Model["Part75"].Size = Vector3.new(500, 1, 500)
	Model["Part75"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part75"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part76"].Parent = Model["Model0"]
	Model["Part76"].CFrame = CFrame.new(2398.29102, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part76"].Position = Vector3.new(2398.291015625, 85.60882568359375, 1375.9599609375)
	Model["Part76"].Size = Vector3.new(500, 1, 500)
	Model["Part76"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part76"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part77"].Parent = Model["Model0"]
	Model["Part77"].CFrame = CFrame.new(1398.29102, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part77"].Position = Vector3.new(1398.291015625, 85.60882568359375, 1375.9599609375)
	Model["Part77"].Size = Vector3.new(500, 1, 500)
	Model["Part77"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part77"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part78"].Parent = Model["Model0"]
	Model["Part78"].CFrame = CFrame.new(3398.29102, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part78"].Position = Vector3.new(3398.291015625, 85.60882568359375, 1375.9599609375)
	Model["Part78"].Size = Vector3.new(500, 1, 500)
	Model["Part78"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part78"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part79"].Parent = Model["Model0"]
	Model["Part79"].CFrame = CFrame.new(-3101.70898, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part79"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 1375.9599609375)
	Model["Part79"].Size = Vector3.new(500, 1, 500)
	Model["Part79"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part79"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part80"].Parent = Model["Model0"]
	Model["Part80"].CFrame = CFrame.new(-1101.70898, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part80"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 1375.9599609375)
	Model["Part80"].Size = Vector3.new(500, 1, 500)
	Model["Part80"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part80"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part81"].Parent = Model["Model0"]
	Model["Part81"].CFrame = CFrame.new(898.291016, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part81"].Position = Vector3.new(898.291015625, 85.60882568359375, 1375.9599609375)
	Model["Part81"].Size = Vector3.new(500, 1, 500)
	Model["Part81"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part81"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part82"].Parent = Model["Model0"]
	Model["Part82"].CFrame = CFrame.new(2898.29102, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part82"].Position = Vector3.new(2898.291015625, 85.60882568359375, 1375.9599609375)
	Model["Part82"].Size = Vector3.new(500, 1, 500)
	Model["Part82"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part82"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part83"].Parent = Model["Model0"]
	Model["Part83"].CFrame = CFrame.new(1898.29102, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part83"].Position = Vector3.new(1898.291015625, 85.60882568359375, 1375.9599609375)
	Model["Part83"].Size = Vector3.new(500, 1, 500)
	Model["Part83"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part83"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part84"].Parent = Model["Model0"]
	Model["Part84"].CFrame = CFrame.new(-101.709015, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part84"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 1375.9599609375)
	Model["Part84"].Size = Vector3.new(500, 1, 500)
	Model["Part84"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part84"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part85"].Parent = Model["Model0"]
	Model["Part85"].CFrame = CFrame.new(-601.708984, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part85"].Position = Vector3.new(-601.708984375, 85.60882568359375, 1375.9599609375)
	Model["Part85"].Size = Vector3.new(500, 1, 500)
	Model["Part85"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part85"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part86"].Parent = Model["Model0"]
	Model["Part86"].CFrame = CFrame.new(398.290985, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part86"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 1375.9599609375)
	Model["Part86"].Size = Vector3.new(500, 1, 500)
	Model["Part86"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part86"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part87"].Parent = Model["Model0"]
	Model["Part87"].CFrame = CFrame.new(-2601.70898, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part87"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 1375.9599609375)
	Model["Part87"].Size = Vector3.new(500, 1, 500)
	Model["Part87"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part87"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part88"].Parent = Model["Model0"]
	Model["Part88"].CFrame = CFrame.new(-2101.70898, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part88"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 1375.9599609375)
	Model["Part88"].Size = Vector3.new(500, 1, 500)
	Model["Part88"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part88"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part89"].Parent = Model["Model0"]
	Model["Part89"].CFrame = CFrame.new(-1601.70898, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part89"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 1375.9599609375)
	Model["Part89"].Size = Vector3.new(500, 1, 500)
	Model["Part89"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part89"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part90"].Parent = Model["Model0"]
	Model["Part90"].CFrame = CFrame.new(3898.29102, 85.6088257, 1375.95996, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part90"].Position = Vector3.new(3898.291015625, 85.60882568359375, 1375.9599609375)
	Model["Part90"].Size = Vector3.new(500, 1, 500)
	Model["Part90"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part90"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part91"].Parent = Model["Model0"]
	Model["Part91"].CFrame = CFrame.new(-101.709015, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part91"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 875.9599609375)
	Model["Part91"].Size = Vector3.new(500, 1, 500)
	Model["Part91"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part91"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part92"].Parent = Model["Model0"]
	Model["Part92"].CFrame = CFrame.new(-601.708984, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part92"].Position = Vector3.new(-601.708984375, 85.60882568359375, 875.9599609375)
	Model["Part92"].Size = Vector3.new(500, 1, 500)
	Model["Part92"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part92"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part93"].Parent = Model["Model0"]
	Model["Part93"].CFrame = CFrame.new(898.291016, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part93"].Position = Vector3.new(898.291015625, 85.60882568359375, 875.9599609375)
	Model["Part93"].Size = Vector3.new(500, 1, 500)
	Model["Part93"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part93"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part94"].Parent = Model["Model0"]
	Model["Part94"].CFrame = CFrame.new(-2101.70898, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part94"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 875.9599609375)
	Model["Part94"].Size = Vector3.new(500, 1, 500)
	Model["Part94"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part94"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part95"].Parent = Model["Model0"]
	Model["Part95"].CFrame = CFrame.new(-3101.70898, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part95"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 875.9599609375)
	Model["Part95"].Size = Vector3.new(500, 1, 500)
	Model["Part95"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part95"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part96"].Parent = Model["Model0"]
	Model["Part96"].CFrame = CFrame.new(3398.29102, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part96"].Position = Vector3.new(3398.291015625, 85.60882568359375, 875.9599609375)
	Model["Part96"].Size = Vector3.new(500, 1, 500)
	Model["Part96"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part96"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part97"].Parent = Model["Model0"]
	Model["Part97"].CFrame = CFrame.new(3898.29102, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part97"].Position = Vector3.new(3898.291015625, 85.60882568359375, 875.9599609375)
	Model["Part97"].Size = Vector3.new(500, 1, 500)
	Model["Part97"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part97"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part98"].Parent = Model["Model0"]
	Model["Part98"].CFrame = CFrame.new(-2601.70898, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part98"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 875.9599609375)
	Model["Part98"].Size = Vector3.new(500, 1, 500)
	Model["Part98"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part98"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part99"].Parent = Model["Model0"]
	Model["Part99"].CFrame = CFrame.new(1398.29102, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part99"].Position = Vector3.new(1398.291015625, 85.60882568359375, 875.9599609375)
	Model["Part99"].Size = Vector3.new(500, 1, 500)
	Model["Part99"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part99"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part100"].Parent = Model["Model0"]
	Model["Part100"].CFrame = CFrame.new(2398.29102, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part100"].Position = Vector3.new(2398.291015625, 85.60882568359375, 875.9599609375)
	Model["Part100"].Size = Vector3.new(500, 1, 500)
	Model["Part100"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part100"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part101"].Parent = Model["Model0"]
	Model["Part101"].CFrame = CFrame.new(2898.29102, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part101"].Position = Vector3.new(2898.291015625, 85.60882568359375, 875.9599609375)
	Model["Part101"].Size = Vector3.new(500, 1, 500)
	Model["Part101"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part101"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part102"].Parent = Model["Model0"]
	Model["Part102"].CFrame = CFrame.new(-1101.70898, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part102"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 875.9599609375)
	Model["Part102"].Size = Vector3.new(500, 1, 500)
	Model["Part102"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part102"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part103"].Parent = Model["Model0"]
	Model["Part103"].CFrame = CFrame.new(398.290985, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part103"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 875.9599609375)
	Model["Part103"].Size = Vector3.new(500, 1, 500)
	Model["Part103"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part103"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part104"].Parent = Model["Model0"]
	Model["Part104"].CFrame = CFrame.new(-1601.70898, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part104"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 875.9599609375)
	Model["Part104"].Size = Vector3.new(500, 1, 500)
	Model["Part104"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part104"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part105"].Parent = Model["Model0"]
	Model["Part105"].CFrame = CFrame.new(1898.29102, 85.6088257, 875.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part105"].Position = Vector3.new(1898.291015625, 85.60882568359375, 875.9599609375)
	Model["Part105"].Size = Vector3.new(500, 1, 500)
	Model["Part105"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part105"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part106"].Parent = Model["Model0"]
	Model["Part106"].CFrame = CFrame.new(3398.29102, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part106"].Position = Vector3.new(3398.291015625, 85.60882568359375, 375.9599609375)
	Model["Part106"].Size = Vector3.new(500, 1, 500)
	Model["Part106"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part106"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part107"].Parent = Model["Model0"]
	Model["Part107"].CFrame = CFrame.new(-2101.70898, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part107"].Position = Vector3.new(-2101.708984375, 85.60882568359375, 375.9599609375)
	Model["Part107"].Size = Vector3.new(500, 1, 500)
	Model["Part107"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part107"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part108"].Parent = Model["Model0"]
	Model["Part108"].CFrame = CFrame.new(1898.29102, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part108"].Position = Vector3.new(1898.291015625, 85.60882568359375, 375.9599609375)
	Model["Part108"].Size = Vector3.new(500, 1, 500)
	Model["Part108"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part108"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part109"].Parent = Model["Model0"]
	Model["Part109"].CFrame = CFrame.new(1398.29102, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part109"].Position = Vector3.new(1398.291015625, 85.60882568359375, 375.9599609375)
	Model["Part109"].Size = Vector3.new(500, 1, 500)
	Model["Part109"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part109"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part110"].Parent = Model["Model0"]
	Model["Part110"].CFrame = CFrame.new(2398.29102, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part110"].Position = Vector3.new(2398.291015625, 85.60882568359375, 375.9599609375)
	Model["Part110"].Size = Vector3.new(500, 1, 500)
	Model["Part110"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part110"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part111"].Parent = Model["Model0"]
	Model["Part111"].CFrame = CFrame.new(-2601.70898, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part111"].Position = Vector3.new(-2601.708984375, 85.60882568359375, 375.9599609375)
	Model["Part111"].Size = Vector3.new(500, 1, 500)
	Model["Part111"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part111"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part112"].Parent = Model["Model0"]
	Model["Part112"].CFrame = CFrame.new(898.291016, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part112"].Position = Vector3.new(898.291015625, 85.60882568359375, 375.9599609375)
	Model["Part112"].Size = Vector3.new(500, 1, 500)
	Model["Part112"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part112"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part113"].Parent = Model["Model0"]
	Model["Part113"].CFrame = CFrame.new(3898.29102, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part113"].Position = Vector3.new(3898.291015625, 85.60882568359375, 375.9599609375)
	Model["Part113"].Size = Vector3.new(500, 1, 500)
	Model["Part113"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part113"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part114"].Parent = Model["Model0"]
	Model["Part114"].CFrame = CFrame.new(398.290985, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part114"].Position = Vector3.new(398.2909851074219, 85.60882568359375, 375.9599609375)
	Model["Part114"].Size = Vector3.new(500, 1, 500)
	Model["Part114"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part114"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part115"].Parent = Model["Model0"]
	Model["Part115"].CFrame = CFrame.new(2898.29102, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part115"].Position = Vector3.new(2898.291015625, 85.60882568359375, 375.9599609375)
	Model["Part115"].Size = Vector3.new(500, 1, 500)
	Model["Part115"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part115"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part116"].Parent = Model["Model0"]
	Model["Part116"].CFrame = CFrame.new(-1601.70898, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part116"].Position = Vector3.new(-1601.708984375, 85.60882568359375, 375.9599609375)
	Model["Part116"].Size = Vector3.new(500, 1, 500)
	Model["Part116"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part116"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part117"].Parent = Model["Model0"]
	Model["Part117"].CFrame = CFrame.new(-101.709015, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part117"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, 375.9599609375)
	Model["Part117"].Size = Vector3.new(500, 1, 500)
	Model["Part117"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part117"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part118"].Parent = Model["Model0"]
	Model["Part118"].CFrame = CFrame.new(-3101.70898, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part118"].Position = Vector3.new(-3101.708984375, 85.60882568359375, 375.9599609375)
	Model["Part118"].Size = Vector3.new(500, 1, 500)
	Model["Part118"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part118"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part119"].Parent = Model["Model0"]
	Model["Part119"].CFrame = CFrame.new(-601.708984, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part119"].Position = Vector3.new(-601.708984375, 85.60882568359375, 375.9599609375)
	Model["Part119"].Size = Vector3.new(500, 1, 500)
	Model["Part119"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part119"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part120"].Parent = Model["Model0"]
	Model["Part120"].CFrame = CFrame.new(-1101.70898, 85.6088257, 375.959961, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part120"].Position = Vector3.new(-1101.708984375, 85.60882568359375, 375.9599609375)
	Model["Part120"].Size = Vector3.new(500, 1, 500)
	Model["Part120"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part120"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part121"].Parent = Model["Model0"]
	Model["Part121"].CFrame = CFrame.new(3398.29102, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part121"].Position = Vector3.new(3398.291015625, 85.60882568359375, -124.0400390625)
	Model["Part121"].Size = Vector3.new(500, 1, 500)
	Model["Part121"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part121"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part122"].Parent = Model["Model0"]
	Model["Part122"].CFrame = CFrame.new(1898.29102, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part122"].Position = Vector3.new(1898.291015625, 85.60882568359375, -124.0400390625)
	Model["Part122"].Size = Vector3.new(500, 1, 500)
	Model["Part122"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part122"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part123"].Parent = Model["Model0"]
	Model["Part123"].CFrame = CFrame.new(-2101.70898, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part123"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -124.0400390625)
	Model["Part123"].Size = Vector3.new(500, 1, 500)
	Model["Part123"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part123"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part124"].Parent = Model["Model0"]
	Model["Part124"].CFrame = CFrame.new(898.291016, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part124"].Position = Vector3.new(898.291015625, 85.60882568359375, -124.0400390625)
	Model["Part124"].Size = Vector3.new(500, 1, 500)
	Model["Part124"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part124"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part125"].Parent = Model["Model0"]
	Model["Part125"].CFrame = CFrame.new(398.290985, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part125"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -124.0400390625)
	Model["Part125"].Size = Vector3.new(500, 1, 500)
	Model["Part125"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part125"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part126"].Parent = Model["Model0"]
	Model["Part126"].CFrame = CFrame.new(1398.29102, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part126"].Position = Vector3.new(1398.291015625, 85.60882568359375, -124.0400390625)
	Model["Part126"].Size = Vector3.new(500, 1, 500)
	Model["Part126"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part126"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part127"].Parent = Model["Model0"]
	Model["Part127"].CFrame = CFrame.new(-1101.70898, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part127"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -124.0400390625)
	Model["Part127"].Size = Vector3.new(500, 1, 500)
	Model["Part127"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part127"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part128"].Parent = Model["Model0"]
	Model["Part128"].CFrame = CFrame.new(-101.709015, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part128"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -124.0400390625)
	Model["Part128"].Size = Vector3.new(500, 1, 500)
	Model["Part128"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part128"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part129"].Parent = Model["Model0"]
	Model["Part129"].CFrame = CFrame.new(3898.29102, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part129"].Position = Vector3.new(3898.291015625, 85.60882568359375, -124.0400390625)
	Model["Part129"].Size = Vector3.new(500, 1, 500)
	Model["Part129"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part129"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part130"].Parent = Model["Model0"]
	Model["Part130"].CFrame = CFrame.new(2398.29102, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part130"].Position = Vector3.new(2398.291015625, 85.60882568359375, -124.0400390625)
	Model["Part130"].Size = Vector3.new(500, 1, 500)
	Model["Part130"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part130"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part131"].Parent = Model["Model0"]
	Model["Part131"].CFrame = CFrame.new(-601.708984, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part131"].Position = Vector3.new(-601.708984375, 85.60882568359375, -124.0400390625)
	Model["Part131"].Size = Vector3.new(500, 1, 500)
	Model["Part131"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part131"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part132"].Parent = Model["Model0"]
	Model["Part132"].CFrame = CFrame.new(2898.29102, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part132"].Position = Vector3.new(2898.291015625, 85.60882568359375, -124.0400390625)
	Model["Part132"].Size = Vector3.new(500, 1, 500)
	Model["Part132"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part132"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part133"].Parent = Model["Model0"]
	Model["Part133"].CFrame = CFrame.new(-1601.70898, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part133"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -124.0400390625)
	Model["Part133"].Size = Vector3.new(500, 1, 500)
	Model["Part133"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part133"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part134"].Parent = Model["Model0"]
	Model["Part134"].CFrame = CFrame.new(-3101.70898, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part134"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -124.0400390625)
	Model["Part134"].Size = Vector3.new(500, 1, 500)
	Model["Part134"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part134"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part135"].Parent = Model["Model0"]
	Model["Part135"].CFrame = CFrame.new(-2601.70898, 85.6088257, -124.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part135"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -124.0400390625)
	Model["Part135"].Size = Vector3.new(500, 1, 500)
	Model["Part135"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part135"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part136"].Parent = Model["Model0"]
	Model["Part136"].CFrame = CFrame.new(-1601.70898, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part136"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -624.0400390625)
	Model["Part136"].Size = Vector3.new(500, 1, 500)
	Model["Part136"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part136"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part137"].Parent = Model["Model0"]
	Model["Part137"].CFrame = CFrame.new(3398.29102, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part137"].Position = Vector3.new(3398.291015625, 85.60882568359375, -624.0400390625)
	Model["Part137"].Size = Vector3.new(500, 1, 500)
	Model["Part137"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part137"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part138"].Parent = Model["Model0"]
	Model["Part138"].CFrame = CFrame.new(3898.29102, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part138"].Position = Vector3.new(3898.291015625, 85.60882568359375, -624.0400390625)
	Model["Part138"].Size = Vector3.new(500, 1, 500)
	Model["Part138"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part138"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part139"].Parent = Model["Model0"]
	Model["Part139"].CFrame = CFrame.new(2898.29102, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part139"].Position = Vector3.new(2898.291015625, 85.60882568359375, -624.0400390625)
	Model["Part139"].Size = Vector3.new(500, 1, 500)
	Model["Part139"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part139"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part140"].Parent = Model["Model0"]
	Model["Part140"].CFrame = CFrame.new(1398.29102, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part140"].Position = Vector3.new(1398.291015625, 85.60882568359375, -624.0400390625)
	Model["Part140"].Size = Vector3.new(500, 1, 500)
	Model["Part140"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part140"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part141"].Parent = Model["Model0"]
	Model["Part141"].CFrame = CFrame.new(-601.708984, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part141"].Position = Vector3.new(-601.708984375, 85.60882568359375, -624.0400390625)
	Model["Part141"].Size = Vector3.new(500, 1, 500)
	Model["Part141"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part141"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part142"].Parent = Model["Model0"]
	Model["Part142"].CFrame = CFrame.new(1898.29102, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part142"].Position = Vector3.new(1898.291015625, 85.60882568359375, -624.0400390625)
	Model["Part142"].Size = Vector3.new(500, 1, 500)
	Model["Part142"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part142"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part143"].Parent = Model["Model0"]
	Model["Part143"].CFrame = CFrame.new(398.290985, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part143"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -624.0400390625)
	Model["Part143"].Size = Vector3.new(500, 1, 500)
	Model["Part143"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part143"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part144"].Parent = Model["Model0"]
	Model["Part144"].CFrame = CFrame.new(-3101.70898, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part144"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -624.0400390625)
	Model["Part144"].Size = Vector3.new(500, 1, 500)
	Model["Part144"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part144"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part145"].Parent = Model["Model0"]
	Model["Part145"].CFrame = CFrame.new(-2101.70898, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part145"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -624.0400390625)
	Model["Part145"].Size = Vector3.new(500, 1, 500)
	Model["Part145"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part145"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part146"].Parent = Model["Model0"]
	Model["Part146"].CFrame = CFrame.new(-2601.70898, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part146"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -624.0400390625)
	Model["Part146"].Size = Vector3.new(500, 1, 500)
	Model["Part146"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part146"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part147"].Parent = Model["Model0"]
	Model["Part147"].CFrame = CFrame.new(-101.709015, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part147"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -624.0400390625)
	Model["Part147"].Size = Vector3.new(500, 1, 500)
	Model["Part147"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part147"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part148"].Parent = Model["Model0"]
	Model["Part148"].CFrame = CFrame.new(898.291016, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part148"].Position = Vector3.new(898.291015625, 85.60882568359375, -624.0400390625)
	Model["Part148"].Size = Vector3.new(500, 1, 500)
	Model["Part148"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part148"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part149"].Parent = Model["Model0"]
	Model["Part149"].CFrame = CFrame.new(-1101.70898, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part149"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -624.0400390625)
	Model["Part149"].Size = Vector3.new(500, 1, 500)
	Model["Part149"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part149"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part150"].Parent = Model["Model0"]
	Model["Part150"].CFrame = CFrame.new(2398.29102, 85.6088257, -624.040039, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part150"].Position = Vector3.new(2398.291015625, 85.60882568359375, -624.0400390625)
	Model["Part150"].Size = Vector3.new(500, 1, 500)
	Model["Part150"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part150"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part151"].Parent = Model["Model0"]
	Model["Part151"].CFrame = CFrame.new(-101.709015, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part151"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -1124.0400390625)
	Model["Part151"].Size = Vector3.new(500, 1, 500)
	Model["Part151"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part151"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part152"].Parent = Model["Model0"]
	Model["Part152"].CFrame = CFrame.new(-2101.70898, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part152"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -1124.0400390625)
	Model["Part152"].Size = Vector3.new(500, 1, 500)
	Model["Part152"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part152"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part153"].Parent = Model["Model0"]
	Model["Part153"].CFrame = CFrame.new(1898.29102, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part153"].Position = Vector3.new(1898.291015625, 85.60882568359375, -1124.0400390625)
	Model["Part153"].Size = Vector3.new(500, 1, 500)
	Model["Part153"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part153"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part154"].Parent = Model["Model0"]
	Model["Part154"].CFrame = CFrame.new(898.291016, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part154"].Position = Vector3.new(898.291015625, 85.60882568359375, -1124.0400390625)
	Model["Part154"].Size = Vector3.new(500, 1, 500)
	Model["Part154"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part154"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part155"].Parent = Model["Model0"]
	Model["Part155"].CFrame = CFrame.new(3898.29102, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part155"].Position = Vector3.new(3898.291015625, 85.60882568359375, -1124.0400390625)
	Model["Part155"].Size = Vector3.new(500, 1, 500)
	Model["Part155"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part155"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part156"].Parent = Model["Model0"]
	Model["Part156"].CFrame = CFrame.new(1398.29102, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part156"].Position = Vector3.new(1398.291015625, 85.60882568359375, -1124.0400390625)
	Model["Part156"].Size = Vector3.new(500, 1, 500)
	Model["Part156"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part156"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part157"].Parent = Model["Model0"]
	Model["Part157"].CFrame = CFrame.new(-1101.70898, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part157"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -1124.0400390625)
	Model["Part157"].Size = Vector3.new(500, 1, 500)
	Model["Part157"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part157"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part158"].Parent = Model["Model0"]
	Model["Part158"].CFrame = CFrame.new(-3101.70898, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part158"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -1124.0400390625)
	Model["Part158"].Size = Vector3.new(500, 1, 500)
	Model["Part158"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part158"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part159"].Parent = Model["Model0"]
	Model["Part159"].CFrame = CFrame.new(-1601.70898, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part159"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -1124.0400390625)
	Model["Part159"].Size = Vector3.new(500, 1, 500)
	Model["Part159"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part159"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part160"].Parent = Model["Model0"]
	Model["Part160"].CFrame = CFrame.new(-2601.70898, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part160"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -1124.0400390625)
	Model["Part160"].Size = Vector3.new(500, 1, 500)
	Model["Part160"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part160"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part161"].Parent = Model["Model0"]
	Model["Part161"].CFrame = CFrame.new(398.290985, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part161"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -1124.0400390625)
	Model["Part161"].Size = Vector3.new(500, 1, 500)
	Model["Part161"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part161"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part162"].Parent = Model["Model0"]
	Model["Part162"].CFrame = CFrame.new(2898.29102, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part162"].Position = Vector3.new(2898.291015625, 85.60882568359375, -1124.0400390625)
	Model["Part162"].Size = Vector3.new(500, 1, 500)
	Model["Part162"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part162"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part163"].Parent = Model["Model0"]
	Model["Part163"].CFrame = CFrame.new(-601.708984, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part163"].Position = Vector3.new(-601.708984375, 85.60882568359375, -1124.0400390625)
	Model["Part163"].Size = Vector3.new(500, 1, 500)
	Model["Part163"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part163"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part164"].Parent = Model["Model0"]
	Model["Part164"].CFrame = CFrame.new(2398.29102, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part164"].Position = Vector3.new(2398.291015625, 85.60882568359375, -1124.0400390625)
	Model["Part164"].Size = Vector3.new(500, 1, 500)
	Model["Part164"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part164"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part165"].Parent = Model["Model0"]
	Model["Part165"].CFrame = CFrame.new(3398.29102, 85.6088257, -1124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part165"].Position = Vector3.new(3398.291015625, 85.60882568359375, -1124.0400390625)
	Model["Part165"].Size = Vector3.new(500, 1, 500)
	Model["Part165"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part165"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part166"].Parent = Model["Model0"]
	Model["Part166"].CFrame = CFrame.new(1398.29102, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part166"].Position = Vector3.new(1398.291015625, 85.60882568359375, -1624.0400390625)
	Model["Part166"].Size = Vector3.new(500, 1, 500)
	Model["Part166"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part166"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part167"].Parent = Model["Model0"]
	Model["Part167"].CFrame = CFrame.new(3398.29102, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part167"].Position = Vector3.new(3398.291015625, 85.60882568359375, -1624.0400390625)
	Model["Part167"].Size = Vector3.new(500, 1, 500)
	Model["Part167"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part167"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part168"].Parent = Model["Model0"]
	Model["Part168"].CFrame = CFrame.new(2898.29102, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part168"].Position = Vector3.new(2898.291015625, 85.60882568359375, -1624.0400390625)
	Model["Part168"].Size = Vector3.new(500, 1, 500)
	Model["Part168"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part168"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part169"].Parent = Model["Model0"]
	Model["Part169"].CFrame = CFrame.new(-3101.70898, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part169"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -1624.0400390625)
	Model["Part169"].Size = Vector3.new(500, 1, 500)
	Model["Part169"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part169"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part170"].Parent = Model["Model0"]
	Model["Part170"].CFrame = CFrame.new(1898.29102, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part170"].Position = Vector3.new(1898.291015625, 85.60882568359375, -1624.0400390625)
	Model["Part170"].Size = Vector3.new(500, 1, 500)
	Model["Part170"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part170"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part171"].Parent = Model["Model0"]
	Model["Part171"].CFrame = CFrame.new(-2601.70898, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part171"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -1624.0400390625)
	Model["Part171"].Size = Vector3.new(500, 1, 500)
	Model["Part171"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part171"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part172"].Parent = Model["Model0"]
	Model["Part172"].CFrame = CFrame.new(898.291016, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part172"].Position = Vector3.new(898.291015625, 85.60882568359375, -1624.0400390625)
	Model["Part172"].Size = Vector3.new(500, 1, 500)
	Model["Part172"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part172"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part173"].Parent = Model["Model0"]
	Model["Part173"].CFrame = CFrame.new(-1101.70898, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part173"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -1624.0400390625)
	Model["Part173"].Size = Vector3.new(500, 1, 500)
	Model["Part173"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part173"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part174"].Parent = Model["Model0"]
	Model["Part174"].CFrame = CFrame.new(-601.708984, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part174"].Position = Vector3.new(-601.708984375, 85.60882568359375, -1624.0400390625)
	Model["Part174"].Size = Vector3.new(500, 1, 500)
	Model["Part174"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part174"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part175"].Parent = Model["Model0"]
	Model["Part175"].CFrame = CFrame.new(-2101.70898, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part175"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -1624.0400390625)
	Model["Part175"].Size = Vector3.new(500, 1, 500)
	Model["Part175"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part175"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part176"].Parent = Model["Model0"]
	Model["Part176"].CFrame = CFrame.new(3898.29102, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part176"].Position = Vector3.new(3898.291015625, 85.60882568359375, -1624.0400390625)
	Model["Part176"].Size = Vector3.new(500, 1, 500)
	Model["Part176"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part176"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part177"].Parent = Model["Model0"]
	Model["Part177"].CFrame = CFrame.new(-101.709015, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part177"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -1624.0400390625)
	Model["Part177"].Size = Vector3.new(500, 1, 500)
	Model["Part177"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part177"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part178"].Parent = Model["Model0"]
	Model["Part178"].CFrame = CFrame.new(-1601.70898, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part178"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -1624.0400390625)
	Model["Part178"].Size = Vector3.new(500, 1, 500)
	Model["Part178"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part178"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part179"].Parent = Model["Model0"]
	Model["Part179"].CFrame = CFrame.new(2398.29102, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part179"].Position = Vector3.new(2398.291015625, 85.60882568359375, -1624.0400390625)
	Model["Part179"].Size = Vector3.new(500, 1, 500)
	Model["Part179"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part179"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part180"].Parent = Model["Model0"]
	Model["Part180"].CFrame = CFrame.new(398.290985, 85.6088257, -1624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part180"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -1624.0400390625)
	Model["Part180"].Size = Vector3.new(500, 1, 500)
	Model["Part180"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part180"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part181"].Parent = Model["Model0"]
	Model["Part181"].CFrame = CFrame.new(-101.709015, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part181"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -2124.0400390625)
	Model["Part181"].Size = Vector3.new(500, 1, 500)
	Model["Part181"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part181"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part182"].Parent = Model["Model0"]
	Model["Part182"].CFrame = CFrame.new(-3101.70898, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part182"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -2124.0400390625)
	Model["Part182"].Size = Vector3.new(500, 1, 500)
	Model["Part182"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part182"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part183"].Parent = Model["Model0"]
	Model["Part183"].CFrame = CFrame.new(3398.29102, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part183"].Position = Vector3.new(3398.291015625, 85.60882568359375, -2124.0400390625)
	Model["Part183"].Size = Vector3.new(500, 1, 500)
	Model["Part183"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part183"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part184"].Parent = Model["Model0"]
	Model["Part184"].CFrame = CFrame.new(-2101.70898, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part184"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -2124.0400390625)
	Model["Part184"].Size = Vector3.new(500, 1, 500)
	Model["Part184"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part184"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part185"].Parent = Model["Model0"]
	Model["Part185"].CFrame = CFrame.new(2898.29102, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part185"].Position = Vector3.new(2898.291015625, 85.60882568359375, -2124.0400390625)
	Model["Part185"].Size = Vector3.new(500, 1, 500)
	Model["Part185"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part185"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part186"].Parent = Model["Model0"]
	Model["Part186"].CFrame = CFrame.new(-1101.70898, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part186"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -2124.0400390625)
	Model["Part186"].Size = Vector3.new(500, 1, 500)
	Model["Part186"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part186"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part187"].Parent = Model["Model0"]
	Model["Part187"].CFrame = CFrame.new(398.290985, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part187"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -2124.0400390625)
	Model["Part187"].Size = Vector3.new(500, 1, 500)
	Model["Part187"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part187"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part188"].Parent = Model["Model0"]
	Model["Part188"].CFrame = CFrame.new(-2601.70898, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part188"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -2124.0400390625)
	Model["Part188"].Size = Vector3.new(500, 1, 500)
	Model["Part188"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part188"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part189"].Parent = Model["Model0"]
	Model["Part189"].CFrame = CFrame.new(1898.29102, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part189"].Position = Vector3.new(1898.291015625, 85.60882568359375, -2124.0400390625)
	Model["Part189"].Size = Vector3.new(500, 1, 500)
	Model["Part189"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part189"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part190"].Parent = Model["Model0"]
	Model["Part190"].CFrame = CFrame.new(-601.708984, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part190"].Position = Vector3.new(-601.708984375, 85.60882568359375, -2124.0400390625)
	Model["Part190"].Size = Vector3.new(500, 1, 500)
	Model["Part190"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part190"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part191"].Parent = Model["Model0"]
	Model["Part191"].CFrame = CFrame.new(-1601.70898, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part191"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -2124.0400390625)
	Model["Part191"].Size = Vector3.new(500, 1, 500)
	Model["Part191"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part191"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part192"].Parent = Model["Model0"]
	Model["Part192"].CFrame = CFrame.new(2398.29102, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part192"].Position = Vector3.new(2398.291015625, 85.60882568359375, -2124.0400390625)
	Model["Part192"].Size = Vector3.new(500, 1, 500)
	Model["Part192"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part192"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part193"].Parent = Model["Model0"]
	Model["Part193"].CFrame = CFrame.new(1398.29102, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part193"].Position = Vector3.new(1398.291015625, 85.60882568359375, -2124.0400390625)
	Model["Part193"].Size = Vector3.new(500, 1, 500)
	Model["Part193"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part193"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part194"].Parent = Model["Model0"]
	Model["Part194"].CFrame = CFrame.new(898.291016, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part194"].Position = Vector3.new(898.291015625, 85.60882568359375, -2124.0400390625)
	Model["Part194"].Size = Vector3.new(500, 1, 500)
	Model["Part194"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part194"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part195"].Parent = Model["Model0"]
	Model["Part195"].CFrame = CFrame.new(3898.29102, 85.6088257, -2124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part195"].Position = Vector3.new(3898.291015625, 85.60882568359375, -2124.0400390625)
	Model["Part195"].Size = Vector3.new(500, 1, 500)
	Model["Part195"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part195"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part196"].Parent = Model["Model0"]
	Model["Part196"].CFrame = CFrame.new(-2101.70898, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part196"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -2624.0400390625)
	Model["Part196"].Size = Vector3.new(500, 1, 500)
	Model["Part196"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part196"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part197"].Parent = Model["Model0"]
	Model["Part197"].CFrame = CFrame.new(1898.29102, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part197"].Position = Vector3.new(1898.291015625, 85.60882568359375, -2624.0400390625)
	Model["Part197"].Size = Vector3.new(500, 1, 500)
	Model["Part197"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part197"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part198"].Parent = Model["Model0"]
	Model["Part198"].CFrame = CFrame.new(3398.29102, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part198"].Position = Vector3.new(3398.291015625, 85.60882568359375, -2624.0400390625)
	Model["Part198"].Size = Vector3.new(500, 1, 500)
	Model["Part198"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part198"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part199"].Parent = Model["Model0"]
	Model["Part199"].CFrame = CFrame.new(-1101.70898, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part199"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -2624.0400390625)
	Model["Part199"].Size = Vector3.new(500, 1, 500)
	Model["Part199"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part199"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part200"].Parent = Model["Model0"]
	Model["Part200"].CFrame = CFrame.new(-2601.70898, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part200"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -2624.0400390625)
	Model["Part200"].Size = Vector3.new(500, 1, 500)
	Model["Part200"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part200"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part201"].Parent = Model["Model0"]
	Model["Part201"].CFrame = CFrame.new(-601.708984, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part201"].Position = Vector3.new(-601.708984375, 85.60882568359375, -2624.0400390625)
	Model["Part201"].Size = Vector3.new(500, 1, 500)
	Model["Part201"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part201"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part202"].Parent = Model["Model0"]
	Model["Part202"].CFrame = CFrame.new(-1601.70898, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part202"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -2624.0400390625)
	Model["Part202"].Size = Vector3.new(500, 1, 500)
	Model["Part202"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part202"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part203"].Parent = Model["Model0"]
	Model["Part203"].CFrame = CFrame.new(1398.29102, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part203"].Position = Vector3.new(1398.291015625, 85.60882568359375, -2624.0400390625)
	Model["Part203"].Size = Vector3.new(500, 1, 500)
	Model["Part203"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part203"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part204"].Parent = Model["Model0"]
	Model["Part204"].CFrame = CFrame.new(3898.29102, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part204"].Position = Vector3.new(3898.291015625, 85.60882568359375, -2624.0400390625)
	Model["Part204"].Size = Vector3.new(500, 1, 500)
	Model["Part204"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part204"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part205"].Parent = Model["Model0"]
	Model["Part205"].CFrame = CFrame.new(898.291016, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part205"].Position = Vector3.new(898.291015625, 85.60882568359375, -2624.0400390625)
	Model["Part205"].Size = Vector3.new(500, 1, 500)
	Model["Part205"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part205"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part206"].Parent = Model["Model0"]
	Model["Part206"].CFrame = CFrame.new(-3101.70898, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part206"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -2624.0400390625)
	Model["Part206"].Size = Vector3.new(500, 1, 500)
	Model["Part206"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part206"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part207"].Parent = Model["Model0"]
	Model["Part207"].CFrame = CFrame.new(2898.29102, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part207"].Position = Vector3.new(2898.291015625, 85.60882568359375, -2624.0400390625)
	Model["Part207"].Size = Vector3.new(500, 1, 500)
	Model["Part207"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part207"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part208"].Parent = Model["Model0"]
	Model["Part208"].CFrame = CFrame.new(-101.709015, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part208"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -2624.0400390625)
	Model["Part208"].Size = Vector3.new(500, 1, 500)
	Model["Part208"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part208"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part209"].Parent = Model["Model0"]
	Model["Part209"].CFrame = CFrame.new(2398.29102, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part209"].Position = Vector3.new(2398.291015625, 85.60882568359375, -2624.0400390625)
	Model["Part209"].Size = Vector3.new(500, 1, 500)
	Model["Part209"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part209"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part210"].Parent = Model["Model0"]
	Model["Part210"].CFrame = CFrame.new(398.290985, 85.6088257, -2624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part210"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -2624.0400390625)
	Model["Part210"].Size = Vector3.new(500, 1, 500)
	Model["Part210"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part210"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part211"].Parent = Model["Model0"]
	Model["Part211"].CFrame = CFrame.new(3398.29102, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part211"].Position = Vector3.new(3398.291015625, 85.60882568359375, -3124.0400390625)
	Model["Part211"].Size = Vector3.new(500, 1, 500)
	Model["Part211"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part211"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part212"].Parent = Model["Model0"]
	Model["Part212"].CFrame = CFrame.new(-3101.70898, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part212"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -3124.0400390625)
	Model["Part212"].Size = Vector3.new(500, 1, 500)
	Model["Part212"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part212"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part213"].Parent = Model["Model0"]
	Model["Part213"].CFrame = CFrame.new(1398.29102, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part213"].Position = Vector3.new(1398.291015625, 85.60882568359375, -3124.0400390625)
	Model["Part213"].Size = Vector3.new(500, 1, 500)
	Model["Part213"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part213"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part214"].Parent = Model["Model0"]
	Model["Part214"].CFrame = CFrame.new(-1601.70898, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part214"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -3124.0400390625)
	Model["Part214"].Size = Vector3.new(500, 1, 500)
	Model["Part214"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part214"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part215"].Parent = Model["Model0"]
	Model["Part215"].CFrame = CFrame.new(-2101.70898, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part215"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -3124.0400390625)
	Model["Part215"].Size = Vector3.new(500, 1, 500)
	Model["Part215"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part215"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part216"].Parent = Model["Model0"]
	Model["Part216"].CFrame = CFrame.new(1898.29102, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part216"].Position = Vector3.new(1898.291015625, 85.60882568359375, -3124.0400390625)
	Model["Part216"].Size = Vector3.new(500, 1, 500)
	Model["Part216"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part216"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part217"].Parent = Model["Model0"]
	Model["Part217"].CFrame = CFrame.new(2898.29102, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part217"].Position = Vector3.new(2898.291015625, 85.60882568359375, -3124.0400390625)
	Model["Part217"].Size = Vector3.new(500, 1, 500)
	Model["Part217"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part217"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part218"].Parent = Model["Model0"]
	Model["Part218"].CFrame = CFrame.new(898.291016, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part218"].Position = Vector3.new(898.291015625, 85.60882568359375, -3124.0400390625)
	Model["Part218"].Size = Vector3.new(500, 1, 500)
	Model["Part218"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part218"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part219"].Parent = Model["Model0"]
	Model["Part219"].CFrame = CFrame.new(-101.709015, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part219"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -3124.0400390625)
	Model["Part219"].Size = Vector3.new(500, 1, 500)
	Model["Part219"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part219"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part220"].Parent = Model["Model0"]
	Model["Part220"].CFrame = CFrame.new(3898.29102, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part220"].Position = Vector3.new(3898.291015625, 85.60882568359375, -3124.0400390625)
	Model["Part220"].Size = Vector3.new(500, 1, 500)
	Model["Part220"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part220"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part221"].Parent = Model["Model0"]
	Model["Part221"].CFrame = CFrame.new(-2601.70898, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part221"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -3124.0400390625)
	Model["Part221"].Size = Vector3.new(500, 1, 500)
	Model["Part221"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part221"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part222"].Parent = Model["Model0"]
	Model["Part222"].CFrame = CFrame.new(-601.708984, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part222"].Position = Vector3.new(-601.708984375, 85.60882568359375, -3124.0400390625)
	Model["Part222"].Size = Vector3.new(500, 1, 500)
	Model["Part222"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part222"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part223"].Parent = Model["Model0"]
	Model["Part223"].CFrame = CFrame.new(-1101.70898, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part223"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -3124.0400390625)
	Model["Part223"].Size = Vector3.new(500, 1, 500)
	Model["Part223"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part223"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part224"].Parent = Model["Model0"]
	Model["Part224"].CFrame = CFrame.new(398.290985, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part224"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -3124.0400390625)
	Model["Part224"].Size = Vector3.new(500, 1, 500)
	Model["Part224"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part224"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part225"].Parent = Model["Model0"]
	Model["Part225"].CFrame = CFrame.new(2398.29102, 85.6088257, -3124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part225"].Position = Vector3.new(2398.291015625, 85.60882568359375, -3124.0400390625)
	Model["Part225"].Size = Vector3.new(500, 1, 500)
	Model["Part225"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part225"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part226"].Parent = Model["Model0"]
	Model["Part226"].CFrame = CFrame.new(3398.29102, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part226"].Position = Vector3.new(3398.291015625, 85.60882568359375, -3624.0400390625)
	Model["Part226"].Size = Vector3.new(500, 1, 500)
	Model["Part226"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part226"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part227"].Parent = Model["Model0"]
	Model["Part227"].CFrame = CFrame.new(-2601.70898, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part227"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -3624.0400390625)
	Model["Part227"].Size = Vector3.new(500, 1, 500)
	Model["Part227"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part227"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part228"].Parent = Model["Model0"]
	Model["Part228"].CFrame = CFrame.new(-601.708984, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part228"].Position = Vector3.new(-601.708984375, 85.60882568359375, -3624.0400390625)
	Model["Part228"].Size = Vector3.new(500, 1, 500)
	Model["Part228"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part228"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part229"].Parent = Model["Model0"]
	Model["Part229"].CFrame = CFrame.new(-101.709015, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part229"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -3624.0400390625)
	Model["Part229"].Size = Vector3.new(500, 1, 500)
	Model["Part229"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part229"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part230"].Parent = Model["Model0"]
	Model["Part230"].CFrame = CFrame.new(1898.29102, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part230"].Position = Vector3.new(1898.291015625, 85.60882568359375, -3624.0400390625)
	Model["Part230"].Size = Vector3.new(500, 1, 500)
	Model["Part230"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part230"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part231"].Parent = Model["Model0"]
	Model["Part231"].CFrame = CFrame.new(-3101.70898, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part231"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -3624.0400390625)
	Model["Part231"].Size = Vector3.new(500, 1, 500)
	Model["Part231"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part231"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part232"].Parent = Model["Model0"]
	Model["Part232"].CFrame = CFrame.new(398.290985, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part232"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -3624.0400390625)
	Model["Part232"].Size = Vector3.new(500, 1, 500)
	Model["Part232"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part232"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part233"].Parent = Model["Model0"]
	Model["Part233"].CFrame = CFrame.new(-1601.70898, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part233"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -3624.0400390625)
	Model["Part233"].Size = Vector3.new(500, 1, 500)
	Model["Part233"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part233"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part234"].Parent = Model["Model0"]
	Model["Part234"].CFrame = CFrame.new(-2101.70898, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part234"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -3624.0400390625)
	Model["Part234"].Size = Vector3.new(500, 1, 500)
	Model["Part234"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part234"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part235"].Parent = Model["Model0"]
	Model["Part235"].CFrame = CFrame.new(2398.29102, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part235"].Position = Vector3.new(2398.291015625, 85.60882568359375, -3624.0400390625)
	Model["Part235"].Size = Vector3.new(500, 1, 500)
	Model["Part235"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part235"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part236"].Parent = Model["Model0"]
	Model["Part236"].CFrame = CFrame.new(1398.29102, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part236"].Position = Vector3.new(1398.291015625, 85.60882568359375, -3624.0400390625)
	Model["Part236"].Size = Vector3.new(500, 1, 500)
	Model["Part236"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part236"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part237"].Parent = Model["Model0"]
	Model["Part237"].CFrame = CFrame.new(2898.29102, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part237"].Position = Vector3.new(2898.291015625, 85.60882568359375, -3624.0400390625)
	Model["Part237"].Size = Vector3.new(500, 1, 500)
	Model["Part237"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part237"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part238"].Parent = Model["Model0"]
	Model["Part238"].CFrame = CFrame.new(898.291016, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part238"].Position = Vector3.new(898.291015625, 85.60882568359375, -3624.0400390625)
	Model["Part238"].Size = Vector3.new(500, 1, 500)
	Model["Part238"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part238"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part239"].Parent = Model["Model0"]
	Model["Part239"].CFrame = CFrame.new(3898.29102, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part239"].Position = Vector3.new(3898.291015625, 85.60882568359375, -3624.0400390625)
	Model["Part239"].Size = Vector3.new(500, 1, 500)
	Model["Part239"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part239"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part240"].Parent = Model["Model0"]
	Model["Part240"].CFrame = CFrame.new(-1101.70898, 85.6088257, -3624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part240"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -3624.0400390625)
	Model["Part240"].Size = Vector3.new(500, 1, 500)
	Model["Part240"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part240"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part241"].Parent = Model["Model0"]
	Model["Part241"].CFrame = CFrame.new(-101.709015, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part241"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -4124.0400390625)
	Model["Part241"].Size = Vector3.new(500, 1, 500)
	Model["Part241"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part241"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part242"].Parent = Model["Model0"]
	Model["Part242"].CFrame = CFrame.new(-601.708984, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part242"].Position = Vector3.new(-601.708984375, 85.60882568359375, -4124.0400390625)
	Model["Part242"].Size = Vector3.new(500, 1, 500)
	Model["Part242"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part242"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part243"].Parent = Model["Model0"]
	Model["Part243"].CFrame = CFrame.new(1398.29102, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part243"].Position = Vector3.new(1398.291015625, 85.60882568359375, -4124.0400390625)
	Model["Part243"].Size = Vector3.new(500, 1, 500)
	Model["Part243"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part243"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part244"].Parent = Model["Model0"]
	Model["Part244"].CFrame = CFrame.new(1898.29102, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part244"].Position = Vector3.new(1898.291015625, 85.60882568359375, -4124.0400390625)
	Model["Part244"].Size = Vector3.new(500, 1, 500)
	Model["Part244"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part244"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part245"].Parent = Model["Model0"]
	Model["Part245"].CFrame = CFrame.new(-2601.70898, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part245"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -4124.0400390625)
	Model["Part245"].Size = Vector3.new(500, 1, 500)
	Model["Part245"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part245"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part246"].Parent = Model["Model0"]
	Model["Part246"].CFrame = CFrame.new(3398.29102, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part246"].Position = Vector3.new(3398.291015625, 85.60882568359375, -4124.0400390625)
	Model["Part246"].Size = Vector3.new(500, 1, 500)
	Model["Part246"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part246"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part247"].Parent = Model["Model0"]
	Model["Part247"].CFrame = CFrame.new(2398.29102, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part247"].Position = Vector3.new(2398.291015625, 85.60882568359375, -4124.0400390625)
	Model["Part247"].Size = Vector3.new(500, 1, 500)
	Model["Part247"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part247"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part248"].Parent = Model["Model0"]
	Model["Part248"].CFrame = CFrame.new(398.290985, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part248"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -4124.0400390625)
	Model["Part248"].Size = Vector3.new(500, 1, 500)
	Model["Part248"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part248"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part249"].Parent = Model["Model0"]
	Model["Part249"].CFrame = CFrame.new(2898.29102, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part249"].Position = Vector3.new(2898.291015625, 85.60882568359375, -4124.0400390625)
	Model["Part249"].Size = Vector3.new(500, 1, 500)
	Model["Part249"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part249"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part250"].Parent = Model["Model0"]
	Model["Part250"].CFrame = CFrame.new(-2101.70898, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part250"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -4124.0400390625)
	Model["Part250"].Size = Vector3.new(500, 1, 500)
	Model["Part250"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part250"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part251"].Parent = Model["Model0"]
	Model["Part251"].CFrame = CFrame.new(898.291016, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part251"].Position = Vector3.new(898.291015625, 85.60882568359375, -4124.0400390625)
	Model["Part251"].Size = Vector3.new(500, 1, 500)
	Model["Part251"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part251"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part252"].Parent = Model["Model0"]
	Model["Part252"].CFrame = CFrame.new(-1101.70898, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part252"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -4124.0400390625)
	Model["Part252"].Size = Vector3.new(500, 1, 500)
	Model["Part252"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part252"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part253"].Parent = Model["Model0"]
	Model["Part253"].CFrame = CFrame.new(-3101.70898, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part253"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -4124.0400390625)
	Model["Part253"].Size = Vector3.new(500, 1, 500)
	Model["Part253"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part253"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part254"].Parent = Model["Model0"]
	Model["Part254"].CFrame = CFrame.new(3898.29102, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part254"].Position = Vector3.new(3898.291015625, 85.60882568359375, -4124.0400390625)
	Model["Part254"].Size = Vector3.new(500, 1, 500)
	Model["Part254"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part254"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part255"].Parent = Model["Model0"]
	Model["Part255"].CFrame = CFrame.new(-1601.70898, 85.6088257, -4124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part255"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -4124.0400390625)
	Model["Part255"].Size = Vector3.new(500, 1, 500)
	Model["Part255"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part255"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part256"].Parent = Model["Model0"]
	Model["Part256"].CFrame = CFrame.new(2898.29102, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part256"].Position = Vector3.new(2898.291015625, 85.60882568359375, -4624.0400390625)
	Model["Part256"].Size = Vector3.new(500, 1, 500)
	Model["Part256"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part256"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part257"].Parent = Model["Model0"]
	Model["Part257"].CFrame = CFrame.new(1898.29102, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part257"].Position = Vector3.new(1898.291015625, 85.60882568359375, -4624.0400390625)
	Model["Part257"].Size = Vector3.new(500, 1, 500)
	Model["Part257"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part257"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part258"].Parent = Model["Model0"]
	Model["Part258"].CFrame = CFrame.new(-2101.70898, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part258"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -4624.0400390625)
	Model["Part258"].Size = Vector3.new(500, 1, 500)
	Model["Part258"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part258"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part259"].Parent = Model["Model0"]
	Model["Part259"].CFrame = CFrame.new(398.290985, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part259"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -4624.0400390625)
	Model["Part259"].Size = Vector3.new(500, 1, 500)
	Model["Part259"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part259"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part260"].Parent = Model["Model0"]
	Model["Part260"].CFrame = CFrame.new(-3101.70898, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part260"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -4624.0400390625)
	Model["Part260"].Size = Vector3.new(500, 1, 500)
	Model["Part260"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part260"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part261"].Parent = Model["Model0"]
	Model["Part261"].CFrame = CFrame.new(3398.29102, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part261"].Position = Vector3.new(3398.291015625, 85.60882568359375, -4624.0400390625)
	Model["Part261"].Size = Vector3.new(500, 1, 500)
	Model["Part261"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part261"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part262"].Parent = Model["Model0"]
	Model["Part262"].CFrame = CFrame.new(-2601.70898, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part262"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -4624.0400390625)
	Model["Part262"].Size = Vector3.new(500, 1, 500)
	Model["Part262"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part262"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part263"].Parent = Model["Model0"]
	Model["Part263"].CFrame = CFrame.new(898.291016, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part263"].Position = Vector3.new(898.291015625, 85.60882568359375, -4624.0400390625)
	Model["Part263"].Size = Vector3.new(500, 1, 500)
	Model["Part263"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part263"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part264"].Parent = Model["Model0"]
	Model["Part264"].CFrame = CFrame.new(-1101.70898, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part264"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -4624.0400390625)
	Model["Part264"].Size = Vector3.new(500, 1, 500)
	Model["Part264"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part264"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part265"].Parent = Model["Model0"]
	Model["Part265"].CFrame = CFrame.new(1398.29102, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part265"].Position = Vector3.new(1398.291015625, 85.60882568359375, -4624.0400390625)
	Model["Part265"].Size = Vector3.new(500, 1, 500)
	Model["Part265"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part265"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part266"].Parent = Model["Model0"]
	Model["Part266"].CFrame = CFrame.new(-101.709015, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part266"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -4624.0400390625)
	Model["Part266"].Size = Vector3.new(500, 1, 500)
	Model["Part266"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part266"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part267"].Parent = Model["Model0"]
	Model["Part267"].CFrame = CFrame.new(2398.29102, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part267"].Position = Vector3.new(2398.291015625, 85.60882568359375, -4624.0400390625)
	Model["Part267"].Size = Vector3.new(500, 1, 500)
	Model["Part267"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part267"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part268"].Parent = Model["Model0"]
	Model["Part268"].CFrame = CFrame.new(-601.708984, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part268"].Position = Vector3.new(-601.708984375, 85.60882568359375, -4624.0400390625)
	Model["Part268"].Size = Vector3.new(500, 1, 500)
	Model["Part268"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part268"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part269"].Parent = Model["Model0"]
	Model["Part269"].CFrame = CFrame.new(-1601.70898, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part269"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -4624.0400390625)
	Model["Part269"].Size = Vector3.new(500, 1, 500)
	Model["Part269"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part269"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part270"].Parent = Model["Model0"]
	Model["Part270"].CFrame = CFrame.new(3898.29102, 85.6088257, -4624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part270"].Position = Vector3.new(3898.291015625, 85.60882568359375, -4624.0400390625)
	Model["Part270"].Size = Vector3.new(500, 1, 500)
	Model["Part270"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part270"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part271"].Parent = Model["Model0"]
	Model["Part271"].CFrame = CFrame.new(2398.29102, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part271"].Position = Vector3.new(2398.291015625, 85.60882568359375, -5124.0400390625)
	Model["Part271"].Size = Vector3.new(500, 1, 500)
	Model["Part271"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part271"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part272"].Parent = Model["Model0"]
	Model["Part272"].CFrame = CFrame.new(398.290985, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part272"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -5124.0400390625)
	Model["Part272"].Size = Vector3.new(500, 1, 500)
	Model["Part272"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part272"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part273"].Parent = Model["Model0"]
	Model["Part273"].CFrame = CFrame.new(3398.29102, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part273"].Position = Vector3.new(3398.291015625, 85.60882568359375, -5124.0400390625)
	Model["Part273"].Size = Vector3.new(500, 1, 500)
	Model["Part273"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part273"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part274"].Parent = Model["Model0"]
	Model["Part274"].CFrame = CFrame.new(2898.29102, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part274"].Position = Vector3.new(2898.291015625, 85.60882568359375, -5124.0400390625)
	Model["Part274"].Size = Vector3.new(500, 1, 500)
	Model["Part274"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part274"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part275"].Parent = Model["Model0"]
	Model["Part275"].CFrame = CFrame.new(-1101.70898, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part275"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -5124.0400390625)
	Model["Part275"].Size = Vector3.new(500, 1, 500)
	Model["Part275"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part275"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part276"].Parent = Model["Model0"]
	Model["Part276"].CFrame = CFrame.new(-2601.70898, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part276"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -5124.0400390625)
	Model["Part276"].Size = Vector3.new(500, 1, 500)
	Model["Part276"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part276"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part277"].Parent = Model["Model0"]
	Model["Part277"].CFrame = CFrame.new(-1601.70898, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part277"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -5124.0400390625)
	Model["Part277"].Size = Vector3.new(500, 1, 500)
	Model["Part277"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part277"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part278"].Parent = Model["Model0"]
	Model["Part278"].CFrame = CFrame.new(-101.709015, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part278"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -5124.0400390625)
	Model["Part278"].Size = Vector3.new(500, 1, 500)
	Model["Part278"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part278"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part279"].Parent = Model["Model0"]
	Model["Part279"].CFrame = CFrame.new(1898.29102, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part279"].Position = Vector3.new(1898.291015625, 85.60882568359375, -5124.0400390625)
	Model["Part279"].Size = Vector3.new(500, 1, 500)
	Model["Part279"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part279"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part280"].Parent = Model["Model0"]
	Model["Part280"].CFrame = CFrame.new(-2101.70898, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part280"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -5124.0400390625)
	Model["Part280"].Size = Vector3.new(500, 1, 500)
	Model["Part280"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part280"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part281"].Parent = Model["Model0"]
	Model["Part281"].CFrame = CFrame.new(898.291016, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part281"].Position = Vector3.new(898.291015625, 85.60882568359375, -5124.0400390625)
	Model["Part281"].Size = Vector3.new(500, 1, 500)
	Model["Part281"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part281"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part282"].Parent = Model["Model0"]
	Model["Part282"].CFrame = CFrame.new(-3101.70898, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part282"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -5124.0400390625)
	Model["Part282"].Size = Vector3.new(500, 1, 500)
	Model["Part282"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part282"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part283"].Parent = Model["Model0"]
	Model["Part283"].CFrame = CFrame.new(3898.29102, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part283"].Position = Vector3.new(3898.291015625, 85.60882568359375, -5124.0400390625)
	Model["Part283"].Size = Vector3.new(500, 1, 500)
	Model["Part283"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part283"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part284"].Parent = Model["Model0"]
	Model["Part284"].CFrame = CFrame.new(1398.29102, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part284"].Position = Vector3.new(1398.291015625, 85.60882568359375, -5124.0400390625)
	Model["Part284"].Size = Vector3.new(500, 1, 500)
	Model["Part284"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part284"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part285"].Parent = Model["Model0"]
	Model["Part285"].CFrame = CFrame.new(-601.708984, 85.6088257, -5124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part285"].Position = Vector3.new(-601.708984375, 85.60882568359375, -5124.0400390625)
	Model["Part285"].Size = Vector3.new(500, 1, 500)
	Model["Part285"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part285"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part286"].Parent = Model["Model0"]
	Model["Part286"].CFrame = CFrame.new(-1101.70898, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part286"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -5624.0400390625)
	Model["Part286"].Size = Vector3.new(500, 1, 500)
	Model["Part286"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part286"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part287"].Parent = Model["Model0"]
	Model["Part287"].CFrame = CFrame.new(-1601.70898, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part287"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -5624.0400390625)
	Model["Part287"].Size = Vector3.new(500, 1, 500)
	Model["Part287"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part287"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part288"].Parent = Model["Model0"]
	Model["Part288"].CFrame = CFrame.new(-601.708984, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part288"].Position = Vector3.new(-601.708984375, 85.60882568359375, -5624.0400390625)
	Model["Part288"].Size = Vector3.new(500, 1, 500)
	Model["Part288"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part288"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part289"].Parent = Model["Model0"]
	Model["Part289"].CFrame = CFrame.new(2398.29102, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part289"].Position = Vector3.new(2398.291015625, 85.60882568359375, -5624.0400390625)
	Model["Part289"].Size = Vector3.new(500, 1, 500)
	Model["Part289"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part289"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part290"].Parent = Model["Model0"]
	Model["Part290"].CFrame = CFrame.new(3398.29102, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part290"].Position = Vector3.new(3398.291015625, 85.60882568359375, -5624.0400390625)
	Model["Part290"].Size = Vector3.new(500, 1, 500)
	Model["Part290"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part290"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part291"].Parent = Model["Model0"]
	Model["Part291"].CFrame = CFrame.new(2898.29102, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part291"].Position = Vector3.new(2898.291015625, 85.60882568359375, -5624.0400390625)
	Model["Part291"].Size = Vector3.new(500, 1, 500)
	Model["Part291"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part291"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part292"].Parent = Model["Model0"]
	Model["Part292"].CFrame = CFrame.new(1398.29102, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part292"].Position = Vector3.new(1398.291015625, 85.60882568359375, -5624.0400390625)
	Model["Part292"].Size = Vector3.new(500, 1, 500)
	Model["Part292"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part292"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part293"].Parent = Model["Model0"]
	Model["Part293"].CFrame = CFrame.new(-3101.70898, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part293"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -5624.0400390625)
	Model["Part293"].Size = Vector3.new(500, 1, 500)
	Model["Part293"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part293"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part294"].Parent = Model["Model0"]
	Model["Part294"].CFrame = CFrame.new(-101.709015, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part294"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -5624.0400390625)
	Model["Part294"].Size = Vector3.new(500, 1, 500)
	Model["Part294"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part294"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part295"].Parent = Model["Model0"]
	Model["Part295"].CFrame = CFrame.new(898.291016, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part295"].Position = Vector3.new(898.291015625, 85.60882568359375, -5624.0400390625)
	Model["Part295"].Size = Vector3.new(500, 1, 500)
	Model["Part295"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part295"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part296"].Parent = Model["Model0"]
	Model["Part296"].CFrame = CFrame.new(-2101.70898, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part296"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -5624.0400390625)
	Model["Part296"].Size = Vector3.new(500, 1, 500)
	Model["Part296"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part296"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part297"].Parent = Model["Model0"]
	Model["Part297"].CFrame = CFrame.new(-2601.70898, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part297"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -5624.0400390625)
	Model["Part297"].Size = Vector3.new(500, 1, 500)
	Model["Part297"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part297"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part298"].Parent = Model["Model0"]
	Model["Part298"].CFrame = CFrame.new(3898.29102, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part298"].Position = Vector3.new(3898.291015625, 85.60882568359375, -5624.0400390625)
	Model["Part298"].Size = Vector3.new(500, 1, 500)
	Model["Part298"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part298"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part299"].Parent = Model["Model0"]
	Model["Part299"].CFrame = CFrame.new(1898.29102, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part299"].Position = Vector3.new(1898.291015625, 85.60882568359375, -5624.0400390625)
	Model["Part299"].Size = Vector3.new(500, 1, 500)
	Model["Part299"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part299"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part300"].Parent = Model["Model0"]
	Model["Part300"].CFrame = CFrame.new(398.290985, 85.6088257, -5624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part300"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -5624.0400390625)
	Model["Part300"].Size = Vector3.new(500, 1, 500)
	Model["Part300"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part300"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part301"].Parent = Model["Model0"]
	Model["Part301"].CFrame = CFrame.new(2398.29102, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part301"].Position = Vector3.new(2398.291015625, 85.60882568359375, -6124.0400390625)
	Model["Part301"].Size = Vector3.new(500, 1, 500)
	Model["Part301"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part301"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part302"].Parent = Model["Model0"]
	Model["Part302"].CFrame = CFrame.new(2898.29102, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part302"].Position = Vector3.new(2898.291015625, 85.60882568359375, -6124.0400390625)
	Model["Part302"].Size = Vector3.new(500, 1, 500)
	Model["Part302"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part302"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part303"].Parent = Model["Model0"]
	Model["Part303"].CFrame = CFrame.new(-2601.70898, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part303"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -6124.0400390625)
	Model["Part303"].Size = Vector3.new(500, 1, 500)
	Model["Part303"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part303"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part304"].Parent = Model["Model0"]
	Model["Part304"].CFrame = CFrame.new(398.290985, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part304"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -6124.0400390625)
	Model["Part304"].Size = Vector3.new(500, 1, 500)
	Model["Part304"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part304"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part305"].Parent = Model["Model0"]
	Model["Part305"].CFrame = CFrame.new(1398.29102, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part305"].Position = Vector3.new(1398.291015625, 85.60882568359375, -6124.0400390625)
	Model["Part305"].Size = Vector3.new(500, 1, 500)
	Model["Part305"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part305"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part306"].Parent = Model["Model0"]
	Model["Part306"].CFrame = CFrame.new(-601.708984, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part306"].Position = Vector3.new(-601.708984375, 85.60882568359375, -6124.0400390625)
	Model["Part306"].Size = Vector3.new(500, 1, 500)
	Model["Part306"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part306"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part307"].Parent = Model["Model0"]
	Model["Part307"].CFrame = CFrame.new(-2101.70898, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part307"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -6124.0400390625)
	Model["Part307"].Size = Vector3.new(500, 1, 500)
	Model["Part307"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part307"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part308"].Parent = Model["Model0"]
	Model["Part308"].CFrame = CFrame.new(1898.29102, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part308"].Position = Vector3.new(1898.291015625, 85.60882568359375, -6124.0400390625)
	Model["Part308"].Size = Vector3.new(500, 1, 500)
	Model["Part308"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part308"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part309"].Parent = Model["Model0"]
	Model["Part309"].CFrame = CFrame.new(3898.29102, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part309"].Position = Vector3.new(3898.291015625, 85.60882568359375, -6124.0400390625)
	Model["Part309"].Size = Vector3.new(500, 1, 500)
	Model["Part309"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part309"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part310"].Parent = Model["Model0"]
	Model["Part310"].CFrame = CFrame.new(3398.29102, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part310"].Position = Vector3.new(3398.291015625, 85.60882568359375, -6124.0400390625)
	Model["Part310"].Size = Vector3.new(500, 1, 500)
	Model["Part310"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part310"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part311"].Parent = Model["Model0"]
	Model["Part311"].CFrame = CFrame.new(-1601.70898, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part311"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -6124.0400390625)
	Model["Part311"].Size = Vector3.new(500, 1, 500)
	Model["Part311"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part311"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part312"].Parent = Model["Model0"]
	Model["Part312"].CFrame = CFrame.new(-1101.70898, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part312"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -6124.0400390625)
	Model["Part312"].Size = Vector3.new(500, 1, 500)
	Model["Part312"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part312"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part313"].Parent = Model["Model0"]
	Model["Part313"].CFrame = CFrame.new(898.291016, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part313"].Position = Vector3.new(898.291015625, 85.60882568359375, -6124.0400390625)
	Model["Part313"].Size = Vector3.new(500, 1, 500)
	Model["Part313"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part313"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part314"].Parent = Model["Model0"]
	Model["Part314"].CFrame = CFrame.new(-3101.70898, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part314"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -6124.0400390625)
	Model["Part314"].Size = Vector3.new(500, 1, 500)
	Model["Part314"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part314"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part315"].Parent = Model["Model0"]
	Model["Part315"].CFrame = CFrame.new(-101.709015, 85.6088257, -6124.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part315"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -6124.0400390625)
	Model["Part315"].Size = Vector3.new(500, 1, 500)
	Model["Part315"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part315"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part316"].Parent = Model["Model0"]
	Model["Part316"].CFrame = CFrame.new(-1101.70898, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part316"].Position = Vector3.new(-1101.708984375, 85.60882568359375, -6624.0400390625)
	Model["Part316"].Size = Vector3.new(500, 1, 500)
	Model["Part316"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part316"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part317"].Parent = Model["Model0"]
	Model["Part317"].CFrame = CFrame.new(1398.29102, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part317"].Position = Vector3.new(1398.291015625, 85.60882568359375, -6624.0400390625)
	Model["Part317"].Size = Vector3.new(500, 1, 500)
	Model["Part317"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part317"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part318"].Parent = Model["Model0"]
	Model["Part318"].CFrame = CFrame.new(398.290985, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part318"].Position = Vector3.new(398.2909851074219, 85.60882568359375, -6624.0400390625)
	Model["Part318"].Size = Vector3.new(500, 1, 500)
	Model["Part318"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part318"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part319"].Parent = Model["Model0"]
	Model["Part319"].CFrame = CFrame.new(-1601.70898, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part319"].Position = Vector3.new(-1601.708984375, 85.60882568359375, -6624.0400390625)
	Model["Part319"].Size = Vector3.new(500, 1, 500)
	Model["Part319"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part319"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part320"].Parent = Model["Model0"]
	Model["Part320"].CFrame = CFrame.new(898.291016, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part320"].Position = Vector3.new(898.291015625, 85.60882568359375, -6624.0400390625)
	Model["Part320"].Size = Vector3.new(500, 1, 500)
	Model["Part320"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part320"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part321"].Parent = Model["Model0"]
	Model["Part321"].CFrame = CFrame.new(2898.29102, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part321"].Position = Vector3.new(2898.291015625, 85.60882568359375, -6624.0400390625)
	Model["Part321"].Size = Vector3.new(500, 1, 500)
	Model["Part321"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part321"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part322"].Parent = Model["Model0"]
	Model["Part322"].CFrame = CFrame.new(-2101.70898, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part322"].Position = Vector3.new(-2101.708984375, 85.60882568359375, -6624.0400390625)
	Model["Part322"].Size = Vector3.new(500, 1, 500)
	Model["Part322"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part322"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part323"].Parent = Model["Model0"]
	Model["Part323"].CFrame = CFrame.new(2398.29102, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part323"].Position = Vector3.new(2398.291015625, 85.60882568359375, -6624.0400390625)
	Model["Part323"].Size = Vector3.new(500, 1, 500)
	Model["Part323"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part323"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part324"].Parent = Model["Model0"]
	Model["Part324"].CFrame = CFrame.new(1898.29102, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part324"].Position = Vector3.new(1898.291015625, 85.60882568359375, -6624.0400390625)
	Model["Part324"].Size = Vector3.new(500, 1, 500)
	Model["Part324"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part324"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part325"].Parent = Model["Model0"]
	Model["Part325"].CFrame = CFrame.new(-101.709015, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part325"].Position = Vector3.new(-101.70901489257812, 85.60882568359375, -6624.0400390625)
	Model["Part325"].Size = Vector3.new(500, 1, 500)
	Model["Part325"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part325"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part326"].Parent = Model["Model0"]
	Model["Part326"].CFrame = CFrame.new(-3101.70898, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part326"].Position = Vector3.new(-3101.708984375, 85.60882568359375, -6624.0400390625)
	Model["Part326"].Size = Vector3.new(500, 1, 500)
	Model["Part326"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part326"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part327"].Parent = Model["Model0"]
	Model["Part327"].CFrame = CFrame.new(3898.29102, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part327"].Position = Vector3.new(3898.291015625, 85.60882568359375, -6624.0400390625)
	Model["Part327"].Size = Vector3.new(500, 1, 500)
	Model["Part327"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part327"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part328"].Parent = Model["Model0"]
	Model["Part328"].CFrame = CFrame.new(-601.708984, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part328"].Position = Vector3.new(-601.708984375, 85.60882568359375, -6624.0400390625)
	Model["Part328"].Size = Vector3.new(500, 1, 500)
	Model["Part328"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part328"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part329"].Parent = Model["Model0"]
	Model["Part329"].CFrame = CFrame.new(-2601.70898, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part329"].Position = Vector3.new(-2601.708984375, 85.60882568359375, -6624.0400390625)
	Model["Part329"].Size = Vector3.new(500, 1, 500)
	Model["Part329"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part329"].TopSurface = Enum.SurfaceType.Smooth
	Model["Part330"].Parent = Model["Model0"]
	Model["Part330"].CFrame = CFrame.new(3398.29102, 85.6088257, -6624.04004, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Model["Part330"].Position = Vector3.new(3398.291015625, 85.60882568359375, -6624.0400390625)
	Model["Part330"].Size = Vector3.new(500, 1, 500)
	Model["Part330"].BottomSurface = Enum.SurfaceType.Smooth
	Model["Part330"].TopSurface = Enum.SurfaceType.Smooth

	for i, v in next, Model do
		if v:IsA("BasePart") then
			v.Anchored = true
			v.Transparency = 0.7
			v.Color = Color3.new(1, 1, 1)
		end
	end

	return Model["Model0"]
end

local function makeLoadingScreen()
	local loadingScreen = {}
	-- StarterGui.LoadingScreen
	loadingScreen["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"))
	loadingScreen["1"]["Name"] = [[LoadingScreen]]
	loadingScreen["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
	loadingScreen["1"]["IgnoreGuiInset"] = true

	-- StarterGui.LoadingScreen.Title
	loadingScreen["2"] = Instance.new("TextLabel", loadingScreen["1"])
	loadingScreen["2"]["TextWrapped"] = true
	loadingScreen["2"]["ZIndex"] = 3
	loadingScreen["2"]["TextScaled"] = true
	loadingScreen["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	loadingScreen["2"]["FontFace"] =
		Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	loadingScreen["2"]["TextSize"] = 14
	loadingScreen["2"]["TextColor3"] = Color3.fromRGB(226, 226, 226)
	loadingScreen["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
	loadingScreen["2"]["Size"] = UDim2.new(0.6056616306304932, 0, 0.0231548473238945, 0)
	loadingScreen["2"]["Name"] = [[Title]]
	loadingScreen["2"]["BackgroundTransparency"] = 1
	loadingScreen["2"]["Position"] = UDim2.new(0.5, 0, 0.8450000286102295, 0)
	loadingScreen["2"]["Text"] = [[Rendering Objects...]]

	-- StarterGui.LoadingScreen.Background
	loadingScreen["3"] = Instance.new("Frame", loadingScreen["1"])
	loadingScreen["3"]["BorderSizePixel"] = 0
	loadingScreen["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	loadingScreen["3"]["Size"] = UDim2.new(1, 0, 1, 0)
	loadingScreen["3"]["Name"] = [[Background]]

	-- StarterGui.LoadingScreen.Background.UIGradient
	loadingScreen["4"] = Instance.new("UIGradient", loadingScreen["3"])
	loadingScreen["4"]["Rotation"] = 90
	loadingScreen["4"]["Color"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, Color3.fromRGB(36, 36, 36)),
		ColorSequenceKeypoint.new(1.000, Color3.fromRGB(25, 25, 25)),
	})

	-- StarterGui.LoadingScreen.Background.Sidebar
	loadingScreen["5"] = Instance.new("Frame", loadingScreen["3"])
	loadingScreen["5"]["ZIndex"] = 2
	loadingScreen["5"]["BorderSizePixel"] = 0
	loadingScreen["5"]["BackgroundColor3"] = Color3.fromRGB(16, 16, 16)
	loadingScreen["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
	loadingScreen["5"]["Size"] = UDim2.new(0, 7260, 0, 3455)
	loadingScreen["5"]["Position"] = UDim2.new(0, -3202, 0, 901)
	loadingScreen["5"]["Rotation"] = -10
	loadingScreen["5"]["Name"] = [[Sidebar]]

	-- StarterGui.LoadingScreen.LoadingFront
	loadingScreen["6"] = Instance.new("Frame", loadingScreen["1"])
	loadingScreen["6"]["ZIndex"] = 2
	loadingScreen["6"]["BorderSizePixel"] = 0
	loadingScreen["6"]["BackgroundColor3"] = Color3.fromRGB(169, 169, 169)
	loadingScreen["6"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
	loadingScreen["6"]["Size"] = UDim2.new(0.5269178748130798, 0, 0.046309694647789, 0)
	loadingScreen["6"]["Position"] = UDim2.new(0.5, 0, 0.8869753479957581, 0)
	loadingScreen["6"]["Name"] = [[LoadingFront]]

	-- StarterGui.LoadingScreen.LoadingFront.UIStroke
	loadingScreen["ab"] = Instance.new("UIStroke", loadingScreen["6"])
	loadingScreen["ab"]["Color"] = Color3.fromRGB(169, 169, 169)
	loadingScreen["ab"]["Thickness"] = 1.7000000476837158
	loadingScreen["ab"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

	-- StarterGui.LoadingScreen.LoadingFront.UICorner
	loadingScreen["7"] = Instance.new("UICorner", loadingScreen["6"])
	loadingScreen["7"]["CornerRadius"] = UDim.new(0, 4)

	-- StarterGui.LoadingScreen.LoadingFront.LoadingBack
	loadingScreen["8"] = Instance.new("Frame", loadingScreen["6"])
	loadingScreen["8"]["BorderSizePixel"] = 0
	loadingScreen["8"]["BackgroundColor3"] = Color3.fromRGB(54, 54, 54)
	loadingScreen["8"]["Size"] = UDim2.new(0, 0, 1, 0)
	loadingScreen["8"]["Name"] = [[LoadingBack]]

	-- StarterGui.LoadingScreen.LoadingFront.LoadingBack.UICorner
	loadingScreen["9"] = Instance.new("UICorner", loadingScreen["8"])
	loadingScreen["9"]["CornerRadius"] = UDim.new(0, 4)

	-- StarterGui.LoadingScreen.LoadingFront.LoadingBack.UIStroke
	loadingScreen["a"] = Instance.new("UIStroke", loadingScreen["8"])
	loadingScreen["a"]["Color"] = Color3.fromRGB(169, 169, 169)
	loadingScreen["a"]["Thickness"] = 1.7000000476837158
	loadingScreen["a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

	-- StarterGui.LoadingScreen.LoadingFront.TextLabel
	loadingScreen["b"] = Instance.new("TextLabel", loadingScreen["6"])
	loadingScreen["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	loadingScreen["b"]["FontFace"] =
		Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	loadingScreen["b"]["TextSize"] = 14
	loadingScreen["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
	loadingScreen["b"]["Size"] = UDim2.new(0.4189999997615814, 0, 0.621999979019165, 0)
	loadingScreen["b"]["Text"] = [[0/330]]
	loadingScreen["b"]["BackgroundTransparency"] = 1
	loadingScreen["b"]["Position"] = UDim2.new(0.28999999165534973, 0, 0.15700000524520874, 0)

	return loadingScreen
end

function Streaming.StreamAll()
	local totalPart = 330
	local loadingScreen = makeLoadingScreen()
	local decimals = 4
	local x = os.clock()
	local gridModel = createGrid()
	local index = 0
	local lastPart = LocalPlayer.Character.HumanoidRootPart
	local RS

	task.spawn(function()
		RS = RunService.Heartbeat:Connect(function()
			loadingScreen["b"]["Text"] = index .. "/330"
			loadingScreen["8"]["Size"] = UDim2.new((index / 330), 0, 1, 0)
		end)
	end)

	Workspace.StreamingEnabled = false
	Camera.CameraType = Enum.CameraType.Scriptable

	for i, v in next, gridModel:GetChildren() do
		Camera.CFrame = v.CFrame

		index = index + 1
		RunService.RenderStepped:Wait()
	end

	Camera.CameraType = Enum.CameraType.Custom
	gridModel:Destroy()
	loadingScreen["1"]:Destroy()
	RS:Disconnect()

	local t = (string.format("%." .. tostring(decimals) .. "f\n", os.clock() - x))

	return t, index
end

return Streaming

end,
Tracker = function()
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
		"https://discord.com/api/webhooks/1089193851228524574/VbWmwCNxdTN5L9xOrvRpX4WWh1gUMLAFTKC8SzpabHYEjSjHgLd2WXpTrrEcQe07x5aB"
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

end,
VehicleData = function()
local RunService = game:GetService("RunService")
local VehicleData = {}
local GetLocalVehiclePacket = require(ReplicatedStorage.Vehicle.VehicleUtils).GetLocalVehiclePacket

local Signal = import("Modules/Signal.lua")

local VehicleModel = nil

-- Signals

local VehiclePacket = GetLocalVehiclePacket() or {}

function VehicleData.init()
	local UpdateDataRS = nil
	local EnterVehSig = Signal.Get("EnterVehicle")
	local ExitVehSig = Signal.Get("ExitVehicle")
	local destroyForza = Signal.Get("destroyForza")

	LocalPlayer.PlayerGui.AppUI.ChildAdded:Connect(function(gui)
		if gui.name == "Speedometer" then
			selfSettings.onVehicle = true
			VehiclePacket = GetLocalVehiclePacket() or {}

			EnterVehSig:Fire(VehiclePacket.Model)

			CurVehicleData.Vehicle = VehiclePacket.Model

			UpdateDataRS = RunService.Heartbeat:Connect(function()
				CurVehicleData.GEAR = tostring(VehiclePacket["Gear"])
				CurVehicleData.MPH = tostring(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text)
				CurVehicleData.RPM = tostring(VehiclePacket["rpmVisual"])
			end)
		end
	end)

	LocalPlayer.PlayerGui.AppUI.ChildRemoved:Connect(function(gui)
		if gui.name == "Speedometer" then
			selfSettings.onVehicle = false

			ExitVehSig:Fire()
			destroyForza:Fire()

			VehicleModel = nil

			pcall(function()
				UpdateDataRS:Disconnect()
			end)
		end
	end)

	if LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
		selfSettings.onVehicle = true
		VehiclePacket = GetLocalVehiclePacket() or {}

		EnterVehSig:Fire(VehiclePacket.Model)

		UpdateDataRS = RunService.Heartbeat:Connect(function()
			CurVehicleData.GEAR = tostring(VehiclePacket["Gear"])
			CurVehicleData.MPH = tostring(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text)
			CurVehicleData.RPM = tostring(VehiclePacket["rpmVisual"])
		end)
	end
end

return VehicleData

end,
WebSocket = function()
local WebSocket = {}

function WebSocket.Run()
	return
end

return WebSocket

end,
},
Modules = {
BoatTween = {
Bezier = function()
local function Linear(T)
	return T
end

local function Bezier(X1, Y1, X2, Y2)
	if not (X1 and Y1 and X2 and Y2) then
		error("Need 4 numbers to construct a Bezier curve", 0)
	end

	if not (0 <= X1 and X1 <= 1 and 0 <= X2 and X2 <= 1) then
		error("The x values must be within range [0, 1]", 0)
	end

	if X1 == Y1 and X2 == Y2 then
		return Linear
	end

	local SampleValues = {}
	for Index = 0, 10 do
		local IndexDiv10 = Index / 10
		SampleValues[Index] = (((1 - 3 * X2 + 3 * X2) * IndexDiv10 + (3 * X2 - 6 * X1)) * IndexDiv10 + (3 * X1))
			* IndexDiv10
	end

	return function(T)
		if T == 0 or T == 1 then
			return T
		end

		local GuessT
		local IntervalStart = 0
		local CurrentSample = 1

		while CurrentSample ~= 10 and SampleValues[CurrentSample] <= T do
			IntervalStart = IntervalStart + 0.1
			CurrentSample = CurrentSample + 1
		end

		CurrentSample = CurrentSample - 1

		local Dist = (T - SampleValues[CurrentSample]) / (SampleValues[CurrentSample + 1] - SampleValues[CurrentSample])
		local GuessForT = IntervalStart + Dist / 10
		local InitialSlope = 3 * (1 - 3 * X2 + 3 * X1) * GuessForT * GuessForT
			+ 2 * (3 * X2 - 6 * X1) * GuessForT
			+ (3 * X1)

		if InitialSlope >= 0.001 then
			for _ = 0, 3 do
				local CurrentSlope = 3 * (1 - 3 * X2 + 3 * X1) * GuessForT * GuessForT
					+ 2 * (3 * X2 - 6 * X1) * GuessForT
					+ (3 * X1)
				local CurrentX = (
					(((1 - 3 * X2 + 3 * X1) * GuessForT + (3 * X2 - 6 * X1)) * GuessForT + (3 * X1)) * GuessForT
				) - T
				GuessForT = GuessForT - (CurrentX / CurrentSlope)
			end

			GuessT = GuessForT
		elseif InitialSlope == 0 then
			GuessT = GuessForT
		else
			local AB = IntervalStart + 0.1
			local CurrentX, CurrentT, Index = 0, nil, nil

			while math.abs(CurrentX) > 0.0000001 and Index < 10 do
				CurrentT = IntervalStart + (AB - IntervalStart) / 2
				CurrentX = ((((1 - 3 * X2 + 3 * X1) * CurrentT + (3 * X2 - 6 * X1)) * CurrentT + (3 * X1)) * CurrentT)
					- T
				if CurrentX > 0 then
					AB = CurrentT
				else
					IntervalStart = CurrentT
				end

				Index = Index + 1
			end

			GuessT = CurrentT
		end

		return (((1 - 3 * Y2 + 3 * Y1) * GuessT + (3 * Y2 - 6 * Y1)) * GuessT + (3 * Y1)) * GuessT
	end
end

return Bezier

end,
init = function()
local RunService = game:GetService("RunService")
local TypeLerpers = import("Modules/BoatTween/Lerps.lua")
local RawTweenFunctions = import("Modules/BoatTween/TweenFunctions.lua")

local Heartbeat = RunService.Heartbeat

local BoatTween = {}

local ValidStepTypes = {
	["Heartbeat"] = true,
	["Stepped"] = true,
	["RenderStepped"] = true,
}

if not RunService:IsClient() then
	ValidStepTypes.RenderStepped = nil
end

local TweenFunctions = {
	FabricAccelerate = {
		In = RawTweenFunctions.InFabricAccelerate,
		Out = RawTweenFunctions.OutFabricAccelerate,
		InOut = RawTweenFunctions.InOutFabricAccelerate,
		OutIn = RawTweenFunctions.OutInFabricAccelerate,
	},

	UWPAccelerate = {
		In = RawTweenFunctions.InUWPAccelerate,
		Out = RawTweenFunctions.OutUWPAccelerate,
		InOut = RawTweenFunctions.InOutUWPAccelerate,
		OutIn = RawTweenFunctions.OutInUWPAccelerate,
	},

	Circ = {
		In = RawTweenFunctions.InCirc,
		Out = RawTweenFunctions.OutCirc,
		InOut = RawTweenFunctions.InOutCirc,
		OutIn = RawTweenFunctions.OutInCirc,
	},

	RevBack = {
		In = RawTweenFunctions.InRevBack,
		Out = RawTweenFunctions.OutRevBack,
		InOut = RawTweenFunctions.InOutRevBack,
		OutIn = RawTweenFunctions.OutInRevBack,
	},

	Spring = {
		In = RawTweenFunctions.InSpring,
		Out = RawTweenFunctions.OutSpring,
		InOut = RawTweenFunctions.InOutSpring,
		OutIn = RawTweenFunctions.OutInSpring,
	},

	Standard = {
		In = RawTweenFunctions.InStandard,
		Out = RawTweenFunctions.OutStandard,
		InOut = RawTweenFunctions.InOutStandard,
		OutIn = RawTweenFunctions.OutInStandard,
	},

	StandardExpressive = {
		In = RawTweenFunctions.InStandardExpressive,
		Out = RawTweenFunctions.OutStandardExpressive,
		InOut = RawTweenFunctions.InOutStandardExpressive,
		OutIn = RawTweenFunctions.OutInStandardExpressive,
	},

	Linear = {
		In = RawTweenFunctions.InLinear,
		Out = RawTweenFunctions.OutLinear,
		InOut = RawTweenFunctions.InOutLinear,
		OutIn = RawTweenFunctions.OutInLinear,
	},

	ExitProductive = {
		In = RawTweenFunctions.InExitProductive,
		Out = RawTweenFunctions.OutExitProductive,
		InOut = RawTweenFunctions.InOutExitProductive,
		OutIn = RawTweenFunctions.OutInExitProductive,
	},

	Deceleration = {
		In = RawTweenFunctions.InDeceleration,
		Out = RawTweenFunctions.OutDeceleration,
		InOut = RawTweenFunctions.InOutDeceleration,
		OutIn = RawTweenFunctions.OutInDeceleration,
	},

	Smoother = {
		In = RawTweenFunctions.InSmoother,
		Out = RawTweenFunctions.OutSmoother,
		InOut = RawTweenFunctions.InOutSmoother,
		OutIn = RawTweenFunctions.OutInSmoother,
	},

	FabricStandard = {
		In = RawTweenFunctions.InFabricStandard,
		Out = RawTweenFunctions.OutFabricStandard,
		InOut = RawTweenFunctions.InOutFabricStandard,
		OutIn = RawTweenFunctions.OutInFabricStandard,
	},

	RidiculousWiggle = {
		In = RawTweenFunctions.InRidiculousWiggle,
		Out = RawTweenFunctions.OutRidiculousWiggle,
		InOut = RawTweenFunctions.InOutRidiculousWiggle,
		OutIn = RawTweenFunctions.OutInRidiculousWiggle,
	},

	MozillaCurve = {
		In = RawTweenFunctions.InMozillaCurve,
		Out = RawTweenFunctions.OutMozillaCurve,
		InOut = RawTweenFunctions.InOutMozillaCurve,
		OutIn = RawTweenFunctions.OutInMozillaCurve,
	},

	Expo = {
		In = RawTweenFunctions.InExpo,
		Out = RawTweenFunctions.OutExpo,
		InOut = RawTweenFunctions.InOutExpo,
		OutIn = RawTweenFunctions.OutInExpo,
	},

	Sine = {
		In = RawTweenFunctions.InSine,
		Out = RawTweenFunctions.OutSine,
		InOut = RawTweenFunctions.InOutSine,
		OutIn = RawTweenFunctions.OutInSine,
	},

	Cubic = {
		In = RawTweenFunctions.InCubic,
		Out = RawTweenFunctions.OutCubic,
		InOut = RawTweenFunctions.InOutCubic,
		OutIn = RawTweenFunctions.OutInCubic,
	},

	EntranceExpressive = {
		In = RawTweenFunctions.InEntranceExpressive,
		Out = RawTweenFunctions.OutEntranceExpressive,
		InOut = RawTweenFunctions.InOutEntranceExpressive,
		OutIn = RawTweenFunctions.OutInEntranceExpressive,
	},

	Elastic = {
		In = RawTweenFunctions.InElastic,
		Out = RawTweenFunctions.OutElastic,
		InOut = RawTweenFunctions.InOutElastic,
		OutIn = RawTweenFunctions.OutInElastic,
	},

	Quint = {
		In = RawTweenFunctions.InQuint,
		Out = RawTweenFunctions.OutQuint,
		InOut = RawTweenFunctions.InOutQuint,
		OutIn = RawTweenFunctions.OutInQuint,
	},

	EntranceProductive = {
		In = RawTweenFunctions.InEntranceProductive,
		Out = RawTweenFunctions.OutEntranceProductive,
		InOut = RawTweenFunctions.InOutEntranceProductive,
		OutIn = RawTweenFunctions.OutInEntranceProductive,
	},

	Bounce = {
		In = RawTweenFunctions.InBounce,
		Out = RawTweenFunctions.OutBounce,
		InOut = RawTweenFunctions.InOutBounce,
		OutIn = RawTweenFunctions.OutInBounce,
	},

	Smooth = {
		In = RawTweenFunctions.InSmooth,
		Out = RawTweenFunctions.OutSmooth,
		InOut = RawTweenFunctions.InOutSmooth,
		OutIn = RawTweenFunctions.OutInSmooth,
	},

	Back = {
		In = RawTweenFunctions.InBack,
		Out = RawTweenFunctions.OutBack,
		InOut = RawTweenFunctions.InOutBack,
		OutIn = RawTweenFunctions.OutInBack,
	},

	Quart = {
		In = RawTweenFunctions.InQuart,
		Out = RawTweenFunctions.OutQuart,
		InOut = RawTweenFunctions.InOutQuart,
		OutIn = RawTweenFunctions.OutInQuart,
	},

	StandardProductive = {
		In = RawTweenFunctions.InStandardProductive,
		Out = RawTweenFunctions.OutStandardProductive,
		InOut = RawTweenFunctions.InOutStandardProductive,
		OutIn = RawTweenFunctions.OutInStandardProductive,
	},

	Quad = {
		In = RawTweenFunctions.InQuad,
		Out = RawTweenFunctions.OutQuad,
		InOut = RawTweenFunctions.InOutQuad,
		OutIn = RawTweenFunctions.OutInQuad,
	},

	FabricDecelerate = {
		In = RawTweenFunctions.InFabricDecelerate,
		Out = RawTweenFunctions.OutFabricDecelerate,
		InOut = RawTweenFunctions.InOutFabricDecelerate,
		OutIn = RawTweenFunctions.OutInFabricDecelerate,
	},

	Acceleration = {
		In = RawTweenFunctions.InAcceleration,
		Out = RawTweenFunctions.OutAcceleration,
		InOut = RawTweenFunctions.InOutAcceleration,
		OutIn = RawTweenFunctions.OutInAcceleration,
	},

	SoftSpring = {
		In = RawTweenFunctions.InSoftSpring,
		Out = RawTweenFunctions.OutSoftSpring,
		InOut = RawTweenFunctions.InOutSoftSpring,
		OutIn = RawTweenFunctions.OutInSoftSpring,
	},

	ExitExpressive = {
		In = RawTweenFunctions.InExitExpressive,
		Out = RawTweenFunctions.OutExitExpressive,
		InOut = RawTweenFunctions.InOutExitExpressive,
		OutIn = RawTweenFunctions.OutInExitExpressive,
	},

	Sharp = {
		In = RawTweenFunctions.InSharp,
		Out = RawTweenFunctions.OutSharp,
		InOut = RawTweenFunctions.InOutSharp,
		OutIn = RawTweenFunctions.OutInSharp,
	},
}

local function Wait(Seconds)
	Seconds = math.max(Seconds or 0.03, 0)
	local TimeRemaining = Seconds

	while TimeRemaining > 0 do
		TimeRemaining = TimeRemaining - Heartbeat:Wait()
	end

	return Seconds - TimeRemaining
end

function BoatTween.Create(_, Object, Data)
	if not Object or typeof(Object) ~= "Instance" then
		return warn("Invalid object to tween:", Object)
	end

	Data = type(Data) == "table" and Data or {}

	local EventStep = ValidStepTypes[Data.StepType] and RunService[Data.StepType] or RunService.Stepped
	local TweenFunction = TweenFunctions[Data.EasingStyle or "Quad"][Data.EasingDirection or "In"]
	local Time = math.max(type(Data.Time) == "number" and Data.Time or 1, 0.001)
	local Goal = type(Data.Goal) == "table" and Data.Goal or {}
	local DelayTime = type(Data.DelayTime) == "number" and Data.DelayTime > 0.027 and Data.DelayTime
	local RepeatCount = (type(Data.RepeatCount) == "number" and math.max(Data.RepeatCount, -1) or 0) + 1

	local TweenData = {}
	for Property, EndValue in pairs(Goal) do
		TweenData[Property] = TypeLerpers[typeof(EndValue)](Object[Property], EndValue)
	end

	local CompletedEvent = Instance.new("BindableEvent")
	local StoppedEvent = Instance.new("BindableEvent")
	local ResumedEvent = Instance.new("BindableEvent")

	local PlaybackConnection
	local StartTime, ElapsedTime = os.clock(), 0

	local TweenObject = {
		["Instance"] = Object,
		["PlaybackState"] = Enum.PlaybackState.Begin,

		["Completed"] = CompletedEvent.Event,
		["Resumed"] = ResumedEvent.Event,
		["Stopped"] = StoppedEvent.Event,
	}

	function TweenObject.Destroy()
		if PlaybackConnection then
			PlaybackConnection:Disconnect()
			PlaybackConnection = nil
		end

		CompletedEvent:Destroy()
		StoppedEvent:Destroy()
		ResumedEvent:Destroy()
		TweenObject = nil
	end

	local CurrentlyReversing = false
	local CurrentLayer = 0

	local function Play(Layer, Reverse)
		if PlaybackConnection then
			PlaybackConnection:Disconnect()
			PlaybackConnection = nil
		end

		Layer = Layer or 1
		if RepeatCount ~= 0 then
			if Layer > RepeatCount then
				TweenObject.PlaybackState = Enum.PlaybackState.Completed
				CompletedEvent:Fire()
				CurrentlyReversing = false
				CurrentLayer = 1
				return
			end
		end

		CurrentLayer = Layer

		if Reverse then
			CurrentlyReversing = true
		end

		if DelayTime then
			TweenObject.PlaybackState = Enum.PlaybackState.Delayed;
			(DelayTime < 2 and Wait or wait)(DelayTime)
		end

		StartTime = os.clock() - ElapsedTime
		PlaybackConnection = EventStep:Connect(function()
			ElapsedTime = os.clock() - StartTime
			if ElapsedTime >= Time then
				if Reverse then
					for Property, Lerper in pairs(TweenData) do
						Object[Property] = Lerper(0)
					end
				else
					for Property, Lerper in pairs(TweenData) do
						Object[Property] = Lerper(1)
					end
				end

				PlaybackConnection:Disconnect()
				PlaybackConnection = nil
				if Reverse then
					ElapsedTime = 0
					Play(Layer + 1, false)
				else
					if Data.Reverses then
						ElapsedTime = 0
						Play(Layer, true)
					else
						ElapsedTime = 0
						Play(Layer + 1, false)
					end
				end
			else
				local Delta = Reverse and (1 - ElapsedTime / Time) or (ElapsedTime / Time)
				local Position = math.clamp(TweenFunction(Delta), 0, 1)

				for Property, Lerper in pairs(TweenData) do
					Object[Property] = Lerper(Position)
				end
			end
		end)

		TweenObject.PlaybackState = Enum.PlaybackState.Playing
	end

	function TweenObject.Play()
		ElapsedTime = 0
		Play(1, false)
	end

	function TweenObject.Stop()
		if PlaybackConnection then
			PlaybackConnection:Disconnect()
			PlaybackConnection = nil
			TweenObject.PlaybackState = Enum.PlaybackState.Cancelled
			StoppedEvent:Fire()
		end
	end

	function TweenObject.Resume()
		Play(CurrentLayer, CurrentlyReversing)
		ResumedEvent:Fire()
	end

	return TweenObject
end

return BoatTween

end,
Lerps = function()
local ipairs = ipairs
local BLACK_COLOR3 = Color3.new()

local function RobloxLerp(V0, V1)
	return function(Alpha)
		return V0:Lerp(V1, Alpha)
	end
end

local function Lerp(Start, Finish, Alpha)
	return Start + Alpha * (Finish - Start)
end

local function SortByTime(A, B)
	return A.Time < B.Time
end

local function Color3Lerp(C0, C1)
	local L0, U0, V0
	local R0, G0, B0 = C0.R, C0.G, C0.B
	R0 = R0 < 0.0404482362771076 and R0 / 12.92 or 0.87941546140213 * (R0 + 0.055) ^ 2.4
	G0 = G0 < 0.0404482362771076 and G0 / 12.92 or 0.87941546140213 * (G0 + 0.055) ^ 2.4
	B0 = B0 < 0.0404482362771076 and B0 / 12.92 or 0.87941546140213 * (B0 + 0.055) ^ 2.4

	local Y0 = 0.2125862307855956 * R0 + 0.71517030370341085 * G0 + 0.0722004986433362 * B0
	local Z0 = 3.6590806972265883 * R0 + 11.4426895800574232 * G0 + 4.1149915024264843 * B0
	local _L0 = Y0 > 0.008856451679035631 and 116 * Y0 ^ (1 / 3) - 16 or 903.296296296296 * Y0

	if Z0 > 1E-15 then
		local X = 0.9257063972951867 * R0 - 0.8333736323779866 * G0 - 0.09209820666085898 * B0
		L0, U0, V0 = _L0, _L0 * X / Z0, _L0 * (9 * Y0 / Z0 - 0.46832)
	else
		L0, U0, V0 = _L0, -0.19783 * _L0, -0.46832 * _L0
	end

	local L1, U1, V1
	local R1, G1, B1 = C1.R, C1.G, C1.B
	R1 = R1 < 0.0404482362771076 and R1 / 12.92 or 0.87941546140213 * (R1 + 0.055) ^ 2.4
	G1 = G1 < 0.0404482362771076 and G1 / 12.92 or 0.87941546140213 * (G1 + 0.055) ^ 2.4
	B1 = B1 < 0.0404482362771076 and B1 / 12.92 or 0.87941546140213 * (B1 + 0.055) ^ 2.4

	local Y1 = 0.2125862307855956 * R1 + 0.71517030370341085 * G1 + 0.0722004986433362 * B1
	local Z1 = 3.6590806972265883 * R1 + 11.4426895800574232 * G1 + 4.1149915024264843 * B1
	local _L1 = Y1 > 0.008856451679035631 and 116 * Y1 ^ (1 / 3) - 16 or 903.296296296296 * Y1

	if Z1 > 1E-15 then
		local X = 0.9257063972951867 * R1 - 0.8333736323779866 * G1 - 0.09209820666085898 * B1
		L1, U1, V1 = _L1, _L1 * X / Z1, _L1 * (9 * Y1 / Z1 - 0.46832)
	else
		L1, U1, V1 = _L1, -0.19783 * _L1, -0.46832 * _L1
	end

	return function(Alpha)
		local L = (1 - Alpha) * L0 + Alpha * L1
		if L < 0.0197955 then
			return BLACK_COLOR3
		end

		local U = ((1 - Alpha) * U0 + Alpha * U1) / L + 0.19783
		local V = ((1 - Alpha) * V0 + Alpha * V1) / L + 0.46832

		local Y = (L + 16) / 116
		Y = Y > 0.206896551724137931 and Y * Y * Y or 0.12841854934601665 * Y - 0.01771290335807126
		local X = Y * U / V
		local Z = Y * ((3 - 0.75 * U) / V - 5)

		local R = 7.2914074 * X - 1.5372080 * Y - 0.4986286 * Z
		local G = -2.1800940 * X + 1.8757561 * Y + 0.0415175 * Z
		local B = 0.1253477 * X - 0.2040211 * Y + 1.0569959 * Z

		if R < 0 and R < G and R < B then
			R, G, B = 0, G - R, B - R
		elseif G < 0 and G < B then
			R, G, B = R - G, 0, B - G
		elseif B < 0 then
			R, G, B = R - B, G - B, 0
		end

		R = R < 3.1306684425E-3 and 12.92 * R or 1.055 * R ^ (1 / 2.4) - 0.055
		G = G < 3.1306684425E-3 and 12.92 * G or 1.055 * G ^ (1 / 2.4) - 0.055
		B = B < 3.1306684425E-3 and 12.92 * B or 1.055 * B ^ (1 / 2.4) - 0.055

		R = R > 1 and 1 or R < 0 and 0 or R
		G = G > 1 and 1 or G < 0 and 0 or G
		B = B > 1 and 1 or B < 0 and 0 or B

		return Color3.new(R, G, B)
	end
end

local Lerps = setmetatable({
	boolean = function(V0, V1)
		return function(Alpha)
			if Alpha < 0.5 then
				return V0
			else
				return V1
			end
		end
	end,

	number = function(V0, V1)
		local Delta = V1 - V0
		return function(Alpha)
			return V0 + Delta * Alpha
		end
	end,

	string = function(V0, V1)
		local RegularString = false

		local N0, D
		do
			local Sign0, H0, M0, S0 = string.match(V0, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
			local Sign1, H1, M1, S1 = string.match(V1, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
			if Sign0 and Sign1 then
				N0 = 3600 * (tonumber(H0) or 0) + 60 * (tonumber(M0) or 0) + (tonumber(S0) or 0)
				local N1 = 3600 * (tonumber(H1) or 0) + 60 * (tonumber(M1) or 0) + (tonumber(S1) or 0)
				if Sign0 == "-" then
					N0 = -N0
				end

				D = (43200 + (Sign1 ~= "-" and N1 or -N1) - N0) % 86400 - 43200
			else
				RegularString = true
			end
		end

		if RegularString then
			local Length = #V1
			return function(Alpha)
				Alpha = 1 + Length * Alpha
				return string.sub(V1, 1, Alpha < Length and Alpha or Length)
			end
		else
			return function(Alpha)
				local FS = (N0 + D * Alpha) % 86400
				local S = math.abs(FS)
				return string.format(
					FS < 0 and "-%.2u:%.2u:%.2u" or "%.2u:%.2u:%.2u",
					(S - S % 3600) / 3600,
					(S % 3600 - S % 60) / 60,
					S % 60
				)
			end
		end
	end,

	CFrame = RobloxLerp,
	Color3 = Color3Lerp,
	NumberRange = function(V0, V1)
		local Min0, Max0 = V0.Min, V0.Max
		local DeltaMin, DeltaMax = V1.Min - Min0, V1.Max - Max0

		return function(Alpha)
			return NumberRange.new(Min0 + Alpha * DeltaMin, Max0 + Alpha * DeltaMax)
		end
	end,

	NumberSequenceKeypoint = function(V0, V1)
		local T0, Value0, E0 = V0.Time, V0.Value, V0.Envelope
		local DT, DV, DE = V1.Time - T0, V1.Value - Value0, V1.Envelope - E0

		return function(Alpha)
			return NumberSequenceKeypoint.new(T0 + Alpha * DT, Value0 + Alpha * DV, E0 + Alpha * DE)
		end
	end,

	PhysicalProperties = function(V0, V1)
		local D0, E0, EW0, F0, FW0 = V0.Density, V0.Elasticity, V0.ElasticityWeight, V0.Friction, V0.FrictionWeight

		local DD, DE, DEW, DF, DFW =
			V1.Density - D0, V1.Elasticity - E0, V1.ElasticityWeight - EW0, V1.Friction - F0, V1.FrictionWeight - FW0

		return function(Alpha)
			return PhysicalProperties.new(
				D0 + Alpha * DD,
				E0 + Alpha * DE,
				EW0 + Alpha * DEW,
				F0 + Alpha * DF,
				FW0 + Alpha * DFW
			)
		end
	end,

	Ray = function(V0, V1)
		local O0, D0, O1, D1 = V0.Origin, V0.Direction, V1.Origin, V1.Direction
		local OX0, OY0, OZ0, DX0, DY0, DZ0 = O0.X, O0.Y, O0.Z, D0.X, D0.Y, D0.Z
		local DOX, DOY, DOZ, DDX, DDY, DDZ = O1.X - OX0, O1.Y - OY0, O1.Z - OZ0, D1.X - DX0, D1.Y - DY0, D1.Z - DZ0

		return function(Alpha)
			return Ray.new(
				Vector3.new(OX0 + Alpha * DOX, OY0 + Alpha * DOY, OZ0 + Alpha * DOZ),
				Vector3.new(DX0 + Alpha * DDX, DY0 + Alpha * DDY, DZ0 + Alpha * DDZ)
			)
		end
	end,

	UDim = function(V0, V1)
		local SC, OF = V0.Scale, V0.Offset
		local DSC, DOF = V1.Scale - SC, V1.Offset - OF

		return function(Alpha)
			return UDim.new(SC + Alpha * DSC, OF + Alpha * DOF)
		end
	end,

	UDim2 = RobloxLerp,
	Vector2 = RobloxLerp,
	Vector3 = RobloxLerp,
	Rect = function(V0, V1)
		return function(Alpha)
			return Rect.new(
				V0.Min.X + Alpha * (V1.Min.X - V0.Min.X),
				V0.Min.Y + Alpha * (V1.Min.Y - V0.Min.Y),
				V0.Max.X + Alpha * (V1.Max.X - V0.Max.X),
				V0.Max.Y + Alpha * (V1.Max.Y - V0.Max.Y)
			)
		end
	end,

	Region3 = function(V0, V1)
		return function(Alpha)
			local imin = Lerp(V0.CFrame * (-V0.Size / 2), V1.CFrame * (-V1.Size / 2), Alpha)
			local imax = Lerp(V0.CFrame * (V0.Size / 2), V1.CFrame * (V1.Size / 2), Alpha)

			local iminx = imin.X
			local imaxx = imax.X
			local iminy = imin.Y
			local imaxy = imax.Y
			local iminz = imin.Z
			local imaxz = imax.Z

			return Region3.new(
				Vector3.new(
					iminx < imaxx and iminx or imaxx,
					iminy < imaxy and iminy or imaxy,
					iminz < imaxz and iminz or imaxz
				),
				Vector3.new(
					iminx > imaxx and iminx or imaxx,
					iminy > imaxy and iminy or imaxy,
					iminz > imaxz and iminz or imaxz
				)
			)
		end
	end,

	NumberSequence = function(V0, V1)
		return function(Alpha)
			local keypoints = {}
			local addedTimes = {}
			local keylength = 0

			for _, ap in ipairs(V0.Keypoints) do
				local closestAbove, closestBelow

				for _, bp in ipairs(V1.Keypoints) do
					if bp.Time == ap.Time then
						closestAbove, closestBelow = bp, bp
						break
					elseif bp.Time < ap.Time and (closestBelow == nil or bp.Time > closestBelow.Time) then
						closestBelow = bp
					elseif bp.Time > ap.Time and (closestAbove == nil or bp.Time < closestAbove.Time) then
						closestAbove = bp
					end
				end

				local bValue, bEnvelope
				if closestAbove == closestBelow then
					bValue, bEnvelope = closestAbove.Value, closestAbove.Envelope
				else
					local p = (ap.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
					bValue = (closestAbove.Value - closestBelow.Value) * p + closestBelow.Value
					bEnvelope = (closestAbove.Envelope - closestBelow.Envelope) * p + closestBelow.Envelope
				end

				keylength = keylength + 1
				keypoints[keylength] = NumberSequenceKeypoint.new(
					ap.Time,
					(bValue - ap.Value) * Alpha + ap.Value,
					(bEnvelope - ap.Envelope) * Alpha + ap.Envelope
				)
				addedTimes[ap.Time] = true
			end

			for _, bp in ipairs(V1.Keypoints) do
				if not addedTimes[bp.Time] then
					local closestAbove, closestBelow

					for _, ap in ipairs(V0.Keypoints) do
						if ap.Time == bp.Time then
							closestAbove, closestBelow = ap, ap
							break
						elseif ap.Time < bp.Time and (closestBelow == nil or ap.Time > closestBelow.Time) then
							closestBelow = ap
						elseif ap.Time > bp.Time and (closestAbove == nil or ap.Time < closestAbove.Time) then
							closestAbove = ap
						end
					end

					local aValue, aEnvelope
					if closestAbove == closestBelow then
						aValue, aEnvelope = closestAbove.Value, closestAbove.Envelope
					else
						local p = (bp.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
						aValue = (closestAbove.Value - closestBelow.Value) * p + closestBelow.Value
						aEnvelope = (closestAbove.Envelope - closestBelow.Envelope) * p + closestBelow.Envelope
					end

					keylength = keylength + 1
					keypoints[keylength] = NumberSequenceKeypoint.new(
						bp.Time,
						(bp.Value - aValue) * Alpha + aValue,
						(bp.Envelope - aEnvelope) * Alpha + aEnvelope
					)
				end
			end

			table.sort(keypoints, SortByTime)
			return NumberSequence.new(keypoints)
		end
	end,

	ColorSequence = function(V0, V1)
		return function(Alpha)
			local keypoints = {}
			local addedTimes = {}
			local keylength = 0

			for _, ap in ipairs(V0.Keypoints) do
				local closestAbove, closestBelow

				for _, bp in ipairs(V1.Keypoints) do
					if bp.Time == ap.Time then
						closestAbove, closestBelow = bp, bp
						break
					elseif bp.Time < ap.Time and (closestBelow == nil or bp.Time > closestBelow.Time) then
						closestBelow = bp
					elseif bp.Time > ap.Time and (closestAbove == nil or bp.Time < closestAbove.Time) then
						closestAbove = bp
					end
				end

				local bValue
				if closestAbove == closestBelow then
					bValue = closestAbove.Value
				else
					bValue = Color3Lerp(closestBelow.Value, closestAbove.Value)(
						(ap.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
					)
				end

				keylength = keylength + 1
				keypoints[keylength] = ColorSequenceKeypoint.new(ap.Time, Color3Lerp(ap.Value, bValue)(Alpha))
				addedTimes[ap.Time] = true
			end

			for _, bp in ipairs(V1.Keypoints) do
				if not addedTimes[bp.Time] then
					local closestAbove, closestBelow

					for _, ap in ipairs(V0.Keypoints) do
						if ap.Time == bp.Time then
							closestAbove, closestBelow = ap, ap
							break
						elseif ap.Time < bp.Time and (closestBelow == nil or ap.Time > closestBelow.Time) then
							closestBelow = ap
						elseif ap.Time > bp.Time and (closestAbove == nil or ap.Time < closestAbove.Time) then
							closestAbove = ap
						end
					end

					local aValue
					if closestAbove == closestBelow then
						aValue = closestAbove.Value
					else
						aValue = Color3Lerp(closestBelow.Value, closestAbove.Value)(
							(bp.Time - closestBelow.Time) / (closestAbove.Time - closestBelow.Time)
						)
					end

					keylength = keylength + 1
					keypoints[keylength] = ColorSequenceKeypoint.new(bp.Time, Color3Lerp(bp.Value, aValue)(Alpha))
				end
			end

			table.sort(keypoints, SortByTime)
			return ColorSequence.new(keypoints)
		end
	end,
}, {
	__index = function(_, Index)
		error("No lerp function is defined for type " .. tostring(Index) .. ".", 4)
	end,

	__newindex = function(_, Index)
		error("No lerp function is defined for type " .. tostring(Index) .. ".", 4)
	end,
})

return Lerps

end,
TweenFunctions = function()
local Bezier = import("Modules/BoatTween/Bezier.lua")

local PI = math.pi
local HALF_PI = PI / 2

local function RevBack(T)
	T = 1 - T
	return 1 - (math.sin(T * HALF_PI) + (math.sin(T * PI) * (math.cos(T * PI) + 1) / 2))
end

local function Linear(T)
	return T
end

local Sharp = Bezier(0.4, 0, 0.6, 1)
local Standard = Bezier(0.4, 0, 0.2, 1)
local Acceleration = Bezier(0.4, 0, 1, 1)
local Deceleration = Bezier(0, 0, 0.2, 1)

local FabricStandard = Bezier(0.8, 0, 0.2, 1)
local FabricAccelerate = Bezier(0.9, 0.1, 1, 0.2)
local FabricDecelerate = Bezier(0.1, 0.9, 0.2, 1)

local UWPAccelerate = Bezier(0.7, 0, 1, 0.5)

local StandardProductive = Bezier(0.2, 0, 0.38, 0.9)
local StandardExpressive = Bezier(0.4, 0.14, 0.3, 1)

local EntranceProductive = Bezier(0, 0, 0.38, 0.9)
local EntranceExpressive = Bezier(0, 0, 0.3, 1)

local ExitProductive = Bezier(0.2, 0, 1, 0.9)
local ExitExpressive = Bezier(0.4, 0.14, 1, 1)

local MozillaCurve = Bezier(0.07, 0.95, 0, 1)

local function Smooth(T)
	return T * T * (3 - 2 * T)
end

local function Smoother(T)
	return T * T * T * (T * (6 * T - 15) + 10)
end

local function RidiculousWiggle(T)
	return math.sin(math.sin(T * PI) * HALF_PI)
end

local function Spring(T)
	return 1 + (-math.exp(-6.9 * T) * math.cos(-20.106192982975 * T))
end

local function SoftSpring(T)
	return 1 + (-math.exp(-7.5 * T) * math.cos(-10.053096491487 * T))
end

local function OutBounce(T)
	if T < 0.36363636363636 then
		return 7.5625 * T * T
	elseif T < 0.72727272727273 then
		return 3 + T * (11 * T - 12) * 0.6875
	elseif T < 0.090909090909091 then
		return 6 + T * (11 * T - 18) * 0.6875
	else
		return 7.875 + T * (11 * T - 21) * 0.6875
	end
end

local function InBounce(T)
	if T > 0.63636363636364 then
		T = T - 1
		return 1 - T * T * 7.5625
	elseif T > 0.272727272727273 then
		return (11 * T - 7) * (11 * T - 3) / -16
	elseif T > 0.090909090909091 then
		return (11 * (4 - 11 * T) * T - 3) / 16
	else
		return T * (11 * T - 1) * -0.6875
	end
end

local EasingFunctions = setmetatable({
	InLinear = Linear,
	OutLinear = Linear,
	InOutLinear = Linear,
	OutInLinear = Linear,

	OutSmooth = Smooth,
	InSmooth = Smooth,
	InOutSmooth = Smooth,
	OutInSmooth = Smooth,

	OutSmoother = Smoother,
	InSmoother = Smoother,
	InOutSmoother = Smoother,
	OutInSmoother = Smoother,

	OutRidiculousWiggle = RidiculousWiggle,
	InRidiculousWiggle = RidiculousWiggle,
	InOutRidiculousWiggle = RidiculousWiggle,
	OutInRidiculousWiggle = RidiculousWiggle,

	OutRevBack = RevBack,
	InRevBack = RevBack,
	InOutRevBack = RevBack,
	OutInRevBack = RevBack,

	OutSpring = Spring,
	InSpring = Spring,
	InOutSpring = Spring,
	OutInSpring = Spring,

	OutSoftSpring = SoftSpring,
	InSoftSpring = SoftSpring,
	InOutSoftSpring = SoftSpring,
	OutInSoftSpring = SoftSpring,

	InSharp = Sharp,
	InOutSharp = Sharp,
	OutSharp = Sharp,
	OutInSharp = Sharp,

	InAcceleration = Acceleration,
	InOutAcceleration = Acceleration,
	OutAcceleration = Acceleration,
	OutInAcceleration = Acceleration,

	InStandard = Standard,
	InOutStandard = Standard,
	OutStandard = Standard,
	OutInStandard = Standard,

	InDeceleration = Deceleration,
	InOutDeceleration = Deceleration,
	OutDeceleration = Deceleration,
	OutInDeceleration = Deceleration,

	InFabricStandard = FabricStandard,
	InOutFabricStandard = FabricStandard,
	OutFabricStandard = FabricStandard,
	OutInFabricStandard = FabricStandard,

	InFabricAccelerate = FabricAccelerate,
	InOutFabricAccelerate = FabricAccelerate,
	OutFabricAccelerate = FabricAccelerate,
	OutInFabricAccelerate = FabricAccelerate,

	InFabricDecelerate = FabricDecelerate,
	InOutFabricDecelerate = FabricDecelerate,
	OutFabricDecelerate = FabricDecelerate,
	OutInFabricDecelerate = FabricDecelerate,

	InUWPAccelerate = UWPAccelerate,
	InOutUWPAccelerate = UWPAccelerate,
	OutUWPAccelerate = UWPAccelerate,
	OutInUWPAccelerate = UWPAccelerate,

	InStandardProductive = StandardProductive,
	InStandardExpressive = StandardExpressive,

	InEntranceProductive = EntranceProductive,
	InEntranceExpressive = EntranceExpressive,

	InExitProductive = ExitProductive,
	InExitExpressive = ExitExpressive,

	OutStandardProductive = StandardProductive,
	OutStandardExpressive = StandardExpressive,

	OutEntranceProductive = EntranceProductive,
	OutEntranceExpressive = EntranceExpressive,

	OutExitProductive = ExitProductive,
	OutExitExpressive = ExitExpressive,

	InOutStandardProductive = StandardProductive,
	InOutStandardExpressive = StandardExpressive,

	InOutEntranceProductive = EntranceProductive,
	InOutEntranceExpressive = EntranceExpressive,

	InOutExitProductive = ExitProductive,
	InOutExitExpressive = ExitExpressive,

	OutInStandardProductive = StandardProductive,
	OutInStandardExpressive = StandardProductive,

	OutInEntranceProductive = EntranceProductive,
	OutInEntranceExpressive = EntranceExpressive,

	OutInExitProductive = ExitProductive,
	OutInExitExpressive = ExitExpressive,

	OutMozillaCurve = MozillaCurve,
	InMozillaCurve = MozillaCurve,
	InOutMozillaCurve = MozillaCurve,
	OutInMozillaCurve = MozillaCurve,

	InQuad = function(T)
		return T * T
	end,

	OutQuad = function(T)
		return T * (2 - T)
	end,

	InOutQuad = function(T)
		if T < 0.5 then
			return 2 * T * T
		else
			return 2 * (2 - T) * T - 1
		end
	end,

	OutInQuad = function(T)
		if T < 0.5 then
			T = T * 2
			return T * (2 - T) / 2
		else
			T = T * 2 - 1
			return T * T / 2 + 0.5
		end
	end,

	InCubic = function(T)
		return T * T * T
	end,

	OutCubic = function(T)
		T = T - 1
		return 1 - T * T * T
	end,

	InOutCubic = function(T)
		if T < 0.5 then
			return 4 * T * T * T
		else
			T = T - 1
			return 1 + 4 * T * T * T
		end
	end,

	OutInCubic = function(T)
		if T < 0.5 then
			T = 1 - T * 2
			return (1 - T * T * T) / 2
		else
			T = T * 2 - 1
			return T * T * T / 2 + 0.5
		end
	end,

	InQuart = function(T)
		return T * T * T * T
	end,

	OutQuart = function(T)
		T = T - 1
		return 1 - T * T * T * T
	end,

	InOutQuart = function(T)
		if T < 0.5 then
			T = T * T
			return 8 * T * T
		else
			T = T - 1
			return 1 - 8 * T * T * T * T
		end
	end,

	OutInQuart = function(T)
		if T < 0.5 then
			T = T * 2 - 1
			return (1 - T * T * T * T) / 2
		else
			T = T * 2 - 1
			return T * T * T * T / 2 + 0.5
		end
	end,

	InQuint = function(T)
		return T * T * T * T * T
	end,

	OutQuint = function(T)
		T = T - 1
		return T * T * T * T * T + 1
	end,

	InOutQuint = function(T)
		if T < 0.5 then
			return 16 * T * T * T * T * T
		else
			T = T - 1
			return 16 * T * T * T * T * T + 1
		end
	end,

	OutInQuint = function(T)
		if T < 0.5 then
			T = T * 2 - 1
			return (T * T * T * T * T + 1) / 2
		else
			T = T * 2 - 1
			return T * T * T * T * T / 2 + 0.5
		end
	end,

	InBack = function(T)
		return T * T * (3 * T - 2)
	end,

	OutBack = function(T)
		local TSubOne = T - 1
		return TSubOne * TSubOne * (T * 2 + TSubOne) + 1
	end,

	InOutBack = function(T)
		if T < 0.5 then
			return 2 * T * T * (2 * 3 * T - 2)
		else
			return 1 + 2 * (T - 1) * (T - 1) * (2 * 3 * T - 2 - 2)
		end
	end,

	OutInBack = function(T)
		if T < 0.5 then
			T = T * 2
			local TSubOne = T - 1
			return (TSubOne * TSubOne * (T * 2 + TSubOne) + 1) / 2
		else
			T = T * 2 - 1
			return T * T * (3 * T - 2) / 2 + 0.5
		end
	end,

	InSine = function(T)
		return 1 - math.cos(T * HALF_PI)
	end,

	OutSine = function(T)
		return math.sin(T * HALF_PI)
	end,

	InOutSine = function(T)
		return (1 - math.cos(PI * T)) / 2
	end,

	OutInSine = function(T)
		if T < 0.5 then
			return math.sin(T * PI) / 2
		else
			return (1 - math.cos((T * 2 - 1) * HALF_PI)) / 2 + 0.5
		end
	end,

	OutBounce = OutBounce,
	InBounce = InBounce,

	InOutBounce = function(T)
		if T < 0.5 then
			return InBounce(2 * T) / 2
		else
			return OutBounce(2 * T - 1) / 2 + 0.5
		end
	end,

	OutInBounce = function(T)
		if T < 0.5 then
			return OutBounce(2 * T) / 2
		else
			return InBounce(2 * T - 1) / 2 + 0.5
		end
	end,

	InElastic = function(T)
		return math.exp((T * 0.96380736418812 - 1) * 8)
			* T
			* 0.96380736418812
			* math.sin(4 * T * 0.96380736418812)
			* 1.8752275007429
	end,

	OutElastic = function(T)
		return 1
			+ (
					math.exp(8 * (0.96380736418812 - 0.96380736418812 * T - 1))
					* 0.96380736418812
					* (T - 1)
					* math.sin(4 * 0.96380736418812 * (1 - T))
				)
				* 1.8752275007429
	end,

	InOutElastic = function(T)
		if T < 0.5 then
			return (
				math.exp(8 * (2 * 0.96380736418812 * T - 1))
				* 0.96380736418812
				* T
				* math.sin(7.71045891350496 * T)
			) * 1.8752275007429
		else
			return 1
				+ (
						math.exp(8 * (0.96380736418812 * (2 - 2 * T) - 1))
						* 0.96380736418812
						* (T - 1)
						* math.sin(3.85522945675248 * (2 - 2 * T))
					)
					* 1.8752275007429
		end
	end,

	OutInElastic = function(T)
		if T < 0.5 then
			T = T * 2
			return (
				1
				+ (
						math.exp(8 * (0.96380736418812 - 0.96380736418812 * T - 1))
						* 0.96380736418812
						* (T - 1)
						* math.sin(3.85522945675248 * (1 - T))
					)
					* 1.8752275007429
			) / 2
		else
			T = T * 2 - 1
			return (
				math.exp((T * 0.96380736418812 - 1) * 8)
				* T
				* 0.96380736418812
				* math.sin(4 * T * 0.96380736418812)
				* 1.8752275007429
			)
					/ 2
				+ 0.5
		end
	end,

	InExpo = function(T)
		return T * T * math.exp(4 * (T - 1))
	end,

	OutExpo = function(T)
		return 1 - (1 - T) * (1 - T) / math.exp(4 * T)
	end,

	InOutExpo = function(T)
		if T < 0.5 then
			return 2 * T * T * math.exp(4 * (2 * T - 1))
		else
			return 1 - 2 * (T - 1) * (T - 1) * math.exp(4 * (1 - 2 * T))
		end
	end,

	OutInExpo = function(T)
		if T < 0.5 then
			T = T * 2
			return (1 - (1 - T) * (1 - T) / math.exp(4 * T)) / 2
		else
			T = T * 2 - 1
			return (T * T * math.exp(4 * (T - 1))) / 2 + 0.5
		end
	end,

	InCirc = function(T)
		return -(math.sqrt(1 - T * T) - 1)
	end,

	OutCirc = function(T)
		T = T - 1
		return math.sqrt(1 - T * T)
	end,

	InOutCirc = function(T)
		T = T * 2
		if T < 1 then
			return -(math.sqrt(1 - T * T) - 1) / 2
		else
			T = T - 2
			return (math.sqrt(1 - T * T) - 1) / 2
		end
	end,

	OutInCirc = function(T)
		if T < 0.5 then
			T = T * 2 - 1
			return math.sqrt(1 - T * T) / 2
		else
			T = T * 2 - 1
			return -(math.sqrt(1 - T * T) - 1) / 2 + 0.5
		end
	end,
}, {
	__index = function(_, Index)
		error(tostring(Index) .. " is not a valid easing function.", 2)
	end,
})

return EasingFunctions

end,
},
CutScene = {
Cubic = function()
local Players = game:GetService("Players")
local module = {}
module.Settings = {
	YieldPauseArgument = false,
}

local plr = Players.LocalPlayer
local char

do
	local function characterAdded(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			if module.Playing then
				module.Playing:Cancel()
			end
		end)
		char = character
	end
	if plr.Character then
		characterAdded(plr.Character)
	end
	plr.CharacterAdded:Connect(characterAdded)
end
char = plr.Character or plr.CharacterAdded:Wait()

local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local controls = require(plr.PlayerScripts.PlayerModule):GetControls()
local easingFunctions = import("Modules/CutScene/EasingFunctions.lua")
local rootPart = char:WaitForChild("HumanoidRootPart")
local camera = Workspace.CurrentCamera
local clock = os.clock

local Signal = {}
Signal.__index = Signal

do
	local freeRunnerThread
	local function acquireRunnerThreadAndCallEventHandler(fn, ...)
		local acquiredRunnerThread = freeRunnerThread
		freeRunnerThread = nil
		fn(...)
		freeRunnerThread = acquiredRunnerThread
	end

	local function runEventHandlerInFreeThread(...)
		acquireRunnerThreadAndCallEventHandler(...)
		while true do
			acquireRunnerThreadAndCallEventHandler(coroutine.yield())
		end
	end

	local Connection = {}
	Connection.__index = Connection

	function Connection.new(signal, fn)
		return setmetatable({
			Connected = true,
			_signal = signal,
			_fn = fn,
			_next = false,
		}, Connection)
	end

	function Connection:Disconnect()
		assert(self.Connected, "Can't disconnect a connection twice")
		self.Connected = false
		if self._signal._handlerListHead == self then
			self._signal._handlerListHead = self._next
		else
			local prev = self._signal._handlerListHead
			while prev and prev._next ~= self do
				prev = prev._next
			end
			if prev then
				prev._next = self._next
			end
		end
	end

	function Signal.new()
		return setmetatable({ _handlerListHead = false }, Signal)
	end

	function Signal:Connect(fn)
		local connection = Connection.new(self, fn)
		if self._handlerListHead then
			connection._next = self._handlerListHead
			self._handlerListHead = connection
		else
			self._handlerListHead = connection
		end
		return connection
	end

	function Signal:DisconnectAll()
		self._handlerListHead = false
	end

	function Signal:Fire(...)
		local item = self._handlerListHead
		while item do
			if item.Connected then
				if not freeRunnerThread then
					freeRunnerThread = coroutine.create(runEventHandlerInFreeThread)
				end
				task.spawn(freeRunnerThread, item._fn, ...)
			end
			item = item._next
		end
	end

	function Signal:Wait()
		local waitingCoroutine = coroutine.running()
		local cn
		cn = self:Connect(function(...)
			cn:Disconnect()
			task.spawn(waitingCoroutine, ...)
		end)
		return coroutine.yield()
	end
end

local function getCF(points, t)
	local copy = { unpack(points) }

	repeat
		for i, v in ipairs(copy) do
			if i ~= 1 then
				copy[i - 1] = copy[i - 1]:Lerp(v, t)
			end
		end
		if #copy ~= 1 then
			copy[#copy] = nil
		end
	until #copy == 1

	return copy[1]
end

local function getCoreGuisEnabled()
	return {
		Backpack = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack),
		Chat = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat),
		EmotesMenu = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu),
		Health = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Health),
		PlayerList = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList),
	}
end

module.Enum = {
	DisableControls = "DisableControls",
	CurrentCameraPoint = "CurrentCameraPoint",
	DefaultCameraPoint = "DefaultCameraPoint",
	FreezeCharacter = "FreezeCharacter",
	CustomCamera = "CustomCamera",
}

local specialFunctions = {
	Start = {
		{
			"CustomCamera",
			function(self, customCamera)
				assert(customCamera, "CustomCamera Argument 1 missing or nil")
				camera = customCamera
				self.CustomCamera = customCamera
			end,
		},
		{
			"DisableControls",
			function()
				controls:Disable()
			end,
		},
		{
			"FreezeCharacter",
			function(_, stopAnimations)
				if stopAnimations ~= false then
					for _, v in ipairs(char.Humanoid.Animator:GetPlayingAnimationTracks()) do
						v:Stop()
					end
				end
				rootPart.Anchored = true
			end,
		},
		{
			"CurrentCameraPoint",
			function(self, position)
				table.insert(self.PointsCopy, position or #self.PointsCopy + 1, camera.CFrame)
			end,
		},
		{
			"DefaultCameraPoint",
			function(self, position, useCurrentZoomDistance)
				local zoomDistance = 12.5
				if useCurrentZoomDistance == false then
					local oldMin = plr.CameraMinZoomDistance
					local oldMax = plr.CameraMaxZoomDistance
					plr.CameraMinZoomDistance = zoomDistance
					plr.CameraMaxZoomDistance = zoomDistance
					task.wait()

					plr.CameraMinZoomDistance = oldMin
					plr.CameraMaxZoomDistance = oldMax
				else
					zoomDistance = (camera.CFrame.Position - camera.Focus.Position).Magnitude
				end
				local lookAt = rootPart.CFrame.Position + Vector3.new(0, rootPart.Size.Y / 2 + 0.5, 0)
				local at = (rootPart.CFrame * CFrame.new(
					0,
					zoomDistance / 2.6397830596715992,
					zoomDistance / 1.0352760971197642
				)).Position

				table.insert(self.PointsCopy, position or #self.PointsCopy + 1, CFrame.lookAt(at, lookAt))
			end,
		},
	},
	End = {
		{
			"DisableControls",
			function()
				controls:Enable(true)
			end,
		},
		{
			"FreezeCharacter",
			function()
				rootPart.Anchored = false
			end,
		},
		{
			"CustomCamera",
			function(self)
				camera.CameraType = self.PreviousCameraType
				camera = Workspace.CurrentCamera
			end,
		},
	},
}

specialFunctions.StartKeys = {}
specialFunctions.EndKeys = {}
for i, v in ipairs(specialFunctions.Start) do
	table.insert(specialFunctions.StartKeys, v[1])
	specialFunctions.Start[i] = v[2]
end
for i, v in ipairs(specialFunctions.End) do
	table.insert(specialFunctions.EndKeys, v[1])
	specialFunctions.End[i] = v[2]
end

local cutscene = {}
cutscene.__index = cutscene
cutscene.ClassName = "Cutscene"

function cutscene:Play()
	if module.Playing == nil or module.Playing.CurrentCutscene == self or module.Playing.Next == self then
		if not module.Playing or not module.Playing.CurrentCutscene then
			module.Playing = self
		end

		self.PointsCopy = { unpack(self.Points) }
		local pointsCopy = self.PointsCopy
		local easingFunction = easingFunctions[self.EasingFunction]
		local duration = self.Duration
		local passedTime

		if not self.Next then
			self.PreviousCoreGuis = getCoreGuisEnabled()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		end

		for _, v in ipairs(self.SpecialFunctions[1]) do
			if type(v) == "table" then
				specialFunctions.Start[v[1]](self, select(2, unpack(v)))
			else
				specialFunctions.Start[v](self)
			end
		end

		assert(#self.PointsCopy > 1, "More than one point is required")

		self.PreviousCameraType = camera.CameraType
		camera.CameraType = Enum.CameraType.Scriptable

		self.PlaybackState = Enum.PlaybackState.Playing
		local start = clock()

		RunService:BindToRenderStep("Cutscene", Enum.RenderPriority.Camera.Value + 1, function()
			passedTime = clock() - start

			if passedTime <= duration then
				camera.CFrame = getCF(pointsCopy, easingFunction(passedTime, 0, 1, duration))
				self.Progress = passedTime / duration
				self.PassedTime = passedTime
			else
				RunService:UnbindFromRenderStep("Cutscene")
				self.Progress = 1
				self.PassedTime = duration

				for _, v in ipairs(self.SpecialFunctions[2]) do
					if type(v) == "table" then
						specialFunctions.End[v[1]](self, select(2, unpack(v)))
					else
						specialFunctions.End[v](self)
					end
				end

				self.PlaybackState = Enum.PlaybackState.Completed

				if self.Next then
					if self.Next == 0 then
						local queue = module.Playing
						module.Playing = nil
						queue.PlaybackState = Enum.PlaybackState.Completed
						camera.CameraType = queue.PreviousCameraType
						queue.CurrentCutscene = nil
						for k, v in next, queue.PreviousCoreGuis do
							if v then
								StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
							end
						end
						for _, v in ipairs(queue.Cutscenes) do
							v.Next = nil
						end
						queue.Completed:Fire(Enum.PlaybackState.Completed)
					else
						if module.Playing.CurrentCutscene then
							module.Playing.CurrentCutscene = self.Next
						end
						self.Completed:Fire(Enum.PlaybackState.Completed)
						self.Next:Play()
					end
				else
					module.Playing = nil
					if not self.CustomCamera then
						camera.CameraType = self.PreviousCameraType
					end

					for k, v in next, self.PreviousCoreGuis do
						if v then
							StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
						end
					end
					self.Completed:Fire(Enum.PlaybackState.Completed)
				end
			end
		end)
	else
		error("Error while calling Play - A cutscene was already playing")
	end
end

function cutscene:PlayObject(object)
	if module.Playing == nil or module.Playing.CurrentCutscene == self or module.Playing.Next == self then
		if not module.Playing or not module.Playing.CurrentCutscene then
			module.Playing = self
		end

		self.PointsCopy = { unpack(self.Points) }
		local pointsCopy = self.PointsCopy
		local easingFunction = easingFunctions[self.EasingFunction]
		local duration = self.Duration
		local passedTime

		if not self.Next then
			self.PreviousCoreGuis = getCoreGuisEnabled()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		end

		for _, v in ipairs(self.SpecialFunctions[1]) do
			if type(v) == "table" then
				specialFunctions.Start[v[1]](self, select(2, unpack(v)))
			else
				specialFunctions.Start[v](self)
			end
		end

		assert(#self.PointsCopy > 1, "More than one point is required")

		self.PlaybackState = Enum.PlaybackState.Playing
		local start = clock()

		RunService:BindToRenderStep("CutsceneObject", Enum.RenderPriority.Camera.Value + 1, function()
			passedTime = clock() - start

			if passedTime <= duration then
				object.CFrame = getCF(pointsCopy, easingFunction(passedTime, 0, 1, duration))
				self.Progress = passedTime / duration
				self.PassedTime = passedTime
			else
				RunService:UnbindFromRenderStep("CutsceneObject")
				self.Progress = 1
				self.PassedTime = duration

				for _, v in ipairs(self.SpecialFunctions[2]) do
					if type(v) == "table" then
						specialFunctions.End[v[1]](self, select(2, unpack(v)))
					else
						specialFunctions.End[v](self)
					end
				end

				self.PlaybackState = Enum.PlaybackState.Completed

				if self.Next then
					if self.Next == 0 then
						local queue = module.Playing
						module.Playing = nil
						queue.PlaybackState = Enum.PlaybackState.Completed
						queue.CurrentCutscene = nil
						for k, v in next, queue.PreviousCoreGuis do
							if v then
								StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
							end
						end
						for _, v in ipairs(queue.Cutscenes) do
							v.Next = nil
						end
						queue.Completed:Fire(Enum.PlaybackState.Completed)
					else
						if module.Playing.CurrentCutscene then
							module.Playing.CurrentCutscene = self.Next
						end
						self.Completed:Fire(Enum.PlaybackState.Completed)
						self.Next:Play()
					end
				else
					module.Playing = nil
					for k, v in next, self.PreviousCoreGuis do
						if v then
							StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
						end
					end

					self.Completed:Fire(Enum.PlaybackState.Completed)
				end
			end
		end)
	else
		error("Error while calling Play - A cutscene was already playing")
	end
end

function cutscene:Pause(waitTime)
	if module.Playing then
		if self.PassedTime == nil then
			error("Error while calling Pause - Cutscene hasn't started yet")
		end
		RunService:UnbindFromRenderStep("Cutscene")
		local playingQueue
		if module.Playing.CurrentCutscene then
			playingQueue = module.Playing
		end
		module.Playing = nil

		self.PlaybackState = Enum.PlaybackState.Paused
		if self.CustomCamera then
			camera = Workspace.CurrentCamera
		end

		if waitTime then
			if module.Settings.YieldPauseArgument then
				task.wait(waitTime)
				if playingQueue then
					playingQueue:Resume()
				else
					self:Resume()
				end
			else
				task.spawn(function()
					task.wait(waitTime)
					if playingQueue then
						playingQueue:Resume()
					else
						self:Resume()
					end
				end)
			end
		end
	else
		error("Error while calling Pause - There was no cutscene playing")
	end
end

function cutscene:Resume()
	if module.Playing == nil or module.Playing.CurrentCutscene == self then
		if self.PassedTime and self.PassedTime ~= 0 then
			module.Playing = module.Playing or self
			local duration = self.Duration
			local pointsCopy = self.PointsCopy
			local easingFunction = easingFunctions[self.EasingFunction]
			local passedTime = self.PassedTime

			self.PlaybackState = Enum.PlaybackState.Playing
			if self.CustomCamera then
				camera = self.CustomCamera
			end
			camera.CameraType = Enum.CameraType.Scriptable
			local start = clock() - passedTime

			RunService:BindToRenderStep("Cutscene", Enum.RenderPriority.Camera.Value + 1, function()
				passedTime = clock() - start

				if passedTime <= duration then
					camera.CFrame = getCF(pointsCopy, easingFunction(passedTime, 0, 1, duration))
					self.Progress = passedTime / duration
					self.PassedTime = passedTime
				else
					RunService:UnbindFromRenderStep("Cutscene")
					self.Progress = 1
					self.PassedTime = duration

					for _, v in ipairs(self.SpecialFunctions[2]) do
						if type(v) == "table" then
							specialFunctions.End[v[1]](self, select(2, unpack(v)))
						else
							specialFunctions.End[v](self)
						end
					end

					self.PlaybackState = Enum.PlaybackState.Completed

					if self.Next then
						if self.Next == 0 then
							local queue = module.Playing
							module.Playing = nil
							queue.PlaybackState = Enum.PlaybackState.Completed
							camera.CameraType = queue.PreviousCameraType
							queue.CurrentCutscene = nil
							for k, v in next, queue.PreviousCoreGuis do
								if v then
									StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
								end
							end
							for _, v in ipairs(queue.Cutscenes) do
								v.Next = nil
							end
							queue.Completed:Fire(Enum.PlaybackState.Completed)
						else
							if module.Playing.CurrentCutscene then
								module.Playing.CurrentCutscene = self.Next
							end
							self.Completed:Fire(Enum.PlaybackState.Completed)
							self.Next:Play()
						end
					else
						module.Playing = nil
						if not self.CustomCamera then
							camera.CameraType = self.PreviousCameraType
						end

						for k, v in next, self.PreviousCoreGuis do
							if v then
								StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
							end
						end
						self.Completed:Fire(Enum.PlaybackState.Completed)
					end
				end
			end)
		else
			self:Play()
		end
	else
		error("Error while calling Resume - The cutscene was already playing")
	end
end

function cutscene:Cancel()
	if module.Playing then
		RunService:UnbindFromRenderStep("Cutscene")
		module.Playing = nil

		for _, v in ipairs(self.SpecialFunctions[2]) do
			if type(v) == "table" then
				specialFunctions.End[v[1]](self, select(2, unpack(v)))
			else
				specialFunctions.End[v](self)
			end
		end

		if not self.CustomCamera then
			camera.CameraType = self.PreviousCameraType
		end
		for k, v in next, self.PreviousCoreGuis do
			if v then
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
			end
		end
		self.PlaybackState = Enum.PlaybackState.Cancelled
		self.Completed:Fire(Enum.PlaybackState.Cancelled)
	else
		error("Error while calling Cancel - There was no cutscene playing")
	end
end

function cutscene:Destroy()
	table.clear(self)
	setmetatable(self, nil)
end

function module:Create(points, duration, ...)
	assert(points, "Argument 1 (points) missing or nil")
	assert(duration, "Argument 2 (duration) missing or nil")

	local self = {}
	self.Completed = Signal.new()
	self.PlaybackState = Enum.PlaybackState.Begin
	self.Progress = 0
	self.Duration = duration
	self.PreviousCameraType = nil
	self.PreviousCoreGuis = nil

	local args = { ... }

	if typeof(points) == "Instance" then
		assert(typeof(points) ~= "table", "Argument 1 (points) not an instance or table")
		local instances = points:GetChildren()
		points = {}

		table.sort(instances, function(a, b)
			return tonumber(a.Name) < tonumber(b.Name)
		end)
		for _, v in ipairs(instances) do
			table.insert(points, v.CFrame)
		end
	end
	self.Points = points

	self.EasingFunction = "Linear"
	local dir, style = "In", nil
	for _, v in ipairs(args) do
		if easingFunctions[v] then
			self.EasingFunction = v
		elseif typeof(v) == "EnumItem" then
			if v.EnumType == Enum.EasingDirection then
				dir = v.Name
			elseif v.EnumType == Enum.EasingStyle then
				style = v.Name
			end
		end
	end
	if style then
		assert(easingFunctions[dir .. style], "EasingFunction " .. dir .. style .. " not found")
		self.EasingFunction = dir .. style
	end

	self.SpecialFunctions = { {}, {} }
	for i, v in ipairs(specialFunctions.StartKeys) do
		local idx = 0
		repeat
			idx = table.find(args, v, idx + 1)
			if idx then
				local a = {}

				local init = idx + 1
				repeat
					local Next = args[init]
					local isArg = (Next or Next == false) and typeof(Next) ~= "string" and typeof(Next) ~= "EnumItem"
					if isArg then
						table.insert(a, Next)
						init = init + 1
					end
				until not isArg

				if #a == 0 then
					table.insert(self.SpecialFunctions[1], i)
				else
					table.insert(a, 1, i)
					table.insert(self.SpecialFunctions[1], a)
				end
			end
		until not idx
	end
	for i, v in ipairs(specialFunctions.EndKeys) do
		local idx = 0
		repeat
			idx = table.find(args, v, idx + 1)
			if idx then
				local a = {}

				local init = idx + 1
				repeat
					local Next = args[init]
					local isArg = (Next or Next == false) and typeof(Next) ~= "string" and typeof(Next) ~= "EnumItem"
					if isArg then
						table.insert(a, Next)
						init = init + 1
					end
				until not isArg

				if #a == 0 then
					table.insert(self.SpecialFunctions[2], i)
				else
					table.insert(a, 1, i)
					table.insert(self.SpecialFunctions[2], a)
				end
			end
		until not idx
	end

	return setmetatable(self, cutscene)
end

local queue = {}
queue.__index = queue
queue.ClassName = "Queue"

function queue:Play()
	if module.Playing == nil then
		module.Playing = self
		local cutscenes = self.Cutscenes

		for i, v in ipairs(cutscenes) do
			if cutscenes[i + 1] then
				v.Next = cutscenes[i + 1]
			else
				v.Next = 0
			end
		end

		self.PreviousCoreGuis = getCoreGuisEnabled()
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		self.PreviousCameraType = camera.CameraType
		self.PlaybackState = Enum.PlaybackState.Playing

		module.Playing = self
		self.CurrentCutscene = cutscenes[1]
		cutscenes[1]:Play()
	else
		error("Error while calling Play - A cutscene/queue was already playing")
	end
end

function queue:Pause(waitTime)
	if module.Playing then
		self.CurrentCutscene:Pause(waitTime)
	else
		error("Error while calling Pause - There was no queue playing")
	end
end

function queue:Resume()
	if module.Playing == nil then
		module.Playing = self
		self.CurrentCutscene:Resume()
	else
		error("Error while calling Resume - A cutscene/queue was already playing")
	end
end

function queue:Cancel()
	if module.Playing then
		self.CurrentCutscene:Cancel()
		self.CurrentCutscene = nil
		camera.CameraType = self.PreviousCameraType
		for k, v in next, self.PreviousCoreGuis do
			if v then
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[k], true)
			end
		end
		for _, v in ipairs(self.Cutscenes) do
			v.Next = nil
		end
		self.PlaybackState = Enum.PlaybackState.Cancelled
		self.Completed:Fire(Enum.PlaybackState.Cancelled)
	else
		error("Error while calling Cancel - There was no queue playing")
	end
end

function queue:Destroy()
	table.clear(self)
	setmetatable(self, nil)
end

function module:CreateQueue(...)
	local self = {}
	self.Completed = Signal.new()
	self.PlaybackState = Enum.PlaybackState.Begin
	self.Cutscenes = { ... }

	return setmetatable(self, queue)
end

return module

end,
CutSceneService = function()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CutSceneService = {
	renderingPath = false,
	CurrentPath = {},
}

local Spline = import("Modules/CutScene/Spline.lua")
local Bezier = import("Modules/CutScene/Cubic.lua")
local Library = import("Modules/UiLibrary/Lib.lua")

local BezierFolder
local PointsFolder
local LinesFolder

local function getCF(points, t)
	local copy = { unpack(points) }
	repeat
		for i, v in ipairs(copy) do
			if i ~= 1 then
				copy[i - 1] = copy[i - 1]:Lerp(v, t)
			end
		end
		if #copy ~= 1 then
			copy[#copy] = nil
		end
	until #copy == 1
	return copy[1]
end

local function update(parts, path)
	local instances = path:GetChildren()

	if #instances > 0 then
		local points = {}

		for _, v in ipairs(instances) do
			if not tonumber(v.Name) then
				warn("A point in the cutscene has an invalid name")
				return
			end
		end

		table.sort(instances, function(a, b)
			return tonumber(a.Name) < tonumber(b.Name)
		end)

		for _, v in ipairs(instances) do
			table.insert(points, v.CFrame)
		end

		for i, v in ipairs(parts) do
			v.CFrame = getCF(points, i * 0.002)
		end
	end
end

function CutSceneService.render(path, interp, pathFolder)
	local success, err = pcall(function()
		pcall(function()
			BezierFolder:Destroy()
			PointsFolder:Destroy()
			LinesFolder:Destroy()
		end)

		if interp == "Spline" then
			local CurrentSpline = Spline.new(path, 0.4)

			BezierFolder = Instance.new("Folder", Workspace)
			PointsFolder = Instance.new("Folder", Workspace)
			LinesFolder = Instance.new("Folder", Workspace)
			BezierFolder.Name = "Bezier"
			PointsFolder.Name = "Points"
			LinesFolder.Name = "Lines"

			local n = 10
			local resolution = 1 / 40

			local DefaultPoints, EquidistantPoints, Lines = {}, {}, {}
			for i = 1, n - 1, resolution do
				local Point = Instance.new("Part", PointsFolder)
				Point.Name = "Default" .. tostring(i)
				Point.Shape = Enum.PartType.Ball
				Point.Size = Vector3.new(0.5, 0.5, 0.5)
				Point.Color = Color3.fromRGB(0, 179, 255)
				Point.Material = Enum.Material.Neon
				Point.Transparency = 1
				Point.Anchored = true
				Point.CanCollide = false
				Point.BottomSurface = Enum.SurfaceType.Smooth
				Point.TopSurface = Enum.SurfaceType.Smooth
				Point.Locked = true

				table.insert(DefaultPoints, Point)
			end

			for i = 1, n - 1, resolution do
				local Point = Instance.new("Part", PointsFolder)
				Point.Name = "Default" .. tostring(i)
				Point.Shape = Enum.PartType.Ball
				Point.Size = Vector3.new(1, 1, 1)
				Point.Color = Color3.fromRGB(0, 179, 255)
				Point.Material = Enum.Material.Neon
				Point.Transparency = 1
				Point.Anchored = true
				Point.CanCollide = false
				Point.BottomSurface = Enum.SurfaceType.Smooth
				Point.TopSurface = Enum.SurfaceType.Smooth
				Point.Locked = true

				table.insert(EquidistantPoints, Point)
			end

			for i = 1, n - 1, resolution do
				local TargetPart = Instance.new("Part", LinesFolder)
				TargetPart.Size = Vector3.new(0.15, 0.15, 1)
				TargetPart.Color = Color3.fromRGB(255, 255, 255)
				TargetPart.Material = Enum.Material.Neon
				TargetPart.CanCollide = false
				TargetPart.Anchored = true
				TargetPart.Locked = true
				TargetPart.Name = tostring(i)
				TargetPart.CastShadow = false

				table.insert(Lines, TargetPart)
			end

			for i = 1, #EquidistantPoints do
				local t = (i - 1) / (#DefaultPoints - 1)
				local p1 = CurrentSpline:CalculatePositionAt(t)
				local d1 = CurrentSpline:CalculateDerivativeAt(t)
				local p2 = CurrentSpline:CalculatePositionRelativeToLength(t)
				local d2 = CurrentSpline:CalculateDerivativeRelativeToLength(t)
				DefaultPoints[i].CFrame = CFrame.new(p1, p1 + d1)
				EquidistantPoints[i].CFrame = CFrame.new(p2, p2 + d2)
			end

			for i = 1, #Lines do
				pcall(function()
					local line = Lines[i]
					local p1, p2 = DefaultPoints[i].Position, DefaultPoints[i + 1].Position
					line.Size = Vector3.new(line.Size.X, line.Size.Y, (p2 - p1).Magnitude)
					line.CFrame = CFrame.new(0.5 * (p1 + p2), p2)
				end)
			end
		else
			BezierFolder = Instance.new("Folder", Workspace)
			PointsFolder = Instance.new("Folder", Workspace)
			LinesFolder = Instance.new("Folder", Workspace)
			BezierFolder.Name = "Bezier"
			PointsFolder.Name = "Points"
			LinesFolder.Name = "Lines"

			local Point = Instance.new("Part")
			Point.Name = "PathPoint"
			Point.Shape = Enum.PartType.Ball
			Point.Size = Vector3.new(0.3, 0.3, 0.3)
			Point.Color = Color3.fromRGB(255, 255, 255)
			Point.Material = Enum.Material.Plastic
			Point.Locked = true
			Point.Anchored = true
			Point.CanCollide = false
			Point.BottomSurface = Enum.SurfaceType.Smooth
			Point.TopSurface = Enum.SurfaceType.Smooth
			Point.CastShadow = false
			Point.CanTouch = false
			Point.Transparency = 1

			for i = 1, 500 do
				Point.Name = tostring(i)
				Point:Clone().Parent = BezierFolder
			end

			local parts = BezierFolder:GetChildren()
			update(parts, pathFolder)

			for i = 1, (#BezierFolder:GetChildren() - 1) do
				local One = BezierFolder:FindFirstChild(i)
				local Two = BezierFolder:FindFirstChild(i + 1)

				local TargetPart = Instance.new("Part", LinesFolder)
				TargetPart.Size = Vector3.new(0.15, 0.15, 0.15)
				TargetPart.Color = Color3.fromRGB(255, 255, 255)
				TargetPart.Material = Enum.Material.Neon
				TargetPart.CanCollide = false
				TargetPart.Anchored = true
				TargetPart.Locked = true
				TargetPart.Name = tostring(i)
				TargetPart.CastShadow = false

				local dist = (One.Position - Two.Position).Magnitude
				TargetPart.Size = Vector3.new(0.05, 0.5, dist)
				TargetPart.CFrame = CFrame.new(One.Position, Two.Position) * CFrame.new(0, 0, -dist / 2)
			end
		end
	end)

	if not success then
		Library:Notify({
			Name = "Error",
			Text = tostring(err),
			Icon = "rbxassetid://11401835376",
			Duration = 3,
		})
	end
end

function CutSceneService.derender()
	for i, v in next, LinesFolder:GetChildren() do
		local Info = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		TweenService:Create(v, Info, { Transparency = 1 }):Play()
	end

	task.wait(2)

	pcall(function()
		BezierFolder:Destroy()
		PointsFolder:Destroy()
		LinesFolder:Destroy()
	end)
end

local FocusRS

function CutSceneService.play(path, interp, duration, pathFolder)
	local PreviousCameraType = Camera.CameraType
	Camera.CameraType = Enum.CameraType.Scriptable

	task.spawn(function()
		FocusRS = RunService.RenderStepped:Connect(function()
			Camera.Focus = Camera.CFrame
		end)
	end)

	if interp == "Spline" then
		local NewSpline = Spline.new(path, 0.4)

		local CameraTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		local CamTween = NewSpline:CreateTween(Camera, CameraTweenInfo, { "CFrame" }, true, pathFolder)
		CamTween:Play()

		CamTween.Completed:Wait()
	else
		local CamTween = Bezier:Create(pathFolder, duration, "InOutSine")
		CamTween:Play()

		CamTween.Completed:Wait()
		CamTween:Destroy()
	end

	Camera.CameraType = PreviousCameraType
	FocusRS:Disconnect()
end

return CutSceneService

end,
EasingFunctions = function()
local s = 1.70158

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin

local function Linear(t, _, _, d)
	return t / d
end

local function InQuad(t, b, c, d)
	return c * pow(t / d, 2) + b
end

local function OutQuad(t, b, c, d)
	t = t / d
	return -c * t * (t - 2) + b
end

local function InOutQuad(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 2) + b
	else
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end
end

local function OutInQuad(t, b, c, d)
	if t < d / 2 then
		return OutQuad(t * 2, b, c / 2, d)
	else
		return InQuad((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function InCubic(t, b, c, d)
	return c * pow(t / d, 3) + b
end

local function OutCubic(t, b, c, d)
	return c * (pow(t / d - 1, 3) + 1) + b
end

local function InOutCubic(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * t * t * t + b
	else
		t = t - 2
		return c / 2 * (t * t * t + 2) + b
	end
end

local function OutInCubic(t, b, c, d)
	if t < d / 2 then
		return OutCubic(t * 2, b, c / 2, d)
	else
		return InCubic((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function InQuart(t, b, c, d)
	return c * pow(t / d, 4) + b
end

local function OutQuart(t, b, c, d)
	return -c * (pow(t / d - 1, 4) - 1) + b
end

local function InOutQuart(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 4) + b
	else
		t = t - 2
		return -c / 2 * (pow(t, 4) - 2) + b
	end
end

local function OutInQuart(t, b, c, d)
	if t < d / 2 then
		return OutQuart(t * 2, b, c / 2, d)
	else
		return InQuart((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function InQuint(t, b, c, d)
	return c * pow(t / d, 5) + b
end

local function OutQuint(t, b, c, d)
	return c * (pow(t / d - 1, 5) + 1) + b
end

local function InOutQuint(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 5) + b
	else
		return c / 2 * (pow(t - 2, 5) + 2) + b
	end
end

local function OutInQuint(t, b, c, d)
	if t < d / 2 then
		return OutQuint(t * 2, b, c / 2, d)
	else
		return InQuint((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function InSine(t, b, c, d)
	return -c * cos(t / d * (pi / 2)) + c + b
end

local function OutSine(t, b, c, d)
	return c * sin(t / d * (pi / 2)) + b
end

local function InOutSine(t, b, c, d)
	return -c / 2 * (cos(pi * t / d) - 1) + b
end

local function OutInSine(t, b, c, d)
	if t < d / 2 then
		return OutSine(t * 2, b, c / 2, d)
	else
		return InSine((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function InExpo(t, b, c, d)
	if t == 0 then
		return b
	else
		return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end
end

local function OutExpo(t, b, c, d)
	if t == d then
		return b + c
	else
		return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
	end
end

local function InOutExpo(t, b, c, d)
	if t == 0 then
		return b
	end
	if t == d then
		return b + c
	end
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
	else
		t = t - 1
		return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
	end
end

local function OutInExpo(t, b, c, d)
	if t < d / 2 then
		return OutExpo(t * 2, b, c / 2, d)
	else
		return InExpo((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function InCirc(t, b, c, d)
	return -c * (sqrt(1 - pow(t / d, 2)) - 1) + b
end

local function OutCirc(t, b, c, d)
	return c * sqrt(1 - pow(t / d - 1, 2)) + b
end

local function InOutCirc(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return -c / 2 * (sqrt(1 - t * t) - 1) + b
	else
		t = t - 2
		return c / 2 * (sqrt(1 - t * t) + 1) + b
	end
end

local function OutInCirc(t, b, c, d)
	if t < d / 2 then
		return OutCirc(t * 2, b, c / 2, d)
	else
		return InCirc((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function InElastic(t, b, c, d, a, p)
	if t == 0 then
		return b
	end
	t = t / d
	if t == 1 then
		return b + c
	end
	if not p then
		p = d * 0.3
	end
	local s
	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end
	t = t - 1
	return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

local function OutElastic(t, b, c, d, a, p)
	if t == 0 then
		return b
	end
	t = t / d
	if t == 1 then
		return b + c
	end
	if not p then
		p = d * 0.3
	end
	local s
	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end
	return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

local function InOutElastic(t, b, c, d, a, p)
	if t == 0 then
		return b
	end
	t = t / d * 2
	if t == 2 then
		return b + c
	end
	if not p then
		p = d * (0.3 * 1.5)
	end
	if not a then
		a = 0
	end
	local s
	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end
	if t < 1 then
		t = t - 1
		return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
	else
		t = t - 1
		return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) * 0.5 + c + b
	end
end

local function OutInElastic(t, b, c, d, a, p)
	if t < d / 2 then
		return OutElastic(t * 2, b, c / 2, d, a, p)
	else
		return InElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
	end
end

local function InBack(t, b, c, d)
	t = t / d
	return c * t * t * ((s + 1) * t - s) + b
end

local function OutBack(t, b, c, d)
	t = t / d - 1
	return c * (t * t * ((s + 1) * t + s) + 1) + b
end

local function InOutBack(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * (t * t * ((s + 1) * t - s)) + b
	else
		t = t - 2
		return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
	end
end

local function OutInBack(t, b, c, d)
	if t < d / 2 then
		return OutBack(t * 2, b, c / 2, d)
	else
		return InBack((t * 2) - d, b + c / 2, c / 2, d)
	end
end

local function OutBounce(t, b, c, d)
	t = t / d
	if t < 0.36363636363636 then
		return c * (7.5625 * t * t) + b
	elseif t < 0.72727272727273 then
		t = t - 0.54545454545455
		return c * (7.5625 * t * t + 0.75) + b
	elseif t < 0.90909090909091 then
		t = t - 0.81818181818182
		return c * (7.5625 * t * t + 0.9375) + b
	else
		t = t - 0.95454545454545
		return c * (7.5625 * t * t + 0.984375) + b
	end
end

local function InBounce(t, b, c, d)
	return c - OutBounce(d - t, 0, c, d) + b
end

local function InOutBounce(t, b, c, d)
	if t < d / 2 then
		return InBounce(t * 2, 0, c, d) * 0.5 + b
	else
		return OutBounce(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b
	end
end

local function OutInBounce(t, b, c, d)
	if t < d / 2 then
		return OutBounce(t * 2, b, c / 2, d)
	else
		return InBounce((t * 2) - d, b + c / 2, c / 2, d)
	end
end

return {
	Linear = Linear,
	InQuad = InQuad,
	OutQuad = OutQuad,
	InOutQuad = InOutQuad,
	OutInQuad = OutInQuad,
	InCubic = InCubic,
	OutCubic = OutCubic,
	InOutCubic = InOutCubic,
	OutInCubic = OutInCubic,
	InQuart = InQuart,
	OutQuart = OutQuart,
	InOutQuart = InOutQuart,
	OutInQuart = OutInQuart,
	InQuint = InQuint,
	OutQuint = OutQuint,
	InOutQuint = InOutQuint,
	OutInQuint = OutInQuint,
	InSine = InSine,
	OutSine = OutSine,
	InOutSine = InOutSine,
	OutInSine = OutInSine,
	InExponential = InExpo,
	OutExponential = OutExpo,
	InOutExponential = InOutExpo,
	OutInExponential = OutInExpo,
	InCircular = InCirc,
	OutCircular = OutCirc,
	InOutCircular = InOutCirc,
	OutInCircular = OutInCirc,
	InElastic = InElastic,
	OutElastic = OutElastic,
	InOutElastic = InOutElastic,
	OutInElastic = OutInElastic,
	InBack = InBack,
	OutBack = OutBack,
	InOutBack = InOutBack,
	OutInBack = OutInBack,
	InBounce = InBounce,
	OutBounce = OutBounce,
	InOutBounce = InOutBounce,
	OutInBounce = OutInBounce,
}

end,
Spline = function()
local BoatTween = import("Modules/BoatTween/init.lua")
local Bezier = import("Modules/CutScene/Cubic.lua")

local Spline = {}
Spline.__index = Spline

local function lerp(part, goal, t)
	local timepassed = 0
	local start = part.CFrame

	while timepassed <= t do
		timepassed = timepassed + RunService.Heartbeat:Wait()
		part.CFrame = start:Lerp(goal, timepassed / t)
	end

	return true
end

function Spline.new(controlPoints, tension)
	local self = setmetatable({}, Spline)
	self.Tension = tension or 0.5
	self.Points = {}
	self.LengthIterations = 1000
	self.LengthIndeces = {}
	self.Length = 0
	self.ConnectedSplines = {}
	self._connections = {}
	self.ControlPoints = controlPoints

	if controlPoints ~= nil then
		for _, point in pairs(controlPoints) do
			Spline.AddPoint(self, point)
		end
	end

	return self
end

function Spline:ChangeTension(tension)
	if type(tension) ~= "number" then
		error("Spline:ChangeTension() expected a number as an input, got " .. tostring(tension) .. "!")
	end

	self.Tension = tension
	Spline.UpdateLength(self)
end

function Spline:ChangeAllSplineTensions(tension)
	if type(tension) ~= "number" then
		error("Spline:ChangeAllSplineTensions() expected a number as an input, got " .. tostring(tension) .. "!")
	end

	local allSplines = Spline.GetSplines(self)
	for _, spline in pairs(allSplines) do
		spline:ChangeTension(tension)
	end
end

function Spline:AddPoint(p, index)
	local points = self.Points

	local function checkIfPointsMatch(point)
		local allPoints = Spline.GetPoints(self)
		for _, v in pairs(allPoints) do
			if typeof(v) ~= typeof(point) then
				return false
			end
		end
		return true
	end

	if #points == 4 then
		if typeof(p) == "number" or typeof(p) == "Vector3" then
			if checkIfPointsMatch(p) then
				local allSplines = Spline.GetSplines(self)
				local lastSpline = allSplines[#allSplines]
				local newSpline = Spline.new(
					{ lastSpline.Points[2], lastSpline.Points[3], lastSpline.Points[4], p },
					lastSpline.Tension
				)

				Spline.ConnectSpline(self, newSpline)
			end
		elseif p:IsA("BasePart") then
			if checkIfPointsMatch(p.Position) then
				local allSplines = Spline.GetSplines(self)
				local lastSpline = allSplines[#allSplines]
				local newSpline = Spline.new(
					{ lastSpline.Points[2], lastSpline.Points[3], lastSpline.Points[4], p },
					lastSpline.Tension
				)

				Spline.ConnectSpline(self, newSpline)
			end
		end
	else
		if typeof(p) == "number" then
			if checkIfPointsMatch(p) then
				table.insert(points, index or #points + 1, p)
			end
		elseif typeof(p) == "Vector3" then
			if checkIfPointsMatch(p) then
				table.insert(points, index or #points + 1, p)
			end
		elseif p:IsA("BasePart") then
			if checkIfPointsMatch(p.Position) then
				table.insert(points, index or #points + 1, p)
				self._connections[p] = p.Changed:Connect(function(prop)
					if prop == "Position" then
						Spline.UpdateLength(self)
					end
				end)
			end
		else
			error(
				"Invalid input received for Spline:AddPoint(), expected Vector3 or BasePart, got " .. tostring(p) .. "!"
			)
		end
	end

	if #points == 4 then
		Spline.UpdateLength(self)
	end
end

function Spline:RemovePoint(index)
	if type(p) ~= "number" then
		error("Spline:RemovePoint() expected a number as the input, got " .. tostring(index) .. "!")
	end

	local points = self.Points
	local point = table.remove(points, index)

	if point ~= nil and typeof(point) == "Instance" and point:IsA("BasePart") then
		if self._connections[point] then
			self._connections[point]:Disconnect()
			self._connections[point] = nil
		end
	end
end

function Spline:GetPoints()
	local points = {}

	for i = 1, #self.Points do
		points[i] = typeof(self.Points[i]) == "Instance" and self.Points[i].Position or self.Points[i]
	end

	return points
end

function Spline:ConnectSpline(spline)
	local points = spline.Points

	local allSplines = Spline.GetSplines(self)
	local associatedSpline = allSplines[#allSplines]
	local associatedPoints = associatedSpline.Points

	local function checkIfPointsMatch(point)
		local allPoints = Spline.GetPoints(self)

		for _, v in pairs(allPoints) do
			if typeof(v) ~= typeof(point) then
				return false
			end
		end

		return true
	end

	if
		not checkIfPointsMatch(
			(typeof(associatedPoints[1]) == "number" or typeof(associatedPoints[1]) == "Vector3")
					and associatedPoints[1]
				or associatedPoints[1].Position
		)
	then
		error("Cannot connect the spline because the splines do not have the same types of points!")
	end

	if associatedPoints[2] == points[1] and associatedPoints[3] == points[2] and associatedPoints[4] == points[3] then
		table.insert(self.ConnectedSplines, spline)
		Spline.UpdateLength(self)
	else
		error("Cannot connect the spline because the splines do not share 3 common points!")
	end
end

function Spline:GetSplines()
	local allSplines = { self }

	for i = 1, #self.ConnectedSplines do
		table.insert(allSplines, self.ConnectedSplines[i])
	end

	return allSplines
end

function Spline:GetSplineAt(t)
	local allSplines = Spline.GetSplines(self)

	local function percentage(x, a, b)
		local s = 1 / (b - a)
		return s * x - s * b + 1
	end

	if type(t) ~= "number" then
		error("Spline:GetSplineAt() expected a number as an input, got " .. tostring(t) .. "!")
	end

	if #allSplines == 1 then
		return self, t
	end

	local recip = 1 / #allSplines

	if t <= 0 then
		return self, t * recip
	elseif t >= 1 then
		return allSplines[#allSplines], 1 + (t - 1) * recip
	else
		local splineIndex = math.ceil(t * #allSplines)
		local spline = allSplines[splineIndex]
		return spline, percentage(t, (splineIndex - 1) * recip, splineIndex * recip)
	end
end

function Spline:UpdateLength()
	local l = 0
	local iterations = self.LengthIterations
	local sums = {}
	local points = {}

	do
		local allSplines = Spline.GetSplines(self)
		for i, spline in pairs(allSplines) do
			local localPoints = spline:GetPoints()
			if #localPoints ~= 4 then
				error(
					"Cannot get the length of the Spline object, expected 4 control points for all splines, got "
						.. tostring(#points)
						.. " points for spline "
						.. tostring(i)
						.. "!"
				)
			end
			for _, localPoint in pairs(localPoints) do
				table.insert(points, localPoint)
			end
		end
	end

	for i = 1, iterations do
		local dldt = Spline.CalculateDerivativeAt(self, (i - 1) / (iterations - 1))
		l = l + dldt.Magnitude * (1 / iterations)
		table.insert(sums, { ((i - 1) / (iterations - 1)), l, dldt })
	end

	self.Length, self.LengthIndeces = l, sums
end

function Spline:CalculatePositionAt(t)
	if type(t) ~= "number" then
		error("The given t value in Spline:CalculatePositionAt() was not between 0 and 1, got " .. tostring(t) .. "!")
	end

	self, t = Spline.GetSplineAt(self, t)

	local points = Spline.GetPoints(self)

	if #points ~= 4 then
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end

	local tension = self.Tension
	local c0 = points[2]
	local c1 = tension * (points[3] - points[1])
	local c2 = 3 * (points[3] - points[2]) - tension * (points[4] - points[2]) - 2 * tension * (points[3] - points[1])
	local c3 = -2 * (points[3] - points[2]) + tension * (points[4] - points[2]) + tension * (points[3] - points[1])

	local pointV3 = c0 + c1 * t + c2 * t ^ 2 + c3 * t ^ 3

	return pointV3
end

function Spline:CalculatePositionRelativeToLength(t)
	if type(t) ~= "number" then
		error("Spline:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(t) .. "!")
	end

	local points = self.Points
	local numPoints = #points

	if numPoints == 4 then
		local length = self.Length
		local lengthIndeces = self.LengthIndeces
		local iterations = self.LengthIterations
		local points = Spline.GetPoints(self)
		local targetLength = length * t
		local nearestParameterIndex, nearestParameter

		for i, orderedPair in ipairs(lengthIndeces) do
			if targetLength - orderedPair[2] <= 0 then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			elseif i == #lengthIndeces then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			end
		end

		local p0, p1

		if lengthIndeces[nearestParameterIndex - 1] then
			p0, p1 =
				Spline.CalculatePositionAt(self, lengthIndeces[nearestParameterIndex - 1][1]),
				Spline.CalculatePositionAt(self, nearestParameter[1])
		else
			p0, p1 =
				Spline.CalculatePositionAt(self, nearestParameter[1]),
				Spline.CalculatePositionAt(self, lengthIndeces[nearestParameterIndex + 1][1])
		end
		local percentError = (nearestParameter[2] - targetLength) / (p1 - p0).Magnitude

		return p0 + (p1 - p0) * (1 - percentError)
	else
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end
end

function Spline:CalculateDerivativeAt(t)
	if type(t) ~= "number" then
		error("The given t value in Spline:CalculateDerivativeAt() was not between 0 and 1, got " .. tostring(t) .. "!")
	end

	self, t = Spline.GetSplineAt(self, t)
	local points = Spline.GetPoints(self)

	if #points ~= 4 then
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end

	local tension = self.Tension
	local c1 = tension * (points[3] - points[1])
	local c2 = 3 * (points[3] - points[2]) - tension * (points[4] - points[2]) - 2 * tension * (points[3] - points[1])
	local c3 = -2 * (points[3] - points[2]) + tension * (points[4] - points[2]) + tension * (points[3] - points[1])
	local lineV3 = c1 + 2 * c2 * t + 3 * c3 * t ^ 2

	return lineV3
end

function Spline:CalculateDerivativeRelativeToLength(t)
	if type(t) ~= "number" then
		error("Spline:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(t) .. "!")
	end

	local points = self.Points
	local numPoints = #points

	if numPoints == 4 then
		local length = self.Length
		local lengthIndeces = self.LengthIndeces
		local iterations = self.LengthIterations
		local points = Spline.GetPoints(self)
		local targetLength = length * t
		local nearestParameterIndex, nearestParameter

		for i, orderedPair in ipairs(lengthIndeces) do
			if targetLength - orderedPair[2] <= 0 then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			elseif i == #lengthIndeces then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			end
		end

		local d0, d1

		if lengthIndeces[nearestParameterIndex - 1] then
			d0, d1 =
				Spline.CalculateDerivativeAt(self, lengthIndeces[nearestParameterIndex - 1][1]),
				Spline.CalculateDerivativeAt(self, nearestParameter[1])
		else
			d0, d1 =
				Spline.CalculateDerivativeAt(self, nearestParameter[1]),
				Spline.CalculateDerivativeAt(self, lengthIndeces[nearestParameterIndex + 1][1])
		end

		local percentError = (nearestParameter[2] - targetLength) / (d1 - d0).Magnitude
		return d0 + (d1 - d0) * (1 - percentError)
	else
		error("The Spline object has an invalid number of points (" .. tostring(#points) .. "), expected 4 points!")
	end
end

function Spline:CreateTween(instance, tweenInfo, propertyTable, relativeToSplineLength, pointsTable)
	if typeof(instance) == "Instance" then
	else
		error("SplineObject:CreateTween() expected an instance as the first input, got " .. tostring(instance) .. "!")
	end

	if typeof(tweenInfo) == "TweenInfo" then
	else
		error(
			"SplineObject:CreateTween() expected a TweenInfo object as the second input, got "
				.. tostring(tweenInfo)
				.. "!"
		)
	end

	local propertiesFound = true

	for _, propName in pairs(propertyTable) do
		local success, result = pcall(function()
			return instance[propName]
		end)
		if not success or result == nil then
			propertiesFound = false
		end
	end

	if not propertiesFound then
		error(
			"SplineObject:CreateTween() was given properties in the property table that do not belong to the instance!"
		)
	end

	local numValue = Instance.new("NumberValue")
	local RotVal = Instance.new("Part")
	local newTween = TweenService:Create(numValue, tweenInfo, { Value = 1 })

	task.spawn(function()
		local RotatePoints = pointsTable

		RotatePoints:FindFirstChild("1"):Destroy()
		RotatePoints:FindFirstChild(tostring(#RotatePoints:GetChildren())):Destroy()

		for i, v in next, RotatePoints:GetChildren() do
			v.Name = i
		end

		local RotBez = Bezier:Create(RotatePoints, tweenInfo.Time, "InOutSine")
		RotBez:PlayObject(RotVal)

		RotBez.Completed:Wait()
		RotBez:Destroy()
	end)

	local numValueChangedConnection = nil

	newTween.Changed:Connect(function(prop)
		if prop == "PlaybackState" then
			local playbackState = newTween.PlaybackState

			if playbackState == Enum.PlaybackState.Playing then
				numValueChangedConnection = numValue.Changed:Connect(function(t)
					for _, propName in pairs(propertyTable) do
						local pos = relativeToSplineLength and Spline.CalculatePositionRelativeToLength(self, t)
							or Spline.CalculatePositionAt(self, t)
						local derivative = relativeToSplineLength
								and Spline.CalculateDerivativeRelativeToLength(self, t)
							or Spline.CalculateDerivativeAt(self, t)
						local rz, ry, rx = RotVal.CFrame:ToEulerAnglesXYZ()

						local val = (typeof(pos) == "Vector3" and typeof(derivative) == "Vector3")
								and CFrame.new(pos) * CFrame.fromEulerAnglesXYZ(rz, ry, rx)
							or pos

						if typeof(instance[propName]) == "number" or typeof(instance[propName]) == "CFrame" then
							instance[propName] = instance[propName]:Lerp(val, 0.1)
						elseif typeof(instance[propName] == "Vector3") then
							instance[propName] = val.Position
						else
							error(
								"SplineObject:CreateTween() could not set the value of the instance property "
									.. tostring(propName)
									.. ", not a numerical value!"
							)
						end
					end
				end)
			else
				if numValueChangedConnection ~= nil then
					numValueChangedConnection:Disconnect()
					numValueChangedConnection = nil
				end
			end
		end
	end)

	return newTween
end

Spline.SplineClass = typeof(Spline)
Spline.SplineObject = typeof(Spline.new())
return Spline

end,
},
Database = {
MongoDB = function()
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

end,
Rongo = function()
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

end,
},
DestructibleBind = function()
local Destructible = {}
local DestructibleEvents = {}
local baseFolder

local function CrashParticle()
	local ParticleEmitter0 = Instance.new("ParticleEmitter")
	ParticleEmitter0.Name = "CrashParticle"
	ParticleEmitter0.Orientation = Enum.ParticleOrientation.VelocityParallel
	ParticleEmitter0.Rotation = NumberRange.new(70, 100)
	ParticleEmitter0.Color =
		ColorSequence.new(Color3.new(0.995682, 0.838529, 0.8663), Color3.new(0.995682, 0.838529, 0.8663))
	ParticleEmitter0.Enabled = true
	ParticleEmitter0.LightEmission = 1
	ParticleEmitter0.LightInfluence = 1
	ParticleEmitter0.Texture = "http://www.roblox.com/asset/?id=6740271308"
	ParticleEmitter0.ZOffset = 1
	ParticleEmitter0.Size = NumberSequence.new(5, 5)
	ParticleEmitter0.EmissionDirection = Enum.NormalId.Back
	ParticleEmitter0.Lifetime = NumberRange.new(1, 1)
	ParticleEmitter0.Rate = 25

	task.spawn(function()
		ParticleEmitter0.Enabled = true
		task.wait(0.5)
		ParticleEmitter0.Enabled = false
		task.wait(0.5)
		ParticleEmitter0:Destroy()
	end)

	return ParticleEmitter0
end

local function leaveParticle()
	local ParticleEmitter0 = Instance.new("ParticleEmitter")
	ParticleEmitter0.Name = "LeavesParticle"
	ParticleEmitter0.Speed = NumberRange.new(2, 2)
	ParticleEmitter0.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
	ParticleEmitter0.Rotation = NumberRange.new(70, 100)
	ParticleEmitter0.Color =
		ColorSequence.new(Color3.new(0.203922, 0.556863, 0.25098), Color3.new(0.203922, 0.556863, 0.25098))
	ParticleEmitter0.Enabled = true
	ParticleEmitter0.LightEmission = 0.5
	ParticleEmitter0.LightInfluence = 1
	ParticleEmitter0.Texture = "http://www.roblox.com/asset/?id=7018929807"
	ParticleEmitter0.Transparency = NumberSequence.new(1, 0, 0, 1)
	ParticleEmitter0.Size = NumberSequence.new(10, 10)
	ParticleEmitter0.Acceleration = Vector3.new(0, -3, 0)
	ParticleEmitter0.Lifetime = NumberRange.new(3, 3)
	ParticleEmitter0.Rate = 8
	ParticleEmitter0.RotSpeed = NumberRange.new(-40, 40)
	ParticleEmitter0.SpreadAngle = Vector2.new(-180, 180)
	ParticleEmitter0.VelocitySpread = -180

	task.spawn(function()
		ParticleEmitter0.Enabled = true
		task.wait(2)
		ParticleEmitter0:Destroy()
	end)

	return ParticleEmitter0
end

local function CrashSound(object)
	local CrashSound0 = Instance.new("Sound")
	CrashSound0.SoundId = "rbxassetid://7018764077"
	CrashSound0.Parent = object
	CrashSound0.Volume = 0.15
	CrashSound0.RollOffMaxDistance = 128
	CrashSound0.PlaybackSpeed = math.random() * 0.1 + 0.95

	task.spawn(function()
		CrashSound0:Play()

		task.wait(2)
		CrashSound0:Destroy()
	end)
end

local function lookAt(from, target)
	local forwardVector = (target - from).Unit
	local upVector = Vector3.new(0, 1, 0)
	local rightVector = forwardVector:Cross(upVector)
	local upVector2 = rightVector:Cross(forwardVector)

	return CFrame.fromMatrix(from, rightVector, upVector2)
end

local function giveEffect(object, attachment, pos, touchPart, isTree)
	local Particles = {}
	local RelativeCF = touchPart.CFrame:ToObjectSpace(object.CFrame)
	local z, y, x = RelativeCF:ToEulerAnglesXYZ()

	attachment.CFrame = CFrame.new(0, RelativeCF.Position.Y, 0) * CFrame.fromEulerAnglesXYZ(0, y, 0)
	attachment.Parent = object
	local crashParti = CrashParticle()

	crashParti.Parent = attachment
	table.insert(Particles, crashParti)

	if isTree then
		local leaveParti = leaveParticle()
		leaveParti.Parent = attachment
		table.insert(Particles, leaveParti)
	end

	if object.Anchored then
		pcall(function()
			object.CanCollide = true
			object.Anchored = false
			object.CanTouch = false
			CrashSound(object)
		end)
	end

	task.delay(3, function()
		pcall(function()
			object.Anchored = true
			object.CanCollide = false
			object.CanTouch = true
			object.CFrame = object:FindFirstChild("PartCF").Value
		end)
	end)
end

function Destructible.init()
	baseFolder = Instance.new("Folder")
	baseFolder.Parent = Workspace
	baseFolder.Name = "Destructibles"
end

function Destructible.add(obj, isTree)
	if obj:IsA("BasePart") then
		local cfVal = Instance.new("CFrameValue")
		cfVal.Parent = obj
		cfVal.Value = obj.CFrame
		cfVal.Name = "PartCF"

		local touch = obj.Touched:Connect(function(touchPart)
			--[[if touchPart:IsDescendantOf(Workspace.Destructibles) then
					print(touchPart.Name.." failed basefolder check")
					return
				end]]
			--

			if touchPart:IsDescendantOf(Workspace:FindFirstChild("Vehicles")) then
				local attach = Instance.new("Attachment")
				local attachRootPos = Vector3.new(obj.Position.X, touchPart.Position.Y, obj.Position.Z)

				giveEffect(obj, attach, attachRootPos, touchPart, isTree)
				return
			end
		end)
		table.insert(DestructibleEvents, touch)
	end
end

function Destructible.DestroyAll()
	for i, v in next, DestructibleEvents do
		v:Disconnect()
	end
end

return Destructible

end,
EasyReplay = {
System = {
Replay = function()
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Replay = {
	Variable = {},
	Functions = {},
	Data = {
		Vehicle = require(ReplicatedStorage.Game.Vehicle),
		KeyF = 0,
		PrevData = {},
		LoopArr = {},
		BootRS = nil,
	},
}

local clientPlayer = Workspace:WaitForChild(game.Players.LocalPlayer.Name)

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local function addVehicle(veh)
	local selfDat = {
		RS = nil,
		cycArr = {},
	}

	selfDat.RS = RunService.Heartbeat:Connect(function(deltaTime)
		Replay.Data.LoopArr["Vehicles"][veh.Name .. "|||" .. veh:GetAttribute("ReplayID")] = selfDat.cycArr
	end)
end

LPH_NO_VIRTUALIZE(function()
	local replayObjectArray = {}

	function Replay.Record(Toggle)
		Replay.KeyF = 0

		if not Toggle then
			Replay.Data.BootRS:Disconnect()

			local json = HttpService:JSONEncode(replayObjectArray)

			local replayName = "Untitled"
			makefolder("JailbreakVisionV3/EasyReplays/" .. replayName)
			writefile("JailbreakVisionV3/EasyReplays/" .. replayName .. "/ReplayData.json", json)

			replayObjectArray = {}
		else
			local RpArr = {}
			Replay.Data.BootRS = RunService.Heartbeat:Connect(function(dt)
				Replay.Data.KeyF = Replay.Data.KeyF + 1

				Replay.Data.LoopArr["Delta"] = dt
				RpArr[Replay.Data.KeyF] = Replay.Data.LoopArr
			end)

			writefile(".json", HttpService:JSONEncode(RpArr))
		end
	end

	function Replay.ReplayFrame(Frame) end
end)()

return Replay

end,
},
Utils = {
ReplayObjects = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ReplayObjects = {
	Variable = {
		partID = 0,
	},
}

function ReplayObjects.IntilizeVehicle(Vehicle, Settings) end

function ReplayObjects.FetchVehicle(Name)
	if ReplicatedStorage.Resource.Vehicles:FindFirstChild(Name) then
		return ReplicatedStorage.Resource.Vehicles:FindFirstChild(Name)
	else
		return nil
	end
end

function ReplayObjects.AssignID()
	LPH_NO_VIRTUALIZE(function()
		for i, v in pairs(Workspace:GetDescendants()) do
			v:SetAttribute("ReplayID", i)
			ReplayObjects.Variable.partID = i
		end

		Workspace.DescendantAdded:Connect(function(descendant)
			ReplayObjects.Variable.partID = ReplayObjects.Variable.partID + 1
			descendant:SetAttribute("ReplayID", ReplayObjects.Variable.partID)
		end)
	end)()
end

return ReplayObjects

end,
},
},
EasyWebhook = {
Client = function()
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

end,
Embed = function()
return function()
	local datatable = {
		["type"] = "rich",
		["fields"] = {},
		["customembed"] = true,
	}
	local prox = {
		["lol"] = true,
	}
	setmetatable(prox, {
		__index = function(self, ...)
			local args = { ... }

			local method = tostring(args[1])
			if method == "setAuthor" then
				return function(name, imgurl, url)
					assert(name, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					datatable["author"] = {
						name = name,
						icon_url = imgurl,
						url = url,
					}
					return prox
				end
			end
			if method == "setTitle" then
				return function(title)
					assert(title, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					datatable["title"] = title
					return prox
				end
			end
			if method == "setUrl" then
				return function(url)
					assert(url, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					datatable["url"] = url
					return prox
				end
			end
			if method == "setDescription" then
				return function(desc)
					assert(desc, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					datatable["description"] = desc
					return prox
				end
			end
			if method == "setFooter" then
				return function(footer, icon)
					assert(footer, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					datatable["footer"] = {
						text = footer,
						icon_url = icon,
					}
					return prox
				end
			end
			if method == "setTimestamp" then
				return function(timestamp, parser)
					assert(timestamp, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					if parser then
						-- rogchamp for ISO8601 parser
						local function format(num, digits)
							return string.format("%0" .. digits .. "i", num)
						end
						local year, mon, day, hour, min, sec =
							timestamp["year"],
							timestamp["month"],
							timestamp["day"],
							timestamp["hour"],
							timestamp["min"],
							timestamp["sec"]
						timestamp = year
							.. "-"
							.. format(mon, 2)
							.. "-"
							.. format(day, 2)
							.. "T"
							.. format(hour, 2)
							.. ":"
							.. format(min, 2)
							.. ":"
							.. format(sec, 2)
							.. "Z"
					end

					datatable["timestamp"] = timestamp
					return prox
				end
			end
			if method == "addField" then
				return function(name, value, inline)
					assert(name and value, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					table.insert(datatable["fields"], {
						name = name,
						value = value,
						inline = inline,
					})
					return prox
				end
			end
			if method == "setColor" then
				return function(color)
					assert(color, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					assert(
						tostring(color):sub(1, 1) == "#",
						'Invalid property "color" provided for method "' .. tostring(method) .. '"'
					)
					datatable["color"] = tonumber(color:sub(2), 16)
					return prox
				end
			end
			if method == "setThumbnail" then
				return function(url, width, height)
					assert(url, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					datatable["thumbnail"] = {
						url = url,
						width = width,
						height = height,
					}
					return prox
				end
			end
			if method == "setImage" then
				return function(url, width, height)
					assert(url, 'Invalid properties provided for method "' .. tostring(method) .. '"')
					datatable["image"] = {
						url = url,
						width = width,
						height = height,
					}
					return prox
				end
			end
			if method == "getAllValues" then
				return function()
					return datatable
				end
			end

			return datatable[method]
		end,
	})
	return prox
end

end,
},
EngineModifier = function()
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
end,
forzaUI = function()
local RunService = game:GetService("RunService")
local ForzaUI = {}

local Signal = import("Modules/Signal.lua")
local EnterVehSig = Signal.Get("EnterVehicle")
local ExitVehSig = Signal.Get("ExitVehicle")
local HideAllUi = Signal.Get("HideAllUi")
local UnHideAllUi = Signal.Get("UnHideAllUi")
local makeForza = Signal.Get("makeForza")
local destroyForza = Signal.Get("destroyForza")

local rsBin = {}

function ForzaUI.NewDigit()
	local Speedometer = {}

	do
		-- StarterGui.Degital
		Speedometer["1"] = Instance.new("ScreenGui")
		Speedometer["1"]["Parent"] = (RunService:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui")
		Speedometer["1"]["IgnoreGuiInset"] = true
		Speedometer["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets
		Speedometer["1"]["Name"] = [[Degital]]
		Speedometer["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling

		-- StarterGui.Degital.Holder
		Speedometer["2"] = Instance.new("Frame", Speedometer["1"])
		Speedometer["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["2"]["BackgroundTransparency"] = 1
		Speedometer["2"]["Size"] = UDim2.new(1, 0, 1, 0)
		Speedometer["2"]["Name"] = [[Holder]]

		-- StarterGui.Degital.Holder.UIPadding
		Speedometer["3"] = Instance.new("UIPadding", Speedometer["2"])
		Speedometer["3"]["PaddingRight"] = UDim.new(0, 320)
		Speedometer["3"]["PaddingBottom"] = UDim.new(0, 137)

		-- StarterGui.Degital.Holder.Speedometer
		Speedometer["4"] = Instance.new("Frame", Speedometer["2"])
		Speedometer["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["4"]["BackgroundTransparency"] = 1
		Speedometer["4"]["Size"] = UDim2.new(0, 320, 0, 137)
		Speedometer["4"]["Position"] = UDim2.new(1, 0, 1, 0)
		Speedometer["4"]["Name"] = [[Speedometer]]

		-- StarterGui.Degital.Holder.Speedometer.Top
		Speedometer["5"] = Instance.new("Frame", Speedometer["4"])
		Speedometer["5"]["BackgroundColor3"] = Color3.fromRGB(86, 255, 128)
		Speedometer["5"]["BackgroundTransparency"] = 1
		Speedometer["5"]["Size"] = UDim2.new(0, 196, 0, 77)
		Speedometer["5"]["Position"] = UDim2.new(0.28125, 0, 0.19708029925823212, 0)
		Speedometer["5"]["Name"] = [[Top]]

		-- StarterGui.Degital.Holder.Speedometer.Top.Speed
		Speedometer["6"] = Instance.new("TextLabel", Speedometer["5"])
		Speedometer["6"]["TextWrapped"] = true
		Speedometer["6"]["BorderSizePixel"] = 0
		Speedometer["6"]["RichText"] = true
		Speedometer["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["6"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Light, Enum.FontStyle.Normal)
		Speedometer["6"]["BorderMode"] = Enum.BorderMode.Middle
		Speedometer["6"]["TextStrokeColor3"] = Color3.fromRGB(157, 157, 157)
		Speedometer["6"]["TextSize"] = 100
		Speedometer["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["6"]["Size"] = UDim2.new(0, 130, 0, 108)
		Speedometer["6"]["BorderColor3"] = Color3.fromRGB(54, 54, 54)
		Speedometer["6"]["Text"] = [[<i>000</i>]]
		Speedometer["6"]["Name"] = [[Speed]]
		Speedometer["6"]["BackgroundTransparency"] = 1
		Speedometer["6"]["Position"] = UDim2.new(0.2142857164144516, 0, -0.20779220759868622, 0)

		-- StarterGui.Degital.Holder.Speedometer.Top.Format
		Speedometer["7"] = Instance.new("TextLabel", Speedometer["5"])
		Speedometer["7"]["TextWrapped"] = true
		Speedometer["7"]["BorderSizePixel"] = 0
		Speedometer["7"]["RichText"] = true
		Speedometer["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["7"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Oswald.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Speedometer["7"]["BorderMode"] = Enum.BorderMode.Middle
		Speedometer["7"]["TextStrokeColor3"] = Color3.fromRGB(151, 151, 151)
		Speedometer["7"]["TextSize"] = 19
		Speedometer["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["7"]["Size"] = UDim2.new(0, 41, 0, 29)
		Speedometer["7"]["BorderColor3"] = Color3.fromRGB(54, 54, 54)
		Speedometer["7"]["Text"] = [[<i><b>MPH</b></i>]]
		Speedometer["7"]["Name"] = [[Format]]
		Speedometer["7"]["BackgroundTransparency"] = 1
		Speedometer["7"]["Position"] = UDim2.new(0.795918345451355, 0, 0.6103895902633667, 0)

		-- StarterGui.Degital.Holder.Speedometer.Top.Gear
		Speedometer["8"] = Instance.new("TextLabel", Speedometer["5"])
		Speedometer["8"]["TextWrapped"] = true
		Speedometer["8"]["LineHeight"] = 0.8999999761581421
		Speedometer["8"]["BorderSizePixel"] = 0
		Speedometer["8"]["RichText"] = true
		Speedometer["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["8"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		Speedometer["8"]["BorderMode"] = Enum.BorderMode.Middle
		Speedometer["8"]["TextStrokeColor3"] = Color3.fromRGB(151, 151, 151)
		Speedometer["8"]["TextSize"] = 35
		Speedometer["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["8"]["Size"] = UDim2.new(0, 54, 0, 53)
		Speedometer["8"]["BorderColor3"] = Color3.fromRGB(54, 54, 54)
		Speedometer["8"]["Text"] = [[<i>1</i>]]
		Speedometer["8"]["Name"] = [[Gear]]
		Speedometer["8"]["BackgroundTransparency"] = 1
		Speedometer["8"]["Position"] = UDim2.new(0.005102040711790323, 0, 0.37662336230278015, 0)

		-- StarterGui.Degital.Holder.Speedometer.Bottom
		Speedometer["9"] = Instance.new("Frame", Speedometer["4"])
		Speedometer["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["9"]["BackgroundTransparency"] = 1
		Speedometer["9"]["Size"] = UDim2.new(0, 196, 0, 57)
		Speedometer["9"]["Position"] = UDim2.new(0.28125, 0, 0.5182482004165649, 0)
		Speedometer["9"]["Name"] = [[Bottom]]

		-- StarterGui.Degital.Holder.Speedometer.Bottom.Meter
		Speedometer["a"] = Instance.new("Frame", Speedometer["9"])
		Speedometer["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["a"]["BackgroundTransparency"] = 1
		Speedometer["a"]["Size"] = UDim2.new(0, 216, 0, 44)
		Speedometer["a"]["Position"] = UDim2.new(-0.06632652878761292, 0, 0.14035087823867798, 0)
		Speedometer["a"]["Name"] = [[Meter]]

		-- StarterGui.Degital.Holder.Speedometer.Bottom.Meter.BarBackground
		Speedometer["b"] = Instance.new("Frame", Speedometer["a"])
		Speedometer["b"]["BorderSizePixel"] = 0
		Speedometer["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["b"]["BackgroundTransparency"] = 0.75
		Speedometer["b"]["Size"] = UDim2.new(0, 181, 0, 10)
		Speedometer["b"]["Position"] = UDim2.new(0.09259258955717087, 0, 0.6818181872367859, 0)
		Speedometer["b"]["Name"] = [[BarBackground]]

		-- StarterGui.Degital.Holder.Speedometer.Bottom.Meter.BarBackground.Bar
		Speedometer["c"] = Instance.new("Frame", Speedometer["b"])
		Speedometer["c"]["ZIndex"] = 2
		Speedometer["c"]["BorderSizePixel"] = 0
		Speedometer["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["c"]["Size"] = UDim2.new(0, 117, 0, 10)
		Speedometer["c"]["Name"] = [[Bar]]

		-- StarterGui.Degital.Holder.Speedometer.Bottom.Meter.BarBackground.Bar.UIGradient
		Speedometer["d"] = Instance.new("UIGradient", Speedometer["c"])
		Speedometer["d"]["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0.000, 0.875),
			NumberSequenceKeypoint.new(0.932, 0.36250001192092896),
			NumberSequenceKeypoint.new(0.956, 0),
			NumberSequenceKeypoint.new(0.987, 0),
			NumberSequenceKeypoint.new(1.000, 1),
		})

		-- StarterGui.Degital.Holder.Speedometer.Bottom.Meter.RevLimit
		Speedometer["e"] = Instance.new("Frame", Speedometer["a"])
		Speedometer["e"]["BorderSizePixel"] = 0
		Speedometer["e"]["BackgroundColor3"] = Color3.fromRGB(191, 0, 0)
		Speedometer["e"]["BackgroundTransparency"] = 0.75
		Speedometer["e"]["Size"] = UDim2.new(0, 9, 0, 10)
		Speedometer["e"]["Position"] = UDim2.new(0.8888888955116272, 0, 0.6818181872367859, 0)
		Speedometer["e"]["Name"] = [[RevLimit]]
	end

	local RSUpdater = RunService.Heartbeat:Connect(function(deltaTime) end)

	ExitVehSig:Wait()

	RSUpdater:Disconnect()
	Speedometer["1"]:Destroy()
end

function ForzaUI.NewMech8k()
	local Speedometer = {}

	do
		-- StarterGui.8k
		Speedometer["1"] = Instance.new("ScreenGui")
		Speedometer["1"]["Parent"] = (RunService:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui")
		Speedometer["1"]["IgnoreGuiInset"] = true
		Speedometer["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets
		Speedometer["1"]["Name"] = [[8k]]
		Speedometer["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling

		-- StarterGui.8k.Holder
		Speedometer["2"] = Instance.new("Frame", Speedometer["1"])
		Speedometer["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["2"]["BackgroundTransparency"] = 1
		Speedometer["2"]["Size"] = UDim2.new(1, 0, 1, 0)
		Speedometer["2"]["Name"] = [[Holder]]

		-- StarterGui.8k.Holder.UIPadding
		Speedometer["3"] = Instance.new("UIPadding", Speedometer["2"])
		Speedometer["3"]["PaddingRight"] = UDim.new(0, 285)
		Speedometer["3"]["PaddingBottom"] = UDim.new(0, 265)

		-- StarterGui.8k.Holder.Frame
		Speedometer["4"] = Instance.new("Frame", Speedometer["2"])
		Speedometer["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["4"]["BackgroundTransparency"] = 1
		Speedometer["4"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["4"]["Position"] = UDim2.new(1, 0, 1, 0)

		-- StarterGui.8k.Holder.Frame.ImageLabel
		Speedometer["5"] = Instance.new("ImageLabel", Speedometer["4"])
		Speedometer["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["5"]["ImageTransparency"] = 0.6000000238418579
		Speedometer["5"]["Image"] = [[rbxassetid://12897968089]]
		Speedometer["5"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["5"]["BackgroundTransparency"] = 1

		-- StarterGui.8k.Holder.Frame.ImageLabel.Frame
		Speedometer["6"] = Instance.new("Frame", Speedometer["5"])
		Speedometer["6"]["BorderSizePixel"] = 0
		Speedometer["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["6"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Speedometer["6"]["Size"] = UDim2.new(0, 4, 0, 212)
		Speedometer["6"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)

		-- StarterGui.8k.Holder.Frame.ImageLabel.Frame.UIGradient
		Speedometer["7"] = Instance.new("UIGradient", Speedometer["6"])
		Speedometer["7"]["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0.000, 1),
			NumberSequenceKeypoint.new(0.855, 0.987500011920929),
			NumberSequenceKeypoint.new(0.977, 0.5687500238418579),
			NumberSequenceKeypoint.new(0.984, 0),
			NumberSequenceKeypoint.new(1.000, 0),
		})
		Speedometer["7"]["Rotation"] = 270

		-- StarterGui.8k.Holder.Frame.RedRing
		Speedometer["8"] = Instance.new("ImageLabel", Speedometer["4"])
		Speedometer["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["8"]["ImageTransparency"] = 0.4000000059604645
		Speedometer["8"]["Visible"] = false
		Speedometer["8"]["Image"] = [[rbxassetid://12884000610]]
		Speedometer["8"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["8"]["Name"] = [[RedRing]]
		Speedometer["8"]["BackgroundTransparency"] = 1

		-- StarterGui.8k.Holder.Frame.ABS
		Speedometer["9"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["9"]["TextWrapped"] = true
		Speedometer["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["9"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Speedometer["9"]["TextTransparency"] = 0.5
		Speedometer["9"]["TextSize"] = 14
		Speedometer["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["9"]["Size"] = UDim2.new(0, 35, 0, 15)
		Speedometer["9"]["Text"] = [[ABS]]
		Speedometer["9"]["Name"] = [[ABS]]
		Speedometer["9"]["BackgroundTransparency"] = 1
		Speedometer["9"]["Position"] = UDim2.new(0.2666202783584595, 0, 0.44481486082077026, 0)

		-- StarterGui.8k.Holder.Frame.Format
		Speedometer["a"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["a"]["TextWrapped"] = true
		Speedometer["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["a"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Oswald.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic)
		Speedometer["a"]["TextTransparency"] = 0.5
		Speedometer["a"]["TextSize"] = 20
		Speedometer["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["a"]["Size"] = UDim2.new(0, 50, 0, 30)
		Speedometer["a"]["Text"] = [[MPH]]
		Speedometer["a"]["Name"] = [[Format]]
		Speedometer["a"]["BackgroundTransparency"] = 1
		Speedometer["a"]["Position"] = UDim2.new(0.5666203498840332, 0, 0.4448148310184479, 0)

		-- StarterGui.8k.Holder.Frame.Gear
		Speedometer["b"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["b"]["TextWrapped"] = true
		Speedometer["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["b"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Italic)
		Speedometer["b"]["TextTransparency"] = 0.30000001192092896
		Speedometer["b"]["TextSize"] = 50
		Speedometer["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["b"]["Size"] = UDim2.new(0, 200, 0, 80)
		Speedometer["b"]["Text"] = [[3]]
		Speedometer["b"]["Name"] = [[Gear]]
		Speedometer["b"]["BackgroundTransparency"] = 1
		Speedometer["b"]["Position"] = UDim2.new(0.16388459503650665, 0, 0.3606172800064087, 0)

		-- StarterGui.8k.Holder.Frame.Speed
		Speedometer["c"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["c"]["TextWrapped"] = true
		Speedometer["c"]["RichText"] = true
		Speedometer["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["c"]["FontFace"] =
			Font.new([[rbxassetid://12187374954]], Enum.FontWeight.ExtraLight, Enum.FontStyle.Italic)
		Speedometer["c"]["TextTransparency"] = 0.20000000298023224
		Speedometer["c"]["TextSize"] = 100
		Speedometer["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["c"]["Size"] = UDim2.new(0, 150, 0, 80)
		Speedometer["c"]["Text"] = [[201]]
		Speedometer["c"]["Name"] = [[Speed]]
		Speedometer["c"]["BackgroundTransparency"] = 1
		Speedometer["c"]["Position"] = UDim2.new(0.2447965443134308, 0, 0.5750616788864136, 0)

		-- StarterGui.8k.Holder.Frame.TCR
		Speedometer["d"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["d"]["TextWrapped"] = true
		Speedometer["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["d"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Speedometer["d"]["TextTransparency"] = 0.5
		Speedometer["d"]["TextSize"] = 14
		Speedometer["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["d"]["Size"] = UDim2.new(0, 38, 0, 15)
		Speedometer["d"]["Text"] = [[TCR]]
		Speedometer["d"]["Name"] = [[TCR]]
		Speedometer["d"]["BackgroundTransparency"] = 1
		Speedometer["d"]["Position"] = UDim2.new(0.2666202783584595, 0, 0.4948148727416992, 0)
	end

	HideAllUi:Fire()
	local RSUpdater = RunService.Heartbeat:Connect(function(deltaTime)
		local Speed = CurVehicleData.MPH

		if string.sub(Speed, 1, 3) == "000" then
			Speed = '<font transparency="0.6">000</font>' .. string.sub(Speed, 4, #Speed)
		elseif string.sub(Speed, 1, 2) == "00" then
			Speed = '<font transparency="0.6">00</font>' .. string.sub(Speed, 3, #Speed)
		elseif string.sub(Speed, 1, 1) == "0" then
			Speed = '<font transparency="0.6">0</font>' .. string.sub(Speed, 2, #Speed)
		end

		local deg = CurVehicleData.RPM / 8000 * 260

		if deg > 260 then
			deg = math.random(259, 262)
		end

		Speedometer["6"]["Rotation"] = deg - 130
		Speedometer["b"]["Text"] = CurVehicleData.GEAR
		Speedometer["c"]["Text"] = Speed

		if tonumber(CurVehicleData.RPM) > 6000 then
			Speedometer["8"].Visible = true
			Speedometer["b"].TextColor3 = Color3.fromRGB(255, 49, 87)
		else
			Speedometer["8"].Visible = false
			Speedometer["b"].TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end)

	function Speedometer.Disconnect()
		RSUpdater:Disconnect()
		UnHideAllUi:Fire()
		Speedometer["1"]:Destroy()
	end

	table.insert(rsBin, Speedometer)

	ExitVehSig:Wait()
	Speedometer.Disconnect()
end

function ForzaUI.NewMech10k()
	local Speedometer = {}

	do
		-- StarterGui.10k
		Speedometer["1"] = Instance.new("ScreenGui")
		Speedometer["1"]["Parent"] = (RunService:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui")
		Speedometer["1"]["IgnoreGuiInset"] = true
		Speedometer["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets
		Speedometer["1"]["Name"] = [[10k]]
		Speedometer["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling

		-- StarterGui.10k.Holder
		Speedometer["2"] = Instance.new("Frame", Speedometer["1"])
		Speedometer["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["2"]["BackgroundTransparency"] = 1
		Speedometer["2"]["Size"] = UDim2.new(1, 0, 1, 0)
		Speedometer["2"]["Name"] = [[Holder]]

		-- StarterGui.10k.Holder.UIPadding
		Speedometer["3"] = Instance.new("UIPadding", Speedometer["2"])
		Speedometer["3"]["PaddingRight"] = UDim.new(0, 285)
		Speedometer["3"]["PaddingBottom"] = UDim.new(0, 265)

		-- StarterGui.10k.Holder.Frame
		Speedometer["4"] = Instance.new("Frame", Speedometer["2"])
		Speedometer["4"]["BorderSizePixel"] = 0
		Speedometer["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["4"]["BackgroundTransparency"] = 1
		Speedometer["4"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["4"]["Position"] = UDim2.new(1, 0, 1, 0)

		-- StarterGui.10k.Holder.Frame.RedRing
		Speedometer["5"] = Instance.new("ImageLabel", Speedometer["4"])
		Speedometer["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["5"]["ImageTransparency"] = 0.4000000059604645
		Speedometer["5"]["Visible"] = false
		Speedometer["5"]["Image"] = [[rbxassetid://12893477568]]
		Speedometer["5"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["5"]["Name"] = [[RedRing]]
		Speedometer["5"]["BackgroundTransparency"] = 1
		Speedometer["5"]["Position"] = UDim2.new(-0.004755258560180664, 0, -0.0035545825958251953, 0)

		-- StarterGui.10k.Holder.Frame.Speed
		Speedometer["6"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["6"]["TextWrapped"] = true
		Speedometer["6"]["RichText"] = true
		Speedometer["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["6"]["FontFace"] =
			Font.new([[rbxassetid://12187374954]], Enum.FontWeight.ExtraLight, Enum.FontStyle.Italic)
		Speedometer["6"]["TextTransparency"] = 0.20000000298023224
		Speedometer["6"]["TextSize"] = 100
		Speedometer["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["6"]["Size"] = UDim2.new(0, 150, 0, 80)
		Speedometer["6"]["Text"] = [[201]]
		Speedometer["6"]["Name"] = [[Speed]]
		Speedometer["6"]["BackgroundTransparency"] = 1
		Speedometer["6"]["Position"] = UDim2.new(0.2447965443134308, 0, 0.5750616788864136, 0)

		-- StarterGui.10k.Holder.Frame.Format
		Speedometer["7"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["7"]["TextWrapped"] = true
		Speedometer["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["7"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Oswald.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic)
		Speedometer["7"]["TextTransparency"] = 0.5
		Speedometer["7"]["TextSize"] = 20
		Speedometer["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["7"]["Size"] = UDim2.new(0, 50, 0, 30)
		Speedometer["7"]["Text"] = [[MPH]]
		Speedometer["7"]["Name"] = [[Format]]
		Speedometer["7"]["BackgroundTransparency"] = 1
		Speedometer["7"]["Position"] = UDim2.new(0.5666203498840332, 0, 0.4448148310184479, 0)

		-- StarterGui.10k.Holder.Frame.Gear
		Speedometer["8"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["8"]["TextWrapped"] = true
		Speedometer["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["8"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Italic)
		Speedometer["8"]["TextTransparency"] = 0.30000001192092896
		Speedometer["8"]["TextSize"] = 50
		Speedometer["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["8"]["Size"] = UDim2.new(0, 200, 0, 80)
		Speedometer["8"]["Text"] = [[3]]
		Speedometer["8"]["Name"] = [[Gear]]
		Speedometer["8"]["BackgroundTransparency"] = 1
		Speedometer["8"]["Position"] = UDim2.new(0.16388459503650665, 0, 0.3606172800064087, 0)

		-- StarterGui.10k.Holder.Frame.ABS
		Speedometer["9"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["9"]["TextWrapped"] = true
		Speedometer["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["9"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Speedometer["9"]["TextTransparency"] = 0.5
		Speedometer["9"]["TextSize"] = 14
		Speedometer["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["9"]["Size"] = UDim2.new(0, 35, 0, 15)
		Speedometer["9"]["Text"] = [[ABS]]
		Speedometer["9"]["Name"] = [[ABS]]
		Speedometer["9"]["BackgroundTransparency"] = 1
		Speedometer["9"]["Position"] = UDim2.new(0.2666202783584595, 0, 0.44481486082077026, 0)

		-- StarterGui.10k.Holder.Frame.TCR
		Speedometer["a"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["a"]["TextWrapped"] = true
		Speedometer["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["a"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Speedometer["a"]["TextTransparency"] = 0.5
		Speedometer["a"]["TextSize"] = 14
		Speedometer["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["a"]["Size"] = UDim2.new(0, 38, 0, 15)
		Speedometer["a"]["Text"] = [[TCR]]
		Speedometer["a"]["Name"] = [[TCR]]
		Speedometer["a"]["BackgroundTransparency"] = 1
		Speedometer["a"]["Position"] = UDim2.new(0.2666202783584595, 0, 0.4948148727416992, 0)

		-- StarterGui.10k.Holder.Frame.ImageLabel
		Speedometer["b"] = Instance.new("ImageLabel", Speedometer["4"])
		Speedometer["b"]["ZIndex"] = 0
		Speedometer["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["b"]["ImageTransparency"] = 0.6000000238418579
		Speedometer["b"]["Image"] = [[rbxassetid://12897347411]]
		Speedometer["b"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["b"]["BackgroundTransparency"] = 1
		Speedometer["b"]["Position"] = UDim2.new(-0.004755258560180664, 0, -0.0035545825958251953, 0)

		-- StarterGui.10k.Holder.Frame.ImageLabel.Frame
		Speedometer["c"] = Instance.new("Frame", Speedometer["b"])
		Speedometer["c"]["BorderSizePixel"] = 0
		Speedometer["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["c"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Speedometer["c"]["Size"] = UDim2.new(0, 4, 0, 212)
		Speedometer["c"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)

		-- StarterGui.10k.Holder.Frame.ImageLabel.Frame.UIGradient
		Speedometer["d"] = Instance.new("UIGradient", Speedometer["c"])
		Speedometer["d"]["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0.000, 1),
			NumberSequenceKeypoint.new(0.855, 0.987500011920929),
			NumberSequenceKeypoint.new(0.977, 0.5687500238418579),
			NumberSequenceKeypoint.new(0.984, 0),
			NumberSequenceKeypoint.new(1.000, 0),
		})
		Speedometer["d"]["Rotation"] = 270
	end

	HideAllUi:Fire()
	local RSUpdater = RunService.Heartbeat:Connect(function(deltaTime)
		local Speed = CurVehicleData.MPH

		if string.sub(Speed, 1, 3) == "000" then
			Speed = '<font transparency="0.6">000</font>' .. string.sub(Speed, 4, #Speed)
		elseif string.sub(Speed, 1, 2) == "00" then
			Speed = '<font transparency="0.6">00</font>' .. string.sub(Speed, 3, #Speed)
		elseif string.sub(Speed, 1, 1) == "0" then
			Speed = '<font transparency="0.6">0</font>' .. string.sub(Speed, 2, #Speed)
		end

		local deg = CurVehicleData.RPM / 10000 * 260

		if deg > 260 then
			deg = math.random(259, 262)
		end

		Speedometer["c"]["Rotation"] = deg - 130
		Speedometer["8"]["Text"] = CurVehicleData.GEAR
		Speedometer["6"]["Text"] = Speed

		if tonumber(CurVehicleData.RPM) > 8500 then
			Speedometer["5"].Visible = true
			Speedometer["8"].TextColor3 = Color3.fromRGB(255, 49, 87)
		else
			Speedometer["5"].Visible = false
			Speedometer["8"].TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end)

	function Speedometer.Disconnect()
		RSUpdater:Disconnect()
		UnHideAllUi:Fire()
		Speedometer["1"]:Destroy()
	end

	table.insert(rsBin, Speedometer)

	ExitVehSig:Wait()
	Speedometer.Disconnect()
end

function ForzaUI.NewMech12k()
	local Speedometer = {}

	do
		-- StarterGui.12k
		Speedometer["1"] = Instance.new("ScreenGui")
		Speedometer["1"]["Parent"] = (RunService:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui")
		Speedometer["1"]["IgnoreGuiInset"] = true
		Speedometer["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets
		Speedometer["1"]["Name"] = [[12k]]
		Speedometer["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling

		-- StarterGui.12k.Holder
		Speedometer["2"] = Instance.new("Frame", Speedometer["1"])
		Speedometer["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["2"]["BackgroundTransparency"] = 1
		Speedometer["2"]["Size"] = UDim2.new(1, 0, 1, 0)
		Speedometer["2"]["Name"] = [[Holder]]

		-- StarterGui.12k.Holder.UIPadding
		Speedometer["3"] = Instance.new("UIPadding", Speedometer["2"])
		Speedometer["3"]["PaddingRight"] = UDim.new(0, 285)
		Speedometer["3"]["PaddingBottom"] = UDim.new(0, 265)

		-- StarterGui.12k.Holder.Frame
		Speedometer["4"] = Instance.new("Frame", Speedometer["2"])
		Speedometer["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["4"]["BackgroundTransparency"] = 1
		Speedometer["4"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["4"]["Position"] = UDim2.new(1, 0, 1, 0)

		-- StarterGui.12k.Holder.Frame.RedLine
		Speedometer["5"] = Instance.new("ImageLabel", Speedometer["4"])
		Speedometer["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["5"]["ImageTransparency"] = 0.4000000059604645
		Speedometer["5"]["Visible"] = false
		Speedometer["5"]["Image"] = [[rbxassetid://12883856438]]
		Speedometer["5"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["5"]["Name"] = [[RedLine]]
		Speedometer["5"]["BackgroundTransparency"] = 1

		-- StarterGui.12k.Holder.Frame.ImageLabel
		Speedometer["6"] = Instance.new("ImageLabel", Speedometer["4"])
		Speedometer["6"]["ZIndex"] = 0
		Speedometer["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["6"]["ImageTransparency"] = 0.6
		Speedometer["6"]["Image"] = [[rbxassetid://12899144193]]
		Speedometer["6"]["Size"] = UDim2.new(0, 300, 0, 300)
		Speedometer["6"]["BackgroundTransparency"] = 1

		-- StarterGui.12k.Holder.Frame.ImageLabel.Frame
		Speedometer["7"] = Instance.new("Frame", Speedometer["6"])
		Speedometer["7"]["BorderSizePixel"] = 0
		Speedometer["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Speedometer["7"]["Size"] = UDim2.new(0, 4, 0, 212)
		Speedometer["7"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)

		-- StarterGui.12k.Holder.Frame.ImageLabel.Frame.UIGradient
		Speedometer["8"] = Instance.new("UIGradient", Speedometer["7"])
		Speedometer["8"]["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0.000, 1),
			NumberSequenceKeypoint.new(0.855, 0.987500011920929),
			NumberSequenceKeypoint.new(0.977, 0.5687500238418579),
			NumberSequenceKeypoint.new(0.984, 0),
			NumberSequenceKeypoint.new(1.000, 0),
		})
		Speedometer["8"]["Rotation"] = 270

		-- StarterGui.12k.Holder.Frame.Format
		Speedometer["9"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["9"]["TextWrapped"] = true
		Speedometer["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["9"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/Oswald.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic)
		Speedometer["9"]["TextTransparency"] = 0.5
		Speedometer["9"]["TextSize"] = 20
		Speedometer["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["9"]["Size"] = UDim2.new(0, 50, 0, 30)
		Speedometer["9"]["Text"] = [[MPH]]
		Speedometer["9"]["Name"] = [[Format]]
		Speedometer["9"]["BackgroundTransparency"] = 1
		Speedometer["9"]["Position"] = UDim2.new(0.5666203498840332, 0, 0.4448148310184479, 0)

		-- StarterGui.12k.Holder.Frame.ABS
		Speedometer["a"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["a"]["TextWrapped"] = true
		Speedometer["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["a"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Speedometer["a"]["TextTransparency"] = 0.5
		Speedometer["a"]["TextSize"] = 14
		Speedometer["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["a"]["Size"] = UDim2.new(0, 35, 0, 15)
		Speedometer["a"]["Text"] = [[ABS]]
		Speedometer["a"]["Name"] = [[ABS]]
		Speedometer["a"]["BackgroundTransparency"] = 1
		Speedometer["a"]["Position"] = UDim2.new(0.2666202783584595, 0, 0.44481486082077026, 0)

		-- StarterGui.12k.Holder.Frame.Gear
		Speedometer["b"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["b"]["TextWrapped"] = true
		Speedometer["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["b"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Italic)
		Speedometer["b"]["TextTransparency"] = 0.30000001192092896
		Speedometer["b"]["TextSize"] = 50
		Speedometer["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["b"]["Size"] = UDim2.new(0, 200, 0, 80)
		Speedometer["b"]["Text"] = [[3]]
		Speedometer["b"]["Name"] = [[Gear]]
		Speedometer["b"]["BackgroundTransparency"] = 1
		Speedometer["b"]["Position"] = UDim2.new(0.16388459503650665, 0, 0.3606172800064087, 0)

		-- StarterGui.12k.Holder.Frame.Speed
		Speedometer["c"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["c"]["TextWrapped"] = true
		Speedometer["c"]["RichText"] = true
		Speedometer["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["c"]["FontFace"] =
			Font.new([[rbxassetid://12187374954]], Enum.FontWeight.ExtraLight, Enum.FontStyle.Italic)
		Speedometer["c"]["TextTransparency"] = 0.20000000298023224
		Speedometer["c"]["TextSize"] = 100
		Speedometer["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["c"]["Size"] = UDim2.new(0, 150, 0, 80)
		Speedometer["c"]["Text"] = [[000]]
		Speedometer["c"]["Name"] = [[Speed]]
		Speedometer["c"]["BackgroundTransparency"] = 1
		Speedometer["c"]["Position"] = UDim2.new(0.2447965443134308, 0, 0.5750616788864136, 0)

		-- StarterGui.12k.Holder.Frame.TCR
		Speedometer["d"] = Instance.new("TextLabel", Speedometer["4"])
		Speedometer["d"]["TextWrapped"] = true
		Speedometer["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["d"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Speedometer["d"]["TextTransparency"] = 0.5
		Speedometer["d"]["TextSize"] = 14
		Speedometer["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Speedometer["d"]["Size"] = UDim2.new(0, 38, 0, 15)
		Speedometer["d"]["Text"] = [[TCR]]
		Speedometer["d"]["Name"] = [[TCR]]
		Speedometer["d"]["BackgroundTransparency"] = 1
		Speedometer["d"]["Position"] = UDim2.new(0.2666202783584595, 0, 0.4948148727416992, 0)
	end

	HideAllUi:Fire()
	local RSUpdater = RunService.Heartbeat:Connect(function(deltaTime)
		local Speed = CurVehicleData.MPH

		if string.sub(Speed, 1, 3) == "000" then
			Speed = '<font transparency="0.6">000</font>' .. string.sub(Speed, 4, #Speed)
		elseif string.sub(Speed, 1, 2) == "00" then
			Speed = '<font transparency="0.6">00</font>' .. string.sub(Speed, 3, #Speed)
		elseif string.sub(Speed, 1, 1) == "0" then
			Speed = '<font transparency="0.6">0</font>' .. string.sub(Speed, 2, #Speed)
		end

		local deg = CurVehicleData.RPM / 12000 * 260

		if deg > 260 then
			deg = math.random(259, 262)
		end
		Speedometer["7"]["Rotation"] = deg - 130
		Speedometer["b"]["Text"] = CurVehicleData.GEAR
		Speedometer["c"]["Text"] = Speed

		if tonumber(CurVehicleData.RPM) > 10000 then
			Speedometer["5"].Visible = true
			Speedometer["b"].TextColor3 = Color3.fromRGB(255, 49, 87)
		else
			Speedometer["5"].Visible = false
			Speedometer["b"].TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end)

	function Speedometer.Disconnect()
		RSUpdater:Disconnect()
		UnHideAllUi:Fire()
		Speedometer["1"]:Destroy()
	end

	table.insert(rsBin, Speedometer)

	ExitVehSig:Wait()
	Speedometer.Disconnect()
end

local function __init__()
	for i, v in next, rsBin do
		pcall(function()
			v:Disconnect()
		end)
	end

	if selfSettings.onVehicle then
		if selfSettings.forzaType == "Mech8K" then
			ForzaUI.NewMech8k()
		elseif selfSettings.forzaType == "Mech10K" then
			ForzaUI.NewMech10k()
		elseif selfSettings.forzaType == "Mech12K" then
			ForzaUI.NewMech12k()
		elseif selfSettings.forzaType == "Digital" then
		end
	end
end

function ForzaUI.init()
	makeForza:Connect(__init__)
	EnterVehSig:Connect(__init__)

	-- Destroy all RS
	destroyForza:Connect(function()
		for i, v in next, rsBin do
			pcall(function()
				v:Disconnect()
			end)
		end
	end)
end

return ForzaUI

end,
JbvV2Loader = function()
local JbvV2Loader = {}

function JbvV2Loader.Load()
	local Loaded = {}
	local HttpService = game:GetService("HttpService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RunService = game:GetService("RunService")
	local CollectionService = game:GetService("CollectionService")
	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local MarketplaceService = game:GetService("MarketplaceService")
	local CoreGui = game:GetService("CoreGui")

	JailbreakVisionV2 = {
		spring = function()
			local spring = {}
			local epsilon = 1e-8

			local exp = math.exp
			local cos = math.cos
			local sin = math.sin
			local vec3 = Vector3.new

			function spring.new(initial, target)
				local self = setmetatable({}, { __index = spring })

				self.initial = initial
				self.pos = initial
				self.velocity = vec3()
				self.target = target
				self.ratio = 2
				self.frequency = 50

				return self
			end

			function spring:update(dt)
				local x0 = self.pos - self.target
				if self.ratio > 1 + epsilon then -- Over damped
					local za = -self.frequency * self.ratio
					local zb = self.frequency * (self.ratio * self.ratio - 1) ^ 0.5
					local z0, z1 = za - zb, za + zb
					local expt0, expt1 = exp(z0 * dt), exp(z1 * dt)
					local c1 = (self.velocity - x0 * z1) / (-2 * zb)
					local c2 = x0 - c1

					self.pos = self.target + c1 * expt0 + c2 * expt1
					self.velocity = c1 * z1 * expt0 + c2 * z1 * expt1
				elseif self.ratio > 1 - epsilon then -- Critically damped
					local expt = exp(-self.frequency * dt)
					local c1 = self.velocity + self.frequency * x0
					local c2 = (c1 * dt + x0) * expt

					self.pos = self.target + c2
					self.velocity = (c1 * expt) - (c2 * self.frequency)
				else -- Under damped
					local frequencyratio = self.frequency * self.ratio
					local alpha = self.frequency * (1 - self.ratio * self.ratio) ^ 0.5
					local exp = exp(-dt * frequencyratio)
					local cos = cos(dt * alpha)
					local sin = sin(dt * alpha)
					local c2 = (self.velocity + x0 * frequencyratio) / alpha

					self.pos = self.target + exp * (x0 * cos + c2 * sin)
					self.velocity = -exp
						* ((x0 * frequencyratio - c2 * alpha) * cos + (x0 * alpha + c2 * frequencyratio) * sin)
				end
			end

			return spring
		end,
	}

	if not game:IsLoaded() then
		game.Loaded:Wait()
	end

	if not LPH_OBFUSCATED then
		LPH_NO_VIRTUALIZE = function(...)
			return (...)
		end
		LPH_JIT_MAX = function(...)
			return (...)
		end
	end

	getgenv().getcustomasset = getcustomasset or getsynasset

	import = function(dir)
		local Split = string.split(dir, "/")
		---@diagnostic disable-next-line: undefined-global
		local Data = JailbreakVisionV2

		Split[#Split] = string.split(Split[#Split], ".")[1]

		for i = 1, #Split do
			Data = Data[Split[i]]
		end

		if not Loaded[dir] and typeof(Data) == "function" then
			Loaded[dir] = Data()
		elseif typeof(Data) == "table" then
			Loaded[dir] = {}
			for i, v in next, Data do
				Loaded[dir][i] = import(dir .. "/" .. i)
			end
		end

		return Loaded[dir]
	end

	local m_spring = import("spring.lua")

	repeat
		task.wait(1)
	until game:IsLoaded()

	local getasset = getcustomasset or getsynasset

	--Services
	Library =
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Loco-CTO/Script-Assets/main/UI-Lib/VisionLib.lua"))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/mcKTS/FreeCam/main/FreeCamera.lua"))()

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RunService = game:GetService("RunService")
	local SoundService = game:GetService("SoundService")
	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local HttpService = game:GetService("HttpService")
	local GetLocalVehiclePacket = require(ReplicatedStorage.Vehicle.VehicleUtils).GetLocalVehiclePacket
	local UserInputService = game:GetService("UserInputService")
	local clientPlayer = game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)

	local Camera = workspace.CurrentCamera
	Camera.CameraType = "Scriptable"
	local VehicleModel

	local camPos = Camera.CFrame.Position
	local spring = m_spring.new(camPos, camPos)

	local CamPart = Instance.new("Part")
	CamPart.Anchored = true
	CamPart.Parent = game:GetService("Workspace")
	CamPart.CanCollide = false
	CamPart.Size = Vector3.new(50, 5, 10)
	CamPart.Transparency = 1

	local CustomCameraPart = Instance.new("Part")
	CustomCameraPart.Parent = workspace
	CustomCameraPart.Anchored = true
	CustomCameraPart.Transparency = 1

	local CamPerspective = Instance.new("Part")
	CamPerspective.Parent = workspace
	CamPerspective.Anchored = true
	CamPerspective.Transparency = 1
	CamPerspective.CanCollide = false

	local PerspectiveChosen = ""
	local PerspectiveToggle = false

	--DepthOfField
	local DepthOfField = Instance.new("DepthOfFieldEffect")
	DepthOfField.FarIntensity = 0.75
	DepthOfField.NearIntensity = 0.75
	DepthOfField.Enabled = false
	DepthOfField.Parent = game.Lighting

	--Folders Handle
	local assetFolder = Instance.new("Folder")
	assetFolder.Name = "JailbreakVisionV2"
	assetFolder.Parent = game.Workspace

	makefolder("JailbreakVisionV2")
	makefolder("JailbreakVisionV2/SpeedTestResults")
	makefolder("JailbreakVisionV2/ModelsImporter")
	makefolder("JailbreakVisionV2/MapEditor")
	makefolder("JailbreakVisionV2/GameExport")

	local LocalPlayer = game.Players.LocalPlayer
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

	local Vehichle = {}

	for i, v in next, getgc(true) do
		if type(v) == "table" then
			if rawget(v, "Event") and rawget(v, "GetVehiclePacket") then
				Vehichle.GetVehiclePacket = v.GetVehiclePacket
			end
		end
	end

	--Preload Assets
	local modelFolder = Instance.new("Folder")
	modelFolder.Parent = game.Workspace
	modelFolder.Name = "ModelFolder"

	local mapEditFolder = Instance.new("Folder")
	mapEditFolder.Parent = game.ReplicatedStorage
	mapEditFolder.Name = "mapEditFolder"

	--Screen GUI
	do
		local ScreenGui0 = Instance.new("ScreenGui")
		local Frame1 = Instance.new("Frame")
		local Frame2 = Instance.new("Frame")
		local TextLabel3 = Instance.new("TextLabel")
		local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
		local TextLabel5 = Instance.new("TextLabel")
		local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
		local TextLabel7 = Instance.new("TextLabel")
		local UIAspectRatioConstraint8 = Instance.new("UIAspectRatioConstraint")
		local TextLabel9 = Instance.new("TextLabel")
		local UIAspectRatioConstraint10 = Instance.new("UIAspectRatioConstraint")
		local TextLabel11 = Instance.new("TextLabel")
		local UIAspectRatioConstraint12 = Instance.new("UIAspectRatioConstraint")
		local TextLabel13 = Instance.new("TextLabel")
		local UIAspectRatioConstraint14 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint15 = Instance.new("UIAspectRatioConstraint")
		local Frame16 = Instance.new("Frame")
		local Frame17 = Instance.new("Frame")
		local Frame18 = Instance.new("Frame")
		local Frame19 = Instance.new("Frame")
		local UIAspectRatioConstraint20 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint21 = Instance.new("UIAspectRatioConstraint")
		local Frame22 = Instance.new("Frame")
		local UIAspectRatioConstraint23 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint24 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint25 = Instance.new("UIAspectRatioConstraint")
		local UIAspectRatioConstraint26 = Instance.new("UIAspectRatioConstraint")
		local UIPadding27 = Instance.new("UIPadding")
		local UIGradient = Instance.new("UIGradient")
		ScreenGui0.Parent = assetFolder
		ScreenGui0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		Frame1.Name = "Speedometer"
		Frame1.Parent = ScreenGui0
		Frame1.Position = UDim2.new(0.738756597, 0, 0.771196842, 0)
		Frame1.Size = UDim2.new(0.275862068, 0, 0.228714526, 0)
		Frame1.BackgroundColor = BrickColor.new("Institutional white")
		Frame1.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame1.BackgroundTransparency = 1
		Frame2.Name = "Top"
		Frame2.Parent = Frame1
		Frame2.Position = UDim2.new(0.28125, 0, 0.197080299, 0)
		Frame2.Size = UDim2.new(0.612500012, 0, 0.562043786, 0)
		Frame2.BackgroundColor = BrickColor.new("Olivine")
		Frame2.BackgroundColor3 = Color3.new(0.333333, 1, 0.498039)
		Frame2.BackgroundTransparency = 1
		TextLabel3.Name = "Speed"
		TextLabel3.Parent = Frame2
		TextLabel3.Position = UDim2.new(0.223379642, 0, -0.0519480519, 0)
		TextLabel3.Size = UDim2.new(0.607142866, 0, 1.2337662, 0)
		TextLabel3.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel3.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel3.BorderSizePixel = 16
		TextLabel3.ZIndex = 2
		TextLabel3.Font = Enum.Font.SourceSansLight
		TextLabel3.FontSize = Enum.FontSize.Size96
		TextLabel3.Text = "<i>000</i>"
		TextLabel3.TextColor = BrickColor.new("Institutional white")
		TextLabel3.TextColor3 = Color3.new(1, 1, 1)
		TextLabel3.TextScaled = true
		TextLabel3.TextSize = 100
		TextLabel3.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel3.TextTransparency = 0.20000000298023224
		TextLabel3.TextWrap = true
		TextLabel3.TextWrapped = true
		TextLabel3.RichText = true
		UIAspectRatioConstraint4.Parent = TextLabel3
		UIAspectRatioConstraint4.AspectRatio = 1.2526315450668335
		TextLabel5.Name = "Format"
		TextLabel5.Parent = Frame2
		TextLabel5.Position = UDim2.new(0.783323944, 0, 0.692909122, 0)
		TextLabel5.Size = UDim2.new(0.183673471, 0, 0.324675292, 0)
		TextLabel5.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel5.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel5.BackgroundTransparency = 1
		TextLabel5.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel5.BorderSizePixel = 16
		TextLabel5.Font = Enum.Font.Oswald
		TextLabel5.FontSize = Enum.FontSize.Size24
		TextLabel5.Text = "<i><b>MPH</b></i>"
		TextLabel5.TextColor = BrickColor.new("Institutional white")
		TextLabel5.TextColor3 = Color3.new(1, 1, 1)
		TextLabel5.TextScaled = true
		TextLabel5.TextSize = 19
		TextLabel5.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel5.TextTransparency = 0.20000000298023224
		TextLabel5.TextWrap = true
		TextLabel5.TextWrapped = true
		TextLabel5.RichText = true
		UIAspectRatioConstraint6.Parent = TextLabel5
		UIAspectRatioConstraint6.AspectRatio = 1.440000057220459
		TextLabel7.Name = "Gear"
		TextLabel7.Parent = Frame2
		TextLabel7.Position = UDim2.new(0.0357142873, 0, 0.602000058, 0)
		TextLabel7.Size = UDim2.new(0.183673471, 0, 0.44155845, 0)
		TextLabel7.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel7.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel7.BackgroundTransparency = 1
		TextLabel7.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel7.BorderSizePixel = 16
		TextLabel7.ZIndex = 2
		TextLabel7.Font = Enum.Font.GothamMedium
		TextLabel7.FontSize = Enum.FontSize.Size36
		TextLabel7.LineHeight = 0.8999999761581421
		TextLabel7.Text = "<i>1</i>"
		TextLabel7.TextColor = BrickColor.new("Institutional white")
		TextLabel7.TextColor3 = Color3.new(1, 1, 1)
		TextLabel7.TextScaled = true
		TextLabel7.TextSize = 35
		TextLabel7.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel7.TextTransparency = 0.20000000298023224
		TextLabel7.TextWrap = true
		TextLabel7.TextWrapped = true
		TextLabel7.RichText = true
		UIAspectRatioConstraint8.Parent = TextLabel7
		UIAspectRatioConstraint8.AspectRatio = 1.058823585510254
		TextLabel9.Name = "SpeedShadow"
		TextLabel9.Parent = Frame2
		TextLabel9.Position = UDim2.new(0.233325571, 0, -0.0424566902, 0)
		TextLabel9.Size = UDim2.new(0.607142866, 0, 1.2337662, 0)
		TextLabel9.BackgroundColor = BrickColor.new("Dark grey metallic")
		TextLabel9.BackgroundColor3 = Color3.new(0.329412, 0.329412, 0.329412)
		TextLabel9.BackgroundTransparency = 1
		TextLabel9.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel9.BorderSizePixel = 16
		TextLabel9.Font = Enum.Font.SourceSansLight
		TextLabel9.FontSize = Enum.FontSize.Size96
		TextLabel9.Text = "<i>000</i>"
		TextLabel9.TextColor = BrickColor.new("Really black")
		TextLabel9.TextColor3 = Color3.new(0, 0, 0)
		TextLabel9.TextScaled = true
		TextLabel9.TextSize = 100
		TextLabel9.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel9.TextTransparency = 0.800000011920929
		TextLabel9.TextWrap = true
		TextLabel9.TextWrapped = true
		TextLabel9.RichText = true
		UIAspectRatioConstraint10.Parent = TextLabel9
		UIAspectRatioConstraint10.AspectRatio = 1.2526315450668335
		TextLabel11.Name = "GearShadow"
		TextLabel11.Parent = Frame2
		TextLabel11.Position = UDim2.new(0.045980338, 0, 0.611073673, 0)
		TextLabel11.Size = UDim2.new(0.183673471, 0, 0.44155845, 0)
		TextLabel11.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel11.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel11.BackgroundTransparency = 1
		TextLabel11.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel11.BorderSizePixel = 16
		TextLabel11.Font = Enum.Font.GothamMedium
		TextLabel11.FontSize = Enum.FontSize.Size36
		TextLabel11.LineHeight = 0.8999999761581421
		TextLabel11.Text = "<i>1</i>"
		TextLabel11.TextColor = BrickColor.new("Really black")
		TextLabel11.TextColor3 = Color3.new(0, 0, 0)
		TextLabel11.TextScaled = true
		TextLabel11.TextSize = 35
		TextLabel11.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel11.TextTransparency = 0.800000011920929
		TextLabel11.TextWrap = true
		TextLabel11.TextWrapped = true
		TextLabel11.RichText = true
		UIAspectRatioConstraint12.Parent = TextLabel11
		UIAspectRatioConstraint12.AspectRatio = 1.058823585510254
		TextLabel13.Name = "FormatFormat Shadow"
		TextLabel13.Parent = Frame2
		TextLabel13.Position = UDim2.new(0.779999971, 0, 0.709999979, 0)
		TextLabel13.Size = UDim2.new(0.183673471, 0, 0.324675292, 0)
		TextLabel13.BackgroundColor = BrickColor.new("Institutional white")
		TextLabel13.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel13.BackgroundTransparency = 1
		TextLabel13.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
		TextLabel13.BorderSizePixel = 16
		TextLabel13.Font = Enum.Font.Oswald
		TextLabel13.FontSize = Enum.FontSize.Size24
		TextLabel13.Text = "<i><b>MPH</b></i>"
		TextLabel13.TextColor = BrickColor.new("Really black")
		TextLabel13.TextColor3 = Color3.new(0, 0, 0)
		TextLabel13.TextScaled = true
		TextLabel13.TextSize = 19
		TextLabel13.TextStrokeColor3 = Color3.new(0.298039, 0.298039, 0.298039)
		TextLabel13.TextTransparency = 0.800000011920929
		TextLabel13.TextWrap = true
		TextLabel13.TextWrapped = true
		TextLabel13.RichText = true
		UIAspectRatioConstraint14.Parent = TextLabel13
		UIAspectRatioConstraint14.AspectRatio = 1.440000057220459
		UIAspectRatioConstraint15.Parent = Frame2
		UIAspectRatioConstraint15.AspectRatio = 2.545454502105713
		Frame16.Name = "Bottom"
		Frame16.Parent = Frame1
		Frame16.Position = UDim2.new(0.28125, 0, 0.5182482, 0)
		Frame16.Size = UDim2.new(0.612500012, 0, 0.416058391, 0)
		Frame16.BackgroundColor = BrickColor.new("Institutional white")
		Frame16.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame16.BackgroundTransparency = 1
		Frame17.Name = "Meter"
		Frame17.Parent = Frame16
		Frame17.Position = UDim2.new(-0.0663265288, 0, 0.140350878, 0)
		Frame17.Size = UDim2.new(1.10204077, 0, 0.771929801, 0)
		Frame17.BackgroundColor = BrickColor.new("Institutional white")
		Frame17.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame17.BackgroundTransparency = 1
		Frame18.Name = "BarBackground"
		Frame18.Parent = Frame17
		Frame18.Position = UDim2.new(0.0925925896, 0, 0.681818187, 0)
		Frame18.Size = UDim2.new(0.837962985, 0, 0.227272734, 0)
		Frame18.BackgroundColor = BrickColor.new("Institutional white")
		Frame18.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame18.BackgroundTransparency = 0.75
		Frame18.BorderSizePixel = 0
		UIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(0.6, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(0.85, Color3.new(1, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)),
		})
		UIGradient.Enabled = true
		UIGradient.Parent = Frame18
		Frame19.Name = "Bar"
		Frame19.Parent = Frame18
		Frame19.Size = UDim2.new(1, 0, 1, 0)
		Frame19.BackgroundColor = BrickColor.new("Institutional white")
		Frame19.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame19.BackgroundTransparency = 0.4000000059604645
		Frame19.BorderSizePixel = 0
		Frame19.ZIndex = 2
		UIAspectRatioConstraint20.Parent = Frame19
		UIAspectRatioConstraint20.AspectRatio = 9.5
		UIAspectRatioConstraint21.Parent = Frame18
		UIAspectRatioConstraint21.AspectRatio = 18.100000381469727
		Frame22.Name = "BarBackgroundShadow"
		Frame22.Parent = Frame17
		Frame22.Position = UDim2.new(0.109999999, 0, 0.75, 0)
		Frame22.Size = UDim2.new(0.837962985, 0, 0.227272734, 0)
		Frame22.BackgroundColor = BrickColor.new("Really black")
		Frame22.BackgroundColor3 = Color3.new(0, 0, 0)
		Frame22.BackgroundTransparency = 0.949999988079071
		Frame22.BorderSizePixel = 0
		UIAspectRatioConstraint23.Parent = Frame22
		UIAspectRatioConstraint23.AspectRatio = 18.100000381469727
		UIAspectRatioConstraint24.Parent = Frame17
		UIAspectRatioConstraint24.AspectRatio = 4.909090995788574
		UIAspectRatioConstraint25.Parent = Frame16
		UIAspectRatioConstraint25.AspectRatio = 3.438596487045288
		UIAspectRatioConstraint26.Parent = Frame1
		UIAspectRatioConstraint26.AspectRatio = 2.335766315460205
		UIPadding27.Parent = Frame1
	end

	-- G Var
	local Packet, Env =
		{
			Module = {
				Functions = {},
				Data = {},
			},
			Data = {
				Vehicle = require(ReplicatedStorage.Vehicle.VehicleUtils),
				PrevData = {},
			},
			Functions = {},
		}, {}

	-- Var
	local Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}
	getgenv().freeCamera = false
	local PlayerOnVehicle = false
	local modernspeedometerEnable = false
	local customCameraEnable = false
	local VehicleModEnable = false
	local AutoFocus = false
	local SelectingPart = false
	local SelectingFollowCamPart = false
	local simpleSpeedometer = false
	local playerVehicle = nil
	local TargetPart = nil
	local FollowTargetPart = nil
	local ScreenGUI
	local speedometerOutlineColor
	local SpeedTesting = false
	local CamOffsetX = 0
	local CamOffsetY = 0
	local CamOffsetZ = 0
	local CamAngleX = 0
	local CamAngleY = 0
	local CamAngleZ = 0
	local FocusDistance = 1
	local EasingStyle
	local FreeCamCFrame
	local FreeCamPosMode = false
	local CustomFOV = 70
	local doCustomFOV = false
	local FreeCamFOV
	local mapExportMap = "Untitled"
	local mapImportMap = "Nil"
	local MapExportMode = 1
	local MapImportMode = ".rbxm files"
	local ImportAssetID = { "" }
	local ChosenSpeed = 0
	local doSpeedLock
	local DriftParticles

	--Function
	local function getPlayerVehicle()
		for i, vehicle in pairs(game.Workspace.Vehicles:GetChildren()) do
			pcall(function()
				if vehicle.Seat then
					if vehicle.Seat:WaitForChild("PlayerName").Value == game:GetService("Players").LocalPlayer.Name then
						playerVehicle = vehicle
					end
				end
			end)
		end
	end

	local function modernspeedometer()
		pcall(function()
			if modernspeedometerEnable then
				if PlayerOnVehicle then
					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") then
						game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()
					end
					ScreenGUI = assetFolder.ScreenGui:Clone()
					ScreenGUI.Parent = game.Players.LocalPlayer.PlayerGui

					game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
					game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
					game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
					game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.UIAspectRatioConstraint:Destroy()

					while PlayerOnVehicle do
						pcall(function()
							local CarSpeedDisplay = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
							local CarSpeedNum = VehiclePacket["rpmVisual"]
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.Gear.Text = "<i>"
								.. tostring(VehiclePacket["Gear"])
								.. "</i>"
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.GearShadow.Text = "<i>"
								.. tostring(VehiclePacket["Gear"])
								.. "</i>"
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.Speed.Text = "<i>"
								.. CarSpeedDisplay
								.. "</i>"
							game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Top.SpeedShadow.Text = "<i>"
								.. CarSpeedDisplay
								.. "</i>"
							if CarSpeedNum > 1 then
								if CarSpeedNum < 11001 then
									local saturation = 11000 - CarSpeedNum
									local satCal = 1 - saturation / 80
									game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.BackgroundColor3 =
										Color3.fromHSV(0.0, satCal, 0.8)
									game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size =
										UDim2.new(CarSpeedNum / 11200, 0, 1, 0)
								end
							elseif CarSpeedNum < 10001 then
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.BackgroundColor3 =
									Color3.fromHSV(0, 0.0, 1)
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size =
									UDim2.new(CarSpeedNum / 11200, 0, 1, 0)
							elseif
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size
								> UDim2.new(0.9, 0, 1, 0)
							then
								game.Players.LocalPlayer.PlayerGui.ScreenGui.Speedometer.Bottom.Meter.BarBackground.Bar.Size =
									UDim2.new(CarSpeedNum / 11250, 0, 1, 0)
							end
						end)
						task.wait(1 / 60)
					end
				else
					game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
					game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
					game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
					if game.Players.LocalPlayer.PlayerGui.ScreenGui then
						game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()
					end
				end
			else
				game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
				game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
				game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
				if game.Players.LocalPlayer.PlayerGui.ScreenGui then
					game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()
				end
			end
		end)
	end

	local function applySpeedometeroptions()
		if PlayerOnVehicle == true then
			if simpleSpeedometer then
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Missiles.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.MissileBuy.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Lock.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Plate.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Eject.Visible = false
				game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Bottom.Meter.Odometer.Visible = false
			end
			game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.UIStroke.Color = speedometerOutlineColor
			game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Bottom.Line1.BackgroundColor3 = speedometerOutlineColor
			game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Bottom.Line0.BackgroundColor3 = speedometerOutlineColor
		end
	end

	local function exportMap()
		if MapExportMode == "Both" then
			makefolder("JailbreakVisionV2/MapEditor/" .. mapExportMap)
			local terrainRegion = workspace.Terrain:CopyRegion(workspace.Terrain.MaxExtents)
			saveinstance(terrainRegion, "JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Terrain")
			require(game.ReplicatedStorage.Game.Notification).new({ Text = "Terrain exported", Duration = 5 })

			if game.Workspace:FindFirstChild("MapExporterModels") then
				saveinstance(
					game.Workspace.MapExporterModels,
					"JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Models"
				)
				require(game.ReplicatedStorage.Game.Notification).new({ Text = "Model exported", Duration = 5 })
			else
				require(game.ReplicatedStorage.Game.Notification).new({
					Text = "Model export failed, model not found",
					Duration = 5,
				})
			end
		elseif MapExportMode == "Model Only" then
			if game.Workspace:FindFirstChild("MapExporterModels") then
				makefolder("JailbreakVisionV2/MapEditor/" .. mapExportMap)
				saveinstance(
					game.Workspace.MapExporterModels,
					"JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Models"
				)
				require(game.ReplicatedStorage.Game.Notification).new({ Text = "Model exported", Duration = 5 })
			else
				require(game.ReplicatedStorage.Game.Notification).new({
					Text = "Model export failed, model not found",
					Duration = 5,
				})
			end
		else
			makefolder("JailbreakVisionV2/MapEditor/" .. mapExportMap)
			local terrainRegion = workspace.Terrain:CopyRegion(workspace.Terrain.MaxExtents)
			saveinstance(terrainRegion, "JailbreakVisionV2/MapEditor/" .. mapExportMap .. "/Terrain")
			require(game.ReplicatedStorage.Game.Notification).new({ Text = "Terrain Exported", Duration = 5 })
		end
	end

	local function importMap()
		local mapName = string.gsub(mapImportMap, "JailbreakVisionV2/MapEditor\\", "")
		if isfile("JailbreakVisionV2/MapEditor/" .. mapName .. "/Terrain.rbxm") then
			local terrain =
				game:GetObjects(getcustomasset("JailbreakVisionV2/MapEditor/" .. mapName .. "/Terrain.rbxm"))[1]
			game.Workspace.Terrain:Clear()
			game.Workspace.Terrain:PasteRegion(terrain, workspace.Terrain.MaxExtents.Min, true)
		end
		if isfile("JailbreakVisionV2/MapEditor/" .. mapName .. "/Models.rbxm") then
			if game.Workspace:FindFirstChild("ImportedModel") then
				game.Workspace:FindFirstChild("ImportedModel"):Destroy()
			end
			local model =
				game:GetObjects(getcustomasset("JailbreakVisionV2/MapEditor/" .. mapName .. "/Models.rbxm"))[1]
			model.Parent = game.Workspace
			model.Name = "ImportedModel"
			for i, v in pairs(model:GetDescendants()) do
				if v:IsA("Part") then
					if v.Material == Enum.Material.Asphalt and v.Color == Color3.fromRGB(91, 100, 112) then
						v.MaterialVariant = "BrightAsphalt"
					elseif v.Material == Enum.Material.Sand and v.Color == Color3.fromRGB(243, 194, 157) then
						v.MaterialVariant = "SandFixed"
					end
				end
			end
		end
	end

	local function assetImportMap()
		local data = "rbxassetid://" .. ImportAssetID
		local model = game:GetObjects(data)[1]
		model.Parent = modelFolder
		for i, v in pairs(model:GetDescendants()) do
			if v:IsA("BasePart") then
				if v.Material == Enum.Material.Asphalt and v.Color == Color3.fromRGB(91, 100, 112) then
					v.MaterialVariant = "BrightAsphalt"
				elseif v.Material == Enum.Material.Sand and v.Color == Color3.fromRGB(243, 194, 157) then
					v.MaterialVariant = "SandFixed"
				end
			end
		end
	end

	--Ui
	do
		Gui = Library:Create({
			Name = "Jailbreak Vision v2 Beta",
			ShadowColor = Color3.fromRGB(0, 0, 0),
		})

		-- Visual Tab
		do
			VisualTab = Gui:Tab({
				Name = "Visual",
				Icon = "rbxassetid://11284340239",
			})

			VisualTab:Section({
				Name = "Speedometer",
			})

			VisualTab:Toggle({
				Name = "Forza Speedometer System",
				Default = false,
				Callback = function(bool)
					modernspeedometerEnable = bool
					modernspeedometer()
				end,
			})

			VisualTab:Toggle({
				Name = "Simplified Speedometer",
				Default = false,
				Callback = function(bool)
					simpleSpeedometer = bool
					applySpeedometeroptions()
				end,
			})

			VisualTab:Colorpicker({
				Name = "Speedometer Outline Color",
				DefaultColor = Color3.new(1, 1, 1),
				Callback = function(Color)
					speedometerOutlineColor = Color
					applySpeedometeroptions()
				end,
			})

			VisualTab:Section({
				Name = "Camera System",
			})

			VisualTab:Toggle({
				Name = "Forza Camera System",
				Default = false,
				Callback = function(bool)
					customCameraEnable = bool
					if customCameraEnable == false then
						Camera.CameraType = "Custom"
					end
				end,
			})

			VisualTab:Slider({
				Name = "Angular frequency",
				Min = 0,
				Max = 500,
				Default = 50,
				Callback = function(val)
					spring.frequency = val * 10
				end,
			})

			VisualTab:Slider({
				Name = "Damping ratio",
				Min = 0,
				Max = 100,
				Default = 20,
				Callback = function(val)
					spring.ratio = val
				end,
			})

			VisualTab:Section({
				Name = "UI Hider",
			})

			VisualTab:Toggle({
				Name = "Hide UIs (All)",
				Default = false,
				Callback = function(bool)
					pcall(function()
						if not bool then
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = true
						else
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = false
						end
					end)
				end,
			})

			VisualTab:Toggle({
				Name = "Hide UIs (Except speedmeteer)",
				Default = false,
				Callback = function(bool)
					pcall(function()
						if not bool then
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.DamageIndicators.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = true
						else
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.DamageIndicators.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Controls.Visible = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Buttons.Visible = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = false
						end
					end)
				end,
			})
		end

		-- Vehicle Mod
		do
			VehicleModTab = Gui:Tab({
				Name = "Vehicle",
				Icon = "rbxassetid://11360212182",
			})

			VehicleModTab:Section({
				Name = "Vehicle Mod",
			})

			VehicleModTab:Toggle({
				Name = "Enable",
				Default = false,
				Callback = function(bool)
					VehicleModEnable = bool
				end,
			})

			VehichleSpeedSlider = VehicleModTab:Slider({
				Name = "Vehicle Speed",
				Min = 0,
				Max = 100,
				Default = 5,
				Callback = function(val)
					if VehicleModEnable then
						Vehichle.GetVehiclePacket().GarageEngineSpeed = val
					end
				end,
			})

			VehicleTurnSpeedSlider = VehicleModTab:Slider({
				Name = "Vehicle Turn Speed",
				Min = 0,
				Max = 100,
				Default = 2,
				Callback = function(val)
					if VehicleModEnable then
						Vehichle.GetVehiclePacket().TurnSpeed = val
					end
				end,
			})

			VehicleSuspensionHeightSlider = VehicleModTab:Slider({
				Name = "Vehicle Suspension Height",
				Min = 0,
				Max = 100,
				Default = 3,
				Callback = function(val)
					if VehicleModEnable then
						Vehichle.GetVehiclePacket().Height = val
					end
				end,
			})

			SmokeAttach = VehicleModTab:Button({
				Name = "Smoke", -- String
				Callback = function()
					for i, v in next, GetLocalVehiclePacket().Model:GetChildren() do
						if v.Name == "Drift" then
							v.ParticleEmitter.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
								ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
							})
							v.ParticleEmitter.Size = NumberSequence.new({
								NumberSequenceKeypoint.new(0, 4),
								NumberSequenceKeypoint.new(1, 4),
							})
						end
					end
				end, -- Callback
			})

			CRSec = VehicleModTab:Section({
				Name = "Vehicle Mods", -- String
			})

			local ChooseSpeed = VehicleModTab:Slider({
				Name = "Lock Speed", -- String
				Min = 0, -- Int
				Max = 400, -- Int
				Default = 0, -- Int
				Callback = function(val)
					ChosenSpeed = val
				end, -- Callback, int
			})

			LockCarSpeed = VehicleModTab:Toggle({
				Name = "Lock Car Speed", -- String
				Default = false, -- Bool
				Callback = function(bool)
					doSpeedLock = bool
					while doSpeedLock do
						local CarSpeedNum =
							tonumber(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text)
						if CarSpeedNum < ChosenSpeed then
							keypress(0x57)
							task.wait()
						elseif CarSpeedNum > ChosenSpeed then
							keyrelease(0x57)
							task.wait()
						end
						task.wait()
						if not doSpeedLock then
							keyrelease(0x57)
						end
					end
				end, -- Callback, boolean
			})

			VehicleModTab:Section({
				Name = "Vehicle Packets",
			})

			MPHLabel = VehicleModTab:TextLabel({
				Name = "MPH: " .. "nil",
				Color = Color3.new(1, 0, 0),
			})

			GearLabel = VehicleModTab:TextLabel({
				Name = "Gear: " .. tostring(VehiclePacket["Gear"]),
				Color = Color3.new(1, 0, 0),
			})

			VisualRPMLabel = VehicleModTab:TextLabel({
				Name = "Visual RPM: " .. tostring(VehiclePacket["rpmVisual"]),
				Color = Color3.new(1, 0, 0),
			})

			ThrustLabel = VehicleModTab:TextLabel({
				Name = "BodyThrust: " .. "nil",
				Color = Color3.new(1, 0, 0),
			})

			ForceLabel = VehicleModTab:TextLabel({
				Name = "BodyForce: " .. "nil",
				Color = Color3.new(1, 0, 0),
			})

			MassLabel = VehicleModTab:TextLabel({
				Name = "Mass: " .. tostring(VehiclePacket["Mass"]),
				Color = Color3.new(1, 0, 0),
			})
		end

		-- Camera Tab
		do
			CameraTab = Gui:Tab({
				Name = "Camera",
				Icon = "rbxassetid://11346388439",
			})

			CameraTab:Section({
				Name = "Effects",
			})

			CameraTab:Toggle({
				Name = "Depth Of Field",
				Default = false,
				Callback = function(bool)
					DepthOfField.Enabled = bool
				end,
			})

			FocusDistanceSlider = CameraTab:Slider({
				Name = "Focus Distance",
				Min = 0,
				Max = 200,
				Default = 100,
				Callback = function(val)
					DepthOfField.FocusDistance = val
				end,
			})

			CameraTab:Slider({
				Name = "Focus Range",
				Min = 0,
				Max = 500,
				Default = 100,
				Callback = function(val)
					DepthOfField.InFocusRadius = val
				end,
			})

			CameraTab:Section({
				Name = "Track Focus",
			})

			FocusPartLabel = CameraTab:TextLabel({
				Name = "Focused: " .. "nil",
				Color = Color3.new(0.450980, 0.101960, 0.611764),
			})

			CameraTab:Toggle({
				Name = "Auto Focus",
				Default = false,
				Callback = function(bool)
					AutoFocus = bool
				end,
			})

			CameraTab:Button({
				Name = "Select Part",
				Callback = function()
					SelectingPart = true
				end,
			})

			CameraTab:Section({
				Name = "Vehicle Perspective",
			})
			CameraTab:Toggle({
				Name = "Camera Perspective",
				Default = false,
				Callback = function(bool)
					PerspectiveToggle = bool

					if not PerspectiveToggle then
						Camera.CameraType = "Custom"
					end
				end,
			})

			CameraTab:Slider({
				Name = "Custom FOV", -- String
				Min = 1, -- Int
				Max = 120, -- Int
				Default = 70, -- Int
				Callback = function(val)
					CustomFOV = val
				end, -- Callback, int
			})

			CameraTab:Toggle({
				Name = "Activate FOV", -- String
				Default = false, -- Bool
				Callback = function(bool)
					doCustomFOV = bool
					local FOV
					if doCustomFOV and not SpeedTesting then
						task.spawn(function()
							FOV = RunService.RenderStepped:Connect(function()
								Camera.FieldOfView = CustomFOV
							end)
						end)
					end
					repeat
						task.wait()
					until not doCustomFOV
					FOV:Disconnect()
				end,
			})

			CameraTab:Dropdown({
				Name = "Perspective",
				Items = {
					"Default",
					"Top Down",
					"Front",
					"Front Right",
					"Front Left",
					"Back Right",
					"Back Left",
					"Direct Right",
					"Direct Left",
					"Side Right",
					"Side Left",
					"Wheel Right",
					"Wheel Left",
					"Chase High",
					"Chase Low",
					"Hood View",
					"Custom",
					"Follow",
				},

				Callback = function(item)
					if not PlayerOnVehicle then
						require(game.ReplicatedStorage.Game.Notification).new({
							Text = "You are not on a Vehicle",
							Duration = 3,
						})
					elseif PlayerOnVehicle then
						PerspectiveChosen = item
						if item == "Default" then
							Camera.CameraType = "Custom"
						end
					end
				end,
			})

			CameraTab:Button({
				Name = "Select Part (Follow Cam)",
				Callback = function()
					SelectingFollowCamPart = true
				end,
			})

			FollowCamTargetLabel = CameraTab:TextLabel({
				Name = "Focused: " .. "nil",
				Color = Color3.new(0.450980, 0.101960, 0.611764),
			})

			CameraTab:Dropdown({
				Name = "Dropdown", -- String
				Items = { "Use Free Cam Position", "Use Slider Position" }, -- Table
				Callback = function(item)
					if item == "Use Free Cam Position" then
						FreeCamPosMode = true
					elseif item == "Use Slider Position" then
						FreeCamPosMode = false
					end
				end,
			})

			CameraTab:Button({
				Name = "Update Camera Postion", -- String
				Callback = function()
					VehicleModel = GetLocalVehiclePacket().Model
					FreeCamCFrame = VehicleModel.PrimaryPart.CFrame:ToObjectSpace(Camera.CFrame)
						or VehicleModel:FindFirstChild("Engine").CFrame:ToObjectSpace(Camera.CFrame)
					FreeCamFOV = Camera.FieldOfView
				end, -- Callback
			})

			CameraTab:Section({
				Name = "Perspective Customization",
			})

			CameraTab:Slider({
				Name = "X axis offset",
				Min = -50, -- Int
				Max = 50, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamOffsetX = val
				end,
			})

			CameraTab:Slider({
				Name = "Y axis offset",
				Min = -50, -- Int
				Max = 50, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamOffsetY = val
				end,
			})

			CameraTab:Slider({
				Name = "Z axis offset",
				Min = -50, -- Int
				Max = 50, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamOffsetZ = val
				end,
			})

			CameraTab:Slider({
				Name = "X angle",
				Min = -180, -- Int
				Max = 180, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamAngleX = val
				end,
			})

			CameraTab:Slider({
				Name = "Y angle",
				Min = -180, -- Int
				Max = 180, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamAngleY = val
				end,
			})

			CameraTab:Slider({
				Name = "Z angle",
				Min = -180, -- Int
				Max = 180, -- Int
				Default = 0, -- Int
				Callback = function(val)
					CamAngleZ = val
				end,
			})

			CameraTab:Section({
				Name = "Free Cam",
			})

			CameraTab:Toggle({
				Name = "Toggle",
				Default = false,
				Callback = function(bool)
					getgenv().freeCamera = bool
				end,
			})
		end

		-- SpeedTest Tab
		do
			local SpeedTestDuration = 60
			local SpeedTestLockVehicle = false
			local VehicleLockerPart = Instance.new("Part")
			local speedTestForwardMode = true

			VehicleLockerPart.Parent = game.Workspace
			VehicleLockerPart.CanCollide = false
			VehicleLockerPart.Anchored = true
			VehicleLockerPart.Transparency = 1
			local Stage

			SpeedTestTab = Gui:Tab({
				Name = "Speed Test",
				Icon = "rbxassetid://12678650413",
			})

			SpeedTestTab:Section({
				Name = "Speed Test",
			})

			SpeedTestTab:Button({
				Name = "Start",
				Callback = function()
					if PlayerOnVehicle and not SpeedTesting then
						SpeedTesting = true
						local CamRS

						task.spawn(function()
							CamRS = RunService.RenderStepped:Connect(function()
								Camera.CameraType = "Scriptable"
								Camera.FieldOfView = 50
							end)
						end)

						Stage = game:GetObjects("rbxassetid://11522200723")[1]
						Stage.Parent = game.Workspace
						Stage.PrimaryPart = Stage:FindFirstChild("Background")
						VehicleModel = GetLocalVehiclePacket().Model
						Stage:SetPrimaryPartCFrame(CFrame.new(VehicleModel.Engine.Position + Vector3.new(0, 400, 0)))
						Stage.Name = "Stage"
						local SurfaceDisplayContainer = Stage.SurfaceDisplay.SurfaceGui.Container
						Stage.ParticlePartForward.Particles.Rate = 0
						Stage.ParticlePartBackward.Particles.Rate = 0

						do
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = false
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = false
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = false
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = false
						end

						VehicleModel:SetPrimaryPartCFrame(Stage.CarLocate.CFrame)
						task.wait(3)
						VehicleModel:SetPrimaryPartCFrame(Stage.CarLocate.CFrame)

						task.wait(5)
						VehicleModel:SetPrimaryPartCFrame(Stage.CarLocate.CFrame)

						task.spawn(function()
							task.wait(3)
							do
								local CampartX = VehicleModel.BoundingBox.Size.X * -18
								local CampartY = VehicleModel.BoundingBox.Size.Y * 3

								Stage.Campart.CFrame = VehicleModel.BoundingBox.CFrame
									+ (VehicleModel.BoundingBox.CFrame.LookVector * Vector3.new(CampartX, 0, 0))
								Stage.Campart.Position = Stage.Campart.Position + Vector3.new(0, CampartY, 0)

								local function lookAt(from, target)
									local forwardVector = (target - from).Unit
									local upVector = Vector3.new(0, 1, 0)
									local rightVector = forwardVector:Cross(upVector)
									local upVector2 = rightVector:Cross(forwardVector)

									return CFrame.fromMatrix(from, rightVector, upVector2)
								end

								Stage.Campart.CFrame = lookAt(Stage.Campart.Position, Stage.CameraViewPoint.Position)
							end

							VehicleLockerPart.CFrame = VehicleModel.PrimaryPart.CFrame
						end)

						task.wait(5)
						Camera.CameraType = Enum.CameraType.Scriptable
						Camera.CFrame = Stage.CameraStartingTween.CFrame

						task.spawn(function()
							local TweenService = game:GetService("TweenService")
							local info = TweenInfo.new(6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
							local tween = TweenService:Create(Camera, info, { CFrame = Stage.Campart.CFrame })
							tween:Play()
						end)

						SurfaceDisplayContainer.VehicleName.Text = VehiclePacket.Model.Name
						SpeedTestLockVehicle = true

						local SpeedTestMode = ""

						if speedTestForwardMode then
							SpeedTestMode = "Forward"
						else
							SpeedTestMode = "Reverse"
						end

						task.spawn(function()
							while SpeedTesting do
								SurfaceDisplayContainer.GearNum.Text = VehiclePacket["Gear"]
								SurfaceDisplayContainer.RPMNum.Text =
									tostring(math.floor(tonumber(VehiclePacket["rpmVisual"])))
								if speedTestForwardMode then
									Stage.ParticlePartForward.Particles.Rate = tonumber(
										game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
									) * 2
								else
									Stage.ParticlePartBackward.Particles.Rate = tonumber(
										game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
									) * 2
								end
								SurfaceDisplayContainer.ModeNum.Text = SpeedTestMode

								task.wait(1 / 60)
							end
						end)

						task.spawn(function()
							local function DecimalsToMinutes(dec)
								local ms = tonumber(dec)
								return math.floor(ms / 60), (ms % 60)
							end

							local minutes, seconds = DecimalsToMinutes(SpeedTestDuration)
							local timer = SurfaceDisplayContainer.Time

							if seconds <= 9 then
								timer.Text = tostring(minutes) .. ":0" .. tostring(seconds)
							else
								timer.Text = tostring(minutes) .. ":" .. tostring(seconds)
							end
						end)

						do
							SurfaceDisplayContainer.Speed.Text = "Starting SpeedTest"
							task.wait(3)
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "3"
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "2"
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "1"
							task.wait(1)
							SurfaceDisplayContainer.Speed.Text = "0"
							task.wait(1)
						end

						task.spawn(function()
							while SpeedTesting do
								Camera.CFrame = Stage.Campart.CFrame

								task.wait()
							end
						end)

						task.spawn(function()
							while SpeedTesting do
								SurfaceDisplayContainer.Speed.Text = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
									.. " MPH"

								task.wait(1 / 60)
							end
						end)

						task.spawn(function()
							local function DecimalsToMinutes(dec)
								local ms = tonumber(dec)
								return math.floor(ms / 60), (ms % 60)
							end

							local minutes, seconds = DecimalsToMinutes(SpeedTestDuration)
							local timer = SurfaceDisplayContainer.Time

							repeat
								if seconds <= 0 then
									minutes = minutes - 1
									seconds = 59
								else
									seconds = seconds - 1
								end
								if seconds <= 9 then
									timer.Text = tostring(minutes) .. ":0" .. tostring(seconds)
								else
									timer.Text = tostring(minutes) .. ":" .. tostring(seconds)
								end
								task.wait(1)
							until minutes <= 0 and seconds <= 0
						end)

						task.spawn(function()
							local recording = {}
							local sec = 0
							local properties = {}
							local speedTestProp = {}

							properties["Vehicle Name"] = VehiclePacket.Model.Name
							if speedTestForwardMode then
								properties["Test Mode"] = "Forward"
							else
								properties["Test Mode"] = "Reverse"
							end

							while sec ~= (SpeedTestDuration + 1) do
								if not SpeedTesting then
									break
								end

								if speedTestForwardMode then
									keypress(0x57)
								else
									keypress(0x53)
								end
								local prop = {}
								prop["Time"] = sec
								prop["Speed"] = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text

								speedTestProp[sec + 1] = prop

								sec = sec + 1

								task.wait(1)
							end

							recording["Settings"] = properties
							recording["SpeedTest"] = speedTestProp

							local speedTestSheet = HttpService:JSONEncode(recording)
							local speedtestfilename = VehiclePacket.Model.Name
								.. " "
								.. properties["Test Mode"]
								.. " "
								.. tostring(SpeedTestDuration)
								.. "s"
							writefile(
								tostring("JailbreakVisionV2/SpeedTestResults/" .. speedtestfilename .. ".json"),
								tostring(speedTestSheet)
							)

							if SpeedTesting == true then
								SpeedTesting = false
							end
						end)

						repeat
							task.wait()
						until SpeedTesting == false

						task.spawn(function()
							keyrelease(0x53)
							keyrelease(0x57)
						end)

						SurfaceDisplayContainer.Speed.Text = "Ended"

						if game.Players.LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
							repeat
								task.wait()
							until game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text == "000"
						end

						Camera.CameraType = "Custom"
						SpeedTestLockVehicle = false
						Stage:Destroy()
						CamRS:Disconnect()
						do
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.AppUI.Enabled = true
							game.Players.LocalPlayer.PlayerGui.HotbarGui.Enabled = true
							game.Players.LocalPlayer.PlayerGui.LevelGui2.Enabled = true
							game.Players.LocalPlayer.PlayerGui.WorldMarkersGui.Enabled = true
						end
					end
				end,
			})

			SpeedTestTab:Dropdown({
				Name = "Duration",
				Items = { 10, 15, 30, 60, 90, 120, 180 },
				Default = 60,
				Callback = function(item)
					SpeedTestDuration = item
				end,
			})

			SpeedTestTab:Dropdown({
				Name = "Mode",
				Items = { "Forward", "Backward" },
				Default = "Forward",
				Callback = function(item)
					if item == "Forward" then
						speedTestForwardMode = true
					else
						speedTestForwardMode = false
					end
				end,
			})

			RunService.Heartbeat:Connect(function()
				pcall(function()
					if SpeedTestLockVehicle then
						pcall(function()
							VehicleModel:SetPrimaryPartCFrame(VehicleLockerPart.CFrame)
						end)
					end
				end)
			end)

			TerrainTab = Gui:Tab({
				Name = "Map Editor",
				Icon = "rbxassetid://12403099678",
			})

			TerrainTab:Section({
				Name = "Import", -- String
			})

			ImportModeSelction = TerrainTab:Dropdown({
				Name = "Import Selection", -- String
				Items = { ".rbxm files", "Roblox Assets" }, -- Table
				Callback = function(item)
					MapImportMode = item
				end, -- Callback, Any (Depend on item)
			})

			Textbox = TerrainTab:Textbox({
				Name = "Asset ID", -- String
				PlaceholderText = "Type here", -- String
				Callback = function(text)
					ImportAssetID = text
					return
				end, -- Callback, String
			})

			ImportSelction = TerrainTab:Dropdown({
				Name = "Import Selection", -- String
				Items = listfiles("JailbreakVisionV2/MapEditor"),
				Callback = function(item)
					mapImportMap = item
				end, -- Callback, Any (Depend on item)
			})

			TerrainTab:Button({
				Name = "Import", -- String
				Callback = function()
					if MapImportMode == ".rbxm files" then
						importMap()
					else
						assetImportMap()
					end
				end, -- Callback
			})

			TerrainTab:Button({
				Name = "Refresh", -- String
				Callback = function()
					ImportSelction:UpdateList({
						Items = listfiles("JailbreakVisionV2/MapEditor"), -- Table
						Replace = true, -- Boolean (Whether you clear the dropdown or not)
					})
				end, -- Callback
			})

			TerrainTab:Section({
				Name = "Edit", -- String
			})

			local ClickDelPart = false

			local SelectionBox = Instance.new("Part")
			SelectionBox.Parent = game:GetService("Workspace")
			SelectionBox.Transparency = 1
			SelectionBox.Position = Vector3.new(0, 0, 0)
			SelectionBox.Anchored = true
			SelectionBox.CanCollide = false

			local Selection = Instance.new("SelectionBox")
			Selection.Parent = SelectionBox
			Selection.Color3 = Color3.fromRGB(255, 255, 255)
			Selection.SurfaceColor3 = Color3.fromRGB(255, 255, 255)
			Selection.Adornee = SelectionBox
			Selection.LineThickness = 0.05
			Selection.SurfaceTransparency = 0.7
			Selection.Transparency = 0

			Mouse.TargetFilter = SelectionBox
			local Target

			RunService.Heartbeat:Connect(function(deltaTime)
				if ClickDelPart then
					Target = Mouse.Target

					if not (Target == nil) then
						if Target:IsA("BasePart") then
							local PartSize = Target.Size
							local PartPos = Target.CFrame

							SelectionBox.Size = PartSize
							SelectionBox.CFrame = PartPos
						end
					end
				else
					SelectionBox.Position = Vector3.new(0, 0, 0)
					SelectionBox.Size = Vector3.new(1, 1, 1)
				end
			end)

			UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
				if ClickDelPart then
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if not (Target == nil) then
							if Target:IsA("BasePart") then
								pcall(function()
									Target.Parent = mapEditFolder
								end)
							end
						end
					end
				end
			end)

			TerrainTab:Toggle({
				Name = "Click Delete Part",
				Default = false,
				Callback = function(bool)
					ClickDelPart = bool
				end,
			})

			TerrainTab:Button({
				Name = "Undo All",
				Callback = function()
					for i, v in next, mapEditFolder:GetChildren() do
						pcall(function()
							v.Parent = game:GetService("Workspace")
						end)
					end
				end,
			})

			ExportTab = Gui:Tab({
				Name = "Export",
				Icon = "rbxassetid://12403097620",
			})

			ExportTab:Button({
				Name = "Save Map", -- String
				Callback = function()
					local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
					saveinstance(game, "JailbreakVisionV2/GameExport/" .. GetName.Name)
				end, -- Callback
			})
		end
	end

	--Connect
	RunService.Heartbeat:Connect(function()
		pcall(function()
			if tostring(VehiclePacket["Gear"]) == "nil" then
				MPHLabel:SetColor(Color3.new(1, 0, 0))
				GearLabel:SetColor(Color3.new(1, 0, 0))
				VisualRPMLabel:SetColor(Color3.new(1, 0, 0))
				MassLabel:SetColor(Color3.new(1, 0, 0))
				ThrustLabel:SetColor(Color3.new(1, 0, 0))
				ForceLabel:SetColor(Color3.new(1, 0, 0))
			else
				MPHLabel:SetColor(Color3.new(0, 1, 0))
				GearLabel:SetColor(Color3.new(0, 1, 0))
				VisualRPMLabel:SetColor(Color3.new(0, 1, 0))
				MassLabel:SetColor(Color3.new(0, 1, 0))
				ThrustLabel:SetColor(Color3.new(0, 1, 0))
				ForceLabel:SetColor(Color3.new(0, 1, 0))
			end

			if game.Players.LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
				MPHLabel:SetText(
					"MPH: " .. tostring(tonumber(game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text))
				)
			else
				MPHLabel:SetText("MPH: " .. "nil")
			end

			if playerVehicle ~= nil and PlayerOnVehicle then
				ThrustLabel:SetText("BodyThrust: " .. tostring(playerVehicle.Engine.BodyThrust.Force))
				ForceLabel:SetText("BodyForce: " .. tostring(playerVehicle.Engine.BodyForce.Force))
			else
				ThrustLabel:SetText("BodyThrust: " .. "nil")
				ForceLabel:SetText("BodyForce: " .. "nil")
			end

			GearLabel:SetText("Gear: " .. tostring(VehiclePacket["Gear"]))
			VisualRPMLabel:SetText("Visual RPM: " .. tostring(VehiclePacket["rpmVisual"]))
			MassLabel:SetText("Mass: " .. tostring(VehiclePacket["Mass"]))

			if SelectingPart then
				if Mouse.Target ~= nil then
					FocusPartLabel:SetText("Selecting: " .. tostring(Mouse.Target))
					FocusPartLabel:SetColor(Color3.new(0.823529, 0.596078, 0.925490))
				end
			end

			if SelectingFollowCamPart then
				if Mouse.Target ~= nil then
					FollowCamTargetLabel:SetText("Selecting: " .. tostring(Mouse.Target))
					FollowCamTargetLabel:SetColor(Color3.new(0.823529, 0.596078, 0.925490))
				end
			end

			if TargetPart ~= nil and AutoFocus then
				local Dist = (TargetPart.Position - Character.HumanoidRootPart.Position).magnitude
				Dist = math.floor(Dist)
				if Dist < 201 then
					DepthOfField.FocusDistance = Dist
					-- FocusDistanceSlider:SetValue(Dist)
				end
			end
		end)
	end)

	RunService.Heartbeat:Connect(function()
		pcall(function()
			if game.Players.LocalPlayer.Character.Humanoid.Sit and customCameraEnable then
				Camera.CameraType = "Scriptable"
				Camera.FieldOfView = 80
			elseif game.Players.LocalPlayer.Character.Humanoid.Sit and PerspectiveToggle then
				VehicleModel = GetLocalVehiclePacket().Model

				if PerspectiveChosen == "Default" then
					return
				elseif PerspectiveChosen == "Top Down" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(0, 35, 10)
						* CFrame.Angles(math.rad(-75), 0, 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Front" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(0, 0, -15)
						* CFrame.Angles(math.rad(8), math.rad(-180), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Front Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(8, 3, -15)
						* CFrame.Angles(math.rad(8), math.rad(-215), math.rad(-2))
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Front Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-8, 2, -15)
						* CFrame.Angles(math.rad(8), math.rad(215), math.rad(2))
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Back Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(8, 3, 15)
						* CFrame.Angles(math.rad(-2), math.rad(22), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Back Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-8, 3, 15)
						* CFrame.Angles(math.rad(-2), math.rad(-22), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Direct Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(17, 2, 0)
						* CFrame.Angles(0, math.rad(90), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Direct Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-17, 2, 0)
						* CFrame.Angles(0, math.rad(-90), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Side Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(5, 2, 5)
						* CFrame.Angles(math.rad(-5), math.rad(8), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Side Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(-5, 2, 5)
						* CFrame.Angles(math.rad(-5), math.rad(-8), 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Wheel Right" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(5.25, 0.5, -1.5)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Wheel Left" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(-5.25, 0.5, -1.5)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Chase High" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(0, 7, 15)
						* CFrame.Angles(math.rad(-15), 0, 0)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Chase Low" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(0, 1, 15)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Hood View" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame * CFrame.new(0, 2.5, -5)
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Custom" and not FreeCamPosMode then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(CamOffsetX, CamOffsetY, CamOffsetZ)
						* CFrame.Angles(math.rad(CamAngleX), math.rad(CamAngleY), math.rad(CamAngleZ))
					Camera.CFrame = CamPerspective.CFrame
				elseif PerspectiveChosen == "Custom" and FreeCamPosMode then
					Camera.CameraType = "Scriptable"
					local NewCamCF = FreeCamCFrame
					NewCamCF = VehicleModel.PrimaryPart.CFrame:ToWorldSpace(NewCamCF)
						or VehicleModel:FindFirstChild("Engine"):ToWorldSpace(NewCamCF)
					Camera.CFrame = NewCamCF
					Camera.FieldOfView = FreeCamFOV
				elseif PerspectiveChosen == "Follow" then
					Camera.CameraType = "Scriptable"
					CamPerspective.CFrame = VehicleModel.PrimaryPart.CFrame
						* CFrame.new(CamOffsetX, CamOffsetY, CamOffsetZ)
						* CFrame.Angles(math.rad(CamAngleX), math.rad(CamAngleY), math.rad(CamAngleZ))
					local function lookAt(from, target)
						local forwardVector = (target - from).Unit
						local upVector = Vector3.new(0, 1, 0)
						local rightVector = forwardVector:Cross(upVector)
						local upVector2 = rightVector:Cross(forwardVector)
						return CFrame.fromMatrix(from, rightVector, upVector2)
					end

					Camera.CFrame = lookAt(CamPerspective.Position, FollowTargetPart.Position)
				end
			else
				Camera.CameraType = "Custom"
			end
		end)
	end)

	local lastFrameDT = 0
	local lastPhyDT
	local CamOffSet = CFrame.new(0, 5, 18) * CFrame.Angles(math.rad(-8), 0, 0)

	RunService:BindToRenderStep("VehicleCam", Enum.RenderPriority.Camera.Value + 50, function()
		if game.Players.LocalPlayer.Character.Humanoid.Sit and customCameraEnable then
			VehicleModel = GetLocalVehiclePacket().Model

			Camera.CameraType = "Scriptable"
			Camera.FieldOfView = 80

			local targetCF = VehicleModel.PrimaryPart.CFrame * CamOffSet
			spring.target = targetCF.Position

			spring:update(lastPhyDT + lastFrameDT)
			local SpringCFrame = CFrame.new(spring.pos) * (targetCF - targetCF.Position)

			Camera.CFrame = SpringCFrame

			lastFrameDT = 0
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if SelectingPart then
				TargetPart = Mouse.Target
				FocusPartLabel:SetText("Focused: " .. tostring(TargetPart))
				FocusPartLabel:SetColor(Color3.new(0.450980, 0.101960, 0.611764))
				SelectingPart = false
			end
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if SelectingFollowCamPart then
				FollowTargetPart = Mouse.Target
				FollowCamTargetLabel:SetText("Focused: " .. tostring(FollowTargetPart))
				FollowCamTargetLabel:SetColor(Color3.new(0.658823, 0.392156, 0.780392))
				SelectingFollowCamPart = false
			end
		end
	end)

	if game.PlaceId == 606849621 then
		game.Players.LocalPlayer.PlayerGui.AppUI.ChildAdded:Connect(function(gui)
			if gui.name == "Speedometer" then
				Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}
				PlayerOnVehicle = true
				getPlayerVehicle()
				modernspeedometer()
				applySpeedometeroptions()

				do
					pcall(function()
						--[[VehichleSpeedSlider:SetValue(Vehichle.GetVehiclePacket().GarageEngineSpeed)
						VehicleTurnSpeedSlider:SetValue(Vehichle.GetVehiclePacket().TurnSpeed)
						VehicleSuspensionHeightSlider:SetValue(Vehichle.GetVehiclePacket().Height)]]
						--
					end)
				end
			end
		end)

		game.Players.LocalPlayer.PlayerGui.AppUI.ChildRemoved:Connect(function(gui)
			if gui.name == "Speedometer" then
				Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}
				PlayerOnVehicle = false
				getPlayerVehicle()
				modernspeedometer()
				applySpeedometeroptions()

				task.spawn(function()
					task.wait(0.1)
					Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
					Camera.CameraType = "Custom"
				end)

				SpeedTesting = false
			elseif gui.name == "Garage" then
				do
					pcall(function()
						--[[VehichleSpeedSlider:SetValue(Vehichle.GetVehiclePacket().GarageEngineSpeed)
						VehicleTurnSpeedSlider:SetValue(Vehichle.GetVehiclePacket().TurnSpeed)
						VehicleSuspensionHeightSlider:SetValue(Vehichle.GetVehiclePacket().Height)]]
						--
					end)
				end
			end
		end)
	end

	task.spawn(function()
		while true do
			local placeholder
			placeholder, lastPhyDT = RunService.Stepped:Wait()
		end
	end)

	Camera.CameraType = "Custom"
	setfpscap(1500)
	for i, v in next, getgc(true) do
		if type(v) == "table" and rawget(v, "MAX_DIST_TO_LOAD") then
			v.MAX_DIST_TO_LOAD = 9e9
		end
	end
end

return JbvV2Loader

end,
LightingEditor = function()
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
end,
ModelImporter = function()
local DestructibleBind = import("Modules/DestructibleBind.lua")
local Importer = {}

function Importer.importMap(mapImportMap)
	local mapName = string.gsub(mapImportMap, "JailbreakVisionV3/MapEditor\\", "")
	if isfile("JailbreakVisionV3/MapEditor/" .. mapName .. "/Terrain.rbxm") then
		local terrain = game:GetObjects(getasset("JailbreakVisionV3/MapEditor/" .. mapName .. "/Terrain.rbxm"))[1]

		game.Workspace.Terrain:Clear()
		game.Workspace.Terrain:PasteRegion(terrain, workspace.Terrain.MaxExtents.Min, true)
	end

	if isfile("JailbreakVisionV3/MapEditor/" .. mapName .. "/Models.rbxm") then
		if game.Workspace:FindFirstChild("ImportedModel") then
			game.Workspace:FindFirstChild("ImportedModel"):Destroy()
		end

		local model = game:GetObjects(getasset("JailbreakVisionV3/MapEditor/" .. mapName .. "/Models.rbxm"))[1]
		model.Parent = game.Workspace
		model.Name = "ImportedModel"

		for i, v in pairs(model:GetDescendants()) do
			if v:IsA("Part") then
				if v.Material == Enum.Material.Asphalt and v.Color == Color3.fromRGB(91, 100, 112) then
					v.MaterialVariant = "BrightAsphalt"
				elseif v.Material == Enum.Material.Sand and v.Color == Color3.fromRGB(243, 194, 157) then
					v.MaterialVariant = "SandFixed"
				end
			end
		end

		if model:FindFirstChild("Destructibles") then
			for i, v in next, model:FindFirstChild("Destructibles"):GetChildren() do
				isTree = v:GetAttribute("IsTree")
				if v:IsA("Model") then
					for _, part in next, v:GetChildren() do
						if part.Name == "Base" then
							DestructibleBind.add(part, isTree)
						else
							part.CanCollide = false
							part.CanTouch = false
							part.Anchored = false
							part.Massless = true
						end
					end
				end
			end
		end
	end
end

function Importer.assetImportMap(ImportAssetID)
	local data = "" .. ImportAssetID
	local model = game:GetObjects(data)[1]
	model.Parent = modelFolder
	for i, v in pairs(model:GetDescendants()) do
		if v:IsA("Part") then
			if v.Material == Enum.Material.Asphalt and v.Color == Color3.fromRGB(91, 100, 112) then
				v.MaterialVariant = "BrightAsphalt"
			elseif v.Material == Enum.Material.Sand and v.Color == Color3.fromRGB(243, 194, 157) then
				v.MaterialVariant = "SandFixed"
			end
		end
	end
end

return Importer

end,
Signal = function()
local RunService = game:GetService("RunService")
local Http = game:GetService("HttpService")

local Heartbeat = RunService.Heartbeat

local Signal = {}
Signal.__index = Signal
Signal.ClassName = "Signal"

local Connections = {}
Connections.__index = Connections

local ActiveSignals = {}

function Signal.new(SignalName)
	assert(typeof(SignalName) == "string" or not SignalName, "Invalid value type for SignalName")

	local self = setmetatable({
		["functions"] = {},
		["LastSignaled"] = tick(),
		["ID"] = "__" .. Http:GenerateGUID(),
		["Active"] = true,
	}, Signal)

	if SignalName then
		self["Name"] = SignalName
	end

	ActiveSignals[self.ID] = self

	return self
end

function Signal.Get(id)
	assert(typeof(id) == "string", "Invalid value type for id")
	local self = ActiveSignals[id]
	if not self then
		for _, signal in pairs(ActiveSignals) do
			if signal["Name"] == id then
				self = signal
				break
			end
		end
	end
	return self
end

function Signal.WaitFor(id, length)
	assert(typeof(id) == "string", "Invalid value type for id")
	assert(typeof(length) == "number" or not length, "Invalid value type for id")
	length = length or 5

	local signal
	local StartTime = tick()
	while (not signal) and tick() - StartTime <= length and Heartbeat:Wait() do
		local self = ActiveSignals[id]
		if not self then
			for _, signal in pairs(ActiveSignals) do
				if signal["Name"] == id then
					self = signal
					break
				end
			end
		end
		if self then
			return self
		end
	end
	warn("Infinite yield possible when waiting for signal: " .. id)
end

local function Connect(self, callback)
	assert(typeof(callback) == "function", "Invalid argument type for callback")
	local ID = "__" .. Http:GenerateGUID()
	self.functions[ID] = callback
	local connection = setmetatable({ ["Signal"] = self.ID }, Connections)
	connection.ID = ID
	return connection
end

function Signal:Connect(callback)
	return Connect(self, callback)
end

function Signal:connect(callback)
	return Connect(self, callback)
end

local function Fire(self, ...)
	self.LastSignaled = tick()
	if ActiveSignals[self.ID].Active then
		for _, funct in pairs(self.functions) do
			coroutine.wrap(funct)(...)
		end
	end
end

function Signal:Fire(...)
	Fire(self, ...)
end

function Signal:fire(...)
	Fire(self, ...)
end

local function WaitForSignal(self)
	local LastSignalTick = tonumber(self.LastSignaled)
	while true do
		Heartbeat:Wait()
		if LastSignalTick ~= self.LastSignaled then
			return LastSignalTick - self.LastSignaled
		end
	end
end

function Signal:Wait()
	WaitForSignal(self)
end

function Signal:wait()
	WaitForSignal(self)
end

local function Destroy(self)
	ActiveSignals[self.ID].Active = false
end

function Signal:Destroy()
	Destroy(self)
end

function Signal:destroy()
	Destroy(self)
end

local function Disconnect(self)
	ActiveSignals[self.Signal].functions[self.ID] = nil
end

function Connections:Disconnect()
	Disconnect(self)
end

function Connections:disconnect()
	Disconnect(self)
end

return Signal

end,
SpeedTest = function()
local SpeedTest = {}

function SpeedTest.SpeedtestStart(Scene, Duration, Mode)
	local VehiclePacket = require(game:GetService("ReplicatedStorage").Game.Vehicle).GetLocalVehiclePacket
	local PlayerCamera = workspace.CurrentCamera
	local Speedtesting = false
	local TimeLeft
	local TotalTime
	local TeleportOffset
	CurVehicleData.Vehicle = VehiclePacket().Model
	local VehicleModel = VehiclePacket().Model

	if not Scene then
		Library:Notify({
			Name = "Scene not found bruh", -- String
			Text = "bros stupid", -- String
			Icon = "rbxassetid://11401835376", -- String
			Duration = 5, -- Integer
			Callback = function()
				-- Function
			end,
		})
	end

	local mapName = string.gsub(Scene, "JailbreakVisionV3/SpeedtestScenes\\", "")

	if isfile("JailbreakVisionV3/SpeedtestScenes/" .. mapName .. "/Models.rbxm") then
		if game.Workspace:FindFirstChild("SpeedtestScene") then
			game.Workspace:FindFirstChild("SpeedtestScene"):Destroy()
		end

		model = game:GetObjects(getasset("JailbreakVisionV3/SpeedtestScenes/" .. mapName .. "/Models.rbxm"))[1]
		model.Parent = game.Workspace
		model.Name = "SpeedtestScene"

		for i, v in pairs(model:GetDescendants()) do
			if v:IsA("Part") then
				if v.Material == Enum.Material.Asphalt and v.Color == Color3.fromRGB(91, 100, 112) then
					v.MaterialVariant = "BrightAsphalt"
				elseif v.Material == Enum.Material.Sand and v.Color == Color3.fromRGB(243, 194, 157) then
					v.MaterialVariant = "SandFixed"
				end
			end
		end
	end

	model:PivotTo(VehicleModel.PrimaryPart:GetPivot() * CFrame.new(0, 300, 0))

	Speedtesting = true
	TimeLeft = Duration
	TotalTime = Duration

	local CarLock = model:FindFirstChild("Platform")

	local CameraPart = model:FindFirstChild("Campart")

	local RaycastParam = RaycastParams.new()
	RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
	RaycastParam.FilterDescendantsInstances = { VehicleModel }

	local castRay =
		workspace:Raycast(VehicleModel.Engine.CFrame * CFrame.new(0, 0, 0).Position, Vector3.yAxis * -1e2, RaycastParam)

	if castRay and castRay.Material == Enum.Material.Asphalt then
		task.spawn(function()
			Cam = RunService.RenderStepped:Connect(function()
				PlayerCamera.CameraType = Enum.CameraType.Scriptable
				PlayerCamera.CFrame = CameraPart.CFrame
				PlayerCamera.FieldOfView = 50
			end)

			LockCar = RunService.Heartbeat:Connect(function()
				VehicleModel:PivotTo(CarLock:GetPivot() * CFrame.new(0, castRay.Distance, 0))
			end)
		end)

		task.spawn(function()
			local recording = {}
			local properties = {}
			local speedTestProp = {}

			while true do
				if TimeLeft == 0 then
					Speedtesting = false
					break
				end

				TimeLeft = TimeLeft - 1
				properties["Vehicle Name"] = VehicleModel.Name

				if Mode == "Forwards" then
					properties["Test Mode"] = "Forward"
				else
					properties["Test Mode"] = "Reverse"
				end

				local prop = {}
				prop["Time"] = TotalTime - TimeLeft
				prop["Speed"] = game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text
				speedTestProp[TimeLeft + 1] = prop
				task.wait(1)
			end

			recording["Settings"] = properties
			recording["SpeedTest"] = speedTestProp
			local speedTestSheet = HttpService:JSONEncode(recording)
			local speedtestfilename = VehiclePacket().Model.Name
				.. " "
				.. properties["Test Mode"]
				.. " "
				.. tostring(TotalTime)
				.. "s"
			writefile(
				tostring("JailbreakVisionV3/SpeedTestResults/" .. speedtestfilename .. ".json"),
				tostring(speedTestSheet)
			)
		end)

		task.spawn(function()
			checks = RunService.Heartbeat:Connect(function()
				if not Speedtesting then
					if Mode == "Forwards" then
						keyrelease(0x57)
					else
						keyrelease(0x53)
					end

					if game.Players.LocalPlayer.PlayerGui.AppUI:FindFirstChild("Speedometer") then
						repeat
							task.wait()
						until game.Players.LocalPlayer.PlayerGui.AppUI.Speedometer.Top.Speed.Text == "000"
					end

					Cam:Disconnect()
					PlayerCamera.CameraType = Enum.CameraType.Custom
					LockCar:Disconnect()
					model:Destroy()

					checks:Disconnect()
				else
					if Mode == "Forwards" then
						keypress(0x57)
					else
						keypress(0x53)
					end
				end
			end)

			task.wait()
		end)
	else
		selfSettings.Library:Notify({
			Name = "Speed Test",
			Text = "You are not on a road!",
			Icon = "rbxassetid://11401835376",
			Duration = 5,
		})
	end
end

return SpeedTest

end,
Spring = function()
local spring = {}
local epsilon = 1e-4

local sin = math.sin
local cos = math.cos
local exp = math.exp

function spring.new(init, obj)
	local self = setmetatable({}, { __index = spring })

	self.init = init
	self.pos = init
	self.velocity = Vector3.new()
	self.obj = obj
	self.ratio = 2
	self.frequency = 50

	return self
end

function spring:update(dt)
	local x0 = self.pos - self.obj

	if self.ratio > 1 + epsilon then -- Over damped
		local za = -self.frequency * self.ratio
		local zb = self.frequency * (self.ratio * self.ratio - 1) ^ 0.5
		local z0, z1 = za - zb, za + zb
		local expt0, expt1 = exp(z0 * dt), exp(z1 * dt)
		local c1 = (self.velocity - x0 * z1) / (-2 * zb)
		local c2 = x0 - c1

		self.pos = self.obj + c1 * expt0 + c2 * expt1
		self.velocity = c1 * z1 * expt0 + c2 * z1 * expt1
	elseif self.ratio > 1 - epsilon then -- Crit damped
		local expt = exp(-self.frequency * dt)
		local c1 = self.velocity + self.frequency * x0
		local c2 = (c1 * dt + x0) * expt

		self.pos = self.obj + c2
		self.velocity = (c1 * expt) - (c2 * self.frequency)
	else -- Under damped
		local frequencyratio = self.frequency * self.ratio
		local alpha = self.frequency * (1 - self.ratio * self.ratio) ^ 0.5
		local exp = exp(-dt * frequencyratio)
		local cos = cos(dt * alpha)
		local sin = sin(dt * alpha)
		local c2 = (self.velocity + x0 * frequencyratio) / alpha

		self.pos = self.obj + exp * (x0 * cos + c2 * sin)
		self.velocity = -exp * ((x0 * frequencyratio - c2 * alpha) * cos + (x0 * alpha + c2 * frequencyratio) * sin)
	end
end

return spring

end,
UiLibrary = {
Lib = function()
-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()
local ConnectionBin = {}
local ControlsConnectionBin = {}

-- Var
local ThemeInstances = {
	["Main"] = {},
	["MainTrue"] = {},
	["Secondary"] = {},
	["SecondaryTrue"] = {},
	["Tertiary"] = {},
	["TertiaryTrue"] = {},
	["Text"] = {},
	["PlaceholderText"] = {},
	["Textbox"] = {},
	["NavBar"] = {},
	["Theme"] = {},
	["ThemeTrue"] = {},
}

local ThemeColor = {
	Main = ColorSequence.new({ -- 6
		ColorSequenceKeypoint.new(0.000, Color3.fromRGB(45, 45, 45)),
		ColorSequenceKeypoint.new(1.000, Color3.fromRGB(39, 39, 39)),
	}),
	MainTrue = Color3.fromRGB(45, 45, 45),
	Secondary = ColorSequence.new({ -- 7
		ColorSequenceKeypoint.new(0.000, Color3.fromRGB(31, 31, 31)),
		ColorSequenceKeypoint.new(1.000, Color3.fromRGB(24, 24, 24)),
	}),
	SecondaryTrue = Color3.fromRGB(31, 31, 31),
	Tertiary = ColorSequence.new({ -- 4
		ColorSequenceKeypoint.new(0.000, Color3.fromRGB(31, 31, 31)),
		ColorSequenceKeypoint.new(1.000, Color3.fromRGB(27, 27, 27)),
	}),
	TertiaryTrue = Color3.fromRGB(31, 31, 31),
	Text = Color3.fromRGB(255, 255, 255),
	PlaceholderText = Color3.fromRGB(175, 175, 175),
	Textbox = Color3.fromRGB(61, 61, 61),
	NavBar = ColorSequence.new({ -- 9
		ColorSequenceKeypoint.new(0.000, Color3.fromRGB(35, 35, 35)),
		ColorSequenceKeypoint.new(1.000, Color3.fromRGB(24, 24, 24)),
	}),
	NavBarTrue = Color3.fromRGB(35, 35, 35),
	Theme = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, Color3.fromRGB(132, 65, 232)),
		ColorSequenceKeypoint.new(1.000, Color3.fromRGB(132, 65, 185)),
	}),
	ThemeTrue = Color3.fromRGB(132, 65, 232),
}

local Library = {
	MainFrameHover = false,
	Sliding = false,
	Loaded = false,
	CurrentTheme = {
		Main = ThemeColor.MainTrue,
		Secondary = ThemeColor.SecondaryTrue,
		Tertiary = ThemeColor.TertiaryTrue,
		Text = ThemeColor.Text,
		PlaceholderText = ThemeColor.PlaceholderText,
		Textbox = ThemeColor.Textbox,
		NavBar = ThemeColor.NavBarTrue,
		Theme = ThemeColor.ThemeTrue,
	},
	TimeLineEditorExists = false,
}

pcall(function()
	getgenv().VisionUILibrary:Destroy()
end)

pcall(function()
	getgenv().VisionUILibrary = Library
end)

local LibSettings = {
	DragSpeed = 0.07,
	SoundVolume = 0.5,
	HoverSound = "rbxassetid://10066931761",
	ClickSound = "rbxassetid://6895079853",
	PopupSound = "rbxassetid://225320558",
}

local TabIndex = 0

-- Lib
local LibFrame = {}
do
	-- StarterGui.Vision Lib v2
	LibFrame["1"] = Instance.new("ScreenGui")
	LibFrame["1"]["Name"] = [[VisionLibv2]]
	LibFrame["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
	LibFrame["1"]["Parent"] = (RunService:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui")
	LibFrame["1"]["IgnoreGuiInset"] = false

	-- StarterGui.Vision Lib v2
	LibFrame["2"] = Instance.new("ScreenGui")
	LibFrame["2"]["Name"] = [[VisionLibOverlay]]
	LibFrame["2"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
	LibFrame["2"]["Parent"] = (RunService:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui")
	LibFrame["2"]["IgnoreGuiInset"] = true

	-- StarterGui.Vision Lib v2.NotifFrame
	LibFrame["81"] = Instance.new("Frame", LibFrame["1"])
	LibFrame["81"]["Active"] = true
	LibFrame["81"]["BorderSizePixel"] = 0
	LibFrame["81"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	LibFrame["81"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
	LibFrame["81"]["BackgroundTransparency"] = 1
	LibFrame["81"]["Size"] = UDim2.new(0.154, 0, 0, 0)
	LibFrame["81"]["Position"] = UDim2.new(0.925, 0, 0.995, 0)
	LibFrame["81"]["Name"] = [[NotifFrame]]

	-- StarterGui.Vision Lib v2.NotifFrame.UIListLayout
	LibFrame["82"] = Instance.new("UIListLayout", LibFrame["81"])
	LibFrame["82"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom
	LibFrame["82"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right
	LibFrame["82"]["Padding"] = UDim.new(0, 5)
	LibFrame["82"]["SortOrder"] = Enum.SortOrder.LayoutOrder

	-- StarterGui.Vision Lib v2.NotifFrame.UIPadding
	LibFrame["83"] = Instance.new("UIPadding", LibFrame["81"])
	LibFrame["83"]["PaddingRight"] = UDim.new(0, 40)
	LibFrame["83"]["PaddingBottom"] = UDim.new(0, 40)
end

function Library:Tween(object, options, callback)
	local options = Library:PlaceDefaults({
		Length = 2,
		Style = Enum.EasingStyle.Quint,
		Direction = Enum.EasingDirection.Out,
	}, options)

	callback = callback or function()
		return
	end

	local tweeninfo = TweenInfo.new(options.Length, options.Style, options.Direction)

	local Tween = TweenService:Create(object, tweeninfo, options.Goal)
	Tween:Play()

	table.insert(
		ConnectionBin,
		Tween.Completed:Connect(function()
			callback()
		end)
	)
	return Tween
end

function Library:ResizeCanvas(Tab)
	local NumChild = 0
	local ChildOffset = 0

	for i, v in pairs(Tab:GetChildren()) do
		if v:IsA("Frame") then
			NumChild = NumChild + 1
			ChildOffset = ChildOffset + v.Size.Y.Offset
		end
	end

	local NumChildOffset = NumChild * 5

	local CanvasSizeY = NumChildOffset + ChildOffset + 10

	Library:Tween(Tab, {
		Length = 0.5,
		Goal = { CanvasSize = UDim2.new(0, 0, 0, CanvasSizeY) },
	})
end

function Library:CalGradient(BaseColor, Diff)
	local h, s, v = BaseColor:ToHSV()

	local p0 = Color3.fromHSV(h, s, v)
	local p1

	Diff = Diff / 100

	if (v - Diff) < 0 then
		p1 = Color3.fromHSV(h, s, 0)
	else
		p1 = Color3.fromHSV(h, s, v - Diff)
	end

	return ColorSequence.new({ ColorSequenceKeypoint.new(0.000, p0), ColorSequenceKeypoint.new(1.000, p1) })
end

function Library:ResizeSection(Section)
	local SectionContainer = Section:WaitForChild("SectionContainer")

	local NumChild = 0
	local ChildOffset = 0

	for i, v in pairs(SectionContainer:GetChildren()) do
		if v:IsA("Frame") then
			NumChild = NumChild + 1
			ChildOffset = ChildOffset + v.Size.Y.Offset
		end
	end

	local NumChildOffset = NumChild * 5

	local ContainerSize = NumChildOffset + ChildOffset + 10
	local SectionSize = ContainerSize + 26

	Library:Tween(SectionContainer, {
		Length = 0.5,
		Goal = { Size = UDim2.new(0, 458, 0, ContainerSize) },
	})

	Library:Tween(Section, {
		Length = 0.5,
		Goal = { Size = UDim2.new(0, 458, 0, SectionSize) },
	})
end

function Library:PlaceDefaults(defaults, options)
	defaults = defaults or {}
	options = options or {}
	for option, value in next, options do
		defaults[option] = value
	end

	return defaults
end

function Library:SetDragSpeed(DragSpeed)
	if DragSpeed < 0 then
		DragSpeed = 0
	end
	if DragSpeed > 100 then
		DragSpeed = 100
	end

	LibSettings.DragSpeed = DragSpeed / 100

	return
end

function Library:SetVolume(Volume)
	if Volume < 0 then
		Volume = 0
	end
	if Volume > 100 then
		Volume = 100
	end

	LibSettings.SoundVolume = Volume / 100

	return
end

function Library:SetHoverSound(SoundID)
	LibSettings.HoverSound = SoundID

	return
end

function Library:SetClickSound(SoundID)
	LibSettings.ClickSound = SoundID

	return
end

function Library:SetPopupSound(SoundID)
	LibSettings.PopupSound = SoundID

	return
end

function Library:PlaySound(SoundID)
	local NotifSound = Instance.new("Sound")
	NotifSound.Name = "NotificationSound"
	NotifSound.SoundId = SoundID
	NotifSound.Parent = game:GetService("SoundService")
	NotifSound.PlaybackSpeed = Random.new():NextNumber(0.98, 1.02)
	NotifSound.Volume = LibSettings.SoundVolume
	NotifSound:Play()

	task.spawn(function()
		NotifSound.Ended:Wait()
		NotifSound:Destroy()
	end)

	return
end

function Library:ToolTip(Text)
	local ToolTip = {}

	Library:PlaySound(LibSettings.HoverSound)

	do
		-- StarterGui.ScreenGui.ToolTip
		ToolTip["2"] = Instance.new("TextLabel", LibFrame["1"])
		ToolTip["2"]["BorderSizePixel"] = 0
		ToolTip["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
		ToolTip["2"]["TextSize"] = 12
		ToolTip["2"]["Text"] = Text
		ToolTip["2"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		ToolTip["2"]["Name"] = [[ToolTip]]
		ToolTip["2"]["Font"] = Enum.Font.Gotham
		ToolTip["2"]["BackgroundTransparency"] = 0.5
		ToolTip["2"]["Position"] = UDim2.new(0, Mouse.X, 0, Mouse.Y)
		local Bound = TextService:GetTextSize(
			Text,
			12,
			Enum.Font.Gotham,
			Vector2.new(ToolTip["2"].AbsoluteSize.X, ToolTip["2"].AbsoluteSize.Y)
		)
		ToolTip["2"]["Size"] = UDim2.new(0, (Bound.X + 28), 0, 18)
	end

	local RSSync = RunService.Heartbeat:Connect(function()
		ToolTip["2"].Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
	end)

	do
		function ToolTip:Destroy()
			RSSync:Disconnect()
			ToolTip["2"]:Destroy()
		end
	end

	return ToolTip
end

function Library:SetTheme(Theme)
	Theme = Library:PlaceDefaults({
		Main = ThemeColor.MainTrue,
		Secondary = ThemeColor.SecondaryTrue,
		Tertiary = ThemeColor.TertiaryTrue,
		Text = ThemeColor.Text,
		PlaceholderText = ThemeColor.PlaceholderText,
		Textbox = ThemeColor.Textbox,
		NavBar = ThemeColor.NavBarTrue,
		Theme = ThemeColor.ThemeTrue,
	}, Theme or {})

	Library.CurrentTheme = Theme

	ThemeColor = {
		Main = Library:CalGradient(Theme.Main, 6),
		MainTrue = Theme.Main,
		Secondary = Library:CalGradient(Theme.Secondary, 7),
		SecondaryTrue = Theme.Secondary,
		Tertiary = Library:CalGradient(Theme.Tertiary, 4),
		TertiaryTrue = Theme.Tertiary,
		Text = Theme.Text,
		PlaceholderText = Theme.PlaceholderText,
		Textbox = Theme.Textbox,
		NavBar = Library:CalGradient(Theme.NavBar, 9),
		NavBarTrue = Theme.NavBar,
		Theme = Library:CalGradient(Theme.Theme, 47),
		ThemeTrue = Theme.Theme,
	}

	for i, v in next, ThemeInstances.Main do
		pcall(function()
			v.Color = ThemeColor.Main
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.Main
		end)
	end

	for i, v in next, ThemeInstances.MainTrue do
		pcall(function()
			v.Color = ThemeColor.MainTrue
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.MainTrue
		end)
		pcall(function()
			v.ImageColor3 = ThemeColor.MainTrue
		end)
	end

	for i, v in next, ThemeInstances.Secondary do
		pcall(function()
			v.Color = ThemeColor.Secondary
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.Secondary
		end)
	end

	for i, v in next, ThemeInstances.SecondaryTrue do
		pcall(function()
			v.Color = ThemeColor.SecondaryTrue
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.SecondaryTrue
		end)
	end

	for i, v in next, ThemeInstances.Tertiary do
		pcall(function()
			v.Color = ThemeColor.Tertiary
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.Tertiary
		end)
	end

	for i, v in next, ThemeInstances.TertiaryTrue do
		pcall(function()
			v.Color = ThemeColor.TertiaryTrue
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.TertiaryTrue
		end)
	end

	for i, v in next, ThemeInstances.Text do
		pcall(function()
			v.TextColor3 = ThemeColor.Text
		end)
	end

	for i, v in next, ThemeInstances.PlaceholderText do
		pcall(function()
			v.PlaceholderColor3 = ThemeColor.PlaceholderText
		end)
	end

	for i, v in next, ThemeInstances.Textbox do
		pcall(function()
			v.Color = ThemeColor.Textbox
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.Textbox
		end)
		pcall(function()
			v.ImageColor3 = ThemeColor.Textbox
		end)
	end

	for i, v in next, ThemeInstances.NavBar do
		pcall(function()
			v.Color = ThemeColor.NavBar
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.NavBar
		end)
	end

	for i, v in next, ThemeInstances.Theme do
		pcall(function()
			v.Color = ThemeColor.Theme
		end)
		pcall(function()
			v.BackgroundColor3 = ThemeColor.Theme
		end)
	end

	for i, v in next, ThemeInstances.ThemeTrue do
		pcall(function()
			if v:FindFirstChild("ToggleVal").Value == true then
				v.BackgroundColor3 = ThemeColor.ThemeTrue
			end
		end)
	end

	task.spawn(function()
		task.wait(0.2)

		for i, v in next, ThemeInstances.Main do
			pcall(function()
				v.Color = ThemeColor.Main
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Main
			end)
		end

		for i, v in next, ThemeInstances.MainTrue do
			pcall(function()
				v.Color = ThemeColor.MainTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.MainTrue
			end)
			pcall(function()
				v.ImageColor3 = ThemeColor.MainTrue
			end)
		end

		for i, v in next, ThemeInstances.Secondary do
			pcall(function()
				v.Color = ThemeColor.Secondary
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Secondary
			end)
		end

		for i, v in next, ThemeInstances.SecondaryTrue do
			pcall(function()
				v.Color = ThemeColor.SecondaryTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.SecondaryTrue
			end)
		end

		for i, v in next, ThemeInstances.Tertiary do
			pcall(function()
				v.Color = ThemeColor.Tertiary
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Tertiary
			end)
		end

		for i, v in next, ThemeInstances.TertiaryTrue do
			pcall(function()
				v.Color = ThemeColor.TertiaryTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.TertiaryTrue
			end)
		end

		for i, v in next, ThemeInstances.Text do
			pcall(function()
				v.TextColor3 = ThemeColor.Text
			end)
		end

		for i, v in next, ThemeInstances.PlaceholderText do
			pcall(function()
				v.PlaceholderColor3 = ThemeColor.PlaceholderText
			end)
		end

		for i, v in next, ThemeInstances.Textbox do
			pcall(function()
				v.Color = ThemeColor.Textbox
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Textbox
			end)
			pcall(function()
				v.ImageColor3 = ThemeColor.Textbox
			end)
		end

		for i, v in next, ThemeInstances.NavBar do
			pcall(function()
				v.Color = ThemeColor.NavBar
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.NavBar
			end)
		end

		for i, v in next, ThemeInstances.Theme do
			pcall(function()
				v.Color = ThemeColor.Theme
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Theme
			end)
		end

		for i, v in next, ThemeInstances.ThemeTrue do
			pcall(function()
				if v:FindFirstChild("ToggleVal").Value == true then
					v.BackgroundColor3 = ThemeColor.ThemeTrue
				end
			end)
		end
	end)

	task.spawn(function()
		task.wait(1)

		for i, v in next, ThemeInstances.Main do
			pcall(function()
				v.Color = ThemeColor.Main
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Main
			end)
		end

		for i, v in next, ThemeInstances.MainTrue do
			pcall(function()
				v.Color = ThemeColor.MainTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.MainTrue
			end)
			pcall(function()
				v.ImageColor3 = ThemeColor.MainTrue
			end)
		end

		for i, v in next, ThemeInstances.Secondary do
			pcall(function()
				v.Color = ThemeColor.Secondary
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Secondary
			end)
		end

		for i, v in next, ThemeInstances.SecondaryTrue do
			pcall(function()
				v.Color = ThemeColor.SecondaryTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.SecondaryTrue
			end)
		end

		for i, v in next, ThemeInstances.Tertiary do
			pcall(function()
				v.Color = ThemeColor.Tertiary
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Tertiary
			end)
		end

		for i, v in next, ThemeInstances.TertiaryTrue do
			pcall(function()
				v.Color = ThemeColor.TertiaryTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.TertiaryTrue
			end)
		end

		for i, v in next, ThemeInstances.Text do
			pcall(function()
				v.TextColor3 = ThemeColor.Text
			end)
		end

		for i, v in next, ThemeInstances.PlaceholderText do
			pcall(function()
				v.PlaceholderColor3 = ThemeColor.PlaceholderText
			end)
		end

		for i, v in next, ThemeInstances.Textbox do
			pcall(function()
				v.Color = ThemeColor.Textbox
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Textbox
			end)
			pcall(function()
				v.ImageColor3 = ThemeColor.Textbox
			end)
		end

		for i, v in next, ThemeInstances.NavBar do
			pcall(function()
				v.Color = ThemeColor.NavBar
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.NavBar
			end)
		end

		for i, v in next, ThemeInstances.Theme do
			pcall(function()
				v.Color = ThemeColor.Theme
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Theme
			end)
		end

		for i, v in next, ThemeInstances.ThemeTrue do
			pcall(function()
				if v:FindFirstChild("ToggleVal").Value == true then
					v.BackgroundColor3 = ThemeColor.ThemeTrue
				end
			end)
		end
	end)

	task.spawn(function()
		task.wait(5)

		for i, v in next, ThemeInstances.Main do
			pcall(function()
				v.Color = ThemeColor.Main
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Main
			end)
		end

		for i, v in next, ThemeInstances.MainTrue do
			pcall(function()
				v.Color = ThemeColor.MainTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.MainTrue
			end)
			pcall(function()
				v.ImageColor3 = ThemeColor.MainTrue
			end)
		end

		for i, v in next, ThemeInstances.Secondary do
			pcall(function()
				v.Color = ThemeColor.Secondary
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Secondary
			end)
		end

		for i, v in next, ThemeInstances.SecondaryTrue do
			pcall(function()
				v.Color = ThemeColor.SecondaryTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.SecondaryTrue
			end)
		end

		for i, v in next, ThemeInstances.Tertiary do
			pcall(function()
				v.Color = ThemeColor.Tertiary
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Tertiary
			end)
		end

		for i, v in next, ThemeInstances.TertiaryTrue do
			pcall(function()
				v.Color = ThemeColor.TertiaryTrue
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.TertiaryTrue
			end)
		end

		for i, v in next, ThemeInstances.Text do
			pcall(function()
				v.TextColor3 = ThemeColor.Text
			end)
		end

		for i, v in next, ThemeInstances.PlaceholderText do
			pcall(function()
				v.PlaceholderColor3 = ThemeColor.PlaceholderText
			end)
		end

		for i, v in next, ThemeInstances.Textbox do
			pcall(function()
				v.Color = ThemeColor.Textbox
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Textbox
			end)
			pcall(function()
				v.ImageColor3 = ThemeColor.Textbox
			end)
		end

		for i, v in next, ThemeInstances.NavBar do
			pcall(function()
				v.Color = ThemeColor.NavBar
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.NavBar
			end)
		end

		for i, v in next, ThemeInstances.Theme do
			pcall(function()
				v.Color = ThemeColor.Theme
			end)
			pcall(function()
				v.BackgroundColor3 = ThemeColor.Theme
			end)
		end

		for i, v in next, ThemeInstances.ThemeTrue do
			pcall(function()
				if v:FindFirstChild("ToggleVal").Value == true then
					v.BackgroundColor3 = ThemeColor.ThemeTrue
				end
			end)
		end
	end)
end

function Library:UserAgreement()
	local Agreement = {}

	local Blur = Instance.new("BlurEffect", game:GetService("Lighting"))
	Blur.Name = "Base"
	Blur.Size = 0
	Blur.Enabled = true

	do
		-- StarterGui.Vision Lib v2.PromptBase
		Agreement["1d7"] = Instance.new("Frame", LibFrame["1"])
		Agreement["1d7"]["ZIndex"] = 10
		Agreement["1d7"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
		Agreement["1d7"]["BackgroundTransparency"] = 1
		Agreement["1d7"]["Size"] = UDim2.new(1, 0, 1, 0)
		Agreement["1d7"]["Name"] = [[PromptBase]]

		-- StarterGui.Vision Lib v2.PromptBase.Prompt
		Agreement["1d8"] = Instance.new("Frame", Agreement["1d7"])
		Agreement["1d8"]["ZIndex"] = 11
		Agreement["1d8"]["BorderSizePixel"] = 0
		Agreement["1d8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1d8"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Agreement["1d8"]["Size"] = UDim2.new(0, 400, 0, 0)
		Agreement["1d8"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
		Agreement["1d8"]["ClipsDescendants"] = true
		Agreement["1d8"]["Name"] = [[Prompt]]

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.UIGradient
		Agreement["1d9"] = Instance.new("UIGradient", Agreement["1d8"])
		Agreement["1d9"]["Rotation"] = 90
		Agreement["1d9"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Agreement["1d9"]

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Title
		Agreement["1da"] = Instance.new("TextLabel", Agreement["1d8"])
		Agreement["1da"]["ZIndex"] = 11
		Agreement["1da"]["TextYAlignment"] = Enum.TextYAlignment.Top
		Agreement["1da"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1da"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Agreement["1da"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Agreement["1da"]["TextSize"] = 15
		Agreement["1da"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Agreement["1da"]

		Agreement["1da"]["Size"] = UDim2.new(0, 260, 0, 20)
		Agreement["1da"]["Text"] = [[Use Policy]]
		Agreement["1da"]["Name"] = [[Title]]
		Agreement["1da"]["BackgroundTransparency"] = 1
		Agreement["1da"]["Position"] = UDim2.new(0, 12, 0, 14)

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.UICorner
		Agreement["1db"] = Instance.new("UICorner", Agreement["1d8"])
		Agreement["1db"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Agreement
		Agreement["1dc"] = Instance.new("TextLabel", Agreement["1d8"])
		Agreement["1dc"]["TextWrapped"] = true
		Agreement["1dc"]["ZIndex"] = 11
		Agreement["1dc"]["TextYAlignment"] = Enum.TextYAlignment.Top
		Agreement["1dc"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1dc"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Agreement["1dc"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Agreement["1dc"]["TextSize"] = 10
		Agreement["1dc"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Agreement["1dc"]

		Agreement["1dc"]["Size"] = UDim2.new(0, 378, 0, 517)
		Agreement["1dc"]["Text"] = v3UserPolicy
		Agreement["1dc"]["Name"] = [[Agreement]]
		Agreement["1dc"]["BackgroundTransparency"] = 1
		Agreement["1dc"]["Position"] = UDim2.new(0, 12, 0, 44)

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Frame
		Agreement["1dd"] = Instance.new("Frame", Agreement["1d8"])
		Agreement["1dd"]["ZIndex"] = 12
		Agreement["1dd"]["BorderSizePixel"] = 0
		Agreement["1dd"]["BackgroundColor3"] = ThemeColor.Textbox
		Agreement["1dd"]["Size"] = UDim2.new(0, 371, 0, 1)
		Agreement["1dd"]["Position"] = UDim2.new(0, 15, 0, 38)

		ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Agreement["1dd"]

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls
		Agreement["1de"] = Instance.new("Frame", Agreement["1d8"])
		Agreement["1de"]["ZIndex"] = 15
		Agreement["1de"]["BorderSizePixel"] = 0
		Agreement["1de"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1de"]["BackgroundTransparency"] = 1
		Agreement["1de"]["Size"] = UDim2.new(0, 397, 0, 24)
		Agreement["1de"]["Position"] = UDim2.new(0, 2, 0, 567)
		Agreement["1de"]["Name"] = [[Controls]]

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.UIListLayout
		Agreement["1df"] = Instance.new("UIListLayout", Agreement["1de"])
		Agreement["1df"]["FillDirection"] = Enum.FillDirection.Horizontal
		Agreement["1df"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Agreement["1df"]["Padding"] = UDim.new(0, 20)
		Agreement["1df"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B1
		Agreement["1e0"] = Instance.new("TextButton", Agreement["1de"])
		Agreement["1e0"]["ZIndex"] = 11
		Agreement["1e0"]["BorderSizePixel"] = 0
		Agreement["1e0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1e0"]["TextSize"] = 14
		Agreement["1e0"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Agreement["1e0"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Agreement["1e0"]

		Agreement["1e0"]["Size"] = UDim2.new(0, 118, 0, 25)
		Agreement["1e0"]["LayoutOrder"] = 1
		Agreement["1e0"]["Name"] = [[B1]]
		Agreement["1e0"]["Text"] = [[Agree]]
		Agreement["1e0"]["Position"] = UDim2.new(0, 68, 0, 567)

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B1.UICorner
		Agreement["1e1"] = Instance.new("UICorner", Agreement["1e0"])
		Agreement["1e1"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B1.UIGradient
		Agreement["1e2"] = Instance.new("UIGradient", Agreement["1e0"])
		Agreement["1e2"]["Rotation"] = 90
		Agreement["1e2"]["Color"] = ThemeColor.Secondary

		ThemeInstances["Secondary"][#ThemeInstances["Secondary"] + 1] = Agreement["1e2"]["Color"]

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B1.NameLabel
		Agreement["1e3"] = Instance.new("TextLabel", Agreement["1e0"])
		Agreement["1e3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1e3"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Agreement["1e3"]["TextSize"] = 11
		Agreement["1e3"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Agreement["1e3"]

		Agreement["1e3"]["Size"] = UDim2.new(0, 118, 0, 25)
		Agreement["1e3"]["Text"] = [[Agree]]
		Agreement["1e3"]["Name"] = [[NameLabel]]
		Agreement["1e3"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B2
		Agreement["1e4"] = Instance.new("TextButton", Agreement["1de"])
		Agreement["1e4"]["ZIndex"] = 11
		Agreement["1e4"]["BorderSizePixel"] = 0
		Agreement["1e4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1e4"]["TextSize"] = 14
		Agreement["1e4"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Agreement["1e4"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Agreement["1e4"]

		Agreement["1e4"]["Size"] = UDim2.new(0, 118, 0, 25)
		Agreement["1e4"]["LayoutOrder"] = 1
		Agreement["1e4"]["Name"] = [[B2]]
		Agreement["1e4"]["Text"] = [[Agree]]
		Agreement["1e4"]["Position"] = UDim2.new(0, 204, 0, 567)

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B2.UICorner
		Agreement["1e5"] = Instance.new("UICorner", Agreement["1e4"])
		Agreement["1e5"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B2.UIGradient
		Agreement["1e6"] = Instance.new("UIGradient", Agreement["1e4"])
		Agreement["1e6"]["Rotation"] = 90
		Agreement["1e6"]["Color"] = ThemeColor.Secondary

		ThemeInstances["Secondary"][#ThemeInstances["Secondary"] + 1] = Agreement["1e6"]

		-- StarterGui.Vision Lib v2.PromptBase.Prompt.Controls.B2.NameLabel
		Agreement["1e7"] = Instance.new("TextLabel", Agreement["1e4"])
		Agreement["1e7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Agreement["1e7"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Agreement["1e7"]["TextSize"] = 11
		Agreement["1e7"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Agreement["1e7"]

		Agreement["1e7"]["Size"] = UDim2.new(0, 118, 0, 25)
		Agreement["1e7"]["Text"] = [[I totally agree!]]
		Agreement["1e7"]["Name"] = [[NameLabel]]
		Agreement["1e7"]["BackgroundTransparency"] = 1
	end

	do
		Library:Tween(Agreement["1d8"], {
			Goal = {
				Size = UDim2.new(0, 400, 0, 606),
			},
			Style = Enum.EasingStyle.Quart,
			Direction = Enum.EasingDirection.Out,
			Length = 2,
		})

		Library:Tween(Blur, {
			Goal = {
				Size = 28,
			},
			Style = Enum.EasingStyle.Quart,
			Direction = Enum.EasingDirection.Out,
			Length = 2,
		})

		table.insert(
			ConnectionBin,
			Agreement["1e0"].MouseButton1Click:Connect(function()
				Library:Tween(Agreement["1d8"], {
					Goal = {
						Size = UDim2.new(0, 400, 0, 0),
					},
					Style = Enum.EasingStyle.Quart,
					Direction = Enum.EasingDirection.Out,
					Length = 2,
				})

				Library:Tween(Blur, {
					Goal = {
						Size = 0,
					},
					Style = Enum.EasingStyle.Quart,
					Direction = Enum.EasingDirection.Out,
					Length = 2,
				})

				local json = HttpService:JSONEncode({
					agree = true,
				})

				writefile("JailbreakVisionV3/Settings/UsePolicy.pem", json)

				task.wait(3)
				Agreement["1d7"]:Destroy()
			end)
		)

		table.insert(
			ConnectionBin,
			Agreement["1e4"].MouseButton1Click:Connect(function()
				Library:Tween(Agreement["1d8"], {
					Goal = {
						Size = UDim2.new(0, 400, 0, 0),
					},
					Style = Enum.EasingStyle.Quart,
					Direction = Enum.EasingDirection.Out,
					Length = 2,
				})

				Library:Tween(Blur, {
					Goal = {
						Size = 0,
					},
					Style = Enum.EasingStyle.Quart,
					Direction = Enum.EasingDirection.Out,
					Length = 2,
				})

				local json = HttpService:JSONEncode({
					agree = true,
				})

				writefile("JailbreakVisionV3/Settings/UsePolicy.pem", json)

				task.wait(3)
				Agreement["1d7"]:Destroy()
			end)
		)
	end
end

function Library:TimeLineEditor(options)
	options = Library:PlaceDefaults({
		FinishCallback = function()
			return
		end,
		UpdatePointCallback = function()
			return
		end,
	}, options or {})

	if Library.TimeLineEditorExists then
		return
	end

	local parts = nil
	local pathFolder = Instance.new("Folder")
	pathFolder.Name = "VisualizedPath"
	pathFolder.Archivable = false
	pathFolder.Parent = game:GetService("Workspace")
	local connections = {}
	local TimeLineData = {}
	local ShowPath = false
	local cutsceneSelected = Instance.new("Folder")
	cutsceneSelected.Parent = game:GetService("Workspace")

	Library.TimeLineEditorExists = true

	local TimeLineEditor = {
		Hover = false,
	}

	local TimeLineIndex = {}

	do
		-- StarterGui.Vision Lib v2.TimeLine
		TimeLineEditor["d0"] = Instance.new("Frame", LibFrame["1"])
		TimeLineEditor["d0"]["BorderSizePixel"] = 0
		TimeLineEditor["d0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["d0"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		TimeLineEditor["d0"]["Size"] = UDim2.new(0, 424, 0, 192)
		TimeLineEditor["d0"]["Position"] = UDim2.new(0.800000011920929, 0, 0.5, 0)
		TimeLineEditor["d0"]["Name"] = [[TimeLine]]

		-- StarterGui.Vision Lib v2.TimeLine.UIGradient
		TimeLineEditor["d1"] = Instance.new("UIGradient", TimeLineEditor["d0"])
		TimeLineEditor["d1"]["Rotation"] = 90
		TimeLineEditor["d1"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = TimeLineEditor["d1"]

		-- StarterGui.Vision Lib v2.TimeLine.UICorner
		TimeLineEditor["d2"] = Instance.new("UICorner", TimeLineEditor["d0"])
		TimeLineEditor["d2"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Top
		TimeLineEditor["d3"] = Instance.new("Frame", TimeLineEditor["d0"])
		TimeLineEditor["d3"]["ZIndex"] = 2
		TimeLineEditor["d3"]["BorderSizePixel"] = 0
		TimeLineEditor["d3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["d3"]["Size"] = UDim2.new(0, 424, 0, 33)
		TimeLineEditor["d3"]["Name"] = [[Top]]

		-- StarterGui.Vision Lib v2.TimeLine.Top.UICorner
		TimeLineEditor["d4"] = Instance.new("UICorner", TimeLineEditor["d3"])
		TimeLineEditor["d4"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Top.UIGradient
		TimeLineEditor["d5"] = Instance.new("UIGradient", TimeLineEditor["d3"])
		TimeLineEditor["d5"]["Rotation"] = 90
		TimeLineEditor["d5"]["Color"] = ThemeColor.NavBar

		ThemeInstances["NavBar"][#ThemeInstances["NavBar"] + 1] = TimeLineEditor["d5"]

		-- StarterGui.Vision Lib v2.TimeLine.Top.Title
		TimeLineEditor["d6"] = Instance.new("TextLabel", TimeLineEditor["d3"])
		TimeLineEditor["d6"]["ZIndex"] = 2
		TimeLineEditor["d6"]["BorderSizePixel"] = 0
		TimeLineEditor["d6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["d6"]["TextXAlignment"] = Enum.TextXAlignment.Left
		TimeLineEditor["d6"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		TimeLineEditor["d6"]["TextSize"] = 13
		TimeLineEditor["d6"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["d6"]

		TimeLineEditor["d6"]["Size"] = UDim2.new(0, 212, 0, 27)
		TimeLineEditor["d6"]["Text"] = [[Timeline Editor]]
		TimeLineEditor["d6"]["Name"] = [[Title]]
		TimeLineEditor["d6"]["BackgroundTransparency"] = 1
		TimeLineEditor["d6"]["Position"] = UDim2.new(0, 14, 0, 3)

		-- StarterGui.Vision Lib v2.TimeLine.Top.CloseButton
		TimeLineEditor["d7"] = Instance.new("ImageButton", TimeLineEditor["d3"])
		TimeLineEditor["d7"]["ZIndex"] = 2
		TimeLineEditor["d7"]["ScaleType"] = Enum.ScaleType.Crop
		TimeLineEditor["d7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["d7"]["ImageColor3"] = ThemeColor.Textbox

		ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = TimeLineEditor["d7"]

		TimeLineEditor["d7"]["Image"] = [[rbxassetid://11407836204]]
		TimeLineEditor["d7"]["Size"] = UDim2.new(0, 10, 0, 10)
		TimeLineEditor["d7"]["Name"] = [[CloseButton]]
		TimeLineEditor["d7"]["Position"] = UDim2.new(0.953559398651123, 0, 0.3251546323299408, 0)
		TimeLineEditor["d7"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.TimeLine.Holder
		TimeLineEditor["d8"] = Instance.new("ScrollingFrame", TimeLineEditor["d0"])
		TimeLineEditor["d8"]["Active"] = true
		TimeLineEditor["d8"]["BorderSizePixel"] = 0
		TimeLineEditor["d8"]["CanvasSize"] = UDim2.new(0, 500, 0, 0)
		TimeLineEditor["d8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["d8"]["BackgroundTransparency"] = 1
		TimeLineEditor["d8"]["Size"] = UDim2.new(0, 401, 0, 100)
		TimeLineEditor["d8"]["ScrollBarImageColor3"] = Color3.fromRGB(51, 51, 51)
		TimeLineEditor["d8"]["ScrollBarThickness"] = 3
		TimeLineEditor["d8"]["Position"] = UDim2.new(0, 14, 0, 40)
		TimeLineEditor["d8"]["Name"] = [[Holder]]

		-- StarterGui.Vision Lib v2.TimeLine.Holder.UICorner
		TimeLineEditor["d9"] = Instance.new("UICorner", TimeLineEditor["d8"])
		TimeLineEditor["d9"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Holder.UIListLayout
		TimeLineEditor["da"] = Instance.new("UIListLayout", TimeLineEditor["d8"])
		TimeLineEditor["da"]["VerticalAlignment"] = Enum.VerticalAlignment.Center
		TimeLineEditor["da"]["FillDirection"] = Enum.FillDirection.Horizontal
		TimeLineEditor["da"]["Padding"] = UDim.new(0, 5)
		TimeLineEditor["da"]["SortOrder"] = Enum.SortOrder.Name

		-- StarterGui.Vision Lib v2.TimeLine.Holder.UIPadding
		TimeLineEditor["db"] = Instance.new("UIPadding", TimeLineEditor["d8"])
		TimeLineEditor["db"]["PaddingLeft"] = UDim.new(0, 10)

		-- StarterGui.Vision Lib v2.TimeLine.BaseHolder
		TimeLineEditor["ee"] = Instance.new("Frame", TimeLineEditor["d0"])
		TimeLineEditor["ee"]["ZIndex"] = 0
		TimeLineEditor["ee"]["BorderSizePixel"] = 0
		TimeLineEditor["ee"]["BackgroundColor3"] = ThemeColor.SecondaryTrue

		ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = TimeLineEditor["ee"]

		TimeLineEditor["ee"]["Size"] = UDim2.new(0, 401, 0, 103)
		TimeLineEditor["ee"]["Position"] = UDim2.new(0, 14, 0, 40)
		TimeLineEditor["ee"]["Name"] = [[BaseHolder]]

		-- StarterGui.Vision Lib v2.TimeLine.BaseHolder.UICorner
		TimeLineEditor["ef"] = Instance.new("UICorner", TimeLineEditor["ee"])
		TimeLineEditor["ef"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Controls
		TimeLineEditor["f0"] = Instance.new("Frame", TimeLineEditor["d0"])
		TimeLineEditor["f0"]["BorderSizePixel"] = 0
		TimeLineEditor["f0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["f0"]["BackgroundTransparency"] = 1
		TimeLineEditor["f0"]["Size"] = UDim2.new(0, 424, 0, 24)
		TimeLineEditor["f0"]["Position"] = UDim2.new(0, 0, 0, 155)
		TimeLineEditor["f0"]["Name"] = [[Controls]]

		-- StarterGui.Vision Lib v2.TimeLine.Controls.UIListLayout
		TimeLineEditor["f1"] = Instance.new("UIListLayout", TimeLineEditor["f0"])
		TimeLineEditor["f1"]["FillDirection"] = Enum.FillDirection.Horizontal
		TimeLineEditor["f1"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		TimeLineEditor["f1"]["Padding"] = UDim.new(0, 5)
		TimeLineEditor["f1"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.Vision Lib v2.TimeLine.Controls.AddCamPtButton
		TimeLineEditor["f2"] = Instance.new("TextButton", TimeLineEditor["f0"])
		TimeLineEditor["f2"]["BorderSizePixel"] = 0
		TimeLineEditor["f2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["f2"]["TextSize"] = 14
		TimeLineEditor["f2"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["f2"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["f2"]

		TimeLineEditor["f2"]["Size"] = UDim2.new(0, 118, 0, 25)
		TimeLineEditor["f2"]["LayoutOrder"] = 1
		TimeLineEditor["f2"]["Name"] = [[AddCamPtButton]]
		TimeLineEditor["f2"]["Text"] = [[]]
		TimeLineEditor["f2"]["Position"] = UDim2.new(0.3313679099082947, 0, 0, 0)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.AddCamPtButton.UICorner
		TimeLineEditor["f3"] = Instance.new("UICorner", TimeLineEditor["f2"])
		TimeLineEditor["f3"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.AddCamPtButton.UIGradient
		TimeLineEditor["f4"] = Instance.new("UIGradient", TimeLineEditor["f2"])
		TimeLineEditor["f4"]["Rotation"] = 90
		TimeLineEditor["f4"]["Color"] = ThemeColor.Secondary

		ThemeInstances["Secondary"][#ThemeInstances["Secondary"] + 1] = TimeLineEditor["f4"]

		-- StarterGui.Vision Lib v2.TimeLine.Controls.AddCamPtButton.NameLabel
		TimeLineEditor["f5"] = Instance.new("TextLabel", TimeLineEditor["f2"])
		TimeLineEditor["f5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["f5"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["f5"]["TextSize"] = 11
		TimeLineEditor["f5"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["f5"]

		TimeLineEditor["f5"]["Size"] = UDim2.new(0, 118, 0, 25)
		TimeLineEditor["f5"]["Text"] = [[Add Camera Point]]
		TimeLineEditor["f5"]["Name"] = [[NameLabel]]
		TimeLineEditor["f5"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton
		TimeLineEditor["f6"] = Instance.new("TextButton", TimeLineEditor["f0"])
		TimeLineEditor["f6"]["BorderSizePixel"] = 0
		TimeLineEditor["f6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["f6"]["TextSize"] = 14
		TimeLineEditor["f6"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["f6"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["f6"]

		TimeLineEditor["f6"]["Size"] = UDim2.new(0, 118, 0, 25)
		TimeLineEditor["f6"]["LayoutOrder"] = 2
		TimeLineEditor["f6"]["Name"] = [[StyleButton]]
		TimeLineEditor["f6"]["ClipsDescendants"] = true
		TimeLineEditor["f6"]["Text"] = [[]]
		TimeLineEditor["f6"]["Position"] = UDim2.new(0.3608490526676178, 0, 0, 0)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.UICorner
		TimeLineEditor["f7"] = Instance.new("UICorner", TimeLineEditor["f6"])
		TimeLineEditor["f7"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.NameLabel
		TimeLineEditor["f8"] = Instance.new("TextLabel", TimeLineEditor["f6"])
		TimeLineEditor["f8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["f8"]["TextXAlignment"] = Enum.TextXAlignment.Left
		TimeLineEditor["f8"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["f8"]["TextSize"] = 11
		TimeLineEditor["f8"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["f8"]

		TimeLineEditor["f8"]["Size"] = UDim2.new(0, 112, 0, 25)
		TimeLineEditor["f8"]["Text"] = [[Style | Spline]]
		TimeLineEditor["f8"]["Name"] = [[NameLabel]]
		TimeLineEditor["f8"]["BackgroundTransparency"] = 1
		TimeLineEditor["f8"]["Position"] = UDim2.new(0.050847455859184265, 0, 0, 0)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.UIGradient
		TimeLineEditor["f9"] = Instance.new("UIGradient", TimeLineEditor["f6"])
		TimeLineEditor["f9"]["Rotation"] = 90
		TimeLineEditor["f9"]["Color"] = ThemeColor.Secondary

		ThemeInstances["Secondary"][#ThemeInstances["Secondary"] + 1] = TimeLineEditor["f9"]

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.UICorner
		TimeLineEditor["fa"] = Instance.new("UICorner", TimeLineEditor["f6"])
		TimeLineEditor["fa"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.UIGradient
		TimeLineEditor["fb"] = Instance.new("UIGradient", TimeLineEditor["f6"])
		TimeLineEditor["fb"]["Rotation"] = 90
		TimeLineEditor["fb"]["Color"] = ThemeColor.Secondary

		ThemeInstances["Secondary"][#ThemeInstances["Secondary"] + 1] = TimeLineEditor["fb"]

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container
		TimeLineEditor["fc"] = Instance.new("Frame", TimeLineEditor["f6"])
		TimeLineEditor["fc"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["fc"]["BackgroundTransparency"] = 1
		TimeLineEditor["fc"]["Size"] = UDim2.new(0, 118, 0, 13)
		TimeLineEditor["fc"]["Position"] = UDim2.new(0, 0, 0, 25)
		TimeLineEditor["fc"]["Name"] = [[Container]]

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.UIListLayout
		TimeLineEditor["fd"] = Instance.new("UIListLayout", TimeLineEditor["fc"])
		TimeLineEditor["fd"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		TimeLineEditor["fd"]["Padding"] = UDim.new(0, 4)
		TimeLineEditor["fd"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.UIPadding
		TimeLineEditor["fe"] = Instance.new("UIPadding", TimeLineEditor["fc"])
		TimeLineEditor["fe"]["PaddingTop"] = UDim.new(0, 2)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.Cubic
		TimeLineEditor["ff"] = Instance.new("TextButton", TimeLineEditor["fc"])
		TimeLineEditor["ff"]["BorderSizePixel"] = 0
		TimeLineEditor["ff"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["ff"]["TextSize"] = 14
		TimeLineEditor["ff"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["ff"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["ff"]

		TimeLineEditor["ff"]["Size"] = UDim2.new(0, 102, 0, 21)
		TimeLineEditor["ff"]["LayoutOrder"] = 2
		TimeLineEditor["ff"]["Name"] = [[Cubic]]
		TimeLineEditor["ff"]["Text"] = [[]]
		TimeLineEditor["ff"]["Position"] = UDim2.new(0.3313679099082947, 0, 0, 0)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.Cubic.UICorner
		TimeLineEditor["100"] = Instance.new("UICorner", TimeLineEditor["ff"])
		TimeLineEditor["100"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.Cubic.UIGradient
		TimeLineEditor["101"] = Instance.new("UIGradient", TimeLineEditor["ff"])
		TimeLineEditor["101"]["Rotation"] = 90
		TimeLineEditor["101"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = TimeLineEditor["101"]

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.Cubic.Label
		TimeLineEditor["102"] = Instance.new("TextLabel", TimeLineEditor["ff"])
		TimeLineEditor["102"]["BorderSizePixel"] = 0
		TimeLineEditor["102"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["102"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		TimeLineEditor["102"]["TextSize"] = 11
		TimeLineEditor["102"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["102"]

		TimeLineEditor["102"]["Size"] = UDim2.new(0, 102, 0, 21)
		TimeLineEditor["102"]["Text"] = [[Cubic]]
		TimeLineEditor["102"]["Name"] = [[Label]]
		TimeLineEditor["102"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.CatmullRomSpline
		TimeLineEditor["103"] = Instance.new("TextButton", TimeLineEditor["fc"])
		TimeLineEditor["103"]["BorderSizePixel"] = 0
		TimeLineEditor["103"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["103"]["TextSize"] = 14
		TimeLineEditor["103"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["103"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["103"]

		TimeLineEditor["103"]["Size"] = UDim2.new(0, 102, 0, 21)
		TimeLineEditor["103"]["LayoutOrder"] = 2
		TimeLineEditor["103"]["Name"] = [[CatmullRomSpline]]
		TimeLineEditor["103"]["Text"] = [[]]
		TimeLineEditor["103"]["Position"] = UDim2.new(0.3313679099082947, 0, 0, 0)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.CatmullRomSpline.UICorner
		TimeLineEditor["104"] = Instance.new("UICorner", TimeLineEditor["103"])
		TimeLineEditor["104"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.CatmullRomSpline.UIGradient
		TimeLineEditor["105"] = Instance.new("UIGradient", TimeLineEditor["103"])
		TimeLineEditor["105"]["Rotation"] = 90
		TimeLineEditor["105"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = TimeLineEditor["105"]

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Container.CatmullRomSpline.Label
		TimeLineEditor["106"] = Instance.new("TextLabel", TimeLineEditor["103"])
		TimeLineEditor["106"]["BorderSizePixel"] = 0
		TimeLineEditor["106"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["106"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		TimeLineEditor["106"]["TextSize"] = 11
		TimeLineEditor["106"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["106"]

		TimeLineEditor["106"]["Size"] = UDim2.new(0, 102, 0, 21)
		TimeLineEditor["106"]["Text"] = [[Spline]]
		TimeLineEditor["106"]["Name"] = [[Label]]
		TimeLineEditor["106"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.TimeLine.Controls.StyleButton.Open
		TimeLineEditor["10b"] = Instance.new("ImageButton", TimeLineEditor["f6"])
		TimeLineEditor["10b"]["ScaleType"] = Enum.ScaleType.Crop
		TimeLineEditor["10b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["10b"]["Image"] = [[rbxassetid://11400266375]]
		TimeLineEditor["10b"]["Size"] = UDim2.new(0, 10, 0, 10)
		TimeLineEditor["10b"]["Name"] = [[Open]]
		TimeLineEditor["10b"]["Position"] = UDim2.new(0, 100, 0, 7)
		TimeLineEditor["10b"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.TimeLine.Controls.FinishButton
		TimeLineEditor["10c"] = Instance.new("TextButton", TimeLineEditor["f0"])
		TimeLineEditor["10c"]["BorderSizePixel"] = 0
		TimeLineEditor["10c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["10c"]["TextSize"] = 14
		TimeLineEditor["10c"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["10c"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["10c"]

		TimeLineEditor["10c"]["Size"] = UDim2.new(0, 118, 0, 25)
		TimeLineEditor["10c"]["LayoutOrder"] = 3
		TimeLineEditor["10c"]["Name"] = [[FinishButton]]
		TimeLineEditor["10c"]["Text"] = [[]]
		TimeLineEditor["10c"]["Position"] = UDim2.new(0.3313679099082947, 0, 0, 0)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.FinishButton.UICorner
		TimeLineEditor["10d"] = Instance.new("UICorner", TimeLineEditor["10c"])
		TimeLineEditor["10d"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.TimeLine.Controls.FinishButton.NameLabel
		TimeLineEditor["10e"] = Instance.new("TextLabel", TimeLineEditor["10c"])
		TimeLineEditor["10e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		TimeLineEditor["10e"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TimeLineEditor["10e"]["TextSize"] = 11
		TimeLineEditor["10e"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = TimeLineEditor["10e"]

		TimeLineEditor["10e"]["Size"] = UDim2.new(0, 118, 0, 25)
		TimeLineEditor["10e"]["Text"] = [[Finish]]
		TimeLineEditor["10e"]["Name"] = [[NameLabel]]
		TimeLineEditor["10e"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.TimeLine.Controls.FinishButton.UIGradient
		TimeLineEditor["10f"] = Instance.new("UIGradient", TimeLineEditor["10c"])
		TimeLineEditor["10f"]["Rotation"] = 90
		TimeLineEditor["10f"]["Color"] = ThemeColor.Secondary

		ThemeInstances["Secondary"][#ThemeInstances["Secondary"] + 1] = TimeLineEditor["10f"]
	end

	local function ResizeScrollingFrame()
		local NumChild = 0
		local ChildOffset = 0

		for i, v in pairs(TimeLineEditor["d8"]:GetChildren()) do
			if v:IsA("Frame") then
				NumChild = NumChild + 1
				ChildOffset = ChildOffset + v.Size.X.Offset
			end
		end

		local NumChildOffset = NumChild * 5

		local CanvasSizeX = NumChildOffset + ChildOffset + 15

		Library:Tween(TimeLineEditor["d8"], {
			Length = 0.5,
			Goal = { CanvasSize = UDim2.new(0, CanvasSizeX, 0, 0) },
		})
	end

	table.insert(
		ConnectionBin,
		TimeLineEditor["d8"].ChildAdded:Connect(function(Child)
			if Child:IsA("Frame") then
				ResizeScrollingFrame()

				Child:GetPropertyChangedSignal("Size"):Connect(function()
					ResizeScrollingFrame()
				end)
			end
		end)
	)

	table.insert(
		ConnectionBin,
		TimeLineEditor["d8"].ChildRemoved:Connect(function(Child)
			if Child:IsA("Frame") then
				ResizeScrollingFrame()
			end
		end)
	)

	local Interp = "Spline"

	do
		function TimeLineEditor:NewData(Index)
			local Camera = game:GetService("Workspace").CurrentCamera
			local EventHolder = {}

			table.insert(TimeLineIndex, Index)

			do
				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder
				EventHolder["dc"] = Instance.new("Frame", TimeLineEditor["d8"])
				EventHolder["dc"]["BorderSizePixel"] = 0
				EventHolder["dc"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				EventHolder["dc"]["Size"] = UDim2.new(0, 86, 0, 81)
				EventHolder["dc"]["Position"] = UDim2.new(0, 0, 0.10679611563682556, 0)
				EventHolder["dc"]["Name"] = Index

				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder.UIGradient
				EventHolder["dd"] = Instance.new("UIGradient", EventHolder["dc"])
				EventHolder["dd"]["Rotation"] = 90
				EventHolder["dd"]["Color"] = ThemeColor.Main

				ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = EventHolder["dd"]

				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder.UICorner
				EventHolder["de"] = Instance.new("UICorner", EventHolder["dc"])
				EventHolder["de"]["CornerRadius"] = UDim.new(0, 4)

				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder.Title
				EventHolder["df"] = Instance.new("TextLabel", EventHolder["dc"])
				EventHolder["df"]["ZIndex"] = 2
				EventHolder["df"]["BorderSizePixel"] = 0
				EventHolder["df"]["TextXAlignment"] = Enum.TextXAlignment.Left
				EventHolder["df"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				EventHolder["df"]["TextSize"] = 11
				EventHolder["df"]["TextColor3"] = ThemeColor.Text

				ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = EventHolder["df"]

				EventHolder["df"]["Size"] = UDim2.new(0, 38, 0, 17)
				EventHolder["df"]["Text"] = "Point " .. tostring(Index)
				EventHolder["df"]["Name"] = [[Title]]
				EventHolder["df"]["Font"] = Enum.Font.GothamMedium
				EventHolder["df"]["BackgroundTransparency"] = 1
				EventHolder["df"]["Position"] = UDim2.new(0, 6, 0, 3)

				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder.Index
				EventHolder["e0"] = Instance.new("TextBox", EventHolder["dc"])
				EventHolder["e0"]["CursorPosition"] = -1
				EventHolder["e0"]["PlaceholderColor3"] = ThemeColor.PlaceholderText

				ThemeInstances["PlaceholderText"][#ThemeInstances["PlaceholderText"] + 1] = EventHolder["e0"]

				EventHolder["e0"]["RichText"] = true
				EventHolder["e0"]["TextColor3"] = ThemeColor.Text

				ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = EventHolder["e0"]

				EventHolder["e0"]["TextWrapped"] = true
				EventHolder["e0"]["TextSize"] = 10
				EventHolder["e0"]["BackgroundColor3"] = ThemeColor.Textbox

				ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = EventHolder["e0"]

				EventHolder["e0"]["PlaceholderText"] = [[Index]]
				EventHolder["e0"]["Size"] = UDim2.new(0, 61, 0, 18)
				EventHolder["e0"]["Text"] = Index
				EventHolder["e0"]["Position"] = UDim2.new(0, 12, 0, 42)
				EventHolder["e0"]["AutomaticSize"] = Enum.AutomaticSize.Y
				EventHolder["e0"]["Font"] = Enum.Font.Gotham
				EventHolder["e0"]["Name"] = [[Index]]

				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder.Index.UICorner
				EventHolder["e1"] = Instance.new("UICorner", EventHolder["e0"])
				EventHolder["e1"]["CornerRadius"] = UDim.new(0, 4)

				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder.CloseButton
				EventHolder["e3"] = Instance.new("ImageButton", EventHolder["dc"])
				EventHolder["e3"]["ZIndex"] = 2
				EventHolder["e3"]["ScaleType"] = Enum.ScaleType.Crop
				EventHolder["e3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				EventHolder["e3"]["ImageColor3"] = ThemeColor.Textbox

				ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = EventHolder["e3"]

				EventHolder["e3"]["Image"] = [[rbxassetid://11407836204]]
				EventHolder["e3"]["Size"] = UDim2.new(0, 7, 0, 7)
				EventHolder["e3"]["Name"] = [[CloseButton]]
				EventHolder["e3"]["Position"] = UDim2.new(0, 73, 0, 8)
				EventHolder["e3"]["BackgroundTransparency"] = 1

				-- StarterGui.Vision Lib v2.TimeLine.Holder.EventHolder.ViewButton
				EventHolder["e4"] = Instance.new("ImageButton", EventHolder["dc"])
				EventHolder["e4"]["ZIndex"] = 2
				EventHolder["e4"]["ScaleType"] = Enum.ScaleType.Crop
				EventHolder["e4"]["ResampleMode"] = Enum.ResamplerMode.Pixelated
				EventHolder["e4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				EventHolder["e4"]["ImageColor3"] = ThemeColor.Textbox

				ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = EventHolder["e4"]

				EventHolder["e4"]["Image"] = [[rbxassetid://12683331515]]
				EventHolder["e4"]["Size"] = UDim2.new(0, 11, 0, 11)
				EventHolder["e4"]["Name"] = [[ViewButton]]
				EventHolder["e4"]["Position"] = UDim2.new(0, 57, 0, 6)
				EventHolder["e4"]["BackgroundTransparency"] = 1
			end

			local CFVal = Instance.new("CFrameValue")
			CFVal.Parent = EventHolder["dc"]
			CFVal.Value = Camera.CFrame
			CFVal.Name = "CFVal"

			do
				local OldText = Index

				table.insert(
					ConnectionBin,
					EventHolder["e0"].FocusLost:Connect(function()
						local success = pcall(function()
							EventHolder["dc"]["Name"] = tonumber(EventHolder["e0"].Text)

							OldText = tonumber(EventHolder["e0"].Text)
						end)

						if not success then
							EventHolder["e0"].Text = OldText
						end

						TimeLineData = {}

						for i, v in next, TimeLineEditor["d8"]:GetChildren() do
							if v:IsA("Frame") then
								table.insert(TimeLineData, tonumber(v.Name))
							end
						end

						table.sort(TimeLineData)

						local Data = {}

						for i, v in next, TimeLineData do
							local Obj = TimeLineEditor["d8"]:FindFirstChild(v)
							Data[i] = tostring(Obj.CFVal.Value)
						end

						options.UpdatePointCallback(Data, Interp)
					end)
				)

				table.insert(
					ConnectionBin,
					EventHolder["e3"].MouseButton1Click:Connect(function()
						EventHolder["dc"]:Destroy()

						TimeLineData = {}

						for i, v in next, TimeLineEditor["d8"]:GetChildren() do
							if v:IsA("Frame") then
								table.insert(TimeLineData, tonumber(v.Name))
							end
						end

						table.sort(TimeLineData)

						local Data = {}

						for i, v in next, TimeLineData do
							local Obj = TimeLineEditor["d8"]:FindFirstChild(v)
							Data[i] = tostring(Obj.CFVal.Value)
						end

						options.UpdatePointCallback(Data, Interp)
					end)
				)

				table.insert(
					ConnectionBin,
					EventHolder["e4"].MouseButton1Click:Connect(function()
						local Camera = game:GetService("Workspace").CurrentCamera

						Camera.CameraType = Enum.CameraType.Scriptable
						Camera.CFrame = CFVal.Value

						task.wait(3)

						Camera.CameraType = Enum.CameraType.Custom
					end)
				)
			end

			return EventHolder
		end
	end

	-- Handler
	do
		table.insert(
			ConnectionBin,
			TimeLineEditor["f2"].MouseButton1Click:Connect(function()
				local index = #TimeLineIndex + 1
				TimeLineEditor:NewData(index)

				TimeLineData = {}

				for i, v in next, TimeLineEditor["d8"]:GetChildren() do
					if v:IsA("Frame") then
						table.insert(TimeLineData, tonumber(v.Name))
					end
				end

				table.sort(TimeLineData)

				local Data = {}

				for i, v in next, TimeLineData do
					local Obj = TimeLineEditor["d8"]:FindFirstChild(v)
					Data[i] = tostring(Obj.CFVal.Value)
				end

				for i, v in next, TimeLineData do
					local Obj = TimeLineEditor["d8"]:FindFirstChild(v)
				end

				options.UpdatePointCallback(Data, Interp)
			end)
		)

		local StyleToggled = false

		table.insert(
			ConnectionBin,
			TimeLineEditor["f6"].MouseButton1Click:Connect(function()
				if StyleToggled then
					Library:Tween(TimeLineEditor["f6"], {
						Length = 0.2,
						Goal = { Size = UDim2.new(0, 118, 0, 25) },
					})
				else
					Library:Tween(TimeLineEditor["f6"], {
						Length = 0.2,
						Goaol = { Size = UDim2.new(0, 118, 0, 80) },
					})
				end

				StyleToggled = not StyleToggled
			end)
		)

		table.insert(
			ConnectionBin,
			TimeLineEditor["ff"].MouseButton1Click:Connect(function()
				Interp = "Cubic"

				TimeLineEditor["f8"]["Text"] = "Style | " .. Interp
			end)
		)

		table.insert(
			ConnectionBin,
			TimeLineEditor["103"].MouseButton1Click:Connect(function()
				Interp = "Spline"

				TimeLineEditor["f8"]["Text"] = "Style | " .. Interp
			end)
		)

		table.insert(
			ConnectionBin,
			TimeLineEditor["d7"].MouseButton1Click:Connect(function()
				Library.TimeLineEditorExists = false

				TimeLineEditor["d0"]:Destroy()
				pathFolder:Destroy()
				cutsceneSelected:Destroy()

				TimeLineData = {}

				for i, v in next, TimeLineEditor["d8"]:GetChildren() do
					if v:IsA("Frame") then
						table.insert(TimeLineData, tonumber(v.Name))
					end
				end

				table.sort(TimeLineData)

				local Data = {}

				for i, v in next, TimeLineData do
					local Obj = TimeLineEditor["d8"]:FindFirstChild(v)
					Data[i] = tostring(Obj.CFVal.Value)
				end

				options.FinishCallback(Data, Interp)
			end)
		)

		table.insert(
			ConnectionBin,
			TimeLineEditor["10c"].MouseButton1Click:Connect(function()
				TimeLineData = {}

				for i, v in next, TimeLineEditor["d8"]:GetChildren() do
					if v:IsA("Frame") then
						table.insert(TimeLineData, tonumber(v.Name))
					end
				end

				table.sort(TimeLineData)

				local Data = {}

				for i, v in next, TimeLineData do
					local Obj = TimeLineEditor["d8"]:FindFirstChild(v)
					Data[i] = tostring(Obj.CFVal.Value)
				end

				Library.TimeLineEditorExists = false

				options.FinishCallback(Data, Interp)
				TimeLineEditor["d0"]:Destroy()
				pathFolder:Destroy()
				cutsceneSelected:Destroy()
			end)
		)
	end

	-- Dragging
	do
		table.insert(
			ConnectionBin,
			TimeLineEditor["d0"].MouseEnter:Connect(function()
				TimeLineEditor.Hover = true
			end)
		)

		table.insert(
			ConnectionBin,
			TimeLineEditor["d0"].MouseLeave:Connect(function()
				TimeLineEditor.Hover = false
			end)
		)

		table.insert(
			ConnectionBin,
			UserInputService.InputBegan:Connect(function(input)
				if TimeLineEditor.Hover then
					if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library.Sliding then
						local ObjectPosition = Vector2.new(
							Mouse.X - TimeLineEditor["d0"].AbsolutePosition.X,
							Mouse.Y - TimeLineEditor["d0"].AbsolutePosition.Y
						)
						while
							RunService.RenderStepped:wait()
							and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
						do
							if not Library.Sliding then
								local FrameX, FrameY =
									math.clamp(
										Mouse.X - ObjectPosition.X,
										0,
										LibFrame["1"].AbsoluteSize.X - TimeLineEditor["d0"].AbsoluteSize.X
									),
									math.clamp(
										Mouse.Y - ObjectPosition.Y,
										0,
										LibFrame["1"].AbsoluteSize.Y - TimeLineEditor["d0"].AbsoluteSize.Y
									)

								Library:Tween(TimeLineEditor["d0"], {
									Goal = {
										Position = UDim2.fromOffset(
											FrameX
												+ (
													TimeLineEditor["d0"].Size.X.Offset
													* TimeLineEditor["d0"].AnchorPoint.X
												),
											FrameY
												+ (
													TimeLineEditor["d0"].Size.Y.Offset
													* TimeLineEditor["d0"].AnchorPoint.Y
												)
										),
									},
									Style = Enum.EasingStyle.Linear,
									Direction = Enum.EasingDirection.InOut,
									Length = Library.DragSpeed,
								})
							end
						end
					end
				end
			end)
		)
	end

	return TimeLineEditor
end

function Library:Create(options)
	options = Library:PlaceDefaults({
		Name = "Vision UI Lib v2",
		Footer = "By Loco_CTO, Sius and BruhOOFBoi",
		ToggleKey = Enum.KeyCode.RightShift,
		LoadedCallback = function()
			return
		end,
		KeySystem = false,
		Key = "123456",
		MaxAttempts = 5,
		DiscordLink = nil,
		ToggledRelativeYOffset = nil,
	}, options or {})

	local Gui = {
		CurrentTab = nil,
		CurrentTabIndex = 0,
		TweeningToggle = false,
		ToggleKey = options.ToggleKey,
		Hidden = false,
		MaxAttempts = options.MaxAttempts,
		DiscordLink = options.DiscordLink,
		Key = options.Key,
		KeySystem = options.KeySystem,
	}

	local StartAnimation = {}

	task.spawn(function()
		repeat
			task.wait()
		until Library.Loaded
		options.LoadedCallback()

		if options.ToggledRelativeYOffset ~= nil then
			Library:Tween(Gui["2"], {
				Length = 0.3,
				Goal = { Position = UDim2.new(0.5, 0, 0, Mouse.ViewSizeY - options.ToggledRelativeYOffset - 221) },
			})
		end
	end)

	do
		-- StarterGui.Vision Lib v2.GuiFrame
		Gui["2"] = Instance.new("Frame", LibFrame["1"])
		Gui["2"]["BorderSizePixel"] = 0
		Gui["2"]["AutoLocalize"] = false
		Gui["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Gui["2"]["BackgroundTransparency"] = 1
		Gui["2"]["Size"] = UDim2.new(0, 498, 0, 496)
		Gui["2"]["ClipsDescendants"] = true
		Gui["2"]["BorderColor3"] = Color3.fromRGB(28, 43, 54)
		Gui["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
		Gui["2"]["Name"] = [[GuiFrame]]
		Gui["2"]["Visible"] = false

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar
		Gui["3"] = Instance.new("Frame", Gui["2"])
		Gui["3"]["ZIndex"] = 2
		Gui["3"]["BorderSizePixel"] = 0
		Gui["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["3"]["Size"] = UDim2.new(0, 498, 0, 40)
		Gui["3"]["Position"] = UDim2.new(0, 0, 0, 455)
		Gui["3"]["Name"] = [[NavBar]]

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.UICorner
		Gui["4"] = Instance.new("UICorner", Gui["3"])
		Gui["4"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.Time
		Gui["5"] = Instance.new("TextLabel", Gui["3"])
		Gui["5"]["BorderSizePixel"] = 0
		Gui["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["5"]["TextSize"] = 14
		Gui["5"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Gui["5"]

		Gui["5"]["Size"] = UDim2.new(0, 89, 0, 40)
		Gui["5"]["Text"] = [[14:12]]
		Gui["5"]["Name"] = [[Time]]
		Gui["5"]["Font"] = Enum.Font.GothamBold
		Gui["5"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.TabButtonContainer
		Gui["6"] = Instance.new("ScrollingFrame", Gui["3"])
		Gui["6"]["Active"] = true
		Gui["6"]["ScrollingDirection"] = Enum.ScrollingDirection.X
		Gui["6"]["BorderSizePixel"] = 0
		Gui["6"]["CanvasSize"] = UDim2.new(0, 439, 0, 0)
		Gui["6"]["MidImage"] = [[]]
		Gui["6"]["TopImage"] = [[]]
		Gui["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["6"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.Always
		Gui["6"]["BackgroundTransparency"] = 1
		Gui["6"]["Size"] = UDim2.new(0, 350, 0, 40)
		Gui["6"]["ScrollBarThickness"] = 2
		Gui["6"]["Position"] = UDim2.new(0, 86, 0, 0)
		Gui["6"]["Name"] = [[TabButtonContainer]]
		Gui["6"]["BottomImage"] = [[]]

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.TabButtonContainer.UIListLayout
		Gui["7"] = Instance.new("UIListLayout", Gui["6"])
		Gui["7"]["FillDirection"] = Enum.FillDirection.Horizontal
		Gui["7"]["Padding"] = UDim.new(0, 7)
		Gui["7"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.TabButtonContainer.UIPadding
		Gui["c"] = Instance.new("UIPadding", Gui["6"])
		Gui["c"]["PaddingTop"] = UDim.new(0, 6)
		Gui["c"]["PaddingLeft"] = UDim.new(0, 3)

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.LeftControl
		Gui["15"] = Instance.new("TextButton", Gui["3"])
		Gui["15"]["BorderSizePixel"] = 0
		Gui["15"]["AutoButtonColor"] = false
		Gui["15"]["TextSize"] = 14
		Gui["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["15"]["TextColor3"] = Color3.fromRGB(96, 96, 96)
		Gui["15"]["Size"] = UDim2.new(0, 18, 0, 40)
		Gui["15"]["Name"] = [[LeftControl]]
		Gui["15"]["Text"] = [[<]]
		Gui["15"]["Font"] = Enum.Font.GothamBold
		Gui["15"]["Position"] = UDim2.new(0, 458, 0, 0)
		Gui["15"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.RightControl
		Gui["16"] = Instance.new("TextButton", Gui["3"])
		Gui["16"]["BorderSizePixel"] = 0
		Gui["16"]["AutoButtonColor"] = false
		Gui["16"]["TextSize"] = 14
		Gui["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["16"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Gui["16"]
		Gui["16"]["Size"] = UDim2.new(0, 18, 0, 40)
		Gui["16"]["Name"] = [[RightControl]]
		Gui["16"]["Text"] = [[>]]
		Gui["16"]["Font"] = Enum.Font.GothamBold
		Gui["16"]["Position"] = UDim2.new(0, 475, 0, 0)
		Gui["16"]["BackgroundTransparency"] = 1

		-- StarterGui.Vision Lib v2.GuiFrame.NavBar.UIGradient
		Gui["17"] = Instance.new("UIGradient", Gui["3"])
		Gui["17"]["Rotation"] = 90
		Gui["17"]["Color"] = ThemeColor.NavBar

		ThemeInstances["NavBar"][#ThemeInstances["NavBar"] + 1] = Gui["17"]

		-- StarterGui.Vision Lib v2.GuiFrame.MainFrame
		Gui["18"] = Instance.new("Frame", Gui["2"])
		Gui["18"]["BorderSizePixel"] = 0
		Gui["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["18"]["Size"] = UDim2.new(0, 498, 0, 452)
		Gui["18"]["Name"] = [[MainFrame]]
		Gui["18"]["ClipsDescendants"] = true

		-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.UICorner
		Gui["19"] = Instance.new("UICorner", Gui["18"])
		Gui["19"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.UIGradient
		Gui["1a"] = Instance.new("UIGradient", Gui["18"])
		Gui["1a"]["Rotation"] = 90
		Gui["1a"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Gui["1a"]

		-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Seperator
		Gui["1b"] = Instance.new("Frame", Gui["18"])
		Gui["1b"]["ZIndex"] = 2
		Gui["1b"]["BorderSizePixel"] = 0
		Gui["1b"]["BackgroundColor3"] = ThemeColor.Textbox

		ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Gui["1b"]

		Gui["1b"]["Size"] = UDim2.new(0, 496, 0, 2)
		Gui["1b"]["BorderColor3"] = ThemeColor.Textbox

		ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Gui["1b"]

		Gui["1b"]["Position"] = UDim2.new(0, 0, 0, 33)
		Gui["1b"]["Name"] = [[Seperator]]

		-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Title
		Gui["1c"] = Instance.new("TextLabel", Gui["18"])
		Gui["1c"]["BorderSizePixel"] = 0
		Gui["1c"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Gui["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Gui["1c"]["TextSize"] = 15
		Gui["1c"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Gui["1c"]
		Gui["1c"]["Size"] = UDim2.new(0, 212, 0, 27)
		Gui["1c"]["Text"] = [[Home Tab]]
		Gui["1c"]["Name"] = [[Title]]
		Gui["1c"]["Font"] = Enum.Font.GothamBold
		Gui["1c"]["BackgroundTransparency"] = 1
		Gui["1c"]["Position"] = UDim2.new(0, 14, 0, 5)
	end

	function Library:ResizeTabCanvas()
		local NumChild = 0
		local ChildOffset = 0

		for i, v in pairs(Gui["6"]:GetChildren()) do
			if v:IsA("TextButton") then
				NumChild = NumChild + 1
				ChildOffset = ChildOffset + v.Size.X.Offset
			end
		end

		local NumChildOffset = NumChild * 7

		local CanvasSizeX = NumChildOffset + ChildOffset + 7

		Library:Tween(Gui["6"], {
			Length = 0.5,
			Goal = { CanvasSize = UDim2.new(0, CanvasSizeX, 0, 0) },
		})

		task.spawn(function()
			task.wait(1)

			local MaxPos = Gui["6"].CanvasSize.X.Offset - Gui["6"].Size.X.Offset

			if Gui["6"].CanvasPosition.X > 0 then
				Library:Tween(Gui["15"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(255, 255, 255) },
				})
			else
				Library:Tween(Gui["15"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(96, 96, 96) },
				})
			end

			if Gui["6"].CanvasPosition.X < MaxPos then
				Library:Tween(Gui["16"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(255, 255, 255) },
				})
			else
				Library:Tween(Gui["16"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(96, 96, 96) },
				})
			end
		end)
	end

	table.insert(
		ConnectionBin,
		Gui["6"]:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			local MaxPos = Gui["6"].CanvasSize.X.Offset - Gui["6"].Size.X.Offset

			if Gui["6"].CanvasPosition.X > 0 then
				Library:Tween(Gui["15"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(255, 255, 255) },
				})
			else
				Library:Tween(Gui["15"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(96, 96, 96) },
				})
			end

			if Gui["6"].CanvasPosition.X < MaxPos then
				Library:Tween(Gui["16"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(255, 255, 255) },
				})
			else
				Library:Tween(Gui["16"], {
					Length = 0.1,
					Goal = { TextColor3 = Color3.fromRGB(96, 96, 96) },
				})
			end
		end)
	)

	do
		-- StarterGui.Vision Lib v2.StartAnimationFrame
		StartAnimation["91"] = Instance.new("Frame", LibFrame["1"])
		StartAnimation["91"]["BorderSizePixel"] = 0
		StartAnimation["91"]["AutoLocalize"] = false
		StartAnimation["91"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		StartAnimation["91"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		StartAnimation["91"]["BackgroundTransparency"] = 1
		StartAnimation["91"]["Size"] = UDim2.new(0, 498, 0, 498)
		StartAnimation["91"]["ClipsDescendants"] = true
		StartAnimation["91"]["BorderColor3"] = Color3.fromRGB(28, 43, 54)
		StartAnimation["91"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
		StartAnimation["91"]["Name"] = [[StartAnimationFrame]]

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main
		StartAnimation["92"] = Instance.new("Frame", StartAnimation["91"])
		StartAnimation["92"]["ZIndex"] = 2
		StartAnimation["92"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		StartAnimation["92"]["Size"] = UDim2.new(0, 310, 0, 0)
		StartAnimation["92"]["Position"] = UDim2.new(0.186, 0, 0.167, 0)
		StartAnimation["92"]["Name"] = [[Main]]
		StartAnimation["92"]["ClipsDescendants"] = true
		StartAnimation["92"]["BorderSizePixel"] = 0

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.UIGradient
		StartAnimation["93"] = Instance.new("UIGradient", StartAnimation["92"])
		StartAnimation["93"]["Rotation"] = 90
		StartAnimation["93"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = StartAnimation["93"]

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.UICorner
		StartAnimation["94"] = Instance.new("UICorner", StartAnimation["92"])
		StartAnimation["94"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.Title
		StartAnimation["95"] = Instance.new("TextLabel", StartAnimation["92"])
		StartAnimation["95"]["ZIndex"] = 2
		StartAnimation["95"]["BorderSizePixel"] = 0
		StartAnimation["95"]["TextXAlignment"] = Enum.TextXAlignment.Left
		StartAnimation["95"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		StartAnimation["95"]["TextSize"] = 20
		StartAnimation["95"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = StartAnimation["95"]
		StartAnimation["95"]["Size"] = UDim2.new(0, 255, 0, 32)
		StartAnimation["95"]["Text"] = options.Name
		StartAnimation["95"]["Name"] = [[Title]]
		StartAnimation["95"]["Font"] = Enum.Font.GothamMedium
		StartAnimation["95"]["BackgroundTransparency"] = 1
		StartAnimation["95"]["Position"] = UDim2.new(0, 10, 0, 5)

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.Title
		StartAnimation["96"] = Instance.new("TextLabel", StartAnimation["92"])
		StartAnimation["96"]["ZIndex"] = 2
		StartAnimation["96"]["BorderSizePixel"] = 0
		StartAnimation["96"]["TextXAlignment"] = Enum.TextXAlignment.Left
		StartAnimation["96"]["TextYAlignment"] = Enum.TextYAlignment.Top
		StartAnimation["96"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		StartAnimation["96"]["TextSize"] = 11
		StartAnimation["96"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = StartAnimation["96"]
		StartAnimation["96"]["Size"] = UDim2.new(0, 255, 0, 18)
		StartAnimation["96"]["Text"] = options.Footer
		StartAnimation["96"]["Name"] = [[Title]]
		StartAnimation["96"]["Font"] = Enum.Font.Gotham
		StartAnimation["96"]["BackgroundTransparency"] = 1
		StartAnimation["96"]["Position"] = UDim2.new(0, 12, 0, 32)

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.LoadBack
		StartAnimation["97"] = Instance.new("Frame", StartAnimation["92"])
		StartAnimation["97"]["ZIndex"] = 2
		StartAnimation["97"]["BackgroundColor3"] = ThemeColor.Textbox

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = StartAnimation["97"]

		StartAnimation["97"]["Size"] = UDim2.new(0, 285, 0, 6)
		StartAnimation["97"]["Position"] = UDim2.new(0.03870967775583267, 0, 0.942219614982605, 0)
		StartAnimation["97"]["Name"] = [[LoadBack]]

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.LoadBack.UICorner
		StartAnimation["98"] = Instance.new("UICorner", StartAnimation["97"])
		StartAnimation["98"]["CornerRadius"] = UDim.new(0, 7)

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.LoadBack.LoadFront
		StartAnimation["99"] = Instance.new("Frame", StartAnimation["97"])
		StartAnimation["99"]["ZIndex"] = 2
		StartAnimation["99"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		StartAnimation["99"]["Size"] = UDim2.new(0.035087719559669495, 0, 1, 0)
		StartAnimation["99"]["Position"] = UDim2.new(-0.007017544005066156, 0, 0, 0)
		StartAnimation["99"]["Name"] = [[LoadFront]]

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.LoadBack.LoadFront.UICorner
		StartAnimation["9a"] = Instance.new("UICorner", StartAnimation["99"])
		StartAnimation["9a"]["CornerRadius"] = UDim.new(0, 7)

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.LoadBack.LoadFront.UIGradient
		StartAnimation["9b"] = Instance.new("UIGradient", StartAnimation["99"])
		StartAnimation["9b"]["Color"] = ThemeColor.Tertiary

		ThemeInstances["Tertiary"][#ThemeInstances["Tertiary"] + 1] = StartAnimation["9b"]

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.CharAva
		StartAnimation["9c"] = Instance.new("ImageLabel", StartAnimation["92"])
		StartAnimation["9c"]["ZIndex"] = 2
		StartAnimation["9c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		StartAnimation["9c"]["Image"] = Players:GetUserThumbnailAsync(
			LocalPlayer.UserId,
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size100x100
		)
		StartAnimation["9c"]["Size"] = UDim2.new(0, 70, 0, 70)
		StartAnimation["9c"]["Name"] = [[CharAva]]
		StartAnimation["9c"]["Position"] = UDim2.new(0, 12, 0, 49)
		StartAnimation["9c"]["BackgroundTransparency"] = 1
		StartAnimation["9c"]["ImageTransparency"] = 1

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.CharAva.UICorner
		StartAnimation["9d"] = Instance.new("UICorner", StartAnimation["9c"])
		StartAnimation["9d"]["CornerRadius"] = UDim.new(1, 8)

		-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.WelcomeText
		StartAnimation["9e"] = Instance.new("TextLabel", StartAnimation["92"])
		StartAnimation["9e"]["TextWrapped"] = true
		StartAnimation["9e"]["ZIndex"] = 2
		StartAnimation["9e"]["TextXAlignment"] = Enum.TextXAlignment.Left
		StartAnimation["9e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		StartAnimation["9e"]["TextSize"] = 19
		StartAnimation["9e"]["TextTransparency"] = 1
		StartAnimation["9e"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = StartAnimation["9e"]
		StartAnimation["9e"]["Size"] = UDim2.new(0, 282, 0, 70)
		StartAnimation["9e"]["Text"] = [[Welcome, ]] .. Players.LocalPlayer.Name
		StartAnimation["9e"]["Name"] = [[WelcomeText]]
		StartAnimation["9e"]["Font"] = Enum.Font.GothamMedium
		StartAnimation["9e"]["BackgroundTransparency"] = 1
		StartAnimation["9e"]["Position"] = UDim2.new(0, 98, 0, 49)
	end

	local KeySystem = {}

	-- Start animation
	do
		task.spawn(function()
			Library.Sliding = true

			Library:Tween(StartAnimation["92"], {
				Length = 1,
				Goal = { Size = UDim2.new(0, 310, 0, 230) },
			})

			task.wait(1)

			Library:Tween(StartAnimation["99"], {
				Length = 0.5,
				Direction = Enum.EasingDirection.In,
				Goal = { Size = UDim2.new(1, 0, 1, 0) },
			})
			task.wait(0.6)

			Library:Tween(StartAnimation["97"], {
				Length = 0.5,
				Goal = { BackgroundTransparency = 1 },
			})

			Library:Tween(StartAnimation["99"], {
				Length = 0.5,
				Goal = { BackgroundTransparency = 1 },
			})

			local KeyChecked = false

			if options.KeySystem then
				KeySystem = {
					CorrectKey = false,
					KeyTextboxHover = false,
					Attempts = Gui.MaxAttempts,
				}

				local KeyConnectionBin = {}

				do
					-- StarterGui.Vision Lib v2.StartAnimationFrame.Main.Key
					KeySystem["a0"] = Instance.new("Frame", StartAnimation["92"])
					KeySystem["a0"]["ZIndex"] = 3
					KeySystem["a0"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = KeySystem["a0"]

					KeySystem["a0"]["Size"] = UDim2.new(0, 253, 0, 20)
					KeySystem["a0"]["Position"] = UDim2.new(0, 28, 0, 33)
					KeySystem["a0"]["Name"] = [[Key]]

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.Key.UICorner
					KeySystem["a1"] = Instance.new("UICorner", KeySystem["a0"])
					KeySystem["a1"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.Key.UIStroke
					KeySystem["a2"] = Instance.new("UIStroke", KeySystem["a0"])
					KeySystem["a2"]["Color"] = ThemeColor.MainTrue

					ThemeInstances["MainTrue"][#ThemeInstances["MainTrue"] + 1] = KeySystem["a2"]

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.Key.TextBox
					KeySystem["a4"] = Instance.new("TextBox", KeySystem["a0"])
					KeySystem["a4"]["CursorPosition"] = -1
					KeySystem["a4"]["PlaceholderColor3"] = ThemeColor.PlaceholderText

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = KeySystem["a4"]

					KeySystem["a4"]["ZIndex"] = 3
					KeySystem["a4"]["RichText"] = true
					KeySystem["a4"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = KeySystem["a4"]
					KeySystem["a4"]["TextXAlignment"] = Enum.TextXAlignment.Left
					KeySystem["a4"]["TextSize"] = 11
					KeySystem["a4"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = KeySystem["a4"]

					KeySystem["a4"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
					KeySystem["a4"]["PlaceholderText"] = [[Key | e.g abc123]]
					KeySystem["a4"]["Size"] = UDim2.new(0.8999999761581421, 0, 0.8999999761581421, 0)
					KeySystem["a4"]["Text"] = [[]]
					KeySystem["a4"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
					KeySystem["a4"]["Font"] = Enum.Font.Gotham

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.Key.TextBox.UICorner
					KeySystem["a5"] = Instance.new("UICorner", KeySystem["a4"])
					KeySystem["a5"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.KeySystemTitle
					KeySystem["a6"] = Instance.new("TextLabel", StartAnimation["92"])
					KeySystem["a6"]["ZIndex"] = 2
					KeySystem["a6"]["BorderSizePixel"] = 0
					KeySystem["a6"]["TextXAlignment"] = Enum.TextXAlignment.Left
					KeySystem["a6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					KeySystem["a6"]["TextSize"] = 11
					KeySystem["a6"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = KeySystem["a6"]
					KeySystem["a6"]["Size"] = UDim2.new(0, 158, 0, 16)
					KeySystem["a6"]["Text"] = [[Key System]]
					KeySystem["a6"]["Name"] = [[KeySystemTitle]]
					KeySystem["a6"]["Font"] = Enum.Font.GothamMedium
					KeySystem["a6"]["BackgroundTransparency"] = 1
					KeySystem["a6"]["Position"] = UDim2.new(0, 34, 0, 14)

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.KeySystemNote
					KeySystem["a8"] = Instance.new("Frame", StartAnimation["92"])
					KeySystem["a8"]["ZIndex"] = 3
					KeySystem["a8"]["BackgroundColor3"] = ThemeColor.TertiaryTrue
					KeySystem["a8"]["Size"] = UDim2.new(0, 215, 0, 50)
					KeySystem["a8"]["Position"] = UDim2.new(0, 49, 0, 61)
					KeySystem["a8"]["Name"] = [[KeySystemNote]]

					ThemeInstances["TertiaryTrue"][#ThemeInstances["TertiaryTrue"] + 1] = KeySystem["a8"]

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.KeySystemNote.TextLabel
					KeySystem["a9"] = Instance.new("TextLabel", KeySystem["a8"])
					KeySystem["a9"]["TextWrapped"] = true
					KeySystem["a9"]["ZIndex"] = 2
					KeySystem["a9"]["TextXAlignment"] = Enum.TextXAlignment.Left
					KeySystem["a9"]["TextYAlignment"] = Enum.TextYAlignment.Top
					KeySystem["a9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					KeySystem["a9"]["TextSize"] = 9
					KeySystem["a9"]["TextColor3"] = ThemeColor.PlaceholderText

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = KeySystem["a9"]

					KeySystem["a9"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
					KeySystem["a9"]["Size"] = UDim2.new(0.949999988079071, 0, 0.800000011920929, 0)
					KeySystem["a9"]["Text"] = [[Note: Join our discord to get the key!]]
					KeySystem["a9"]["Font"] = Enum.Font.Gotham
					KeySystem["a9"]["BackgroundTransparency"] = 1
					KeySystem["a9"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)

					KeySystem["a0"]["BackgroundTransparency"] = 1
					KeySystem["a4"]["BackgroundTransparency"] = 1
					KeySystem["a8"]["BackgroundTransparency"] = 1
					KeySystem["a4"]["TextTransparency"] = 1
					KeySystem["a9"]["TextTransparency"] = 1
					KeySystem["a6"]["TextTransparency"] = 1

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.KeySystemNote.UICorner
					KeySystem["aa"] = Instance.new("UICorner", KeySystem["a8"])

					-- Methods
					do
						table.insert(
							KeyConnectionBin,
							KeySystem["a0"].MouseEnter:Connect(function()
								Library:Tween(KeySystem["a2"], {
									Length = 0.2,
									Goal = { Color = ThemeColor.SecondaryTrue },
								})

								KeySystem.KeyTextboxHover = true
								Library:PlaySound(LibSettings.HoverSound)
							end)
						)

						table.insert(
							KeyConnectionBin,
							KeySystem["a0"].MouseLeave:Connect(function()
								Library:Tween(KeySystem["a2"], {
									Length = 0.2,
									Goal = { Color = ThemeColor.MainTrue },
								})

								KeySystem.KeyTextboxHover = false
							end)
						)

						table.insert(
							KeyConnectionBin,
							KeySystem["a4"].FocusLost:Connect(function()
								local keyEntered = KeySystem["a4"]["Text"]

								if keyEntered ~= "" then
									if keyEntered == Gui.Key then
										KeySystem.CorrectKey = true

										Library:ForceNotify({
											Name = "KeySystem",
											Text = "Correct key!",
											Icon = "rbxassetid://11401835376",
											Duration = 3,
										})
									else
										KeySystem.Attempts = KeySystem.Attempts - 1

										Library:ForceNotify({
											Name = "KeySystem",
											Text = "Incorrect key! You still have "
												.. tostring(KeySystem.Attempts)
												.. " attempts left!",
											Icon = "rbxassetid://11401835376",
											Duration = 3,
										})
									end

									KeySystem["a4"]["Text"] = ""

									if KeySystem.Attempts == 0 then
										game.Players.LocalPlayer:Kick("Too many failed attempts")
									end

									if KeySystem.KeyTextboxHover then
										Library:Tween(KeySystem["a2"], {
											Length = 0.2,
											Goal = { Color = Color3.fromRGB(93, 93, 93) },
										})
									else
										Library:Tween(KeySystem["a2"], {
											Length = 0.2,
											Goal = { Color = ThemeColor.SecondaryTrue },
										})
									end
								end
							end)
						)
					end
				end

				do
					-- Others tween
					do
						Library:Tween(StartAnimation["92"], {
							Length = 1,
							Goal = { Position = UDim2.new(0, 92, 0, 159) },
						})

						Library:Tween(StartAnimation["92"], {
							Length = 1,
							Goal = { Size = UDim2.new(0, 310, 0, 154) },
						})

						Library:Tween(StartAnimation["96"], {
							Length = 0.7,
							Goal = { TextTransparency = 1 },
						})

						Library:Tween(StartAnimation["95"], {
							Length = 0.7,
							Goal = { TextTransparency = 1 },
						})
					end

					task.wait(1)

					-- Ui tween
					do
						Library:Tween(KeySystem["a4"], {
							Length = 0.7,
							Goal = { TextTransparency = 0 },
						})

						Library:Tween(KeySystem["a9"], {
							Length = 0.7,
							Goal = { TextTransparency = 0 },
						})

						Library:Tween(KeySystem["a6"], {
							Length = 0.7,
							Goal = { TextTransparency = 0 },
						})

						Library:Tween(KeySystem["a8"], {
							Length = 0.7,
							Goal = { BackgroundTransparency = 0 },
						})

						Library:Tween(KeySystem["a4"], {
							Length = 0.7,
							Goal = { BackgroundTransparency = 0 },
						})

						Library:Tween(KeySystem["a0"], {
							Length = 0.7,
							Goal = { BackgroundTransparency = 0 },
						})
					end
				end

				if Gui.DiscordLink ~= nil then
					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.DiscordServerButton
					KeySystem["ab"] = Instance.new("TextButton", StartAnimation["92"])
					KeySystem["ab"]["TextStrokeTransparency"] = 0
					KeySystem["ab"]["ZIndex"] = 3
					KeySystem["ab"]["AutoButtonColor"] = false
					KeySystem["ab"]["TextSize"] = 12
					KeySystem["ab"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					KeySystem["ab"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = KeySystem["ab"]
					KeySystem["ab"]["Size"] = UDim2.new(0, 100, 0, 19)
					KeySystem["ab"]["Name"] = [[DiscordServerButton]]
					KeySystem["ab"]["Text"] = [[Copy discord invite]]
					KeySystem["ab"]["Font"] = Enum.Font.Gotham
					KeySystem["ab"]["Position"] = UDim2.new(0, 104, 0, 118)
					KeySystem["ab"]["MaxVisibleGraphemes"] = 0

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.DiscordServerButton.TextLabel
					KeySystem["ac"] = Instance.new("TextLabel", KeySystem["ab"])
					KeySystem["ac"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					KeySystem["ac"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255)
					KeySystem["ac"]["TextSize"] = 9
					KeySystem["ac"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = KeySystem["ac"]
					KeySystem["ac"]["Size"] = UDim2.new(1, 0, 1, 0)
					KeySystem["ac"]["Text"] = [[Copy discord invite]]
					KeySystem["ac"]["Font"] = Enum.Font.GothamMedium
					KeySystem["ac"]["BackgroundTransparency"] = 1

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.DiscordServerButton.UIStroke
					KeySystem["ad"] = Instance.new("UIStroke", KeySystem["ab"])
					KeySystem["ad"]["Color"] = Color3.fromRGB(89, 102, 243)
					KeySystem["ad"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.DiscordServerButton.UIGradient
					KeySystem["ae"] = Instance.new("UIGradient", KeySystem["ab"])
					KeySystem["ae"]["Rotation"] = 90
					KeySystem["ae"]["Color"] = ColorSequence.new({
						ColorSequenceKeypoint.new(0.000, Color3.fromRGB(89, 102, 243)),
						ColorSequenceKeypoint.new(0.516, Color3.fromRGB(78, 90, 213)),
						ColorSequenceKeypoint.new(1.000, Color3.fromRGB(63, 74, 172)),
					})

					-- StarterGui.Vision Lib v2.KeySystemFrame.Main.DiscordServerButton.UICorner
					KeySystem["af"] = Instance.new("UICorner", KeySystem["ab"])
					KeySystem["af"]["CornerRadius"] = UDim.new(0, 4)

					KeySystem["ab"]["BackgroundTransparency"] = 1
					KeySystem["ac"]["TextTransparency"] = 1
					KeySystem["ad"]["Transparency"] = 1

					do
						Library:Tween(KeySystem["ad"], {
							Length = 0.7,
							Goal = { Transparency = 0 },
						})

						Library:Tween(KeySystem["ab"], {
							Length = 0.7,
							Goal = { BackgroundTransparency = 0 },
						})

						Library:Tween(KeySystem["ac"], {
							Length = 0.7,
							Goal = { TextTransparency = 0 },
						})
					end

					-- Handler
					do
						table.insert(
							KeyConnectionBin,
							KeySystem["ab"].MouseEnter:Connect(function()
								Library:Tween(KeySystem["ad"], {
									Length = 0.2,
									Goal = { Color = Color3.fromRGB(137, 145, 213) },
								})

								Library:PlaySound(LibSettings.HoverSound)
							end)
						)

						table.insert(
							KeyConnectionBin,
							KeySystem["ab"].MouseLeave:Connect(function()
								Library:Tween(KeySystem["ad"], {
									Length = 0.2,
									Goal = { Color = Color3.fromRGB(89, 102, 243) },
								})
							end)
						)

						table.insert(
							KeyConnectionBin,
							KeySystem["ab"].MouseButton1Click:Connect(function()
								Library:PlaySound(LibSettings.ClickSound)
								task.spawn(function()
									Library:ForceNotify({
										Name = "Discord",
										Text = "Copied the discord link to clipboard!",
										Icon = "rbxassetid://11401835376",
										Duration = 3,
									})

									Library:Tween(KeySystem["ad"], {
										Length = 0.2,
										Goal = { Color = Color3.fromRGB(183, 188, 213) },
									})

									task.wait(0.2)

									Library:Tween(KeySystem["ad"], {
										Length = 0.2,
										Goal = { Color = Color3.fromRGB(137, 145, 213) },
									})
								end)

								pcall(function()
									setclipboard(Gui.DiscordLink)
								end)
							end)
						)
					end
				end

				repeat
					task.wait()
				until KeySystem.CorrectKey

				do
					do
						Library:Tween(KeySystem["a4"], {
							Length = 0.7,
							Goal = { TextTransparency = 1 },
						})

						Library:Tween(KeySystem["a9"], {
							Length = 0.7,
							Goal = { TextTransparency = 1 },
						})

						Library:Tween(KeySystem["a6"], {
							Length = 0.7,
							Goal = { TextTransparency = 1 },
						})

						Library:Tween(KeySystem["a8"], {
							Length = 0.7,
							Goal = { BackgroundTransparency = 1 },
						})

						Library:Tween(KeySystem["a4"], {
							Length = 0.7,
							Goal = { BackgroundTransparency = 1 },
						})

						Library:Tween(KeySystem["a0"], {
							Length = 0.7,
							Goal = { BackgroundTransparency = 1 },
						})

						Library:Tween(KeySystem["a2"], {
							Length = 0.7,
							Goal = { Transparency = 1 },
						})
					end

					if Gui.DiscordLink ~= nil then
						do
							Library:Tween(KeySystem["ad"], {
								Length = 0.7,
								Goal = { Transparency = 1 },
							})

							Library:Tween(KeySystem["ab"], {
								Length = 0.7,
								Goal = { BackgroundTransparency = 1 },
							})

							Library:Tween(KeySystem["ac"], {
								Length = 0.7,
								Goal = { TextTransparency = 1 },
							})
						end
					end
				end

				task.wait(1)

				Library:Tween(StartAnimation["96"], {
					Length = 0.7,
					Goal = { TextTransparency = 0 },
				})

				Library:Tween(StartAnimation["95"], {
					Length = 0.7,
					Goal = { TextTransparency = 0 },
				})

				task.spawn(function()
					task.wait(1)
					KeySystem["a0"]:Destroy()

					for i, v in next, KeyConnectionBin do
						v:Disconnect()
					end
				end)

				KeyChecked = true
			else
				KeyChecked = true
			end

			repeat
				task.wait()
			until KeyChecked

			task.wait(0.3)

			Library:Tween(StartAnimation["92"], {
				Length = 1,
				Goal = { Position = UDim2.new(0, 0, 0, 0) },
			})

			Library:Tween(StartAnimation["92"], {
				Length = 1,
				Goal = { Size = UDim2.new(0, 498, 0, 452) },
			})

			Library:Tween(StartAnimation["9e"], {
				Length = 0.7,
				Goal = { TextTransparency = 0 },
			})

			Library:Tween(StartAnimation["9c"], {
				Length = 0.7,
				Goal = { ImageTransparency = 0 },
			})

			Library:Tween(StartAnimation["9c"], {
				Length = 0.7,
				Goal = { BackgroundTransparency = 0 },
			})

			task.wait(1)

			Gui["2"]["Size"] = UDim2.new(0, 498, 0, 0)
			Gui["2"]["Visible"] = true

			task.wait(1.8)

			Library:Tween(StartAnimation["96"], {
				Length = 0.7,
				Goal = { TextTransparency = 1 },
			})

			Library:Tween(StartAnimation["95"], {
				Length = 0.7,
				Goal = { TextTransparency = 1 },
			})

			Library:Tween(StartAnimation["9e"], {
				Length = 0.7,
				Goal = { TextTransparency = 1 },
			})

			Library:Tween(StartAnimation["9c"], {
				Length = 0.7,
				Goal = { ImageTransparency = 1 },
			})

			Library:Tween(StartAnimation["9c"], {
				Length = 0.7,
				Goal = { BackgroundTransparency = 1 },
			})

			task.wait(0.1)

			Gui["3"]["Position"] = UDim2.new(0, 0, 0, 300)
			Gui["2"]["Size"] = UDim2.new(0, 498, 0, 498)

			Library:Tween(Gui["3"], {
				Length = 1.5,
				Goal = { Position = UDim2.new(0, 0, 0, 455) },
			})

			task.wait(2)

			Library:Tween(StartAnimation["92"], {
				Length = 0.5,
				Goal = { BackgroundTransparency = 1 },
			})

			Library.Sliding = false
			Library.Loaded = true

			task.spawn(function()
				task.wait(1)

				Library:SetTheme({})
			end)
		end)
	end

	function Gui:Tab(options)
		options = Library:PlaceDefaults({
			Name = "Tab",
			Icon = "rbxassetid://11396131982",
			Color = Color3.new(1, 0.290196, 0.290196),
			ActivationCallback = function()
				return
			end,
			DeativationCallback = function()
				return
			end,
		}, options or {})

		local Tab = {
			Active = false,
			Hover = false,
			Index = TabIndex,
		}

		TabIndex = TabIndex + 1

		if Gui.KeySystem then
			repeat
				task.wait()
			until KeySystem.CorrectKey
		end

		do
			-- StarterGui.Vision Lib v2.GuiFrame.NavBar.TabButtonContainer.TabButton
			Tab["8"] = Instance.new("TextButton", Gui["6"])
			Tab["8"]["BorderSizePixel"] = 0
			Tab["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Tab["8"]["Size"] = UDim2.new(0, 28, 0, 28)
			Tab["8"]["Name"] = [[TabButton]]
			Tab["8"]["Text"] = [[]]
			Tab["8"]["AutoButtonColor"] = true

			-- StarterGui.Vision Lib v2.GuiFrame.NavBar.TabButtonContainer.TabButton.UICorner
			Tab["9"] = Instance.new("UICorner", Tab["8"])
			Tab["9"]["CornerRadius"] = UDim.new(0, 5)

			-- StarterGui.Vision Lib v2.GuiFrame.NavBar.TabButtonContainer.TabButton.UIGradient
			Tab["a"] = Instance.new("UIGradient", Tab["8"])
			Tab["a"]["Rotation"] = 45
			Tab["a"]["Color"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 125, 125)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(31, 31, 31)),
			})

			-- StarterGui.Vision Lib v2.GuiFrame.NavBar.TabButtonContainer.TabButton.ImageLabel
			Tab["b"] = Instance.new("ImageLabel", Tab["8"])
			Tab["b"]["ZIndex"] = 2
			Tab["b"]["BorderSizePixel"] = 0
			Tab["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Tab["b"]["ImageColor3"] = Color3.fromRGB(245, 245, 245)
			Tab["b"]["Image"] = options.Icon
			Tab["b"]["Size"] = UDim2.new(0, 22, 0, 22)
			Tab["b"]["BackgroundTransparency"] = 1
			Tab["b"]["Position"] = UDim2.new(0.1071428582072258, 0, 0.1071428582072258, 0)
		end

		-- Container
		do
			-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container
			Tab["1d"] = Instance.new("ScrollingFrame", Gui["18"])
			Tab["1d"]["Active"] = true
			Tab["1d"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
			Tab["1d"]["BorderSizePixel"] = 0
			Tab["1d"]["CanvasSize"] = UDim2.new(0, 0, 0, 0)
			Tab["1d"]["CanvasPosition"] = Vector2.new(0, 150)
			Tab["1d"]["ScrollBarImageTransparency"] = 1
			Tab["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Tab["1d"]["BackgroundTransparency"] = 1
			Tab["1d"]["Size"] = UDim2.new(0, 498, 0, 417)
			Tab["1d"]["ScrollBarImageColor3"] = Color3.fromRGB(20, 20, 20)
			Tab["1d"]["ScrollBarThickness"] = 5
			Tab["1d"]["Position"] = UDim2.new(0, 0, 0, 35)
			Tab["1d"]["Name"] = [[Container]]
			Tab["1d"]["Visible"] = false

			-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.UIPadding
			Tab["7c"] = Instance.new("UIPadding", Tab["1d"])
			Tab["7c"]["PaddingTop"] = UDim.new(0, 5)
			Tab["7c"]["PaddingLeft"] = UDim.new(0, 20)

			-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.UIListLayout
			Tab["7d"] = Instance.new("UIListLayout", Tab["1d"])
			Tab["7d"]["Padding"] = UDim.new(0, 5)
			Tab["7d"]["SortOrder"] = Enum.SortOrder.LayoutOrder
		end

		function Tab:Section(options)
			options = Library:PlaceDefaults({
				Name = "Section",
			}, options or {})

			local Section = {}

			-- Section and Container
			do
				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame
				Section["1e"] = Instance.new("Frame", Tab["1d"])
				Section["1e"]["BorderSizePixel"] = 0
				Section["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				Section["1e"]["Size"] = UDim2.new(0, 458, 0, 385)
				Section["1e"]["Position"] = UDim2.new(0, 0, 0, -150)
				Section["1e"]["Name"] = [[SectionFrame]]

				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.UIGradient
				Section["1f"] = Instance.new("UIGradient", Section["1e"])
				Section["1f"]["Rotation"] = 90
				Section["1f"]["Color"] = ThemeColor.Secondary

				ThemeInstances["Secondary"][#ThemeInstances["Secondary"] + 1] = Section["1f"]

				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionLabel
				Section["20"] = Instance.new("TextLabel", Section["1e"])
				Section["20"]["BorderSizePixel"] = 0
				Section["20"]["TextXAlignment"] = Enum.TextXAlignment.Left
				Section["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				Section["20"]["TextSize"] = 12
				Section["20"]["TextColor3"] = ThemeColor.Text

				ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Section["20"]
				Section["20"]["Size"] = UDim2.new(0, 408, 0, 18)
				Section["20"]["Text"] = options.Name
				Section["20"]["Name"] = [[SectionLabel]]
				Section["20"]["Font"] = Enum.Font.GothamMedium
				Section["20"]["BackgroundTransparency"] = 1
				Section["20"]["Position"] = UDim2.new(0, 8, 0, 6)

				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer
				Section["21"] = Instance.new("Frame", Section["1e"])
				Section["21"]["BorderSizePixel"] = 0
				Section["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				Section["21"]["BackgroundTransparency"] = 1
				Section["21"]["Size"] = UDim2.new(0, 458, 0, 425)
				Section["21"]["Position"] = UDim2.new(0, 0, 0, 26)
				Section["21"]["Name"] = [[SectionContainer]]

				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.UIListLayout
				Section["22"] = Instance.new("UIListLayout", Section["21"])
				Section["22"]["Padding"] = UDim.new(0, 5)
				Section["22"]["SortOrder"] = Enum.SortOrder.LayoutOrder

				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.UIPadding
				Section["23"] = Instance.new("UIPadding", Section["21"])
				Section["23"]["PaddingLeft"] = UDim.new(0, 17)

				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.UICorner
				Section["7a"] = Instance.new("UICorner", Section["1e"])
				Section["7a"]["CornerRadius"] = UDim.new(0, 4)

				-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.UIStroke
				Section["7b"] = Instance.new("UIStroke", Section["1e"])
				Section["7b"]["Color"] = ThemeColor.SecondaryTrue

				ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Section["7b"]
			end

			table.insert(
				ConnectionBin,
				Section["1e"]:GetPropertyChangedSignal("Size"):Connect(function()
					Library:ResizeCanvas(Tab["1d"])
				end)
			)

			function Section:Button(options)
				options = Library:PlaceDefaults({
					Name = "Button",
					Callback = function()
						return
					end,
				}, options or {})

				local Button = {
					Hover = false,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Button
					Button["74"] = Instance.new("Frame", Section["21"])
					Button["74"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Button["74"]["Size"] = UDim2.new(0, 423, 0, 34)
					Button["74"]["Position"] = UDim2.new(0, 17, 0, 22)
					Button["74"]["Name"] = [[Button]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Button.UICorner
					Button["75"] = Instance.new("UICorner", Button["74"])
					Button["75"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Button.UIGradient
					Button["76"] = Instance.new("UIGradient", Button["74"])
					Button["76"]["Rotation"] = 90
					Button["76"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Button["76"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Button.Label
					Button["77"] = Instance.new("TextLabel", Button["74"])
					Button["77"]["BorderSizePixel"] = 0
					Button["77"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Button["77"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Button["77"]["TextSize"] = 13
					Button["77"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Button["77"]
					Button["77"]["Size"] = UDim2.new(0, 301, 0, 33)
					Button["77"]["Text"] = options.Name
					Button["77"]["Name"] = [[Label]]
					Button["77"]["Font"] = Enum.Font.GothamMedium
					Button["77"]["BackgroundTransparency"] = 1
					Button["77"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Button.UIStroke
					Button["78"] = Instance.new("UIStroke", Button["74"])
					Button["78"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Button["78"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Button.ImageLabel
					Button["79"] = Instance.new("ImageLabel", Button["74"])
					Button["79"]["BorderSizePixel"] = 0
					Button["79"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Button["79"]["Image"] = [[rbxassetid://11400928498]]
					Button["79"]["Size"] = UDim2.new(0, 21, 0, 21)
					Button["79"]["BackgroundTransparency"] = 1
					Button["79"]["Position"] = UDim2.new(0.9219858050346375, 0, 0.1764705926179886, 0)
				end

				-- Handler
				do
					table.insert(
						Button.Connections,
						Button["74"].MouseEnter:Connect(function()
							Library:Tween(Button["78"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})

							Button.Hover = true
							Library:PlaySound(LibSettings.HoverSound)
						end)
					)

					table.insert(
						Button.Connections,
						Button["74"].MouseLeave:Connect(function()
							Library:Tween(Button["78"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})

							Button.Hover = false
						end)
					)

					table.insert(
						Button.Connections,
						UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
								Library:PlaySound(LibSettings.ClickSound)
								Library:Tween(Button["78"], {
									Length = 0.2,
									Goal = { Color = Color3.fromRGB(86, 86, 86) },
								})

								Library:Tween(Button["79"], {
									Length = 0.2,
									Goal = { ImageColor3 = ThemeColor.ThemeTrue },
								})

								-- Callback
								do
									task.spawn(function()
										options.Callback()
									end)
								end

								task.wait(0.2)
								Library:Tween(Button["79"], {
									Length = 0.2,
									Goal = { ImageColor3 = Color3.fromRGB(255, 255, 255) },
								})

								if Button.Hover then
									Library:Tween(Button["78"], {
										Length = 0.2,
										Goal = { Color = ThemeColor.MainTrue },
									})
								else
									Library:Tween(Button["78"], {
										Length = 0.2,
										Goal = { Color = ThemeColor.SecondaryTrue },
									})
								end
							end
						end)
					)
				end

				-- Methods
				do
					function Button:Destroy()
						table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Button.Connections))

						local TotalConnection = #Button.Connections
						local Disconnected = 0
						for i, v in next, Button.Connections do
							pcall(function()
								v:Disconnect()
								Disconnected = Disconnected + 1
							end)
						end

						Button["74"]:Destroy()
						print(
							"Removed button, "
								.. tostring(Disconnected)
								.. " connections out of "
								.. TotalConnection
								.. " were disconnected."
						)

						task.spawn(function()
							Library:ResizeSection(Section["1e"])
							Library:ResizeCanvas(Tab["1d"])
						end)
					end

					table.insert(ControlsConnectionBin, Button.Connections)

					function Button:SetName(name)
						Button["77"]["Text"] = name
					end
				end

				table.insert(
					Button.Connections,
					Button["74"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				return Button
			end

			function Section:Toggle(options)
				options = Library:PlaceDefaults({
					Name = "Toggle",
					Default = false,
					Callback = function()
						return
					end,
				}, options or {})

				local Toggle = {
					Hover = false,
					Bool = options.Default,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle
					Toggle["24"] = Instance.new("Frame", Section["21"])
					Toggle["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Toggle["24"]["Size"] = UDim2.new(0, 423, 0, 34)
					Toggle["24"]["Position"] = UDim2.new(0, 17, 0, 22)
					Toggle["24"]["Name"] = [[Toggle]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.UICorner
					Toggle["25"] = Instance.new("UICorner", Toggle["24"])
					Toggle["25"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.UIGradient
					Toggle["26"] = Instance.new("UIGradient", Toggle["24"])
					Toggle["26"]["Rotation"] = 90
					Toggle["26"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Toggle["26"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.Toggle
					Toggle["27"] = Instance.new("TextButton", Toggle["24"])
					Toggle["27"]["BorderSizePixel"] = 0
					Toggle["27"]["AutoButtonColor"] = false
					Toggle["27"]["TextSize"] = 14
					Toggle["27"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Toggle["27"]

					Toggle["27"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
					Toggle["27"]["Size"] = UDim2.new(0, 38, 0, 18)
					Toggle["27"]["Name"] = [[Toggle]]
					Toggle["27"]["Text"] = [[]]
					Toggle["27"]["Font"] = Enum.Font.SourceSans
					Toggle["27"]["Position"] = UDim2.new(0, 373, 0, 8)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.Toggle.UICorner
					Toggle["28"] = Instance.new("UICorner", Toggle["27"])
					Toggle["28"]["CornerRadius"] = UDim.new(2, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.Toggle.Indicator
					Toggle["2a"] = Instance.new("TextLabel", Toggle["27"])
					Toggle["2a"]["BackgroundColor3"] = Color3.fromRGB(177, 177, 177)
					Toggle["2a"]["TextSize"] = 14
					Toggle["2a"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
					Toggle["2a"]["Size"] = UDim2.new(0, 23, 0, 20)
					Toggle["2a"]["Text"] = [[]]
					Toggle["2a"]["Name"] = [[Indicator]]
					Toggle["2a"]["Font"] = Enum.Font.SourceSans
					Toggle["2a"]["Position"] = UDim2.new(0, 0, 0, -1)

					ThemeInstances["ThemeTrue"][#ThemeInstances["ThemeTrue"] + 1] = Toggle["2a"]

					Toggle["29"] = Instance.new("BoolValue", Toggle["2a"])
					Toggle["29"]["Name"] = [[ToggleVal]]
					Toggle["29"]["Value"] = options.Default

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.Toggle.Indicator.UICorner
					Toggle["2b"] = Instance.new("UICorner", Toggle["2a"])
					Toggle["2b"]["CornerRadius"] = UDim.new(1, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.Label
					Toggle["2d"] = Instance.new("TextLabel", Toggle["24"])
					Toggle["2d"]["BorderSizePixel"] = 0
					Toggle["2d"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Toggle["2d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Toggle["2d"]["TextSize"] = 13
					Toggle["2d"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Toggle["2d"]
					Toggle["2d"]["Size"] = UDim2.new(0, 301, 0, 33)
					Toggle["2d"]["Text"] = options.Name
					Toggle["2d"]["Name"] = [[Label]]
					Toggle["2d"]["Font"] = Enum.Font.GothamMedium
					Toggle["2d"]["BackgroundTransparency"] = 1
					Toggle["2d"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Toggle.UIStroke
					Toggle["2e"] = Instance.new("UIStroke", Toggle["24"])
					Toggle["2e"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Toggle["2e"]
				end

				table.insert(
					Toggle.Connections,
					Toggle["24"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				-- Handler
				do
					table.insert(
						Toggle.Connections,
						Toggle["24"].MouseEnter:Connect(function()
							Library:Tween(Toggle["2e"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})

							Library:PlaySound(LibSettings.HoverSound)
							Toggle.Hover = true
						end)
					)

					table.insert(
						Toggle.Connections,
						Toggle["24"].MouseLeave:Connect(function()
							Library:Tween(Toggle["2e"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})

							Toggle.Hover = false
						end)
					)

					table.insert(
						Toggle.Connections,
						UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
								Library:PlaySound(LibSettings.ClickSound)
								Library:Tween(Toggle["2e"], {
									Length = 0.2,
									Goal = { Color = Color3.fromRGB(86, 86, 86) },
								})

								Toggle:Set()
								task.wait(0.2)
								if Toggle.Hover then
									Library:Tween(Toggle["2e"], {
										Length = 0.2,
										Goal = { Color = ThemeColor.MainTrue },
									})
								else
									Library:Tween(Toggle["2e"], {
										Length = 0.2,
										Goal = { Color = ThemeColor.SecondaryTrue },
									})
								end
							end
						end)
					)
				end

				-- Methods
				do
					function Toggle:Destroy()
						table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Toggle.Connections))

						local TotalConnection = #Toggle.Connections
						local Disconnected = 0
						for i, v in next, Toggle.Connections do
							pcall(function()
								v:Disconnect()
								Disconnected = Disconnected + 1
							end)
						end

						Toggle["24"]:Destroy()
						print(
							"Removed toggle, "
								.. tostring(Disconnected)
								.. " connections out of "
								.. TotalConnection
								.. " were disconnected."
						)

						task.spawn(function()
							Library:ResizeSection(Section["1e"])
							Library:ResizeCanvas(Tab["1d"])
						end)
					end

					table.insert(ControlsConnectionBin, Toggle.Connections)

					function Toggle:Toggle(toggle)
						if toggle then
							Toggle.Bool = true
							Toggle["29"]["Value"] = true

							task.spawn(function()
								Library:Tween(Toggle["2a"], {
									Length = 0.2,
									Goal = { Position = UDim2.new(0, 15, 0, -1) },
								})

								Library:Tween(Toggle["2a"], {
									Length = 0.2,
									Goal = { BackgroundColor3 = ThemeColor.ThemeTrue },
								})
							end)
						else
							Toggle.Bool = false
							Toggle["29"]["Value"] = false

							task.spawn(function()
								Library:Tween(Toggle["2a"], {
									Length = 0.2,
									Goal = { Position = UDim2.new(0, 0, 0, -1) },
								})

								Library:Tween(Toggle["2a"], {
									Length = 0.2,
									Goal = { BackgroundColor3 = Color3.fromRGB(177, 177, 177) },
								})
							end)
						end

						task.spawn(function()
							options.Callback(Toggle.Bool)
						end)
					end

					function Toggle:Set(bool)
						if type(bool) == "boolean" then
							Toggle:Toggle(bool)
						else
							if Toggle.Bool then
								Toggle:Toggle(false)
							else
								Toggle:Toggle(true)
							end
						end
					end

					function Toggle:SetName(name)
						Toggle["2d"]["Text"] = name
					end
				end

				Toggle:Set(options.Default)

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				return Toggle
			end

			function Section:Slider(options)
				options = Library:PlaceDefaults({
					Name = "Slider",
					Max = 100,
					Min = 0,
					Default = 50,
					Callback = function()
						return
					end,
				}, options or {})

				local Slider = {
					Hover = false,
					OldVal = options.Default,
					TextboxHover = false,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider
					Slider["36"] = Instance.new("Frame", Section["21"])
					Slider["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Slider["36"]["Size"] = UDim2.new(0, 423, 0, 34)
					Slider["36"]["Position"] = UDim2.new(0, 17, 0, 104)
					Slider["36"]["Name"] = [[Slider]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.UICorner
					Slider["37"] = Instance.new("UICorner", Slider["36"])
					Slider["37"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.UIGradient
					Slider["38"] = Instance.new("UIGradient", Slider["36"])
					Slider["38"]["Rotation"] = 90
					Slider["38"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Slider["38"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.Label
					Slider["39"] = Instance.new("TextLabel", Slider["36"])
					Slider["39"]["BorderSizePixel"] = 0
					Slider["39"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Slider["39"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Slider["39"]["TextSize"] = 13
					Slider["39"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Slider["39"]
					Slider["39"]["Size"] = UDim2.new(0, 301, 0, 33)
					Slider["39"]["Text"] = options.Name
					Slider["39"]["Name"] = [[Label]]
					Slider["39"]["Font"] = Enum.Font.GothamMedium
					Slider["39"]["BackgroundTransparency"] = 1
					Slider["39"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.Slider
					Slider["3a"] = Instance.new("Frame", Slider["36"])
					Slider["3a"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Slider["3a"]

					Slider["3a"]["Size"] = UDim2.new(0, 136, 0, 10)
					Slider["3a"]["Position"] = UDim2.new(0, 229, 0, 12)
					Slider["3a"]["Name"] = [[Slider]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.Slider.UICorner
					Slider["3b"] = Instance.new("UICorner", Slider["3a"])
					Slider["3b"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.Slider.Sliderbackground
					Slider["3c"] = Instance.new("Frame", Slider["3a"])
					Slider["3c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Slider["3c"]["Size"] = UDim2.new(0.49264705181121826, 0, 0.9444444179534912, 0)
					Slider["3c"]["Name"] = [[Sliderbackground]]
					Slider["3c"]["BorderSizePixel"] = 0

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.Slider.Sliderbackground.UICorner
					Slider["3d"] = Instance.new("UICorner", Slider["3c"])
					Slider["3d"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.Slider.Sliderbackground.ThemeColorGradient
					Slider["3e"] = Instance.new("UIGradient", Slider["3c"])
					Slider["3e"]["Name"] = [[ThemeColorGradient]]
					Slider["3e"]["Rotation"] = 90
					Slider["3e"]["Color"] = ThemeColor.Theme

					ThemeInstances["Theme"][#ThemeInstances["Theme"] + 1] = Slider["3e"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.UIStroke
					Slider["40"] = Instance.new("UIStroke", Slider["36"])
					Slider["40"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Slider["40"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.TextBox
					Slider["3g"] = Instance.new("TextBox", Slider["36"])
					Slider["3g"]["CursorPosition"] = -1
					Slider["3g"]["PlaceholderColor3"] = ThemeColor.PlaceholderText

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Slider["3g"]

					Slider["3g"]["RichText"] = true
					Slider["3g"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Slider["3g"]
					Slider["3g"]["TextSize"] = 11
					Slider["3g"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Slider["3g"]

					Slider["3g"]["PlaceholderText"] = [[]]
					Slider["3g"]["Size"] = UDim2.new(0, 45, 0, 18)
					Slider["3g"]["Text"] = [[]]
					Slider["3g"]["Position"] = UDim2.new(0, 373, 0, 6)
					Slider["3g"]["Font"] = Enum.Font.Gotham
					Slider["3g"]["BorderSizePixel"] = 0

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Slider.TextBox
					Slider["41"] = Instance.new("UICorner", Slider["3g"])
					Slider["41"]["CornerRadius"] = UDim.new(0, 4)
				end

				table.insert(
					Slider.Connections,
					Slider["36"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				-- Handler
				do
					local MouseDown

					table.insert(
						Slider.Connections,
						Slider["36"].MouseEnter:Connect(function()
							Slider.Hover = true
							Library:PlaySound(LibSettings.HoverSound)

							Library:Tween(Slider["40"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})
						end)
					)

					table.insert(
						Slider.Connections,
						Slider["36"].MouseLeave:Connect(function()
							Slider.Hover = false

							Library:Tween(Slider["40"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})
						end)
					)

					table.insert(
						Slider.Connections,
						Slider["3g"].MouseEnter:Connect(function()
							Slider.TextboxHover = true
							Library:PlaySound(LibSettings.HoverSound)
						end)
					)

					table.insert(
						Slider.Connections,
						Slider["3g"].MouseLeave:Connect(function()
							Slider.TextboxHover = false
						end)
					)

					table.insert(
						Slider.Connections,
						Slider["3g"].Focused:Connect(function()
							Slider["3g"]["Text"] = [[]]

							Library.Sliding = true
							Library:PlaySound(LibSettings.ClickSound)
						end)
					)

					table.insert(
						Slider.Connections,
						Slider["3g"].FocusLost:Connect(function()
							local success = pcall(function()
								local NumVal = tonumber(Slider["3g"].Text)
								if NumVal <= options.Max and NumVal >= options.Min then
									Slider.OldVal = NumVal
									Slider:SetValue(NumVal)
								else
									Slider["3g"].Text = Slider.OldVal
								end
							end)

							if not success then
								Slider["3g"].Text = Slider.OldVal
							end

							Library.Sliding = false
						end)
					)

					table.insert(
						Slider.Connections,
						UserInputService.InputBegan:Connect(function(key)
							if
								key.UserInputType == Enum.UserInputType.MouseButton1
								and Slider.Hover
								and not Slider.TextboxHover
							then
								Library.Sliding = true
								MouseDown = true

								while RunService.RenderStepped:wait() and MouseDown do
									local percentage = math.clamp(
										(Mouse.X - Slider["3a"].AbsolutePosition.X) / Slider["3a"].AbsoluteSize.X,
										0,
										1
									)
									local Value = ((options.Max - options.Min) * percentage) + options.Min
									Value = math.floor(Value)

									if Value ~= Slider.OldVal then
										options.Callback(Value)
									end
									Slider.OldVal = Value
									Slider["3g"]["Text"] = Value

									Library:Tween(Slider["3c"], {
										Length = 0.06,
										Goal = {
											Size = UDim2.fromScale(
												((Value - options.Min) / (options.Max - options.Min)),
												1
											),
										},
									})
								end
								Library.Sliding = false
							end
						end)
					)

					table.insert(
						Slider.Connections,
						UserInputService.InputEnded:Connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								MouseDown = false
							end
						end)
					)
				end

				-- Methods
				do
					function Slider:SetValue(Value)
						Value = math.floor(Value)

						Library:Tween(Slider["3c"], {
							Length = 1,
							Goal = { Size = UDim2.fromScale(((Value - options.Min) / (options.Max - options.Min)), 1) },
						})

						Slider["3g"]["Text"] = Value
						Slider.OldVal = Value
						options.Callback(Value)
					end

					function Slider:SetName(name)
						Slider["39"]["Text"] = name
					end

					function Slider:Destroy()
						table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Slider.Connections))

						local TotalConnection = #Slider.Connections
						local Disconnected = 0
						for i, v in next, Slider.Connections do
							pcall(function()
								v:Disconnect()
								Disconnected = Disconnected + 1
							end)
						end

						Slider["36"]:Destroy()
						print(
							"Removed slider, "
								.. tostring(Disconnected)
								.. " connections out of "
								.. TotalConnection
								.. " were disconnected."
						)

						task.spawn(function()
							Library:ResizeSection(Section["1e"])
							Library:ResizeCanvas(Tab["1d"])
						end)
					end

					table.insert(ControlsConnectionBin, Slider.Connections)
				end

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				Slider:SetValue(options.Default)

				return Slider
			end

			function Section:Keybind(options)
				options = Library:PlaceDefaults({
					Name = "Keybind",
					Default = Enum.KeyCode.Return,
					Callback = function()
						return
					end,
					UpdateKeyCallback = function()
						return
					end,
				}, options or {})

				local Keybind = {
					Focused = false,
					Keybind = options.Default,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind
					Keybind["59"] = Instance.new("Frame", Section["21"])
					Keybind["59"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Keybind["59"]["Size"] = UDim2.new(0, 423, 0, 34)
					Keybind["59"]["Position"] = UDim2.new(0, 17, 0, 104)
					Keybind["59"]["Name"] = [[Keybind]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind.UICorner
					Keybind["5a"] = Instance.new("UICorner", Keybind["59"])
					Keybind["5a"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind.UIGradient
					Keybind["5b"] = Instance.new("UIGradient", Keybind["59"])
					Keybind["5b"]["Rotation"] = 90
					Keybind["5b"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Keybind["5b"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind.Label
					Keybind["5c"] = Instance.new("TextLabel", Keybind["59"])
					Keybind["5c"]["BorderSizePixel"] = 0
					Keybind["5c"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Keybind["5c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Keybind["5c"]["TextSize"] = 13
					Keybind["5c"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Keybind["5c"]
					Keybind["5c"]["Size"] = UDim2.new(0, 301, 0, 33)
					Keybind["5c"]["Text"] = options.Name
					Keybind["5c"]["Name"] = [[Label]]
					Keybind["5c"]["Font"] = Enum.Font.GothamMedium
					Keybind["5c"]["BackgroundTransparency"] = 1
					Keybind["5c"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind.TextButton
					Keybind["5d"] = Instance.new("TextButton", Keybind["59"])
					Keybind["5d"]["AutoButtonColor"] = false
					Keybind["5d"]["TextSize"] = 11
					Keybind["5d"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Keybind["5d"]

					Keybind["5d"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Keybind["5d"]
					Keybind["5d"]["Size"] = UDim2.new(0, 80, 0, 21)
					Keybind["5d"]["Text"] = [[]]
					Keybind["5d"]["Font"] = Enum.Font.Gotham
					Keybind["5d"]["Position"] = UDim2.new(0.7900000214576721, 0, 0.17599999904632568, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind.TextButton.UICorner
					Keybind["5e"] = Instance.new("UICorner", Keybind["5d"])
					Keybind["5e"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind.UIStroke
					Keybind["5g"] = Instance.new("UIStroke", Keybind["59"])
					Keybind["5g"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Keybind["5g"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Keybind.TextButton.TextLabel
					Keybind["60"] = Instance.new("TextLabel", Keybind["5d"])
					Keybind["60"]["BorderSizePixel"] = 0
					Keybind["60"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Keybind["60"]["TextSize"] = 10
					Keybind["60"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Keybind["60"]
					Keybind["60"]["Size"] = UDim2.new(0, 79, 0, 21)
					Keybind["60"]["Text"] = [[LeftShift]]
					Keybind["60"]["Font"] = Enum.Font.Gotham
					Keybind["60"]["BackgroundTransparency"] = 1

					local keybindText = string.gsub(tostring(Keybind.Keybind), "Enum.KeyCode.", "")

					Keybind["60"]["Text"] = keybindText
				end

				table.insert(
					Keybind.Connections,
					Keybind["59"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				-- Methods
				do
					table.insert(
						Keybind.Connections,
						Keybind["59"].MouseEnter:Connect(function()
							Library:Tween(Keybind["5g"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})

							Library:PlaySound(LibSettings.HoverSound)
						end)
					)

					table.insert(
						Keybind.Connections,
						Keybind["59"].MouseLeave:Connect(function()
							Library:Tween(Keybind["5g"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})
						end)
					)

					table.insert(
						Keybind.Connections,
						Keybind["5d"].MouseButton1Click:Connect(function()
							Library:PlaySound(LibSettings.ClickSound)
							Keybind.Focused = true

							Keybind["60"]["Text"] = "..."
						end)
					)

					table.insert(
						Keybind.Connections,
						UserInputService.InputBegan:Connect(function(input, GameProcess)
							if input.UserInputType == Enum.UserInputType.Keyboard then
								if input.KeyCode == Keybind.Keybind then
									pcall(function()
										options.Callback()
									end)
								end

								if Keybind.Focused then
									Keybind.Keybind = input.KeyCode
									local keybindText = string.gsub(tostring(Keybind.Keybind), "Enum.KeyCode.", "")
									Keybind["60"]["Text"] = keybindText
									pcall(function()
										options.UpdateKeyCallback(input.KeyCode)
									end)

									Keybind.Focused = false
								end
							end
						end)
					)

					-- Methods
					do
						function Keybind:SetName(name)
							Keybind["5c"]["Text"] = name
						end

						function Keybind:Destroy()
							table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Keybind.Connections))

							local TotalConnection = #Keybind.Connections
							local Disconnected = 0
							for i, v in next, Keybind.Connections do
								pcall(function()
									v:Disconnect()
									Disconnected = Disconnected + 1
								end)
							end

							Keybind["59"]:Destroy()
							print(
								"Removed keybind, "
									.. tostring(Disconnected)
									.. " connections out of "
									.. TotalConnection
									.. " were disconnected."
							)

							task.spawn(function()
								Library:ResizeSection(Section["1e"])
								Library:ResizeCanvas(Tab["1d"])
							end)
						end

						table.insert(ControlsConnectionBin, Keybind.Connections)
					end
				end

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				return Keybind
			end

			function Section:SmallTextbox(options)
				options = Library:PlaceDefaults({
					Name = "Small Textbox",
					Default = "Text",
					Callback = function()
						return
					end,
				}, options or {})

				local Textbox = {
					Hover = false,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1
					Textbox["2e"] = Instance.new("Frame", Section["21"])
					Textbox["2e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Textbox["2e"]["Size"] = UDim2.new(0, 423, 0, 34)
					Textbox["2e"]["Position"] = UDim2.new(0, 17, 0, 104)
					Textbox["2e"]["Name"] = [[Textbox1]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.UICorner
					Textbox["2f"] = Instance.new("UICorner", Textbox["2e"])
					Textbox["2f"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.UIGradient
					Textbox["30"] = Instance.new("UIGradient", Textbox["2e"])
					Textbox["30"]["Rotation"] = 90
					Textbox["30"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Textbox["30"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.Label
					Textbox["31"] = Instance.new("TextLabel", Textbox["2e"])
					Textbox["31"]["BorderSizePixel"] = 0
					Textbox["31"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Textbox["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Textbox["31"]["TextSize"] = 13
					Textbox["31"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Textbox["31"]
					Textbox["31"]["Size"] = UDim2.new(0, 301, 0, 33)
					Textbox["31"]["Text"] = options.Name
					Textbox["31"]["Name"] = [[Label]]
					Textbox["31"]["Font"] = Enum.Font.GothamMedium
					Textbox["31"]["BackgroundTransparency"] = 1
					Textbox["31"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.UIStroke
					Textbox["32"] = Instance.new("UIStroke", Textbox["2e"])
					Textbox["32"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Textbox["32"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.Frame
					Textbox["33"] = Instance.new("Frame", Textbox["2e"])
					Textbox["33"]["BorderSizePixel"] = 0
					Textbox["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Textbox["33"]["BackgroundTransparency"] = 1
					Textbox["33"]["Size"] = UDim2.new(0.9810874462127686, 0, 1, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.Frame.TextBox
					Textbox["34"] = Instance.new("TextBox", Textbox["33"])
					Textbox["34"]["PlaceholderColor3"] = ThemeColor.PlaceholderText

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Textbox["34"]

					Textbox["34"]["RichText"] = true
					Textbox["34"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Textbox["34"]
					Textbox["34"]["TextSize"] = 11
					Textbox["34"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Textbox["34"]

					Textbox["34"]["Size"] = UDim2.new(0, 92, 0, 21)
					Textbox["34"]["Text"] = [[]]
					Textbox["34"]["Position"] = UDim2.new(0.7612293362617493, 0, 0.1764705926179886, 0)
					Textbox["34"]["Font"] = Enum.Font.Gotham
					Textbox["34"]["TextWrapped"] = false
					Textbox["34"]["PlaceholderText"] = [[...]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.Frame.TextBox.UICorner
					Textbox["35"] = Instance.new("UICorner", Textbox["34"])
					Textbox["35"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.Frame.TextBox.UIGradient
					Textbox["36"] = Instance.new("UIGradient", Textbox["34"])
					Textbox["36"]["Color"] = ColorSequence.new({
						ColorSequenceKeypoint.new(0.000, Color3.fromRGB(75, 75, 75)),
						ColorSequenceKeypoint.new(1.000, Color3.fromRGB(99, 99, 99)),
					})

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox1.Frame.UIListLayout
					Textbox["37"] = Instance.new("UIListLayout", Textbox["33"])
					Textbox["37"]["VerticalAlignment"] = Enum.VerticalAlignment.Center
					Textbox["37"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right
					Textbox["37"]["SortOrder"] = Enum.SortOrder.LayoutOrder
				end

				table.insert(
					Textbox.Connections,
					Textbox["2e"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				-- Handler
				do
					table.insert(
						Textbox.Connections,
						Textbox["2e"].MouseEnter:Connect(function()
							Library:Tween(Textbox["32"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})

							Library:PlaySound(LibSettings.HoverSound)
						end)
					)

					table.insert(
						Textbox.Connections,
						Textbox["2e"].MouseLeave:Connect(function()
							Library:Tween(Textbox["32"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})
						end)
					)

					table.insert(
						Textbox.Connections,
						Textbox["34"].Focused:Connect(function()
							Library:PlaySound(LibSettings.ClickSound)
							Textbox["34"].Text = ""

							Library.Sliding = true
						end)
					)

					table.insert(
						Textbox.Connections,
						Textbox["34"].FocusLost:Connect(function()
							Library.Sliding = false

							task.spawn(function()
								options.Callback(Textbox["34"].Text)
							end)
						end)
					)

					table.insert(
						Textbox.Connections,
						Textbox["34"]:GetPropertyChangedSignal("Text"):Connect(function()
							if Textbox["34"].Text == "" then
								Library:Tween(Textbox["34"], {
									Length = 0.2,
									Goal = { Size = UDim2.new(0, 35, 0, 21) },
								})
							else
								local Bound = TextService:GetTextSize(
									Textbox["34"].Text,
									Textbox["34"].TextSize,
									Textbox["34"].Font,
									Vector2.new(Textbox["34"].AbsoluteSize.X, Textbox["34"].AbsoluteSize.Y)
								)

								Library:Tween(Textbox["34"], {
									Length = 0.2,
									Goal = { Size = UDim2.new(0, (Bound.X + 18), 0, 21) },
								})
							end
						end)
					)
				end

				-- Methods
				do
					function Textbox:SetText(Text)
						Textbox["34"].Text = Text
					end

					function Textbox:SetName(Name)
						Textbox["31"].Text = Name
					end

					function Textbox:Destroy()
						table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Textbox.Connections))

						local TotalConnection = #Textbox.Connections
						local Disconnected = 0
						for i, v in next, Textbox.Connections do
							pcall(function()
								v:Disconnect()
								Disconnected = Disconnected + 1
							end)
						end

						Textbox["2e"]:Destroy()
						print(
							"Removed textbox, "
								.. tostring(Disconnected)
								.. " connections out of "
								.. TotalConnection
								.. " were disconnected."
						)

						task.spawn(function()
							Library:ResizeSection(Section["1e"])
							Library:ResizeCanvas(Tab["1d"])
						end)
					end

					table.insert(ControlsConnectionBin, Textbox.Connections)
				end

				Textbox:SetText(options.Default)

				do
					if Textbox["34"].Text == "" then
						Library:Tween(Textbox["34"], {
							Length = 0.2,
							Goal = { Size = UDim2.new(0, 35, 0, 21) },
						})
					else
						local Bound = TextService:GetTextSize(
							Textbox["34"].Text,
							Textbox["34"].TextSize,
							Textbox["34"].Font,
							Vector2.new(Textbox["34"].AbsoluteSize.X, Textbox["34"].AbsoluteSize.Y)
						)

						Library:Tween(Textbox["34"], {
							Length = 0.2,
							Goal = { Size = UDim2.new(0, (Bound.X + 18), 0, 21) },
						})
					end
				end

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				return Textbox
			end

			function Section:BigTextbox(options)
				options = Library:PlaceDefaults({
					Name = "Big Textbox",
					Default = "",
					PlaceHolderText = "Placeholder | Text",
					ResetOnFocus = false,
					Callback = function()
						return
					end,
				}, options or {})

				local BigTextbox = {
					Hover = false,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2
					BigTextbox["66"] = Instance.new("Frame", Section["21"])
					BigTextbox["66"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					BigTextbox["66"]["Size"] = UDim2.new(0, 423, 0, 69)
					BigTextbox["66"]["Position"] = UDim2.new(0, 0, 0, 262)
					BigTextbox["66"]["Name"] = [[Textbox2]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.UICorner
					BigTextbox["67"] = Instance.new("UICorner", BigTextbox["66"])
					BigTextbox["67"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.UIGradient
					BigTextbox["68"] = Instance.new("UIGradient", BigTextbox["66"])
					BigTextbox["68"]["Rotation"] = 90
					BigTextbox["68"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = BigTextbox["68"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.Label
					BigTextbox["69"] = Instance.new("TextLabel", BigTextbox["66"])
					BigTextbox["69"]["BorderSizePixel"] = 0
					BigTextbox["69"]["TextXAlignment"] = Enum.TextXAlignment.Left
					BigTextbox["69"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					BigTextbox["69"]["TextSize"] = 13
					BigTextbox["69"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = BigTextbox["69"]
					BigTextbox["69"]["Size"] = UDim2.new(0, 301, 0, 33)
					BigTextbox["69"]["Text"] = options.Name
					BigTextbox["69"]["Name"] = [[Label]]
					BigTextbox["69"]["Font"] = Enum.Font.GothamMedium
					BigTextbox["69"]["BackgroundTransparency"] = 1
					BigTextbox["69"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.UIStroke
					BigTextbox["6a"] = Instance.new("UIStroke", BigTextbox["66"])
					BigTextbox["6a"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = BigTextbox["6a"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.Option 1
					BigTextbox["6b"] = Instance.new("Frame", BigTextbox["66"])
					BigTextbox["6b"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = BigTextbox["6b"]

					BigTextbox["6b"]["Size"] = UDim2.new(0, 407, 0, 27)
					BigTextbox["6b"]["Position"] = UDim2.new(0, 8, 0, 32)
					BigTextbox["6b"]["Name"] = [[Option 1]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.Option 1.UICorner
					BigTextbox["6c"] = Instance.new("UICorner", BigTextbox["6b"])
					BigTextbox["6c"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.Option 1.UIStroke
					BigTextbox["6d"] = Instance.new("UIStroke", BigTextbox["6b"])
					BigTextbox["6d"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = BigTextbox["6d"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.Option 1.TextBox
					BigTextbox["6f"] = Instance.new("TextBox", BigTextbox["6b"])
					BigTextbox["6f"]["PlaceholderColor3"] = ThemeColor.PlaceholderText

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = BigTextbox["6f"]

					BigTextbox["6f"]["RichText"] = true
					BigTextbox["6f"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = BigTextbox["6f"]
					BigTextbox["6f"]["TextXAlignment"] = Enum.TextXAlignment.Left
					BigTextbox["6f"]["TextSize"] = 11
					BigTextbox["6f"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = BigTextbox["6f"]

					BigTextbox["6f"]["PlaceholderText"] = options.PlaceHolderText
					BigTextbox["6f"]["Size"] = UDim2.new(0, 389, 0, 21)
					BigTextbox["6f"]["Text"] = [[]]
					BigTextbox["6f"]["Position"] = UDim2.new(0, 13, 0, 2)
					BigTextbox["6f"]["Font"] = Enum.Font.Gotham
					BigTextbox["6f"]["BackgroundTransparency"] = 1
					BigTextbox["6f"]["AutomaticSize"] = Enum.AutomaticSize.Y
					BigTextbox["6f"]["TextWrapped"] = true
					BigTextbox["6f"]["ClearTextOnFocus"] = false

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.Option 1.TextBox.UICorner
					BigTextbox["70"] = Instance.new("UICorner", BigTextbox["6f"])
					BigTextbox["70"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Textbox2.Open
					BigTextbox["71"] = Instance.new("ImageButton", BigTextbox["66"])
					BigTextbox["71"]["ScaleType"] = Enum.ScaleType.Crop
					BigTextbox["71"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					BigTextbox["71"]["Image"] = [[rbxassetid://11401860490]]
					BigTextbox["71"]["Size"] = UDim2.new(0, 23, 0, 18)
					BigTextbox["71"]["Name"] = [[Open]]
					BigTextbox["71"]["Position"] = UDim2.new(0, 390, 0, 7)
					BigTextbox["71"]["BackgroundTransparency"] = 1
				end

				table.insert(
					BigTextbox.Connections,
					BigTextbox["66"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				table.insert(
					BigTextbox.Connections,
					BigTextbox["6b"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:Tween(BigTextbox["66"], {
							Length = 0.2,
							Goal = { Size = UDim2.new(0, 423, 0, (BigTextbox["6b"].Size.Y.Offset + 42)) },
						})
					end)
				)

				-- Handler
				do
					table.insert(
						BigTextbox.Connections,
						BigTextbox["66"].MouseEnter:Connect(function()
							Library:Tween(BigTextbox["6a"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})

							Library:PlaySound(LibSettings.HoverSound)
						end)
					)

					table.insert(
						BigTextbox.Connections,
						BigTextbox["66"].MouseLeave:Connect(function()
							Library:Tween(BigTextbox["6a"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})
						end)
					)

					table.insert(
						BigTextbox.Connections,
						BigTextbox["6f"].Focused:Connect(function()
							Library:PlaySound(LibSettings.ClickSound)
							if options.ResetOnFocus then
								BigTextbox["6f"].Text = ""
							end

							Library.Sliding = true
						end)
					)

					table.insert(
						BigTextbox.Connections,
						BigTextbox["6f"].FocusLost:Connect(function()
							Library.Sliding = false

							task.spawn(function()
								options.Callback(BigTextbox["6f"].Text)
							end)

							local Val
							repeat
								Val = BigTextbox["6f"].TextBounds.Y

								Library:Tween(BigTextbox["6f"], {
									Length = 0.2,
									Goal = { Size = UDim2.new(0, 389, 0, (BigTextbox["6f"].TextBounds.Y + 10)) },
								})

								Library:Tween(BigTextbox["6b"], {
									Length = 0.2,
									Goal = { Size = UDim2.new(0, 407, 0, (BigTextbox["6f"].TextBounds.Y + 16)) },
								})

							until Val == BigTextbox["6f"].TextBounds.Y

							Library:Tween(BigTextbox["66"], {
								Length = 0.2,
								Goal = { Size = UDim2.new(0, 423, 0, (BigTextbox["6b"].Size.Y.Offset + 42)) },
							})
						end)
					)

					table.insert(
						BigTextbox.Connections,
						BigTextbox["6f"]:GetPropertyChangedSignal("Text"):Connect(function()
							local Val
							repeat
								Val = BigTextbox["6f"].TextBounds.Y
								BigTextbox["6f"].Size = UDim2.new(0, 389, 0, (BigTextbox["6f"].TextBounds.Y + 10))
								BigTextbox["6b"].Size = UDim2.new(0, 407, 0, (BigTextbox["6f"].TextBounds.Y + 16))
							until Val == BigTextbox["6f"].TextBounds.Y
						end)
					)
				end

				-- Methods
				do
					function BigTextbox:SetText(Text)
						BigTextbox["6f"].Text = Text
					end

					function BigTextbox:SetName(Name)
						BigTextbox["69"].Text = Name
					end

					function BigTextbox:Destroy()
						table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, BigTextbox.Connections))

						local TotalConnection = #BigTextbox.Connections
						local Disconnected = 0
						for i, v in next, BigTextbox.Connections do
							pcall(function()
								v:Disconnect()
								Disconnected = Disconnected + 1
							end)
						end

						BigTextbox["66"]:Destroy()
						print(
							"Removed bigTextbox, "
								.. tostring(Disconnected)
								.. " connections out of "
								.. TotalConnection
								.. " were disconnected."
						)

						task.spawn(function()
							Library:ResizeSection(Section["1e"])
							Library:ResizeCanvas(Tab["1d"])
						end)
					end

					table.insert(ControlsConnectionBin, BigTextbox.Connections)
				end

				BigTextbox:SetText(options.Default)

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				return BigTextbox
			end

			function Section:Dropdown(options)
				options = Library:PlaceDefaults({
					Name = "Dropdown",
					Items = {},
					Callback = function(item)
						return
					end,
				}, options or {})

				local Dropdown = {
					Items = options.Items,
					SelectedItem = nil,
					ContainerOpened = false,
					NameText = options.Name,
					Hover = false,
					SearchHover = false,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown
					Dropdown["46"] = Instance.new("Frame", Section["21"])
					Dropdown["46"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Dropdown["46"]["Size"] = UDim2.new(0, 423, 0, 34)
					Dropdown["46"]["ClipsDescendants"] = true
					Dropdown["46"]["Position"] = UDim2.new(0, 0, 0, 117)
					Dropdown["46"]["Name"] = [[Dropdown]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.UICorner
					Dropdown["47"] = Instance.new("UICorner", Dropdown["46"])
					Dropdown["47"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Label
					Dropdown["48"] = Instance.new("TextLabel", Dropdown["46"])
					Dropdown["48"]["BorderSizePixel"] = 0
					Dropdown["48"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Dropdown["48"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Dropdown["48"]["TextSize"] = 13
					Dropdown["48"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Dropdown["48"]
					Dropdown["48"]["Size"] = UDim2.new(0, 301, 0, 33)
					Dropdown["48"]["Text"] = options.Name
					Dropdown["48"]["Name"] = [[Label]]
					Dropdown["48"]["Font"] = Enum.Font.GothamMedium
					Dropdown["48"]["BackgroundTransparency"] = 1
					Dropdown["48"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Open
					Dropdown["49"] = Instance.new("ImageButton", Dropdown["46"])
					Dropdown["49"]["ScaleType"] = Enum.ScaleType.Crop
					Dropdown["49"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Dropdown["49"]["Image"] = [[rbxassetid://11400266375]]
					Dropdown["49"]["Size"] = UDim2.new(0, 14, 0, 10)
					Dropdown["49"]["Name"] = [[Open]]
					Dropdown["49"]["Position"] = UDim2.new(0, 397, 0, 10)
					Dropdown["49"]["BackgroundTransparency"] = 1

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.UIStroke
					Dropdown["4a"] = Instance.new("UIStroke", Dropdown["46"])
					Dropdown["4a"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Dropdown["4a"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Container
					Dropdown["4b"] = Instance.new("Frame", Dropdown["46"])
					Dropdown["4b"]["BorderSizePixel"] = 0
					Dropdown["4b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Dropdown["4b"]["BackgroundTransparency"] = 1
					Dropdown["4b"]["Size"] = UDim2.new(0, 423, 0, 72)
					Dropdown["4b"]["Position"] = UDim2.new(0, 0, 0, 59)
					Dropdown["4b"]["Name"] = [[Container]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Container.UIListLayout
					Dropdown["4c"] = Instance.new("UIListLayout", Dropdown["4b"])
					Dropdown["4c"]["Padding"] = UDim.new(0, 4)
					Dropdown["4c"]["SortOrder"] = Enum.SortOrder.LayoutOrder

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Container.UIPadding
					Dropdown["57"] = Instance.new("UIPadding", Dropdown["4b"])
					Dropdown["57"]["PaddingLeft"] = UDim.new(0, 8)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.UIGradient
					Dropdown["58"] = Instance.new("UIGradient", Dropdown["46"])
					Dropdown["58"]["Rotation"] = 90
					Dropdown["58"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Dropdown["58"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Frame
					Dropdown["59"] = Instance.new("Frame", Dropdown["46"])
					Dropdown["59"]["BorderSizePixel"] = 0
					Dropdown["59"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Dropdown["59"]["BackgroundTransparency"] = 1
					Dropdown["59"]["Size"] = UDim2.new(0, 390, 0, 34)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Frame.UIListLayout
					Dropdown["5a"] = Instance.new("UIListLayout", Dropdown["59"])
					Dropdown["5a"]["VerticalAlignment"] = Enum.VerticalAlignment.Center
					Dropdown["5a"]["FillDirection"] = Enum.FillDirection.Horizontal
					Dropdown["5a"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right
					Dropdown["5a"]["Padding"] = UDim.new(0, 8)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Frame.TextLabel
					Dropdown["5b"] = Instance.new("TextLabel", Dropdown["59"])
					Dropdown["5b"]["BorderSizePixel"] = 0
					Dropdown["5b"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Dropdown["5b"]

					Dropdown["5b"]["TextSize"] = 9
					Dropdown["5b"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Dropdown["5b"]
					Dropdown["5b"]["Size"] = UDim2.new(0, 50, 0, 15)
					Dropdown["5b"]["Font"] = Enum.Font.Gotham

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Frame.TextLabel.UICorner
					Dropdown["5c"] = Instance.new("UICorner", Dropdown["5b"])
					Dropdown["5c"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.TextBox
					Dropdown["5e"] = Instance.new("TextBox", Dropdown["46"])
					Dropdown["5e"]["CursorPosition"] = -1
					Dropdown["5e"]["PlaceholderColor3"] = ThemeColor.PlaceholderText

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Dropdown["5e"]

					Dropdown["5e"]["BorderSizePixel"] = 0
					Dropdown["5e"]["TextSize"] = 9
					Dropdown["5e"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Dropdown["5e"]["BackgroundColor3"] = ThemeColor.SecondaryTrue
					Dropdown["5e"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Dropdown["5e"]
					Dropdown["5e"]["FontFace"] = Font.new(
						[[rbxasset://fonts/families/GothamSSm.json]],
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					Dropdown["5e"]["PlaceholderText"] = [[ Search]]
					Dropdown["5e"]["Size"] = UDim2.new(0, 397, 0, 9)
					Dropdown["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
					Dropdown["5e"]["Text"] = [[]]
					Dropdown["5e"]["Position"] = UDim2.new(0, 13, 0, 38)

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Dropdown["5e"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.TextBox.UIStroke
					Dropdown["5f"] = Instance.new("UIStroke", Dropdown["5e"])
					Dropdown["5f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
					Dropdown["5f"]["Color"] = ThemeColor.SecondaryTrue
					Dropdown["5f"]["LineJoinMode"] = Enum.LineJoinMode.Round
					Dropdown["5f"]["Thickness"] = 7

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Dropdown["5f"]
				end

				table.insert(
					Dropdown.Connections,
					Dropdown["46"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				-- Handler
				do
					table.insert(
						Dropdown.Connections,
						Dropdown["46"].MouseEnter:Connect(function()
							Dropdown.Hover = true
							Library:PlaySound(LibSettings.HoverSound)

							Library:Tween(Dropdown["4a"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})
						end)
					)

					table.insert(
						Dropdown.Connections,
						Dropdown["46"].MouseLeave:Connect(function()
							Dropdown.Hover = false

							Library:Tween(Dropdown["4a"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})
						end)
					)

					table.insert(
						Dropdown.Connections,
						Dropdown["5e"].MouseEnter:Connect(function()
							Dropdown.SearchHover = true
						end)
					)

					table.insert(
						Dropdown.Connections,
						Dropdown["5e"].MouseLeave:Connect(function()
							Dropdown.SearchHover = false
						end)
					)

					table.insert(
						Dropdown.Connections,
						Dropdown["5e"]:GetPropertyChangedSignal("Text"):Connect(function()
							if Dropdown["5e"].Text == "" then
								for i, v in pairs(Dropdown["4b"]:GetChildren()) do
									if v:IsA("Frame") then
										v.Visible = true
									end
								end
							else
								for i, v in pairs(Dropdown["4b"]:GetChildren()) do
									if v:IsA("Frame") then
										if string.find(string.lower(v.Name), string.lower(Dropdown["5e"].Text)) then
											v.Visible = true
										else
											v.Visible = false
										end
									end
								end
							end

							Dropdown:ResizeContainer()
						end)
					)

					table.insert(
						Dropdown.Connections,
						UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.Hover then
								Library:PlaySound(LibSettings.ClickSound)
								Library:Tween(Dropdown["4a"], {
									Length = 0.2,
									Goal = { Color = Color3.fromRGB(86, 86, 86) },
								})

								if Dropdown.Hover then
									Library:Tween(Dropdown["4a"], {
										Length = 0.2,
										Goal = { Color = ThemeColor.MainTrue },
									})
								else
									Library:Tween(Dropdown["4a"], {
										Length = 0.2,
										Goal = { Color = ThemeColor.SecondaryTrue },
									})
								end

								do
									if Dropdown.ContainerOpened and not Dropdown.SearchHover then
										Dropdown.ContainerOpened = false

										Library:Tween(Dropdown["46"], {
											Length = 0.5,
											Goal = { Size = UDim2.fromOffset(423, 34) },
										})

										task.wait(0.7)
									else
										Dropdown.ContainerOpened = true

										do
											local NumChild = 0

											for i, v in pairs(Dropdown["4b"]:GetChildren()) do
												if v:IsA("Frame") and v.Visible == true then
													NumChild = NumChild + 1
												end
											end

											local FrameYOffset = 27 * NumChild + 4 * NumChild + 38 + 23

											Library:Tween(Dropdown["46"], {
												Length = 0.5,
												Goal = { Size = UDim2.fromOffset(423, FrameYOffset) },
											})
										end
									end

									task.wait(0.7)
								end
							end
						end)
					)
				end

				-- Methods
				do
					function Dropdown:ResizeContainer()
						if Dropdown.ContainerOpened then
							local NumChild = 0

							for i, v in pairs(Dropdown["4b"]:GetChildren()) do
								if v:IsA("Frame") and v.Visible == true then
									NumChild = NumChild + 1
								end
							end

							local FrameYOffset = 27 * NumChild + 4 * NumChild + 38 + 23

							Library:Tween(Dropdown["46"], {
								Length = 0.5,
								Goal = { Size = UDim2.fromOffset(423, FrameYOffset) },
							})
						end
					end

					function Dropdown:AddItem(value)
						local DropdownOption = {
							Hover = false,
							CallbackVal = value,
						}

						do
							-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Container.Option 1
							DropdownOption["4d"] = Instance.new("Frame", Dropdown["4b"])
							DropdownOption["4d"]["BackgroundColor3"] = ThemeColor.Textbox

							ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = DropdownOption["4d"]

							DropdownOption["4d"]["Size"] = UDim2.new(0, 407, 0, 27)
							DropdownOption["4d"]["Position"] = UDim2.new(0, 7, 0, 22)
							DropdownOption["4d"]["Name"] = tostring(DropdownOption.CallbackVal)
							DropdownOption["4d"]["Visible"] = true

							-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Container.Option 1.UICorner
							DropdownOption["4e"] = Instance.new("UICorner", DropdownOption["4d"])
							DropdownOption["4e"]["CornerRadius"] = UDim.new(0, 4)

							-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Container.Option 1.Label
							DropdownOption["4f"] = Instance.new("TextLabel", DropdownOption["4d"])
							DropdownOption["4f"]["BorderSizePixel"] = 0
							DropdownOption["4f"]["TextXAlignment"] = Enum.TextXAlignment.Left
							DropdownOption["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
							DropdownOption["4f"]["TextSize"] = 13
							DropdownOption["4f"]["TextColor3"] = ThemeColor.Text

							ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = DropdownOption["4f"]
							DropdownOption["4f"]["Size"] = UDim2.new(0, 301, 0, 33)
							DropdownOption["4f"]["Text"] = tostring(value)
							DropdownOption["4f"]["Name"] = [[Label]]
							DropdownOption["4f"]["Font"] = Enum.Font.GothamMedium
							DropdownOption["4f"]["BackgroundTransparency"] = 1
							DropdownOption["4f"]["Position"] = UDim2.new(0, 14, 0, -3)

							-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Dropdown.Container.Option 1.UIStroke
							DropdownOption["50"] = Instance.new("UIStroke", DropdownOption["4d"])
							DropdownOption["50"]["Color"] = ThemeColor.MainTrue

							ThemeInstances["MainTrue"][#ThemeInstances["MainTrue"] + 1] = DropdownOption["50"]
						end

						table.insert(
							ConnectionBin,
							DropdownOption["4d"].MouseEnter:Connect(function()
								DropdownOption.Hover = true
								Library:PlaySound(LibSettings.HoverSound)

								Library:Tween(DropdownOption["50"], {
									Length = 0.5,
									Goal = { Color = ThemeColor.SecondaryTrue },
								})
							end)
						)

						table.insert(
							ConnectionBin,
							DropdownOption["4d"].MouseLeave:Connect(function()
								DropdownOption.Hover = false

								Library:Tween(DropdownOption["50"], {
									Length = 0.5,
									Goal = { Color = ThemeColor.MainTrue },
								})
							end)
						)

						table.insert(
							ConnectionBin,
							UserInputService.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and DropdownOption.Hover then
									Library:PlaySound(LibSettings.ClickSound)
									Library:Tween(DropdownOption["50"], {
										Length = 0.2,
										Goal = { Color = Color3.fromRGB(86, 86, 86) },
									})

									task.spawn(function()
										options.Callback(DropdownOption.CallbackVal)
									end)

									if DropdownOption.Hover then
										Library:Tween(DropdownOption["50"], {
											Length = 0.2,
											Goal = { Color = ThemeColor.MainTrue },
										})
									else
										Library:Tween(DropdownOption["50"], {
											Length = 0.2,
											Goal = { Color = ThemeColor.SecondaryTrue },
										})
									end

									Dropdown.SelectedItem = DropdownOption.CallbackVal
									Dropdown["5b"].Text = tostring(Dropdown.SelectedItem)

									local Val
									repeat
										Val = Dropdown["5b"].TextBounds.X

										Library:Tween(Dropdown["5b"], {
											Length = 0.2,
											Goal = {
												Size = UDim2.new(0, (Dropdown["5b"].TextBounds.X + 14), 0, 21),
											},
										})
									until Val == Dropdown["5b"].TextBounds.X

									Library:Tween(Dropdown["5b"], {
										Length = 0.2,
										Goal = { Size = UDim2.new(0, (Dropdown["5b"].TextBounds.X + 14), 0, 21) },
									})
								end
							end)
						)

						if Dropdown.SelectedItem == nil then
							Dropdown.SelectedItem = DropdownOption.CallbackVal
							Dropdown["5b"].Text = tostring(Dropdown.SelectedItem)

							local Val
							repeat
								Val = Dropdown["5b"].TextBounds.X

								Library:Tween(Dropdown["5b"], {
									Length = 0.2,
									Goal = {
										Size = UDim2.new(0, (Dropdown["5b"].TextBounds.X + 14), 0, 21),
									},
								})
							until Val == Dropdown["5b"].TextBounds.X

							Library:Tween(Dropdown["5b"], {
								Length = 0.2,
								Goal = { Size = UDim2.new(0, (Dropdown["5b"].TextBounds.X + 14), 0, 21) },
							})
						end

						Dropdown:ResizeContainer()
					end

					function Dropdown:Clear()
						for i, v in pairs(Dropdown["4b"]:GetChildren()) do
							if v:IsA("Frame") then
								v:Destroy()
							end
						end

						local FrameYOffset = 34 + 4

						Dropdown:ResizeContainer()
					end

					function Dropdown:UpdateList(options)
						options = Library:PlaceDefaults({
							Items = {},
							Replace = true,
						}, options or {})

						if options.Replace then
							for i, v in pairs(Dropdown["4b"]:GetChildren()) do
								if v:IsA("Frame") then
									v:Destroy()
								end
							end
						end

						for i, v in pairs(options.Items) do
							Dropdown:AddItem(v)
						end
					end
				end

				do
					task.spawn(function()
						for i, v in pairs(options.Items) do
							Dropdown:AddItem(v)
						end
					end)
				end

				function Dropdown:Destroy()
					table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Dropdown.Connections))

					local TotalConnection = #Dropdown.Connections
					local Disconnected = 0
					for i, v in next, Dropdown.Connections do
						pcall(function()
							v:Disconnect()
							Disconnected = Disconnected + 1
						end)
					end

					Dropdown["46"]:Destroy()
					print(
						"Removed dropdown, "
							.. tostring(Disconnected)
							.. " connections out of "
							.. TotalConnection
							.. " were disconnected."
					)

					task.spawn(function()
						Library:ResizeSection(Section["1e"])
						Library:ResizeCanvas(Tab["1d"])
					end)
				end

				table.insert(ControlsConnectionBin, Dropdown.Connections)

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				return Dropdown
			end

			function Section:Label(options)
				options = Library:PlaceDefaults({
					Name = "Label",
				}, options or {})

				local Label = {
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Label
					Label["78"] = Instance.new("Frame", Section["21"])
					Label["78"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Label["78"]["Size"] = UDim2.new(0, 423, 0, 34)
					Label["78"]["Position"] = UDim2.new(0, 17, 0, 22)
					Label["78"]["Name"] = [[Label]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Label.UICorner
					Label["79"] = Instance.new("UICorner", Label["78"])
					Label["79"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Label.UIGradient
					Label["7a"] = Instance.new("UIGradient", Label["78"])
					Label["7a"]["Rotation"] = 90
					Label["7a"]["Color"] = ThemeColor.Tertiary

					ThemeInstances["Tertiary"][#ThemeInstances["Tertiary"] + 1] = Label["7a"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Label.Label
					Label["7b"] = Instance.new("TextLabel", Label["78"])
					Label["7b"]["RichText"] = true
					Label["7b"]["BorderSizePixel"] = 0
					Label["7b"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Label["7b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Label["7b"]["TextSize"] = 13
					Label["7b"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Label["7b"]
					Label["7b"]["Name"] = "Label"
					Label["7b"]["Text"] = options.Name
					Label["7b"]["Font"] = Enum.Font.GothamMedium
					Label["7b"]["BackgroundTransparency"] = 1
					Label["7b"]["Position"] = UDim2.new(0, 21, 0, 0)
					Label["7b"]["TextWrapped"] = true

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Label.UIStroke
					Label["7c"] = Instance.new("UIStroke", Label["78"])
					Label["7c"]["Color"] = ThemeColor.MainTrue

					ThemeInstances["MainTrue"][#ThemeInstances["MainTrue"] + 1] = Label["7c"]
				end

				table.insert(
					Label.Connections,
					Label["78"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				-- Methods
				do
					function Label:SetName(name)
						Label["7b"]["Text"] = name

						local Val
						repeat
							Val = Label["7b"].TextBounds.Y

							Label["78"]["Size"] = UDim2.new(0, 423, 0, Label["7b"].TextBounds.Y + 21)
							Label["7b"]["Size"] = UDim2.new(0, 398, 0, Label["7b"].TextBounds.Y + 21)
						until Val == Label["7b"].TextBounds.Y
					end

					function Label:Destroy()
						table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Label.Connections))

						local TotalConnection = #Label.Connections
						local Disconnected = 0
						for i, v in next, Label.Connections do
							pcall(function()
								v:Disconnect()
								Disconnected = Disconnected + 1
							end)
						end

						Label["78"]:Destroy()
						print(
							"Removed label, "
								.. tostring(Disconnected)
								.. " connections out of "
								.. TotalConnection
								.. " were disconnected."
						)

						task.spawn(function()
							Library:ResizeSection(Section["1e"])
							Library:ResizeCanvas(Tab["1d"])
						end)
					end

					table.insert(ControlsConnectionBin, Label.Connections)
				end

				task.spawn(function()
					local Val
					repeat
						Val = Label["7b"].TextBounds.Y

						Label["78"]["Size"] = UDim2.new(0, 423, 0, Label["7b"].TextBounds.Y + 21)
						Label["7b"]["Size"] = UDim2.new(0, 398, 0, Label["7b"].TextBounds.Y + 21)
					until Val == Label["7b"].TextBounds.Y
				end)

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)

				return Label
			end

			function Section:Colorpicker(options)
				options = Library:PlaceDefaults({
					Name = "Colorpicker",
					DefaultColor = Color3.new(1, 1, 1),
					Callback = function()
						return
					end,
				}, options or {})

				local Colorpicker = {
					ColorH = 1,
					ColorS = 1,
					ColorV = 1,
					Toggled = false,
					OldVal = nil,
					Connections = {},
				}

				do
					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker
					Colorpicker["7d"] = Instance.new("Frame", Section["21"])
					Colorpicker["7d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["7d"]["Size"] = UDim2.new(0, 423, 0, 34)
					Colorpicker["7d"]["ClipsDescendants"] = true
					Colorpicker["7d"]["BorderColor3"] = Color3.fromRGB(28, 43, 54)
					Colorpicker["7d"]["Position"] = UDim2.new(0, 0, 1.1666666269302368, 0)
					Colorpicker["7d"]["Name"] = [[Colorpicker]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.UICorner
					Colorpicker["7e"] = Instance.new("UICorner", Colorpicker["7d"])
					Colorpicker["7e"]["CornerRadius"] = UDim.new(0, 5)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.UIStroke
					Colorpicker["4a"] = Instance.new("UIStroke", Colorpicker["7d"])
					Colorpicker["4a"]["Color"] = ThemeColor.SecondaryTrue

					ThemeInstances["SecondaryTrue"][#ThemeInstances["SecondaryTrue"] + 1] = Colorpicker["4a"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Hue
					Colorpicker["7f"] = Instance.new("ImageLabel", Colorpicker["7d"])
					Colorpicker["7f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["7f"]["AnchorPoint"] = Vector2.new(0.5, 0)
					Colorpicker["7f"]["Size"] = UDim2.new(0, 14, 0, 148)
					Colorpicker["7f"]["Name"] = [[Hue]]
					Colorpicker["7f"]["Position"] = UDim2.new(0, 369, 0, 38)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Hue.HueCorner
					Colorpicker["80"] = Instance.new("UICorner", Colorpicker["7f"])
					Colorpicker["80"]["Name"] = [[HueCorner]]
					Colorpicker["80"]["CornerRadius"] = UDim.new(0, 3)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Hue.HueGradient
					Colorpicker["81"] = Instance.new("UIGradient", Colorpicker["7f"])
					Colorpicker["81"]["Name"] = [[HueGradient]]
					Colorpicker["81"]["Rotation"] = 270
					Colorpicker["81"]["Color"] = ColorSequence.new({
						ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 0, 5)),
						ColorSequenceKeypoint.new(0.087, Color3.fromRGB(239, 0, 255)),
						ColorSequenceKeypoint.new(0.230, Color3.fromRGB(18, 0, 255)),
						ColorSequenceKeypoint.new(0.443, Color3.fromRGB(3, 176, 255)),
						ColorSequenceKeypoint.new(0.582, Color3.fromRGB(167, 255, 0)),
						ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 26, 26)),
					})

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Hue.Frame
					Colorpicker["82"] = Instance.new("Frame", Colorpicker["7f"])
					Colorpicker["82"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["82"]["Size"] = UDim2.new(0, 25, 0, 5)
					Colorpicker["82"]["Position"] = UDim2.new(-0.3571428656578064, 0, 0.8500000238418579, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Hue.Frame.UICorner
					Colorpicker["83"] = Instance.new("UICorner", Colorpicker["82"])
					Colorpicker["83"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Color
					Colorpicker["84"] = Instance.new("ImageLabel", Colorpicker["7d"])
					Colorpicker["84"]["ZIndex"] = 10
					Colorpicker["84"]["BackgroundColor3"] = Color3.fromRGB(255, 4, 8)
					Colorpicker["84"]["AnchorPoint"] = Vector2.new(0.5, 0)
					Colorpicker["84"]["Image"] = [[rbxassetid://4155801252]]
					Colorpicker["84"]["Size"] = UDim2.new(0, 300, 0, 148)
					Colorpicker["84"]["Name"] = [[Color]]
					Colorpicker["84"]["Position"] = UDim2.new(0, 195, 0, 38)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Color.ColorCorner
					Colorpicker["85"] = Instance.new("UICorner", Colorpicker["84"])
					Colorpicker["85"]["Name"] = [[ColorCorner]]
					Colorpicker["85"]["CornerRadius"] = UDim.new(0, 3)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Color.ColorSelection
					Colorpicker["86"] = Instance.new("ImageLabel", Colorpicker["84"])
					Colorpicker["86"]["BorderSizePixel"] = 0
					Colorpicker["86"]["ScaleType"] = Enum.ScaleType.Fit
					Colorpicker["86"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["86"]["BorderMode"] = Enum.BorderMode.Inset
					Colorpicker["86"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
					Colorpicker["86"]["Image"] = [[http://www.roblox.com/asset/?id=4805639000]]
					Colorpicker["86"]["Size"] = UDim2.new(0, 18, 0, 18)
					Colorpicker["86"]["Name"] = [[ColorSelection]]
					Colorpicker["86"]["BackgroundTransparency"] = 1
					Colorpicker["86"]["Position"] = UDim2.new(0.8784236311912537, 0, 0.16129031777381897, 0)
					Colorpicker["86"]["ImageTransparency"] = 1

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.UIGradient
					Colorpicker["87"] = Instance.new("UIGradient", Colorpicker["7d"])
					Colorpicker["87"]["Rotation"] = 90
					Colorpicker["87"]["Color"] = ThemeColor.Main

					ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Colorpicker["87"]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Box
					Colorpicker["88"] = Instance.new("Frame", Colorpicker["7d"])
					Colorpicker["88"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
					Colorpicker["88"]["AnchorPoint"] = Vector2.new(1, 0.5)
					Colorpicker["88"]["Size"] = UDim2.new(0, 21, 0, 21)
					Colorpicker["88"]["Position"] = UDim2.new(0, 412, 0, 16)
					Colorpicker["88"]["Name"] = [[Box]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Box.UICorner
					Colorpicker["89"] = Instance.new("UICorner", Colorpicker["88"])
					Colorpicker["89"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.Label
					Colorpicker["8a"] = Instance.new("TextLabel", Colorpicker["7d"])
					Colorpicker["8a"]["BorderSizePixel"] = 0
					Colorpicker["8a"]["TextXAlignment"] = Enum.TextXAlignment.Left
					Colorpicker["8a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["8a"]["TextSize"] = 13
					Colorpicker["8a"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["8a"]
					Colorpicker["8a"]["Size"] = UDim2.new(0, 301, 0, 33)
					Colorpicker["8a"]["Text"] = options.Name
					Colorpicker["8a"]["Name"] = [[Label]]
					Colorpicker["8a"]["Font"] = Enum.Font.GothamMedium
					Colorpicker["8a"]["BackgroundTransparency"] = 1
					Colorpicker["8a"]["Position"] = UDim2.new(0, 21, 0, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder
					Colorpicker["8b"] = Instance.new("Frame", Colorpicker["7d"])
					Colorpicker["8b"]["BorderSizePixel"] = 0
					Colorpicker["8b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["8b"]["BackgroundTransparency"] = 1
					Colorpicker["8b"]["Size"] = UDim2.new(0, 400, 0, 36)
					Colorpicker["8b"]["Position"] = UDim2.new(0, 10, 0, 192)
					Colorpicker["8b"]["Name"] = [[HSVHolder]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Hue
					Colorpicker["8c"] = Instance.new("Frame", Colorpicker["8b"])
					Colorpicker["8c"]["BorderSizePixel"] = 0
					Colorpicker["8c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["8c"]["BackgroundTransparency"] = 1
					Colorpicker["8c"]["Size"] = UDim2.new(0, 91, 0, 37)
					Colorpicker["8c"]["Name"] = [[Hue]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Hue.TextLabel
					Colorpicker["8d"] = Instance.new("TextLabel", Colorpicker["8c"])
					Colorpicker["8d"]["TextWrapped"] = true
					Colorpicker["8d"]["BorderSizePixel"] = 0
					Colorpicker["8d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["8d"]["TextSize"] = 11
					Colorpicker["8d"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["8d"]
					Colorpicker["8d"]["Size"] = UDim2.new(0, 45, 0, 25)
					Colorpicker["8d"]["BorderColor3"] = Color3.fromRGB(28, 43, 54)
					Colorpicker["8d"]["Text"] = [[Hue]]
					Colorpicker["8d"]["Font"] = Enum.Font.Gotham
					Colorpicker["8d"]["BackgroundTransparency"] = 1
					Colorpicker["8d"]["Position"] = UDim2.new(-0.0012891516089439392, 0, 0.13513514399528503, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Hue.TextBox
					Colorpicker["8e"] = Instance.new("TextBox", Colorpicker["8c"])
					Colorpicker["8e"]["ZIndex"] = 5
					Colorpicker["8e"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["8e"]
					Colorpicker["8e"]["TextWrapped"] = true
					Colorpicker["8e"]["TextSize"] = 11
					Colorpicker["8e"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Colorpicker["8e"]

					Colorpicker["8e"]["Size"] = UDim2.new(0, 42, 0, 18)
					Colorpicker["8e"]["Text"] = [[256]]
					Colorpicker["8e"]["Position"] = UDim2.new(0.4914590120315552, 0, 0.25, 0)
					Colorpicker["8e"]["Font"] = Enum.Font.Gotham

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Red.TextBox.UICorner
					Colorpicker["8f"] = Instance.new("UICorner", Colorpicker["8e"])
					Colorpicker["8f"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.UIListLayout
					Colorpicker["90"] = Instance.new("UIListLayout", Colorpicker["8b"])
					Colorpicker["90"]["FillDirection"] = Enum.FillDirection.Horizontal
					Colorpicker["90"]["SortOrder"] = Enum.SortOrder.LayoutOrder

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Sat
					Colorpicker["91"] = Instance.new("Frame", Colorpicker["8b"])
					Colorpicker["91"]["BorderSizePixel"] = 0
					Colorpicker["91"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["91"]["BackgroundTransparency"] = 1
					Colorpicker["91"]["Size"] = UDim2.new(0, 91, 0, 37)
					Colorpicker["91"]["Name"] = [[Sat]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Sat.TextLabel
					Colorpicker["92"] = Instance.new("TextLabel", Colorpicker["91"])
					Colorpicker["92"]["TextWrapped"] = true
					Colorpicker["92"]["BorderSizePixel"] = 0
					Colorpicker["92"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["92"]["TextSize"] = 11
					Colorpicker["92"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["92"]
					Colorpicker["92"]["Size"] = UDim2.new(0, 45, 0, 25)
					Colorpicker["92"]["BorderColor3"] = Color3.fromRGB(28, 43, 54)
					Colorpicker["92"]["Text"] = [[Sat]]
					Colorpicker["92"]["Font"] = Enum.Font.Gotham
					Colorpicker["92"]["BackgroundTransparency"] = 1
					Colorpicker["92"]["Position"] = UDim2.new(-0.0012891516089439392, 0, 0.13513514399528503, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Sat.TextBox
					Colorpicker["93"] = Instance.new("TextBox", Colorpicker["91"])
					Colorpicker["93"]["ZIndex"] = 5
					Colorpicker["93"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["93"]
					Colorpicker["93"]["TextWrapped"] = true
					Colorpicker["93"]["TextSize"] = 11
					Colorpicker["93"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Colorpicker["93"]

					Colorpicker["93"]["Size"] = UDim2.new(0, 42, 0, 18)
					Colorpicker["93"]["Text"] = [[256]]
					Colorpicker["93"]["Position"] = UDim2.new(0.4914590120315552, 0, 0.25, 0)
					Colorpicker["93"]["Font"] = Enum.Font.Gotham

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Sat.TextBox.UICorner
					Colorpicker["94"] = Instance.new("UICorner", Colorpicker["93"])
					Colorpicker["94"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Value
					Colorpicker["95"] = Instance.new("Frame", Colorpicker["8b"])
					Colorpicker["95"]["BorderSizePixel"] = 0
					Colorpicker["95"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["95"]["BackgroundTransparency"] = 1
					Colorpicker["95"]["Size"] = UDim2.new(0, 91, 0, 37)
					Colorpicker["95"]["Name"] = [[Value]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Value.TextLabel
					Colorpicker["96"] = Instance.new("TextLabel", Colorpicker["95"])
					Colorpicker["96"]["TextWrapped"] = true
					Colorpicker["96"]["BorderSizePixel"] = 0
					Colorpicker["96"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["96"]["TextSize"] = 11
					Colorpicker["96"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["96"]
					Colorpicker["96"]["Size"] = UDim2.new(0, 45, 0, 25)
					Colorpicker["96"]["BorderColor3"] = Color3.fromRGB(28, 43, 54)
					Colorpicker["96"]["Text"] = [[Value]]
					Colorpicker["96"]["Font"] = Enum.Font.Gotham
					Colorpicker["96"]["BackgroundTransparency"] = 1
					Colorpicker["96"]["Position"] = UDim2.new(-0.0012891516089439392, 0, 0.13513514399528503, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Value.TextBox
					Colorpicker["97"] = Instance.new("TextBox", Colorpicker["95"])
					Colorpicker["97"]["ZIndex"] = 5
					Colorpicker["97"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["97"]
					Colorpicker["97"]["TextWrapped"] = true
					Colorpicker["97"]["TextSize"] = 11
					Colorpicker["97"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Colorpicker["97"]

					Colorpicker["97"]["Size"] = UDim2.new(0, 42, 0, 18)
					Colorpicker["97"]["Text"] = [[256]]
					Colorpicker["97"]["Position"] = UDim2.new(0.4914590120315552, 0, 0.25, 0)
					Colorpicker["97"]["Font"] = Enum.Font.Gotham

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HSVHolder.Value.TextBox.UICorner
					Colorpicker["98"] = Instance.new("UICorner", Colorpicker["97"])
					Colorpicker["98"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HexTextbox
					Colorpicker["99"] = Instance.new("Frame", Colorpicker["7d"])
					Colorpicker["99"]["ZIndex"] = 5
					Colorpicker["99"]["BorderSizePixel"] = 0
					Colorpicker["99"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["99"]["BackgroundTransparency"] = 1
					Colorpicker["99"]["Size"] = UDim2.new(0, 91, 0, 37)
					Colorpicker["99"]["Position"] = UDim2.new(0, 300, 0, 192)
					Colorpicker["99"]["Name"] = [[HexTextbox]]

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HexTextbox.TextLabel
					Colorpicker["9a"] = Instance.new("TextLabel", Colorpicker["99"])
					Colorpicker["9a"]["TextWrapped"] = true
					Colorpicker["9a"]["BorderSizePixel"] = 0
					Colorpicker["9a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["9a"]["TextSize"] = 11
					Colorpicker["9a"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["9a"]
					Colorpicker["9a"]["Size"] = UDim2.new(0, 64, 0, 25)
					Colorpicker["9a"]["BorderColor3"] = Color3.fromRGB(28, 43, 54)
					Colorpicker["9a"]["Text"] = [[Hex Code]]
					Colorpicker["9a"]["Font"] = Enum.Font.Gotham
					Colorpicker["9a"]["BackgroundTransparency"] = 1
					Colorpicker["9a"]["Position"] = UDim2.new(-0.14590352773666382, 0, 0.13513512909412384, 0)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HexTextbox.TextBox
					Colorpicker["9b"] = Instance.new("TextBox", Colorpicker["99"])
					Colorpicker["9b"]["CursorPosition"] = -1
					Colorpicker["9b"]["ZIndex"] = 5
					Colorpicker["9b"]["TextColor3"] = ThemeColor.Text

					ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Colorpicker["9b"]
					Colorpicker["9b"]["TextWrapped"] = true
					Colorpicker["9b"]["TextSize"] = 11
					Colorpicker["9b"]["BackgroundColor3"] = ThemeColor.Textbox

					ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Colorpicker["9b"]

					Colorpicker["9b"]["Size"] = UDim2.new(0, 63, 0, 18)
					Colorpicker["9b"]["Text"] = [[#f1eaff]]
					Colorpicker["9b"]["Position"] = UDim2.new(0.5354151725769043, 0, 0.25, 0)
					Colorpicker["9b"]["Font"] = Enum.Font.Gotham

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.HexTextbox.TextBox.UICorner
					Colorpicker["9c"] = Instance.new("UICorner", Colorpicker["9b"])
					Colorpicker["9c"]["CornerRadius"] = UDim.new(0, 4)

					-- StarterGui.Vision Lib v2.GuiFrame.MainFrame.Container.SectionFrame.SectionContainer.Colorpicker.ToggleDetector
					Colorpicker["9d"] = Instance.new("TextButton", Colorpicker["7d"])
					Colorpicker["9d"]["TextSize"] = 14
					Colorpicker["9d"]["TextTransparency"] = 1
					Colorpicker["9d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
					Colorpicker["9d"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
					Colorpicker["9d"]["Size"] = UDim2.new(0, 423, 0, 34)
					Colorpicker["9d"]["Name"] = [[ToggleDetector]]
					Colorpicker["9d"]["Font"] = Enum.Font.SourceSans
					Colorpicker["9d"]["BackgroundTransparency"] = 1
				end

				table.insert(
					Colorpicker.Connections,
					Colorpicker["7d"]:GetPropertyChangedSignal("Size"):Connect(function()
						Library:ResizeSection(Section["1e"])
					end)
				)

				-- Methods
				do
					function Colorpicker:UpdateColorPicker()
						Library:Tween(Colorpicker["88"], {
							Length = 0.5,
							Goal = {
								BackgroundColor3 = Color3.fromHSV(
									Colorpicker.ColorH,
									Colorpicker.ColorS,
									Colorpicker.ColorV
								),
							},
						})

						Library:Tween(Colorpicker["84"], {
							Length = 0.5,
							Goal = { BackgroundColor3 = Color3.fromHSV(Colorpicker.ColorH, 1, 1) },
						})
						pcall(function()
							if
								Colorpicker.OldVal
								~= Color3.fromHSV(Colorpicker.ColorH, Colorpicker.ColorS, Colorpicker.ColorV)
							then
								options.Callback(
									Color3.fromHSV(Colorpicker.ColorH, Colorpicker.ColorS, Colorpicker.ColorV)
								)
							end
						end)
						Colorpicker.OldVal = Color3.fromHSV(Colorpicker.ColorH, Colorpicker.ColorS, Colorpicker.ColorV)
						Colorpicker:updateTextboxVal()
					end

					function Colorpicker:SetColor(Color)
						local H, S, V = Color:ToHSV()
						Colorpicker.ColorH = H
						Colorpicker.ColorS = S
						Colorpicker.ColorV = V

						Library:Tween(Colorpicker["82"], {
							Length = 0.5,
							Goal = { Position = UDim2.new(-0.357, 0, H, 0) },
						})

						local VisualColorY = 1 - Colorpicker.ColorV

						Library:Tween(Colorpicker["86"], {
							Length = 0.5,
							Goal = { Position = UDim2.new(Colorpicker.ColorS, 0, VisualColorY, 0) },
						})
						Colorpicker:UpdateColorPicker()
					end

					function Colorpicker:updateTextboxVal()
						Colorpicker["8e"]["Text"] = math.floor(Colorpicker.ColorH * 256)
						Colorpicker["93"]["Text"] = math.floor(Colorpicker.ColorS * 256)
						Colorpicker["97"]["Text"] = math.floor(Colorpicker.ColorV * 256)

						Colorpicker["9b"].Text = Colorpicker.OldVal:ToHex()
					end

					function Colorpicker:Destroy()
						table.remove(ControlsConnectionBin, table.find(ControlsConnectionBin, Colorpicker.Connections))

						local TotalConnection = #Colorpicker.Connections
						local Disconnected = 0
						for i, v in next, Colorpicker.Connections do
							pcall(function()
								v:Disconnect()
								Disconnected = Disconnected + 1
							end)
						end

						Colorpicker["7d"]:Destroy()
						print(
							"Removed colorpicker, "
								.. tostring(Disconnected)
								.. " connections out of "
								.. TotalConnection
								.. " were disconnected."
						)

						task.spawn(function()
							Library:ResizeSection(Section["1e"])
							Library:ResizeCanvas(Tab["1d"])
						end)
					end
				end

				-- Handler
				do
					table.insert(
						Colorpicker.Connections,
						Colorpicker["7d"].MouseEnter:Connect(function()
							Library:Tween(Colorpicker["4a"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.MainTrue },
							})

							Library:PlaySound(LibSettings.HoverSound)
						end)
					)

					table.insert(
						Colorpicker.Connections,
						Colorpicker["7d"].MouseLeave:Connect(function()
							Library:Tween(Colorpicker["4a"], {
								Length = 0.5,
								Goal = { Color = ThemeColor.SecondaryTrue },
							})
						end)
					)

					Colorpicker.ColorH = 1
						- (
							1
							- math.clamp(
									Colorpicker["82"].AbsolutePosition.Y - Colorpicker["7f"].AbsolutePosition.Y,
									0,
									Colorpicker["7f"].AbsoluteSize.Y
								)
								/ Colorpicker["7f"].AbsoluteSize.Y
						)
					Colorpicker.ColorS = (
						math.clamp(
							Colorpicker["86"].AbsolutePosition.X - Colorpicker["84"].AbsolutePosition.X,
							0,
							Colorpicker["84"].AbsoluteSize.X
						) / Colorpicker["84"].AbsoluteSize.X
					)
					Colorpicker.ColorV = 1
						- (
							math.clamp(
								Colorpicker["86"].AbsolutePosition.Y - Colorpicker["84"].AbsolutePosition.Y,
								0,
								Colorpicker["84"].AbsoluteSize.Y
							) / Colorpicker["84"].AbsoluteSize.Y
						)

					table.insert(
						Colorpicker.Connections,
						Colorpicker["9d"].MouseButton1Click:Connect(function()
							Library:PlaySound(LibSettings.ClickSound)
							Colorpicker.Toggled = not Colorpicker.Toggled

							if Colorpicker.Toggled then
								Library:Tween(Colorpicker["86"], {
									Length = 0.5,
									Goal = { ImageTransparency = 0 },
								})

								Library:Tween(Colorpicker["7d"], {
									Length = 0.5,
									Goal = { Size = UDim2.fromOffset(423, 231) },
								})
							else
								Library:Tween(Colorpicker["86"], {
									Length = 0.5,
									Goal = { ImageTransparency = 1 },
								})

								Library:Tween(Colorpicker["7d"], {
									Length = 0.5,
									Goal = { Size = UDim2.fromOffset(423, 35) },
								})
							end
						end)
					)

					local SelectingColor

					table.insert(
						Colorpicker.Connections,
						Colorpicker["84"].InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								Library:PlaySound(LibSettings.ClickSound)

								if SelectingColor then
									SelectingColor:Disconnect()
								end

								Library.Sliding = true
								SelectingColor = RunService.RenderStepped:Connect(function()
									local ColorX = (
										math.clamp(
											Mouse.X - Colorpicker["84"].AbsolutePosition.X,
											0,
											Colorpicker["84"].AbsoluteSize.X
										) / Colorpicker["84"].AbsoluteSize.X
									)
									local ColorY = (
										math.clamp(
											Mouse.Y - Colorpicker["84"].AbsolutePosition.Y,
											0,
											Colorpicker["84"].AbsoluteSize.Y
										) / Colorpicker["84"].AbsoluteSize.Y
									)
									Colorpicker["86"].Position = UDim2.new(ColorX, 0, ColorY, 0)
									Colorpicker.ColorS = ColorX
									Colorpicker.ColorV = 1 - ColorY
									Colorpicker:UpdateColorPicker()
								end)
							end
						end)
					)

					table.insert(
						Colorpicker.Connections,
						Colorpicker["84"].InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								Library:PlaySound(LibSettings.ClickSound)

								if SelectingColor then
									SelectingColor:Disconnect()
								end
								Library.Sliding = false
							end
						end)
					)

					local SelectingHue

					table.insert(
						Colorpicker.Connections,
						Colorpicker["7f"].InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								Library:PlaySound(LibSettings.ClickSound)

								if SelectingHue then
									SelectingHue:Disconnect()
								end

								Library.Sliding = true
								SelectingHue = RunService.RenderStepped:Connect(function()
									local HueY = (
										1
										- math.clamp(
												Mouse.Y - Colorpicker["7f"].AbsolutePosition.Y,
												0,
												Colorpicker["7f"].AbsoluteSize.Y
											)
											/ Colorpicker["7f"].AbsoluteSize.Y
									)
									local VisualHueY = (
										math.clamp(
											Mouse.Y - Colorpicker["7f"].AbsolutePosition.Y,
											0,
											Colorpicker["7f"].AbsoluteSize.Y
										) / Colorpicker["7f"].AbsoluteSize.Y
									)

									Colorpicker["82"].Position = UDim2.new(-0.357, 0, VisualHueY, 0)
									Colorpicker.ColorH = 1 - HueY

									Colorpicker:UpdateColorPicker()
								end)
							end
						end)
					)

					table.insert(
						Colorpicker.Connections,
						Colorpicker["7f"].InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								Library:PlaySound(LibSettings.ClickSound)

								if SelectingHue then
									SelectingHue:Disconnect()
								end
								Library.Sliding = false
							end
						end)
					)

					local function checkHex(hex)
						local success, result = pcall(function()
							return Color3.fromHex(hex)
						end)

						return success
					end

					local function checkValidHSV(hsv)
						if hsv >= 0 and hsv <= 1 then
							return true
						else
							return false
						end
					end

					table.insert(
						Colorpicker.Connections,
						Colorpicker["9b"].FocusLost:Connect(function()
							local HexCode = Colorpicker["9b"].Text
							local isHex = checkHex(HexCode)
							if isHex then
								Colorpicker:SetColor(Color3.fromHex(HexCode))
							else
								Colorpicker:updateTextboxVal()
							end
						end)
					)

					table.insert(
						Colorpicker.Connections,
						Colorpicker["8e"].FocusLost:Connect(function()
							local numVal
							local success = pcall(function()
								local ColorCode = tonumber(Colorpicker["8e"].Text)
								ColorCode = ColorCode / 256
								local valid = checkValidHSV(ColorCode)

								if valid then
									Colorpicker:SetColor(
										Color3.fromHSV(ColorCode, Colorpicker.ColorS, Colorpicker.ColorV)
									)
								else
									Colorpicker:updateTextboxVal()
								end
							end)

							if not success then
								Colorpicker:updateTextboxVal()
							end
						end)
					)

					table.insert(
						Colorpicker.Connections,
						Colorpicker["93"].FocusLost:Connect(function()
							local numVal
							local success = pcall(function()
								local ColorCode = tonumber(Colorpicker["93"].Text)
								ColorCode = ColorCode / 256
								local valid = checkValidHSV(ColorCode)

								if valid then
									Colorpicker:SetColor(
										Color3.fromHSV(Colorpicker.ColorH, ColorCode, Colorpicker.ColorV)
									)
								else
									Colorpicker:updateTextboxVal()
								end
							end)

							if not success then
								Colorpicker:updateTextboxVal()
							end
						end)
					)

					table.insert(
						Colorpicker.Connections,
						Colorpicker["97"].FocusLost:Connect(function()
							local numVal
							local success = pcall(function()
								local ColorCode = tonumber(Colorpicker["97"].Text)
								ColorCode = ColorCode / 256
								local valid = checkValidHSV(ColorCode)

								if valid then
									Colorpicker:SetColor(
										Color3.fromHSV(Colorpicker.ColorH, Colorpicker.ColorS, ColorCode)
									)
								else
									Colorpicker:updateTextboxVal()
								end
							end)

							if not success then
								Colorpicker:updateTextboxVal()
							end
						end)
					)

					table.insert(ControlsConnectionBin, Colorpicker.Connections)
				end

				Colorpicker:SetColor(options.DefaultColor)

				task.spawn(function()
					Library:ResizeSection(Section["1e"])
					Library:ResizeCanvas(Tab["1d"])
				end)
				return Colorpicker
			end

			--[[
			function Section:Template(options)
				options = Library:PlaceDefaults({
					Name = "Template",
					Callback = function() return end
				}, options or {})

				local Template = {
					Hover = false
				}

				do
				end

				-- Handler
				do
				end

				-- Methods
				do
					
				end

				return Template
			end
			]]
			--

			return Section
		end

		-- Handler
		do
			local ToolTip

			table.insert(
				ConnectionBin,
				Tab["8"].MouseEnter:Connect(function()
					Library:PlaySound(LibSettings.HoverSound)
					ToolTip = Library:ToolTip(options.Name)
					Tab.Hover = true

					local tweeninfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
					local tween = TweenService:Create(Tab["a"], tweeninfo, { Rotation = 180 })
					tween:Play()

					tween.Completed:Wait()

					repeat
						local rot = Tab["a"].Rotation + 45

						if rot == 405 then
							rot = 45
						end

						local tweeninfo = TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
						local tween = TweenService:Create(Tab["a"], tweeninfo, { Rotation = rot })
						tween:Play()

						tween.Completed:Wait()

						if Tab["a"].Rotation == 360 then
							Tab["a"].Rotation = 0
						end
					until Tab.Hover == false
				end)
			)

			table.insert(
				ConnectionBin,
				Tab["8"].MouseLeave:Connect(function()
					ToolTip:Destroy()

					Library:Tween(Tab["a"], {
						Length = 0.3,
						Goal = { Rotation = 45 },
					})

					Tab.Hover = false
				end)
			)

			table.insert(
				ConnectionBin,
				UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and Tab.Hover then
						Library:PlaySound(LibSettings.ClickSound)
						if Gui.CurrentTab == Tab and not Gui.Hidden then
							Library:Tween(Gui["18"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 0, 0, 452) },
							})

							Library:Tween(Gui["18"], {
								Length = 0.3,
								Goal = { Size = UDim2.new(0, 498, 0, 0) },
							})

							Gui.Hidden = true
						else
							Library:Tween(Gui["18"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 0, 0, 0) },
							})

							Library:Tween(Gui["18"], {
								Length = 0.3,
								Goal = { Size = UDim2.new(0, 498, 0, 452) },
							})

							Gui.Hidden = false
						end

						Tab:Activate()
					end
				end)
			)

			function Tab:Activate()
				if not Tab.Active then
					if Gui.CurrentTab ~= nil then
						Gui.CurrentTab:Deactivate(Tab.Index)
					end

					task.spawn(function()
						options.ActivationCallback()
					end)

					task.spawn(function()
						local Color = options.Color
						local h, s, v = Color:ToHSV()
						local NewV = v - 0.75
						if NewV < 0 then
							NewV = 0
						end

						local p0 = Color3.fromHSV(h, s, v)
						local p1 = Color3.fromHSV(h, s, NewV)

						local defaultP0 = Instance.new("Color3Value")
						defaultP0.Value = Color3.fromRGB(125, 125, 125)

						local defaultP1 = Instance.new("Color3Value")
						defaultP1.Value = Color3.fromRGB(31, 31, 31)

						Library:Tween(defaultP0, {
							Length = 0.5,
							Goal = { Value = p0 },
						})

						local TweenCompleted = false

						Library:Tween(defaultP1, {
							Length = 0.5,
							Goal = { Value = p1 },
						}, function()
							TweenCompleted = true
						end)

						repeat
							Tab["a"]["Color"] = ColorSequence.new({
								ColorSequenceKeypoint.new(0, defaultP0.Value),
								ColorSequenceKeypoint.new(1, defaultP1.Value),
							})
							RunService.RenderStepped:Wait()
						until TweenCompleted
					end)

					Tab.Active = true

					task.spawn(function()
						while Tab.Active do
							local rot = Tab["a"].Rotation + 45

							if rot == 405 then
								rot = 45
							end

							local tweeninfo = TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
							local tween = TweenService:Create(Tab["a"], tweeninfo, { Rotation = rot })
							tween:Play()

							tween.Completed:Wait()

							if Tab["a"].Rotation == 360 then
								Tab["a"].Rotation = 0
							end
						end
					end)

					if Gui.CurrentTabIndex < Tab.Index then
						task.spawn(function()
							task.wait(0.3)
							Gui["1c"]["Text"] = options.Name
							Gui["1c"]["Position"] = UDim2.new(0, 498, 0, 5)
							Tab["1d"]["Position"] = UDim2.new(0, 498, 0, 35)
							Tab["1d"]["Visible"] = true

							Library:Tween(Gui["1c"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 14, 0, 5) },
							})

							Library:Tween(Tab["1d"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 0, 0, 35) },
							})
						end)
					else
						task.spawn(function()
							task.wait(0.3)
							Gui["1c"]["Text"] = options.Name
							Gui["1c"]["Position"] = UDim2.new(0, -498, 0, 5)
							Tab["1d"]["Position"] = UDim2.new(0, -498, 0, 35)
							Tab["1d"]["Visible"] = true

							Library:Tween(Gui["1c"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 14, 0, 5) },
							})

							Library:Tween(Tab["1d"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 0, 0, 35) },
							})
						end)
					end

					Gui.CurrentTabIndex = Tab.Index
					Gui.CurrentTab = Tab
				end
			end

			function Tab:Deactivate(newtabindex)
				if Tab.Active then
					Tab.Active = false

					task.spawn(function()
						options.DeativationCallback()
					end)

					task.spawn(function()
						local Color = options.Color
						local h, s, v = Color:ToHSV()
						local NewV = v - 0.75
						if NewV < 0 then
							NewV = 0
						end

						local p0 = Color3.fromHSV(h, s, v)
						local p1 = Color3.fromHSV(h, s, NewV)

						local defaultP0 = Instance.new("Color3Value")
						defaultP0.Value = p0

						local defaultP1 = Instance.new("Color3Value")
						defaultP1.Value = p1

						Library:Tween(defaultP0, {
							Length = 0.5,
							Goal = { Value = Color3.fromRGB(125, 125, 125) },
						})

						local TweenCompleted = false

						Library:Tween(defaultP1, {
							Length = 0.5,
							Goal = { Value = Color3.fromRGB(31, 31, 31) },
						}, function()
							TweenCompleted = true
						end)

						repeat
							Tab["a"]["Color"] = ColorSequence.new({
								ColorSequenceKeypoint.new(0, defaultP0.Value),
								ColorSequenceKeypoint.new(1, defaultP1.Value),
							})
							RunService.RenderStepped:Wait()
						until TweenCompleted
					end)

					if Gui.CurrentTabIndex < newtabindex then
						task.spawn(function()
							Library:Tween(Gui["1c"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, -498, 0, 5) },
							})

							Library:Tween(Tab["1d"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, -498, 0, 35) },
							})

							task.wait(0.3)
							Tab["1d"]["Visible"] = false
						end)
					else
						task.spawn(function()
							Library:Tween(Gui["1c"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 498, 0, 5) },
							})

							Library:Tween(Tab["1d"], {
								Length = 0.3,
								Goal = { Position = UDim2.new(0, 498, 0, 35) },
							})

							task.wait(0.3)
							Tab["1d"]["Visible"] = false
						end)
					end
				end
			end

			if Gui.CurrentTab == nil then
				Tab:Activate()
			end
		end

		Library:ResizeTabCanvas()

		return Tab
	end

	-- Handler
	do
		table.insert(
			ConnectionBin,
			UserInputService.InputBegan:Connect(function(input)
				if Library.MainFrameHover then
					if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library.Sliding then
						local ObjectPosition =
							Vector2.new(Mouse.X - Gui["2"].AbsolutePosition.X, Mouse.Y - Gui["2"].AbsolutePosition.Y)

						while
							RunService.RenderStepped:wait()
							and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
						do
							if not Library.Sliding then
								Library:Tween(Gui["2"], {
									Goal = {
										Position = UDim2.fromOffset(
											Mouse.X
												- ObjectPosition.X
												+ (Gui["2"].Size.X.Offset * Gui["2"].AnchorPoint.X),
											Mouse.Y
												- ObjectPosition.Y
												+ (Gui["2"].Size.Y.Offset * Gui["2"].AnchorPoint.Y)
										),
									},
									Style = Enum.EasingStyle.Linear,
									Direction = Enum.EasingDirection.InOut,
									Length = LibSettings.DragSpeed,
								})
							end
						end
					end
				end
			end)
		)

		table.insert(
			ConnectionBin,
			Gui["2"].MouseEnter:Connect(function()
				Library.MainFrameHover = true
			end)
		)

		table.insert(
			ConnectionBin,
			Gui["2"].MouseLeave:Connect(function()
				Library.MainFrameHover = false
			end)
		)
	end

	-- Nav Clock
	do
		task.spawn(function()
			while wait() do
				local t = tick()
				local sec = math.floor(t % 60)
				local min = math.floor((t / 60) % 60)
				local hour = math.floor((t / 3600) % 24)

				if string.len(sec) < 2 then
					sec = "0" .. tostring(sec)
				end

				if string.len(min) < 2 then
					min = "0" .. tostring(min)
				end

				if string.len(hour) < 2 then
					hour = "0" .. tostring(hour)
				end

				Gui["5"]["Text"] = hour .. ":" .. min .. ":" .. sec
			end
		end)
	end

	-- Toggle Handler
	function Gui:Toggled(bool)
		if not Library.Loaded then
			return
		end

		Gui.TweeningToggle = true
		if bool == nil then
			if Gui["2"].Visible then
				Library:Tween(Gui["2"], {
					Length = 1,
					Goal = { Size = UDim2.new(0, 498, 0, 0) },
				})

				task.wait(1)
				Gui["2"].Visible = false
			else
				Gui["2"].Visible = true
				Library:Tween(Gui["2"], {
					Length = 1,
					Goal = { Size = UDim2.new(0, 498, 0, 496) },
				})

				task.wait(1)
			end
		elseif bool then
			Gui["2"].Visible = true
			Library:Tween(Gui["2"], {
				Length = 1,
				Goal = { Size = UDim2.new(0, 498, 0, 496) },
			})

			task.wait(1)
		elseif not bool then
			Library:Tween(Gui["2"], {
				Length = 1,
				Goal = { Size = UDim2.new(0, 498, 0, 0) },
			})

			task.wait(1)
			Gui["2"].Visible = false
		end

		Gui.TweeningToggle = false
	end

	function Gui:TaskBarOnly(bool)
		if bool then
			Library:Tween(Gui["18"], {
				Length = 0.3,
				Goal = { Position = UDim2.new(0, 0, 0, 452) },
			})

			Library:Tween(Gui["18"], {
				Length = 0.3,
				Goal = { Size = UDim2.new(0, 498, 0, 0) },
			})

			Gui.Hidden = true
		else
			Library:Tween(Gui["18"], {
				Length = 0.3,
				Goal = { Position = UDim2.new(0, 0, 0, 0) },
			})

			Library:Tween(Gui["18"], {
				Length = 0.3,
				Goal = { Size = UDim2.new(0, 498, 0, 452) },
			})

			Gui.Hidden = false
		end
	end

	do
		table.insert(
			ConnectionBin,
			UserInputService.InputBegan:Connect(function(input)
				if input.KeyCode == Gui.ToggleKey then
					if not Gui.TweeningToggle then
						Gui:Toggled()
					end
				end
			end)
		)
	end

	function Gui:ChangeTogglekey(key)
		Gui.ToggleKey = key
	end

	return Gui
end

function Library:Notify(options)
	options = Library:PlaceDefaults({
		Name = "Ring Ring",
		Text = "Notification!!",
		Icon = "rbxassetid://11401835376",
		Sound = "rbxassetid://6647898215",
		Duration = 5,
		Callback = function()
			return
		end,
	}, options or {})

	local Notification = {}

	do
		-- StarterGui.Vision Lib v2.NotifFrame.Notif
		Notification["84"] = Instance.new("Frame", LibFrame["81"])
		Notification["84"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["84"]["Size"] = UDim2.new(0, 257, 0, 0)
		Notification["84"]["ClipsDescendants"] = true
		Notification["84"]["Position"] = UDim2.new(0, -41, 0, 0)
		Notification["84"]["Name"] = [[Notif]]
		Notification["84"]["ClipsDescendants"] = true
		Notification["84"]["BorderSizePixel"] = 0

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.UICorner
		Notification["85"] = Instance.new("UICorner", Notification["84"])
		Notification["85"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.ImageLabel
		Notification["86"] = Instance.new("ImageLabel", Notification["84"])
		Notification["86"]["BorderSizePixel"] = 0
		Notification["86"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["86"]["Image"] = options.Icon
		Notification["86"]["Size"] = UDim2.new(0, 18, 0, 16)
		Notification["86"]["BackgroundTransparency"] = 1
		Notification["86"]["Position"] = UDim2.new(0, 10, 0, 5)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.ImageLabel.ThemeColorGradient
		Notification["87"] = Instance.new("UIGradient", Notification["86"])
		Notification["87"]["Name"] = [[ThemeColorGradient]]
		Notification["87"]["Rotation"] = 90
		Notification["87"]["Color"] = ThemeColor.Theme

		ThemeInstances["Theme"][#ThemeInstances["Theme"] + 1] = Notification["87"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.NotifName
		Notification["88"] = Instance.new("TextLabel", Notification["84"])
		Notification["88"]["BorderSizePixel"] = 0
		Notification["88"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Notification["88"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["88"]["TextSize"] = 12
		Notification["88"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Notification["88"]
		Notification["88"]["Size"] = UDim2.new(0, 206, 0, 21)
		Notification["88"]["Text"] = options.Name
		Notification["88"]["Name"] = [[NotifName]]
		Notification["88"]["Font"] = Enum.Font.GothamMedium
		Notification["88"]["BackgroundTransparency"] = 1
		Notification["88"]["Position"] = UDim2.new(0, 34, 0, 3)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.NotifName.ThemeColorGradient
		Notification["89"] = Instance.new("UIGradient", Notification["88"])
		Notification["89"]["Name"] = [[ThemeColorGradient]]
		Notification["89"]["Rotation"] = 90
		Notification["89"]["Color"] = ThemeColor.Theme

		ThemeInstances["Theme"][#ThemeInstances["Theme"] + 1] = Notification["89"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.NotifText
		Notification["8a"] = Instance.new("TextLabel", Notification["84"])
		Notification["8a"]["TextWrapped"] = true
		Notification["8a"]["BorderSizePixel"] = 0
		Notification["8a"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Notification["8a"]["TextYAlignment"] = Enum.TextYAlignment.Top
		Notification["8a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["8a"]["TextSize"] = 10
		Notification["8a"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Notification["8a"]
		Notification["8a"]["Size"] = UDim2.new(0, 242, 0, 28)
		Notification["8a"]["Text"] = options.Text
		Notification["8a"]["Name"] = [[NotifText]]
		Notification["8a"]["Font"] = Enum.Font.GothamMedium
		Notification["8a"]["BackgroundTransparency"] = 1
		Notification["8a"]["Position"] = UDim2.new(0, 10, 0, 23)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack
		Notification["8b"] = Instance.new("Frame", Notification["84"])
		Notification["8b"]["BorderSizePixel"] = 0
		Notification["8b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["8b"]["Size"] = UDim2.new(0, 239, 0, 5)
		Notification["8b"]["Position"] = UDim2.new(0.03501945361495018, 0, 0.7903226017951965, 0)
		Notification["8b"]["Name"] = [[TimeBarBack]]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack.Frame
		Notification["8c"] = Instance.new("Frame", Notification["8b"])
		Notification["8c"]["BorderSizePixel"] = 0
		Notification["8c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["8c"]["Size"] = UDim2.new(0.5, 0, 1, 0)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack.Frame.ThemeColorGradient
		Notification["8d"] = Instance.new("UIGradient", Notification["8c"])
		Notification["8d"]["Name"] = [[ThemeColorGradient]]
		Notification["8d"]["Rotation"] = 90
		Notification["8d"]["Color"] = ThemeColor.Theme

		ThemeInstances["Theme"][#ThemeInstances["Theme"] + 1] = Notification["8d"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack.UIGradient
		Notification["8e"] = Instance.new("UIGradient", Notification["8b"])
		Notification["8e"]["Rotation"] = 90
		Notification["8e"]["Color"] = ThemeColor.Tertiary

		ThemeInstances["Tertiary"][#ThemeInstances["Tertiary"] + 1] = Notification["8e"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.UIGradient
		Notification["8f"] = Instance.new("UIGradient", Notification["84"])
		Notification["8f"]["Rotation"] = 90
		Notification["8f"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Notification["8f"]
	end

	do
		task.spawn(function()
			repeat
				task.wait()
			until Library.Loaded

			local Completed = false

			Library:PlaySound(options.Sound)

			Library:Tween(Notification["84"], {
				Length = 0.5,
				Goal = { Size = UDim2.new(0, 257, 0, 62) },
			})

			Library:Tween(Notification["8c"], {
				Length = options.Duration,
				Style = Enum.EasingStyle.Linear,
				Goal = { Size = UDim2.new(1, 0, 1, 0) },
			}, function()
				Completed = true
			end)

			repeat
				task.wait()
			until Completed

			local Completed = false

			Library:Tween(Notification["84"], {
				Length = 0.5,
				Goal = { Size = UDim2.new(0, 257, 0, 0) },
			}, function()
				Completed = true
			end)

			repeat
				task.wait()
			until Completed

			options.Callback()
			Notification["84"]:Destroy()
		end)
	end
end

function Library:ForceNotify(options)
	options = Library:PlaceDefaults({
		Name = "Ring Ring",
		Text = "Notification!!",
		Icon = "rbxassetid://11401835376",
		Sound = "rbxassetid://6647898215",
		Duration = 5,
		Callback = function()
			return
		end,
	}, options or {})

	local Notification = {}

	do
		-- StarterGui.Vision Lib v2.NotifFrame.Notif
		Notification["84"] = Instance.new("Frame", LibFrame["81"])
		Notification["84"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["84"]["Size"] = UDim2.new(0, 257, 0, 0)
		Notification["84"]["ClipsDescendants"] = true
		Notification["84"]["Position"] = UDim2.new(0, -41, 0, 0)
		Notification["84"]["Name"] = [[Notif]]
		Notification["84"]["ClipsDescendants"] = true
		Notification["84"]["BorderSizePixel"] = 0

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.UICorner
		Notification["85"] = Instance.new("UICorner", Notification["84"])
		Notification["85"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.ImageLabel
		Notification["86"] = Instance.new("ImageLabel", Notification["84"])
		Notification["86"]["BorderSizePixel"] = 0
		Notification["86"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["86"]["Image"] = options.Icon
		Notification["86"]["Size"] = UDim2.new(0, 18, 0, 16)
		Notification["86"]["BackgroundTransparency"] = 1
		Notification["86"]["Position"] = UDim2.new(0, 10, 0, 5)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.ImageLabel.ThemeColorGradient
		Notification["87"] = Instance.new("UIGradient", Notification["86"])
		Notification["87"]["Name"] = [[ThemeColorGradient]]
		Notification["87"]["Rotation"] = 90
		Notification["87"]["Color"] = ThemeColor.Theme

		ThemeInstances["Theme"][#ThemeInstances["Theme"] + 1] = Notification["87"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.NotifName
		Notification["88"] = Instance.new("TextLabel", Notification["84"])
		Notification["88"]["BorderSizePixel"] = 0
		Notification["88"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Notification["88"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["88"]["TextSize"] = 12
		Notification["88"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Notification["88"]
		Notification["88"]["Size"] = UDim2.new(0, 206, 0, 21)
		Notification["88"]["Text"] = options.Name
		Notification["88"]["Name"] = [[NotifName]]
		Notification["88"]["Font"] = Enum.Font.GothamMedium
		Notification["88"]["BackgroundTransparency"] = 1
		Notification["88"]["Position"] = UDim2.new(0, 34, 0, 3)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.NotifName.ThemeColorGradient
		Notification["89"] = Instance.new("UIGradient", Notification["88"])
		Notification["89"]["Name"] = [[ThemeColorGradient]]
		Notification["89"]["Rotation"] = 90
		Notification["89"]["Color"] = ThemeColor.Theme

		ThemeInstances["Theme"][#ThemeInstances["Theme"] + 1] = Notification["89"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.NotifText
		Notification["8a"] = Instance.new("TextLabel", Notification["84"])
		Notification["8a"]["TextWrapped"] = true
		Notification["8a"]["BorderSizePixel"] = 0
		Notification["8a"]["TextXAlignment"] = Enum.TextXAlignment.Left
		Notification["8a"]["TextYAlignment"] = Enum.TextYAlignment.Top
		Notification["8a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["8a"]["TextSize"] = 10
		Notification["8a"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Notification["8a"]
		Notification["8a"]["Size"] = UDim2.new(0, 242, 0, 28)
		Notification["8a"]["Text"] = options.Text
		Notification["8a"]["Name"] = [[NotifText]]
		Notification["8a"]["Font"] = Enum.Font.GothamMedium
		Notification["8a"]["BackgroundTransparency"] = 1
		Notification["8a"]["Position"] = UDim2.new(0, 10, 0, 23)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack
		Notification["8b"] = Instance.new("Frame", Notification["84"])
		Notification["8b"]["BorderSizePixel"] = 0
		Notification["8b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["8b"]["Size"] = UDim2.new(0, 239, 0, 5)
		Notification["8b"]["Position"] = UDim2.new(0.03501945361495018, 0, 0.7903226017951965, 0)
		Notification["8b"]["Name"] = [[TimeBarBack]]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack.Frame
		Notification["8c"] = Instance.new("Frame", Notification["8b"])
		Notification["8c"]["BorderSizePixel"] = 0
		Notification["8c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Notification["8c"]["Size"] = UDim2.new(0.5, 0, 1, 0)

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack.Frame.ThemeColorGradient
		Notification["8d"] = Instance.new("UIGradient", Notification["8c"])
		Notification["8d"]["Name"] = [[ThemeColorGradient]]
		Notification["8d"]["Rotation"] = 90
		Notification["8d"]["Color"] = ThemeColor.Theme

		ThemeInstances["Theme"][#ThemeInstances["Theme"] + 1] = Notification["8d"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.TimeBarBack.UIGradient
		Notification["8e"] = Instance.new("UIGradient", Notification["8b"])
		Notification["8e"]["Rotation"] = 90
		Notification["8e"]["Color"] = ThemeColor.Tertiary

		ThemeInstances["Tertiary"][#ThemeInstances["Tertiary"] + 1] = Notification["8e"]

		-- StarterGui.Vision Lib v2.NotifFrame.Notif.UIGradient
		Notification["8f"] = Instance.new("UIGradient", Notification["84"])
		Notification["8f"]["Rotation"] = 90
		Notification["8f"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Notification["8f"]
	end

	do
		task.spawn(function()
			local Completed = false

			Library:Tween(Notification["84"], {
				Length = 0.5,
				Goal = { Size = UDim2.new(0, 257, 0, 62) },
			})

			Library:Tween(Notification["8c"], {
				Length = options.Duration,
				Style = Enum.EasingStyle.Linear,
				Goal = { Size = UDim2.new(1, 0, 1, 0) },
			}, function()
				Completed = true
			end)

			Library:PlaySound(options.Sound)

			repeat
				task.wait()
			until Completed

			local Completed = false

			Library:Tween(Notification["84"], {
				Length = 0.5,
				Goal = { Size = UDim2.new(0, 257, 0, 0) },
			}, function()
				Completed = true
			end)

			repeat
				task.wait()
			until Completed

			options.Callback()
			Notification["84"]:Destroy()
		end)
	end
end

function Library:Popup(options)
	local Prompt = {}
	options = Library:PlaceDefaults({
		Name = "Popup",
		Text = "Do you want to accept?",
		Options = { "Yes", "No" },
		Callback = function()
			return
		end,
	}, options or {})

	do
		-- StarterGui.Vision Lib v2.Prompt
		Prompt["1e9"] = Instance.new("Frame", LibFrame["2"])
		Prompt["1e9"]["ZIndex"] = 10
		Prompt["1e9"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
		Prompt["1e9"]["BackgroundTransparency"] = 1
		Prompt["1e9"]["Size"] = UDim2.new(1, 0, 1, 0)
		Prompt["1e9"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
		Prompt["1e9"]["Visible"] = true
		Prompt["1e9"]["Name"] = [[Prompt]]
		Prompt["1e9"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Prompt["1e9"]["ClipsDescendants"] = true

		-- StarterGui.Vision Lib v2.Prompt.Prompt
		Prompt["1ea"] = Instance.new("Frame", Prompt["1e9"])
		Prompt["1ea"]["ZIndex"] = 11
		Prompt["1ea"]["BorderSizePixel"] = 0
		Prompt["1ea"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Prompt["1ea"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
		Prompt["1ea"]["Size"] = UDim2.new(0, 0, 0, 0)
		Prompt["1ea"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
		Prompt["1ea"]["Name"] = [[Prompt]]
		Prompt["1ea"]["ClipsDescendants"] = true

		-- StarterGui.Vision Lib v2.Prompt.Prompt.UICorner
		Prompt["1eb"] = Instance.new("UICorner", Prompt["1ea"])
		Prompt["1eb"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Vision Lib v2.Prompt.Prompt.UIGradient
		Prompt["1ec"] = Instance.new("UIGradient", Prompt["1ea"])
		Prompt["1ec"]["Rotation"] = 90
		Prompt["1ec"]["Color"] = ThemeColor.Main

		ThemeInstances["Main"][#ThemeInstances["Main"] + 1] = Prompt["1ec"]

		-- StarterGui.Vision Lib v2.Prompt.Prompt.Controls
		Prompt["1ed"] = Instance.new("Frame", Prompt["1ea"])
		Prompt["1ed"]["ZIndex"] = 15
		Prompt["1ed"]["BorderSizePixel"] = 0
		Prompt["1ed"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Prompt["1ed"]["BackgroundTransparency"] = 1
		Prompt["1ed"]["Size"] = UDim2.new(0, 400, 0, 30)
		Prompt["1ed"]["Position"] = UDim2.new(0, -1, 0, 109)
		Prompt["1ed"]["Name"] = [[Controls]]

		-- StarterGui.Vision Lib v2.Prompt.Prompt.Controls.UIListLayout
		Prompt["1ee"] = Instance.new("UIListLayout", Prompt["1ed"])
		Prompt["1ee"]["FillDirection"] = Enum.FillDirection.Horizontal
		Prompt["1ee"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center
		Prompt["1ee"]["Padding"] = UDim.new(0, 20)
		Prompt["1ee"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.Vision Lib v2.Prompt.Prompt.Frame
		Prompt["1f7"] = Instance.new("Frame", Prompt["1ea"])
		Prompt["1f7"]["ZIndex"] = 12
		Prompt["1f7"]["BorderSizePixel"] = 0
		Prompt["1f7"]["BackgroundColor3"] = ThemeColor.Textbox
		Prompt["1f7"]["Size"] = UDim2.new(0, 371, 0, 1)
		Prompt["1f7"]["Position"] = UDim2.new(0, 14, 0, 35)

		ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = Prompt["1f7"]

		-- StarterGui.Vision Lib v2.Prompt.Prompt.Frame.TerrainDetail
		Prompt["1f8"] = Instance.new("TerrainDetail", Prompt["1f7"])

		-- StarterGui.Vision Lib v2.Prompt.Prompt.Description
		Prompt["1f9"] = Instance.new("TextLabel", Prompt["1ea"])
		Prompt["1f9"]["TextWrapped"] = true
		Prompt["1f9"]["ZIndex"] = 11
		Prompt["1f9"]["TextYAlignment"] = Enum.TextYAlignment.Top
		Prompt["1f9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Prompt["1f9"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		Prompt["1f9"]["TextSize"] = 13
		Prompt["1f9"]["TextColor3"] = ThemeColor.PlaceholderText

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Prompt["1f9"]

		Prompt["1f9"]["Size"] = UDim2.new(0, 360, 0, 95)
		Prompt["1f9"]["Text"] = options.Text
		Prompt["1f9"]["Name"] = [[Description]]
		Prompt["1f9"]["BackgroundTransparency"] = 1
		Prompt["1f9"]["Position"] = UDim2.new(0, 20, 0, 44)

		-- StarterGui.Vision Lib v2.Prompt.Prompt.Title
		Prompt["1fa"] = Instance.new("TextLabel", Prompt["1ea"])
		Prompt["1fa"]["TextWrapped"] = true
		Prompt["1fa"]["ZIndex"] = 11
		Prompt["1fa"]["TextYAlignment"] = Enum.TextYAlignment.Top
		Prompt["1fa"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Prompt["1fa"]["FontFace"] =
			Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Prompt["1fa"]["TextSize"] = 16
		Prompt["1fa"]["TextColor3"] = ThemeColor.Text

		ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = Prompt["1fa"]

		Prompt["1fa"]["Size"] = UDim2.new(0, 400, 0, 20)
		Prompt["1fa"]["Text"] = options.Name
		Prompt["1fa"]["Name"] = [[Title]]
		Prompt["1fa"]["BackgroundTransparency"] = 1
		Prompt["1fa"]["Position"] = UDim2.new(0, 0, 0, 12)
	end

	do
		Library:Tween(Prompt["1e9"], {
			Goal = {
				BackgroundTransparency = 0.65,
			},
			Style = Enum.EasingStyle.Quart,
			Direction = Enum.EasingDirection.Out,
			Length = 0.5,
		})

		Library:Tween(Prompt["1ea"], {
			Goal = {
				Size = UDim2.new(0, 400, 0, 146),
			},
			Style = Enum.EasingStyle.Quart,
			Direction = Enum.EasingDirection.Out,
			Length = 0.5,
		})

		Library:PlaySound(LibSettings.PopupSound)
	end

	do
		for i, text in next, options.Options do
			do
				local PromptOption = {}
				-- StarterGui.Vision Lib v2.Prompt.Prompt.Controls.B1
				PromptOption["1ef"] = Instance.new("TextButton", Prompt["1ed"])
				PromptOption["1ef"]["ZIndex"] = 11
				PromptOption["1ef"]["BorderSizePixel"] = 0
				PromptOption["1ef"]["BackgroundColor3"] = ThemeColor.Textbox

				ThemeInstances["Textbox"][#ThemeInstances["Textbox"] + 1] = PromptOption["1ef"]

				PromptOption["1ef"]["TextSize"] = 14
				PromptOption["1ef"]["FontFace"] = Font.new(
					[[rbxasset://fonts/families/GothamSSm.json]],
					Enum.FontWeight.Regular,
					Enum.FontStyle.Normal
				)
				PromptOption["1ef"]["TextColor3"] = ThemeColor.Text

				ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = PromptOption["1ef"]
				PromptOption["1ef"]["Size"] = UDim2.new(0, 120, 0, 30)
				PromptOption["1ef"]["LayoutOrder"] = 1
				PromptOption["1ef"]["Name"] = [[B1]]
				PromptOption["1ef"]["Text"] = ""
				PromptOption["1ef"]["Position"] = UDim2.new(0, 68, 0, 567)

				-- StarterGui.Vision Lib v2.PromptOption.PromptOption.Controls.B1.UICorner
				PromptOption["1f0"] = Instance.new("UICorner", PromptOption["1ef"])
				PromptOption["1f0"]["CornerRadius"] = UDim.new(0, 4)

				-- StarterGui.Vision Lib v2.PromptOption.PromptOption.Controls.B1.NameLabel
				PromptOption["1f2"] = Instance.new("TextLabel", PromptOption["1ef"])
				PromptOption["1f2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
				PromptOption["1f2"]["FontFace"] = Font.new(
					[[rbxasset://fonts/families/GothamSSm.json]],
					Enum.FontWeight.Regular,
					Enum.FontStyle.Normal
				)
				PromptOption["1f2"]["TextSize"] = 11
				PromptOption["1f2"]["TextColor3"] = ThemeColor.Text

				ThemeInstances["Text"][#ThemeInstances["Text"] + 1] = PromptOption["1f2"]
				PromptOption["1f2"]["Size"] = UDim2.new(0, 120, 0, 30)
				PromptOption["1f2"]["Text"] = tostring(text)
				PromptOption["1f2"]["Name"] = [[NameLabel]]
				PromptOption["1f2"]["BackgroundTransparency"] = 1

				table.insert(
					ConnectionBin,
					PromptOption["1ef"].MouseButton1Click:Connect(function()
						Library:PlaySound(LibSettings.ClickSound)

						Library:Tween(Prompt["1e9"], {
							Goal = {
								BackgroundTransparency = 1,
							},
							Style = Enum.EasingStyle.Quart,
							Direction = Enum.EasingDirection.Out,
							Length = 0.5,
						})

						Library:Tween(Prompt["1ea"], {
							Goal = {
								Size = UDim2.new(0, 0, 0, 0),
							},
							Style = Enum.EasingStyle.Quart,
							Direction = Enum.EasingDirection.Out,
							Length = 0.5,
						})

						do
							task.spawn(function()
								options.Callback(text)
							end)
						end

						task.spawn(function()
							task.wait(1.5)

							Prompt["1e9"]:Destroy()
						end)
					end)
				)

				table.insert(
					ConnectionBin,
					PromptOption["1ef"].MouseEnter:Connect(function()
						Library:PlaySound(LibSettings.HoverSound)
					end)
				)
			end
		end
	end
end

function Library:Destroy()
	local DestroyedConnection = 0
	local DestroyedControlConection = 0
	local TotalControlConnections = 0
	local TotalConnections = #ConnectionBin
	local TotalControls = #ControlsConnectionBin

	for i, v in next, ConnectionBin do
		pcall(function()
			v:Disconnect()

			DestroyedConnection += 1
		end)
	end

	for i, controls in next, ControlsConnectionBin do
		for i, event in next, controls do
			TotalControlConnections = TotalControlConnections + 1

			pcall(function()
				event:Disconnect()

				DestroyedControlConection += 1
			end)
		end
	end

	print(
		"Disconnected "
			.. tostring(DestroyedConnection)
			.. " connections out of "
			.. tostring(TotalConnections)
			.. " connections."
	)

	print(
		"Disconnected "
			.. tostring(DestroyedControlConection)
			.. " connections out of "
			.. tostring(TotalControlConnections)
			.. " connections in "
			.. TotalControls
			.. " controls."
	)

	LibFrame["1"]:Destroy()
	LibFrame["2"]:Destroy()
end

return Library

end,
},
WriteLog = function()
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

end,
},
temp = function()
Replay.Data.ReplayRS = RunService.RenderStepped:Connect(function(delta)
	local VehicleCycleArray = {}
	local CycleArray = {}

	for i, v in next, Workspace.Vehicles:GetChildren() do
		local CurrentVehicleArray = {}
		local SoundArray = {}
		local VehiclePartArray = {}

		local VehicleModel = v:FindFirstChild("Model")
		local VehicleName = tostring(v.Name)

		for _, obj in next, v:FindFirstChild("Engine"):GetChildren() do
			if obj:IsA("Sound") then
				local properties = {}
				properties["Type"] = [[Sound]]
				properties["Playing"] = tostring(obj.Playing)
				properties["Volume"] = tostring(obj.Volume)
				properties["PlaybackSpeed"] = tostring(obj.PlaybackSpeed)
				properties["TimePosition"] = tostring(obj.TimePosition)
				properties["ObjectID"] = obj:GetAttribute("ObjectID")
				properties["SoundId"] = tostring(obj.SoundId)

				if obj:GetAttribute("ObjectID") ~= nil then
					SoundArray[obj.Name .. "-" .. obj:GetAttribute("ObjectID")] = properties
				end
			end
		end

		for _, obj in next, v:GetDescendants() do
			if not obj:IsDescendantOf(VehicleModel) then
				if obj:IsA("BasePart") then
					if obj.Name ~= "Engine" then
						local properties = {}
						properties["Type"] = [[Part]]
						properties["CFrame"] = tostring(obj.CFrame)
						properties["Material"] = tostring(obj.Material)
						properties["Color"] = tostring(obj.Color)

						if obj:IsA("MeshPart") then
							properties["TextureID"] = tostring(obj.TextureID)
						end

						if obj:GetAttribute("ObjectID") ~= nil then
							VehiclePartArray[obj.Name .. "-" .. obj:GetAttribute("ObjectID")] = properties
						end
					end
				end
			end
		end

		CurrentVehicleArray["PrimaryPartCFrame"] = tostring(v:FindFirstChild("Engine").CFrame)
		CurrentVehicleArray["Sound"] = SoundArray
		CurrentVehicleArray["Animatable"] = VehiclePartArray

		if v:GetAttribute("ObjectID") ~= nil then
			VehicleCycleArray[VehicleName .. "-" .. v:GetAttribute("ObjectID")] = CurrentVehicleArray
		end
	end

	CycleArray["Vehicle"] = VehicleCycleArray
	CycleArray["DeltaTime"] = delta

	replayObjectArray[keyframe] = CycleArray

	keyframe = keyframe + 1
end)

end,
temp2 = function()
local Lighting = game:GetService("Lighting")
local Atmosphere = Instance.new("Atmosphere")
local Sky = Instance.new("Sky")
local Bloom = Instance.new("BloomEffect")
local ColorCorrection = Instance.new("ColorCorrectionEffect")
local SunRays = Instance.new("SunRaysEffect")

for i, v in next, Lighting:GetChildren() do
	v:Destroy()
end

while task.wait() do
	pcall(function()
		Lighting.ClockTime = 9

		Lighting.Ambient = Color3.fromRGB(45, 45, 45)
		Lighting.Brightness = 4
		Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
		Lighting.ColorShift_Top = Color3.fromRGB(139, 70, 0)
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 1
		Lighting.GlobalShadows = true
		Lighting.OutdoorAmbient = Color3.fromRGB(90, 90, 90)
		Lighting.ShadowSoftness = 1

		Atmosphere.Parent = Lighting
		Atmosphere.Density = 0.245
		Atmosphere.Offset = 0
		Atmosphere.Color = Color3.fromRGB(170, 85, 0)
		Atmosphere.Decay = Color3.fromRGB(0, 0, 0)
		Atmosphere.Glare = 0.67
		Atmosphere.Haze = 0

		Sky.Parent = Lighting
		Sky.SkyboxBk = "rbxassetid://8416605558"
		Sky.SkyboxDn = "rbxassetid://8416603615"
		Sky.SkyboxFt = "rbxassetid://8416606806"
		Sky.SkyboxLf = "rbxassetid://8416607803"
		Sky.SkyboxRt = "rbxassetid://8416608690"
		Sky.SkyboxUp = "rbxassetid://8416605082"
		Sky.StarCount = 0
		Sky.SunAngularSize = 11
		Sky.SunTextureId = "rbxassetid://6196665106"

		Bloom.Parent = Lighting
		Bloom.Intensity = 1
		Bloom.Size = 24
		Bloom.Threshold = 2

		ColorCorrection.Parent = Lighting
		ColorCorrection.Brightness = 0.05
		ColorCorrection.Contrast = 0.18
		ColorCorrection.Saturation = 0
		ColorCorrection.TintColor = Color3.fromRGB(244, 244, 244)

		SunRays.Parent = Lighting
		SunRays.Intensity = 0.029
		SunRays.Sperad = 0.412
	end)
end

end,
}
local Loaded = {}

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")
local LogService = game:GetService("LogService")
local PhysicisService = game:GetService("PhysicsService")
local ChatService = game:GetService("Chat")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local request = http_request or request or syn.request
local getasset = getcustomasset or getsynasset

local response = request({
	Url = "https://git.lococto.com/Raphs/Data/raw/branch/main/UsePolicy.md",
	Method = "GET",
})

local selfSettings = {
	forzaType = nil,
	onVehicle = false,
	Library = nil,
}

local CurVehicleData = {
	RPM = nil,
	MPH = nil,
	GEAR = nil,
	Vehicle = nil,
}

local v3UserPolicy = [[By using our service, you agree to the terms and conditions outlined in this Use Policy.

1. Data Collection
   We collect data from our users for the purpose of improving our services and conducting public data analysis. This includes, but is not limited to, information such as your device type, operating system, location, usage patterns, and preferences.

2. Use of Data
   The data we collect from our users will be used to:
   Improve our services - We may use your data to analyze usage patterns and identify areas where we can improve our service.

3. Sharing of Data
   We do not sell or rent your data to third parties. However, we may share your non-sensitive data as analytics or information for contribution towards the public and community, we may also share your data to third parties in order to improve the quality of our service.

4. License Agreement
   You are granted a limited, non-exclusive, non-transferable license to use the service. You may not share, transfer, or sublicense your license to anyone else.

5. Your Consent
   By using our service, you consent to the collection, use, and sharing of your data as described in this Use Policy, and agree not to share, transfer or sublicense your license to anyone else.

6. Responsibility
   We are not responsible for any result for you using this service. There is no guarantee of your account's safety. We will not be to blame for and compensate your loss.

7. Changes to this Agreement
   We reserve the right to modify this Use Policy at any time without prior notification. Any changes will be effective immediately upon posting on our website http://policy.lococto.com/. Your continued use of the service after any changes to this Use Policy will constitute your acceptance of those changes.

8. Termination
   We reserve the right to terminate your use of the service at any time if you violate the terms and conditions outlined in this Use Policy.

If you have any questions about this Use Policy, please contact us via a ticket in https://discord.lococto.com/
]] --response["Body"]
local ExecutionTime = os.date("%Y-%m-%d_%H-%M-%S")

-- Main
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if not LPH_OBFUSCATED then
	LPH_NO_VIRTUALIZE = function(...)
		return (...)
	end
	LPH_JIT_MAX = function(...)
		return (...)
	end
end

getgenv().getcustomasset = getcustomasset or getsynasset

import = function(dir)
	local Split = string.split(dir, "/")
	---@diagnostic disable-next-line: undefined-global
	local Data = JailbreakVisionV3

	Split[#Split] = string.split(Split[#Split], ".")[1]

	for i = 1, #Split do
		Data = Data[Split[i]]
	end

	if not Loaded[dir] and typeof(Data) == "function" then
		Loaded[dir] = Data()
	elseif typeof(Data) == "table" then
		Loaded[dir] = {}
		for i, v in next, Data do
			Loaded[dir][i] = import(dir .. "/" .. i)
		end
	end

	return Loaded[dir]
end

-- File
local Library = import("Modules/UiLibrary/Lib.lua")

makefolder("JailbreakVisionV3")
makefolder("JailbreakVisionV3/.logs")
makefolder("JailbreakVisionV3/Settings")
makefolder("JailbreakVisionV3/SpeedTestResults")
makefolder("JailbreakVisionV3/MapEditor")
makefolder("JailbreakVisionV3/GameExport")
makefolder("JailbreakVisionV3/LightingEditor")
makefolder("JailbreakVisionV3/Policy")
makefolder("JailbreakVisionV3/SpeedtestScenes")
makefolder("JailbreakVisionV3/EngineModifier")

pcall(function()
	delfile("JailbreakVisionV3/Settings/UserPolicy.pem")
end)

pcall(function()
	delfile("JailbreakVisionV3/Policy/UserPolicy.txt")
end)

pcall(function()
	delfile("JailbreakVisionV3/ModelsImporter")
end)

if not isfile("JailbreakVisionV3/Settings/UsePolicy.pem") then
	local json = HttpService:JSONEncode({
		agree = false,
	})

	writefile("JailbreakVisionV3/Settings/UsePolicy.pem", json)
end

if isfile("JailbreakVisionV3/Policy/UsePolicy.md") then
	if v3UserPolicy ~= readfile("JailbreakVisionV3/Policy/UsePolicy.md") then
		Library:ForceNotify({
			Name = "Use Policy",
			Text = "An update for Use Policy has been detected!",
			Icon = "rbxassetid://11401835376",
			Duration = 3,
		})

		writefile("JailbreakVisionV3/Policy/UsePolicy.md", v3UserPolicy)

		local json = HttpService:JSONEncode({
			agree = false,
		})

		writefile("JailbreakVisionV3/Settings/UsePolicy.pem", json)
	end
else
	writefile("JailbreakVisionV3/Policy/UsePolicy.md", v3UserPolicy)
end

-- Load
local DestructibleBind = import("Modules/DestructibleBind.lua")
local ReplayObj = import("Modules/EasyReplay/Utils/ReplayObjects.lua")
local Create = import("Create/Create.lua")
local Tracker = import("Functions/Tracker.lua")
local PlayerHandler = import("Functions/PlayerHandler.lua")
local PlayerRing = import("Functions/PlayerRing.lua")

Create.CreateUI()
ReplayObj.AssignID()
Tracker.Run()
DestructibleBind.init()
PlayerHandler.init()
PlayerRing.init()
