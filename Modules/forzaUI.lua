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
