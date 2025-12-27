-- COMPACT KEY SYSTEM + AUTOSAVE + FARM TOGGLE

Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791",
    service = "Saltink",
    provider = "Anubis"
}

--------------------------------------------------
-- FARM STATE
--------------------------------------------------
getgenv().FarmEnabled = false

--------------------------------------------------
-- MAIN SCRIPT (FARM TOGGLE SUPPORT)
--------------------------------------------------
local function main()
    print("Key Validated! Starting Script...")

    local ITEM_NAME = "Combat"
    local player = game:GetService("Players").LocalPlayer
    local VirtualUser = game:GetService("VirtualUser")

    -- AUTO EQUIP
    task.spawn(function()
        while true do
            if getgenv().FarmEnabled then
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local bp = player:FindFirstChild("Backpack")
                    if hum and bp and not char:FindFirstChild(ITEM_NAME) then
                        local tool = bp:FindFirstChild(ITEM_NAME)
                        if tool then hum:EquipTool(tool) end
                    end
                end
            end
            task.wait(2)
        end
    end)

    -- AUTO CLICK
    task.spawn(function()
        while true do
            if getgenv().FarmEnabled then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(851,158), workspace.CurrentCamera.CFrame)
            end
            task.wait(0.1)
        end
    end)

    -- FARM TELEPORTS
    task.spawn(function()
        while true do
            if getgenv().FarmEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                task.wait(15)
                player.Character.HumanoidRootPart.CFrame =
                    workspace.Bosses.Waiting.Titan.qw.CFrame

                task.wait(8)
                if workspace.RespawnMobs.Titan
                    and workspace.RespawnMobs.Titan:FindFirstChild("Titan")
                    and workspace.RespawnMobs.Titan.Titan
                then
                    player.Character.HumanoidRootPart.CFrame =
                        workspace.RespawnMobs.Titan.Titan.CFrame
                end

                task.wait(27)
                player.Character.HumanoidRootPart.CFrame =
                    workspace.Bosses.Waiting.Muscle.qw.CFrame

                task.wait(8)
                if workspace.RespawnMobs.Muscle
                    and workspace.RespawnMobs.Muscle:FindFirstChild("Muscle")
                then
                    player.Character.HumanoidRootPart.CFrame =
                        workspace.RespawnMobs.Muscle.Muscle.CFrame
                end
            end
            task.wait(1)
        end
    end)
end

--------------------------------------------------
-- KEY SYSTEM (UNCHANGED)
--------------------------------------------------
if getgenv().FixedKeySys then return end
getgenv().FixedKeySys = true

local CoreGui = game:GetService("CoreGui")
local SAVE_FILE = "anubis_key.txt"

local Colors = {
    BG = Color3.fromRGB(20,20,25),
    Red = Color3.fromRGB(220,50,50),
    Green = Color3.fromRGB(80,200,80),
    Button = Color3.fromRGB(45,45,55),
    Input = Color3.fromRGB(30,30,35),
    Discord = Color3.fromRGB(88,101,242)
}

--------------------------------------------------
-- FILE
--------------------------------------------------
local function saveKey(k)
    if writefile then writefile(SAVE_FILE, k) end
end

local function loadKey()
    if isfile and readfile and isfile(SAVE_FILE) then
        return readfile(SAVE_FILE)
    end
end

--------------------------------------------------
-- GUI
--------------------------------------------------
local Gui = Instance.new("ScreenGui", CoreGui)
Gui.IgnoreGuiInset = false
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.fromOffset(420, 400)
Frame.Position = UDim2.fromScale(0.5, 0.5)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Colors.BG
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

local Layout = Instance.new("UIListLayout", Frame)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center
Layout.Padding = UDim.new(0,10)

local function label(text,size,color)
    local l = Instance.new("TextLabel", Frame)
    l.Size = UDim2.new(1,-40,0,size)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = size
    l.TextColor3 = color
    return l
end

label("ANUBIS HUB", 24, Colors.Red)
label("Key System", 13, Color3.fromRGB(180,180,180))

local KeyBox = Instance.new("TextBox", Frame)
KeyBox.Size = UDim2.new(0.85,0,0,42)
KeyBox.PlaceholderText = "Enter your key..."
KeyBox.Text = loadKey() or ""
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Colors.Input
Instance.new("UICorner", KeyBox)

local function button(text,color)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(0.85,0,0,42)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    Instance.new("UICorner", b)
    return b
end

local VerifyBtn = button("VERIFY KEY", Colors.Button)
local FarmBtn   = button("FARM: OFF", Colors.Red)

--------------------------------------------------
-- JUNKIE
--------------------------------------------------
local function getJunkie()
    return loadstring(game:HttpGet(
        "https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
end

--------------------------------------------------
-- BUTTON LOGIC
--------------------------------------------------
VerifyBtn.Activated:Connect(function()
    local key = KeyBox.Text:gsub("%s+","")
    if key == "" then return end

    local ok,valid = pcall(function()
        return getJunkie().verifyKey(Config.api, key, Config.service)
    end)

    if ok and valid then
        saveKey(key)
        Gui:Destroy()
        main()
    end
end)

FarmBtn.Activated:Connect(function()
    getgenv().FarmEnabled = not getgenv().FarmEnabled
    if getgenv().FarmEnabled then
        FarmBtn.Text = "FARM: ON"
        FarmBtn.BackgroundColor3 = Colors.Green
    else
        FarmBtn.Text = "FARM: OFF"
        FarmBtn.BackgroundColor3 = Colors.Red
    end
end)
