--------------------------------------------------
-- BEAUTIFUL HUB GUI + MOBILE DRAG + FARM TOGGLE
--------------------------------------------------

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- FARM STATE (используется в main)
getgenv().FarmEnabled = getgenv().FarmEnabled or false

--------------------------------------------------
-- GUI
--------------------------------------------------
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "AnubisHub"
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.fromOffset(520, 340)
Frame.Position = UDim2.fromScale(0.5, 0.5)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(24,24,30)
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(80,80,110)
Stroke.Transparency = 0.3
Stroke.Thickness = 1.2

--------------------------------------------------
-- MOBILE + PC DRAG
--------------------------------------------------
do
    local dragging = false
    local dragStart, startPos

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and
        (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Frame.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

--------------------------------------------------
-- LEFT TABS
--------------------------------------------------
local Tabs = Instance.new("Frame", Frame)
Tabs.Size = UDim2.fromOffset(130, 340)
Tabs.BackgroundColor3 = Color3.fromRGB(20,20,26)
Tabs.BorderSizePixel = 0
Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0,18)

local TabsLayout = Instance.new("UIListLayout", Tabs)
TabsLayout.Padding = UDim.new(0,10)
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center

--------------------------------------------------
-- CONTENT
--------------------------------------------------
local Content = Instance.new("Frame", Frame)
Content.Position = UDim2.fromOffset(145, 15)
Content.Size = UDim2.fromOffset(360, 310)
Content.BackgroundTransparency = 1

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.Padding = UDim.new(0,10)

--------------------------------------------------
-- UI HELPERS
--------------------------------------------------
local function clear()
    for _,v in pairs(Content:GetChildren()) do
        if not v:IsA("UIListLayout") then
            v:Destroy()
        end
    end
end

local function label(text, size)
    local l = Instance.new("TextLabel", Content)
    l.Size = UDim2.new(1,0,0,30)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = size or 16
    l.TextColor3 = Color3.new(1,1,1)
    l.TextXAlignment = Enum.TextXAlignment.Left
end

local function toggle(text, default, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(1,0,0,42)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)

    local state = default
    local function refresh()
        btn.Text = text .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state
            and Color3.fromRGB(70,180,90)
            or Color3.fromRGB(180,70,70)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        refresh()
        callback(state)
    end)

    refresh()
end

local function tabButton(text)
    local b = Instance.new("TextButton", Tabs)
    b.Size = UDim2.new(1,-20,0,44)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,55)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
    return b
end

--------------------------------------------------
-- TABS
--------------------------------------------------
local MainTab = tabButton("Main")
local FarmTab = tabButton("Farm")
local MiscTab = tabButton("Misc")

--------------------------------------------------
-- TAB CONTENTS
--------------------------------------------------
MainTab.MouseButton1Click:Connect(function()
    clear()
    label("ANUBIS HUB", 20)
    label("Status: Loaded")
    label("Version: 1.0")
end)

FarmTab.MouseButton1Click:Connect(function()
    clear()
    label("Farm Settings", 18)

    toggle("Auto Farm", getgenv().FarmEnabled, function(v)
        getgenv().FarmEnabled = v
    end)
end)

MiscTab.MouseButton1Click:Connect(function()
    clear()
    label("Misc", 18)
    label("More features soon...")
end)

-- DEFAULT TAB
MainTab:MouseButton1Click()
