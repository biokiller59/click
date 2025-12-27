-- ANUBIS HUB | FARM FIXED 100%

--------------------------------------------------
-- GLOBAL STATE
--------------------------------------------------
getgenv().FarmEnabled = false

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--------------------------------------------------
-- SAFE CHARACTER GET
--------------------------------------------------
local function getChar()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    return char, hrp
end

--------------------------------------------------
-- FARM SYSTEM (STABLE)
--------------------------------------------------
task.spawn(function()
    while true do
        if getgenv().FarmEnabled then
            local char, hrp = getChar()
            if hrp then
                -- AUTO CLICK
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(500,500), workspace.CurrentCamera.CFrame)

                -- TITAN WAIT
                if workspace:FindFirstChild("Bosses") then
                    hrp.CFrame = workspace.Bosses.Waiting.Titan.qw.CFrame
                    task.wait(15)
                end

                -- TITAN SPAWN
                if workspace:FindFirstChild("RespawnMobs")
                and workspace.RespawnMobs:FindFirstChild("Titan")
                and workspace.RespawnMobs.Titan:FindFirstChild("Titan") then
                    hrp.CFrame = workspace.RespawnMobs.Titan.Titan.CFrame
                    task.wait(10)
                end

                -- MUSCLE WAIT
                hrp.CFrame = workspace.Bosses.Waiting.Muscle.qw.CFrame
                task.wait(25)

                -- MUSCLE SPAWN
                if workspace.RespawnMobs:FindFirstChild("Muscle")
                and workspace.RespawnMobs.Muscle:FindFirstChild("Muscle") then
                    hrp.CFrame = workspace.RespawnMobs.Muscle.Muscle.CFrame
                    task.wait(10)
                end
            end
        else
            task.wait(0.5)
        end
    end
end)

--------------------------------------------------
-- GUI
--------------------------------------------------
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.fromOffset(420, 220)
Frame.Position = UDim2.fromScale(0.5, 0.5)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,32)
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

-- DRAG (PC + MOBILE)
do
    local drag, startPos, dragPos
    Frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            startPos = i.Position
            dragPos = Frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startPos
            Frame.Position = dragPos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

--------------------------------------------------
-- UI ELEMENTS
--------------------------------------------------
local Layout = Instance.new("UIListLayout", Frame)
Layout.Padding = UDim.new(0,12)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,-40,0,30)
Title.BackgroundTransparency = 1
Title.Text = "ANUBIS AUTO FARM"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)

local FarmBtn = Instance.new("TextButton", Frame)
FarmBtn.Size = UDim2.new(0.85,0,0,50)
FarmBtn.Text = "AUTO FARM: OFF"
FarmBtn.Font = Enum.Font.GothamBold
FarmBtn.TextSize = 16
FarmBtn.TextColor3 = Color3.new(1,1,1)
FarmBtn.BackgroundColor3 = Color3.fromRGB(180,70,70)
Instance.new("UICorner", FarmBtn).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- BUTTON LOGIC
--------------------------------------------------
FarmBtn.MouseButton1Click:Connect(function()
    getgenv().FarmEnabled = not getgenv().FarmEnabled
    if getgenv().FarmEnabled then
        FarmBtn.Text = "AUTO FARM: ON"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(70,180,90)
    else
        FarmBtn.Text = "AUTO FARM: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(180,70,70)
    end
end)
