--------------------------------------------------
-- MAIN HUB GUI
--------------------------------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local HubGui = Instance.new("ScreenGui", game.CoreGui)
HubGui.Name = "AnubisHub"
HubGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", HubGui)
MainFrame.Size = UDim2.fromOffset(520, 360)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(22,22,28)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,14)

-- Drag
do
    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

--------------------------------------------------
-- LEFT TABS
--------------------------------------------------
local Tabs = Instance.new("Frame", MainFrame)
Tabs.Size = UDim2.fromOffset(120, 360)
Tabs.BackgroundColor3 = Color3.fromRGB(18,18,24)
Tabs.BorderSizePixel = 0
Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0,14)

local TabLayout = Instance.new("UIListLayout", Tabs)
TabLayout.Padding = UDim.new(0,8)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--------------------------------------------------
-- CONTENT
--------------------------------------------------
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.fromOffset(130, 10)
Content.Size = UDim2.fromOffset(380, 340)
Content.BackgroundTransparency = 1

--------------------------------------------------
-- UI HELPERS
--------------------------------------------------
local function createTab(name)
    local btn = Instance.new("TextButton", Tabs)
    btn.Size = UDim2.new(1,-20,0,40)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(35,35,45)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    return btn
end

local function clearContent()
    for _,v in pairs(Content:GetChildren()) do
        if not v:IsA("UICorner") then
            v:Destroy()
        end
    end
end

local function label(text)
    local l = Instance.new("TextLabel", Content)
    l.Size = UDim2.new(1,0,0,30)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = 16
    l.TextColor3 = Color3.new(1,1,1)
    l.TextXAlignment = Left
    return l
end

local function toggle(text, default, callback)
    local t = Instance.new("TextButton", Content)
    t.Size = UDim2.new(1,0,0,36)
    t.Text = text .. ": " .. (default and "ON" or "OFF")
    t.Font = Enum.Font.Gotham
    t.TextSize = 14
    t.BackgroundColor3 = default and Color3.fromRGB(70,160,70) or Color3.fromRGB(160,70,70)
    t.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", t)

    local state = default
    t.MouseButton1Click:Connect(function()
        state = not state
        t.Text = text .. ": " .. (state and "ON" or "OFF")
        t.BackgroundColor3 = state and Color3.fromRGB(70,160,70) or Color3.fromRGB(160,70,70)
        callback(state)
    end)
end

--------------------------------------------------
-- TABS SETUP
--------------------------------------------------
local MainTab = createTab("Main")
local FarmTab = createTab("Farm")
local PlayerTab = createTab("Player")
local MiscTab = createTab("Misc")

--------------------------------------------------
-- TAB CONTENTS
--------------------------------------------------
MainTab.MouseButton1Click:Connect(function()
    clearContent()
    label("Anubis Hub")
    label("Status: Loaded")
end)

FarmTab.MouseButton1Click:Connect(function()
    clearContent()
    label("Farm Settings")

    toggle("Auto Farm", getgenv().FarmEnabled, function(v)
        getgenv().FarmEnabled = v
    end)

    toggle("Auto Click", true, function(v)
        getgenv().AutoClick = v
    end)
end)

PlayerTab.MouseButton1Click:Connect(function()
    clearContent()
    label("Player")

    toggle("Infinite Jump", false, function(v)
        getgenv().InfJump = v
    end)
end)

MiscTab.MouseButton1Click:Connect(function()
    clearContent()
    label("Misc")
    label("More soon...")
end)

-- default tab
MainTab:MouseButton1Click()
