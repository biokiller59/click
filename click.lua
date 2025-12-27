-- ANUBIS HUB | FULL READY SCRIPT

--------------------------------------------------
-- CONFIG
--------------------------------------------------
Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791",
    service = "Saltink",
    provider = "Anubis"
}

--------------------------------------------------
-- GLOBAL STATES
--------------------------------------------------
getgenv().FarmEnabled = false
getgenv().Started = false

--------------------------------------------------
-- FARM SYSTEM
--------------------------------------------------
local function startFarm()
    if getgenv().Started then return end
    getgenv().Started = true

    local Players = game:GetService("Players")
    local VirtualUser = game:GetService("VirtualUser")
    local player = Players.LocalPlayer
    local ITEM_NAME = "Combat"

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
            task.wait(1)
        end
    end)

    -- AUTO CLICK
    task.spawn(function()
        while true do
            if getgenv().FarmEnabled then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(500,500), workspace.CurrentCamera.CFrame)
            end
            task.wait(0.08)
        end
    end)

    -- FARM LOOP
    task.spawn(function()
        while true do
            if getgenv().FarmEnabled then
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- TITAN
                    hrp.CFrame = workspace.Bosses.Waiting.Titan.qw.CFrame
                    task.wait(15)

                    if workspace.RespawnMobs.Titan
                        and workspace.RespawnMobs.Titan:FindFirstChild("Titan")
                        and workspace.RespawnMobs.Titan.Titan then
                        hrp.CFrame = workspace.RespawnMobs.Titan.Titan.CFrame
                    end

                    task.wait(10)

                    -- MUSCLE
                    hrp.CFrame = workspace.Bosses.Waiting.Muscle.qw.CFrame
                    task.wait(25)

                    if workspace.RespawnMobs.Muscle
                        and workspace.RespawnMobs.Muscle:FindFirstChild("Muscle") then
                        hrp.CFrame = workspace.RespawnMobs.Muscle.Muscle.CFrame
                    end
                end
            end
            task.wait(1)
        end
    end)
end

--------------------------------------------------
-- GUI HUB
--------------------------------------------------
local UIS = game:GetService("UserInputService")
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.fromOffset(520, 330)
Frame.Position = UDim2.fromScale(0.5, 0.5)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(24,24,30)
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(90,90,130)
Stroke.Transparency = 0.35

-- DRAG (PC + MOBILE)
do
    local dragging, dragStart, startPos
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Frame.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)
end

--------------------------------------------------
-- CONTENT
--------------------------------------------------
local Layout = Instance.new("UIListLayout", Frame)
Layout.Padding = UDim.new(0,12)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center

local function label(text, size)
    local l = Instance.new("TextLabel", Frame)
    l.Size = UDim2.new(1,-40,0,size)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = size
    l.TextColor3 = Color3.new(1,1,1)
end

local function button(text, color)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(0.85,0,0,44)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
    return b
end

--------------------------------------------------
-- UI ELEMENTS
--------------------------------------------------
label("ANUBIS HUB", 22)
label("Auto Farm System", 14)

local FarmBtn = button("AUTO FARM: OFF", Color3.fromRGB(170,70,70))

FarmBtn.MouseButton1Click:Connect(function()
    getgenv().FarmEnabled = not getgenv().FarmEnabled
    if getgenv().FarmEnabled then
        FarmBtn.Text = "AUTO FARM: ON"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(70,180,90)
    else
        FarmBtn.Text = "AUTO FARM: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(170,70,70)
    end
end)

--------------------------------------------------
-- START FARM SYSTEM
--------------------------------------------------
startFarm()
