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
