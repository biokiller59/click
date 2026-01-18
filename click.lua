--// CONFIG
local Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791",
    service = "Saltink",
    provider = "Anubis1"
}

--// SERVICES
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

--// KEY SYSTEM LOADER
local function KeySystem()
    return loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
end

local keyFile = "anubis_key.txt"

local function saveKey(k)
    if writefile then writefile(keyFile, k) end
end

local function loadKey()
    if isfile and readfile and isfile(keyFile) then
        local k = readfile(keyFile)
        if k and #k > 5 then return k end
    end
end

--// MAIN SCRIPT START
local function START_SCRIPT()
    -- ⬇⬇⬇ ТВОЙ ОСНОВНОЙ СКРИПТ ⬇⬇⬇
    local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlueBird_Final_V3"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local CurrentThemeColor = Color3.fromRGB(80, 150, 255)
local ConfigFileName = "BlueBird_AutoSettings.json"

-- СОСТОЯНИЯ (ФЛАГИ)
local AutoClickerEnabled = false
local AutoFarmEnabled = false
local AutoSacEnabled = false
local SelectedSacMode = "None"
local AuraEnabled = false
local ESP_Enabled = false
local AutoBringEnabled = false
local AFKFarmEnabled = false
local SelectedBoss = "All"
local SelectedBosses = {}
local SLOT_NUMBER = 2
local SelectedWorld = "World1"
local SelectedBoxName = "Box1"
local CurrentWalkSpeed = nil
local CurrentJumpPower = nil
local FloatForce = nil

-- ГЛАВНОЕ ОКНО
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
Main.Position = UDim2.new(0.5, -200, 0.5, -150)  -- центрируем по экрану
Main.Size     = UDim2.new(0, 400, 0, 300)       -- ширина 400, высота 300
Main.BorderSizePixel = 0
Main.ClipsDescendants = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

-- Glow
local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.Parent = Main
Glow.BackgroundTransparency = 1
Glow.Position = UDim2.new(0, -15, 0, -15)
Glow.Size = UDim2.new(1, 30, 1, 30)
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = CurrentThemeColor
Glow.ImageTransparency = 0.3
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(24, 24, 276, 276)
Glow.ZIndex = 0

-- Drag & Resize icons
local DragIcon = Instance.new("ImageButton")
DragIcon.Name = "DragIcon"
DragIcon.Parent = Main
DragIcon.BackgroundTransparency = 1
DragIcon.Position = UDim2.new(1, -38, 0, 12)
DragIcon.Size = UDim2.new(0, 25, 0, 25)
DragIcon.Image = "rbxthumb://type=Asset&id=125809679318645&w=420&h=420"
DragIcon.ImageColor3 = CurrentThemeColor
DragIcon.ZIndex = 20

local ResizeIcon = Instance.new("ImageButton")
ResizeIcon.Name = "ResizeIcon"
ResizeIcon.Parent = Main
ResizeIcon.BackgroundTransparency = 1
ResizeIcon.Position = UDim2.new(1, -25, 1, -25)
ResizeIcon.Size = UDim2.new(0, 20, 0, 20)
ResizeIcon.Image = "rbxthumb://type=Asset&id=122623591272133&w=420&h=420"
ResizeIcon.ImageColor3 = CurrentThemeColor
ResizeIcon.ZIndex = 20

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 60, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, 0, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SidebarLine.BorderSizePixel = 0
SidebarLine.Parent = Sidebar

local Logo = Instance.new("ImageLabel")
Logo.Parent = Sidebar
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0.5, -15, 0, 15)
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Image = "rbxthumb://type=Asset&id=12859565587&w=420&h=420"
Logo.ImageColor3 = CurrentThemeColor
Logo.ZIndex = 6

local NavButtons = Instance.new("ScrollingFrame")
NavButtons.Size = UDim2.new(1, 0, 1, -80)
NavButtons.Position = UDim2.new(0, 0, 0, 60)
NavButtons.BackgroundTransparency = 1
NavButtons.BorderSizePixel = 0
NavButtons.ScrollBarThickness = 0
NavButtons.ZIndex = 6
NavButtons.Parent = Sidebar

local NavLayout = Instance.new("UIListLayout", NavButtons)
NavLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavLayout.Padding = UDim.new(0, 20)

local MainTitle = Instance.new("TextLabel")
MainTitle.Position = UDim2.new(0, 80, 0, 15)
MainTitle.Size = UDim2.new(0, 200, 0, 20)
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 16
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = Main

local SubTitle = Instance.new("TextLabel")
SubTitle.Position = UDim2.new(0, 80, 0, 33)
SubTitle.Size = UDim2.new(0, 200, 0, 15)
SubTitle.TextColor3 = Color3.fromRGB(100, 100, 105)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.BackgroundTransparency = 1
SubTitle.Parent = Main

local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -90, 1, -100)
Pages.Position = UDim2.new(0, 80, 0, 65)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

-- Утилиты
local function equipItem()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local character = LocalPlayer.Character
    if backpack and character and character:FindFirstChild("Humanoid") then
        local items = backpack:GetChildren()
        if items[SLOT_NUMBER] then
            character.Humanoid:EquipTool(items[SLOT_NUMBER])
        end
    end
end

local function createToggleButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Btn.Text = text .. ": OFF"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 14
    Btn.Parent = parent
    Instance.new("UICorner", Btn)

    local state = false
    Btn.Activated:Connect(function()
        state = not state
        Btn.Text = text .. (state and ": ON" or ": OFF")
        Btn.TextColor3 = state and CurrentThemeColor or Color3.fromRGB(200, 200, 200)
        callback(state)
    end)
    return Btn
end

local function SaveCurrentSettings()
    local data = {Theme = {CurrentThemeColor.R, CurrentThemeColor.G, CurrentThemeColor.B}}
    pcall(function()
        writefile(ConfigFileName, HttpService:JSONEncode(data))
    end)
end

local function LoadAutoSettings()
    if isfile and isfile(ConfigFileName) then
        pcall(function()
            local data = HttpService:JSONDecode(readfile(ConfigFileName))
            if data and data.Theme then
                CurrentThemeColor = Color3.new(data.Theme[1], data.Theme[2], data.Theme[3])
            end
        end)
    end
end

local function UpdateThemeColor(newColor)
    CurrentThemeColor = newColor
    Glow.ImageColor3 = newColor
    Logo.ImageColor3 = newColor
    DragIcon.ImageColor3 = newColor
    ResizeIcon.ImageColor3 = newColor
    for _, v in pairs(NavButtons:GetChildren()) do
        if v:IsA("ImageButton") and v:GetAttribute("Active") then
            v.ImageColor3 = newColor
        end
    end
    SaveCurrentSettings()
end

-- Карточки и страницы
local function createCard(parent, title)
    local Card = Instance.new("Frame")
    Card.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Card.Parent = parent
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local Stroke = Instance.new("UIStroke", Card)
    Stroke.Color = Color3.fromRGB(35, 35, 40)

    local Tl = Instance.new("TextLabel", Card)
    Tl.Text = title:upper()
    Tl.Size = UDim2.new(1, -20, 0, 30)
    Tl.Position = UDim2.new(0, 10, 0, 5)
    Tl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tl.Font = Enum.Font.GothamBold
    Tl.TextSize = 12
    Tl.BackgroundTransparency = 1
    Tl.TextXAlignment = Enum.TextXAlignment.Left

    local Content = Instance.new("Frame", Card)
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -20, 1, -45)
    Content.Position = UDim2.new(0, 10, 0, 40)
    Content.BackgroundTransparency = 1

    Instance.new("UIListLayout", Content).Padding = UDim.new(0, 8)
    return Content
end

local function createPage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "_Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 0
    Page.Visible = false
    Page.Parent = Pages

    local Grid = Instance.new("UIGridLayout", Page)
    Grid.CellSize = UDim2.new(0.485, 0, 0, 220)
    Grid.CellPadding = UDim2.new(0, 12, 0, 12)
    return Page
end

local tabs = {
    {id = "81381827579989", name = "Main", sub = "Profile Details", col1 = "Main Features", col2 = "Extra Options"},
    {id = "6031068426", name = "Objects", sub = "World Data", col1 = "Boxes", col2 = "Object Mods"},
    {id = "11715804818", name = "Location", sub = "World Position", col1 = "Teleportation", col2 = "Waypoints"},
    {id = "137067025238662", name = "Combat", sub = "Weaponry", col1 = "Aimbot", col2 = "Misc Combat"},
    {id = "103289157776464", name = "Visuals", sub = "Render Settings", col1 = "ESP", col2 = "Chams"},
    {id = "76450275833193", name = "Player", sub = "Character Mods", col1 = "Movement", col2 = "Jump"},
    {id = "139799066359532", name = "Notifications", sub = "Events Log", col1 = "Log Settings", col2 = "History"},
    {id = "10734950309", name = "Settings", sub = "UI Configuration", col1 = "Themes", col2 = "System Info"}
}

local createdPages = {}
for _, info in pairs(tabs) do
    local p = createPage(info.name)
    createdPages[info.name] = p
    local c1 = createCard(p, info.col1)
    local c2 = createCard(p, info.col2)

    if info.name == "Combat" then
        createToggleButton(c1, "Auto Clicker", function(val)
            AutoClickerEnabled = val
            if val then
                task.spawn(function()
                    while AutoClickerEnabled do
                        pcall(function()
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(851, 158), Workspace.CurrentCamera.CFrame)
                        end)
                        task.wait(0.5)
                    end
                end)
            end
        end)

        createToggleButton(c2, "Auto Boss Farm", function(val)
            AutoFarmEnabled = val
            if val then
                task.spawn(function()
                    local playerService = LocalPlayer
                    local function setAnchor(state)
                        if playerService.Character and playerService.Character:FindFirstChild("HumanoidRootPart") then
                            playerService.Character.HumanoidRootPart.Anchored = state
                        end
                    end
                    local function isSelected(name)
                        if SelectedBoss == "All" then return true end
                        for _, b in pairs(SelectedBosses) do
                            if b == name then return true end
                        end
                        return false
                    end
                    while AutoFarmEnabled do
                        task.wait(1)
                        if not AutoFarmEnabled then break end
                        if isSelected("Titan") then
                            setAnchor(false)
                            equipItem()
                            if Workspace.Bosses and Workspace.Bosses.Waiting and Workspace.Bosses.Waiting:FindFirstChild("Titan") then
                                playerService.Character.HumanoidRootPart.CFrame = Workspace.Bosses.Waiting.Titan.qw.CFrame
                            end
                            task.wait(8)
                            local titanTarget = Workspace.RespawnMobs and Workspace.RespawnMobs:FindFirstChild("Titan") and Workspace.RespawnMobs.Titan.Titan:FindFirstChild("Titan")
                            if titanTarget then
                                playerService.Character.HumanoidRootPart.CFrame = titanTarget.Parent.CFrame
                                local t = tick()
                                repeat task.wait() until playerService.Character.Humanoid.FloorMaterial ~= Enum.Material.Air or tick()-t > 1
                                setAnchor(true)
                                repeat task.wait(1) until not Workspace.RespawnMobs.Titan.Titan:FindFirstChild("Titan") or not AutoFarmEnabled
                                setAnchor(false)
                            end
                            task.wait(2)
                        end
                        if isSelected("Muscle") then
                            setAnchor(false)
                            equipItem()
                            if Workspace.Bosses and Workspace.Bosses.Waiting and Workspace.Bosses.Waiting:FindFirstChild("Muscle") then
                                playerService.Character.HumanoidRootPart.CFrame = Workspace.Bosses.Waiting.Muscle.qw.CFrame
                            end
                            task.wait(8)
                            local muscleTarget = Workspace.RespawnMobs and Workspace.RespawnMobs:FindFirstChild("Muscle") and Workspace.RespawnMobs.Muscle.Muscle:FindFirstChild("Muscle")
                            if muscleTarget then
                                playerService.Character.HumanoidRootPart.CFrame = muscleTarget.Parent.CFrame
                                local t = tick()
                                repeat task.wait() until playerService.Character.Humanoid.FloorMaterial ~= Enum.Material.Air or tick()-t > 1
                                setAnchor(true)
                                repeat task.wait(1) until not Workspace.RespawnMobs.Muscle.Muscle:FindFirstChild("Muscle") or not AutoFarmEnabled
                                setAnchor(false)
                            end
                            task.wait(2)
                        end
                        if isSelected("White") then
                            setAnchor(false)
                            equipItem()
                            if Workspace.Bosses and Workspace.Bosses.Waiting and Workspace.Bosses.Waiting:FindFirstChild("White") then
                                playerService.Character.HumanoidRootPart.CFrame = Workspace.Bosses.Waiting.White.qw.CFrame
                            end
                            task.wait(8)
                            local whiteTarget = Workspace.RespawnMobs and Workspace.RespawnMobs:FindFirstChild("White") and Workspace.RespawnMobs.White.White:FindFirstChild("White")
                            if whiteTarget then
                                playerService.Character.HumanoidRootPart.CFrame = whiteTarget.Parent.CFrame
                                local t = tick()
                                repeat task.wait() until playerService.Character.Humanoid.FloorMaterial ~= Enum.Material.Air or tick()-t > 1
                                setAnchor(true)
                                repeat task.wait(1) until not Workspace.RespawnMobs.White.White:FindFirstChild("White") or not AutoFarmEnabled
                                setAnchor(false)
                            end
                            task.wait(5)
                        end
                    end
                    setAnchor(false)
                end)
            else
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.Anchored = false
                end
            end
        end)

        local bossDrop = Instance.new("TextButton", c2)
        bossDrop.Size = UDim2.new(1, 0, 0, 30)
        bossDrop.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        bossDrop.Text = "Select Bosses ▼"
        bossDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
        bossDrop.Font = Enum.Font.Gotham
        Instance.new("UICorner", bossDrop)

        local bossList = Instance.new("Frame", bossDrop)
        bossList.Size = UDim2.new(1, 0, 0, 120)
        bossList.Position = UDim2.new(0, 0, 1, 5)
        bossList.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        bossList.Visible = false
        bossList.ZIndex = 50
        Instance.new("UICorner", bossList)

        local blsc = Instance.new("ScrollingFrame", bossList)
        blsc.Size = UDim2.new(1, 0, 1, 0)
        blsc.BackgroundTransparency = 1
        blsc.ScrollBarThickness = 0
        Instance.new("UIListLayout", blsc)

        local bosses = {"Titan", "Muscle", "White", "All"}
        for _, name in pairs(bosses) do
            local tb = Instance.new("TextButton", blsc)
            tb.Size = UDim2.new(1, 0, 0, 30)
            tb.BackgroundTransparency = 1
            tb.Text = name
            tb.TextColor3 = Color3.fromRGB(200, 200, 200)
            tb.Font = Enum.Font.GothamSemibold
            tb.ZIndex = 51

            tb.Activated:Connect(function()
                if name == "All" then
                    SelectedBoss = "All"
                    SelectedBosses = {}
                    bossDrop.Text = "Target: All ▼"
                else
                    SelectedBoss = "Custom"
                    local found = false
                    for i, b in pairs(SelectedBosses) do
                        if b == name then
                            table.remove(SelectedBosses, i)
                            found = true
                            break
                        end
                    end
                    if not found then table.insert(SelectedBosses, name) end
                    if #SelectedBosses == 0 then
                        bossDrop.Text = "Select Bosses ▼"
                    else
                        bossDrop.Text = "Target: " .. table.concat(SelectedBosses, ", ") .. " ▼"
                    end
                end

                for _, button in pairs(blsc:GetChildren()) do
                    if button:IsA("TextButton") then
                        button.TextColor3 = Color3.fromRGB(200, 200, 200)
                        for _, sel in pairs(SelectedBosses) do
                            if button.Text == sel then button.TextColor3 = Color3.fromRGB(80, 255, 120) end
                        end
                        if SelectedBoss == "All" and button.Text == "All" then button.TextColor3 = Color3.fromRGB(80, 255, 120) end
                    end
                end
            end)
        end
        bossDrop.Activated:Connect(function() bossList.Visible = not bossList.Visible end)

-- ──────────────────────────────
--       ULTIMATE KILL AURA v4
--    БЬЁТ НА РАССТОЯНИИ БЕЗ ТЕЛЕПОРТА!
-- ──────────────────────────────

local AuraEnabled = false
local AuraRadius = 45  -- Радиус атаки (увеличил для дистанции)
local AttackDelay = 0.085  -- Частота (безопасно ~12 атак/сек)
local lp = LocalPlayer
local camera = Workspace.CurrentCamera

task.spawn(function()
    while true do
        if not AuraEnabled then
            task.wait(0.3)
            continue
        end

        local char = lp.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            task.wait(AttackDelay)
            continue
        end

        local hrp = char.HumanoidRootPart
        local hum = char:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then
            task.wait(AttackDelay)
            continue
        end

        -- АВТО-ЭКИП ТУЛ (слот 2 или первый доступный)
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then
            equipItem()  -- Твоя функция из скрипта
            task.wait(0.1)
            tool = char:FindFirstChildOfClass("Tool")
        end
        if not tool then
            task.wait(AttackDelay)
            continue
        end

        -- НАХОДИМ БЛИЖАЙШУЮ ЦЕЛЬ
        local closest, minDist = nil, AuraRadius
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == lp then continue end
            local tchar = plr.Character
            if not tchar then continue end
            local thrp = tchar:FindFirstChild("HumanoidRootPart")
            local thum = tchar:FindFirstChild("Humanoid")
            if thrp and thum and thum.Health > 0 then
                local dist = (thrp.Position - hrp.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = tchar
                end
            end
        end

        if not closest then
            task.wait(AttackDelay)
            continue
        end

        local targetHrp = closest.HumanoidRootPart
        local targetHum = closest.Humanoid

        -- 1. ПОВОРОТ КАМЕРЫ/ГОЛОВЫ К ЦЕЛИ (silent aim - сервер думает, что смотришь)
        local oldCameraCFrame = camera.CFrame
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetHrp.Position)

        local head = char:FindFirstChild("Head")
        local neck = head and head:FindFirstChild("Neck")
        if neck and neck:IsA("Motor6D") then
            local oldNeckC0 = neck.C0
            neck.C0 = CFrame.new() * CFrame.lookAt(Vector3.new(), targetHrp.Position - head.Position)
        end

        -- 2. Handle - расширяем хитбокс (сервер видит касание!)
        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
        local oldHandleSize = handle and handle.Size
        local oldCanCollide = handle and handle.CanCollide
        local oldCanQuery = handle and handle.CanQuery

        if handle then
            handle.CanCollide = false
            handle.CanQuery = true
            handle.Size = Vector3.new(AuraRadius * 1.5, AuraRadius * 1.5, AuraRadius * 1.5)
        end

        -- 3. АКТИВАЦИЯ + TOUCH BYPASS (ГЛАВНЫЙ СЕКРЕТ - работает в 95% игр!)
        tool:Activate()
        if handle and targetHrp then
            firetouchinterest(handle, targetHrp, 0)
            task.wait(0.015)
            firetouchinterest(handle, targetHrp, 1)
        end

        -- 4. FIRE ВСЕ REMOTES (Tool + ReplicatedStorage)
        for _, obj in ipairs(tool:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                pcall(function()
                    obj:FireServer(targetHrp, targetHrp.Position, targetHum)
                    obj:FireServer(targetHum)
                    obj:FireServer("Hit", targetHrp)
                end)
            end
        end

        -- Ищем remotes в ReplicatedStorage (часто там общие combat remotes)
        local rs = game:GetService("ReplicatedStorage")
        for _, rem in ipairs(rs:GetDescendants()) do
            if rem.Name:lower():find("hit") or rem.Name:lower():find("damage") or rem.Name:lower():find("attack") or rem.Name:lower():find("combat") then
                if rem:IsA("RemoteEvent") then
                    pcall(function()
                        rem:FireServer(targetHrp)
                    end)
                end
            end
        end

        -- 5. ВОЗВРАЩАЕМ ВСЁ НА МЕСТО (НЕВИДИМЫЙ BYPASS!)
        task.wait(0.025)
        camera.CFrame = oldCameraCFrame
        if neck then
            neck.C0 = oldNeckC0
        end
        if handle then
            handle.Size = oldHandleSize
            handle.CanCollide = oldCanCollide
            handle.CanQuery = oldCanQuery
        end

        task.wait(AttackDelay)
    end
end)

-- КНОПКА (оставь как есть)
createToggleButton(c1, "Kill aura(only pc)", function(val)
    AuraEnabled = val
end)
end

    if info.name == "Settings" then
        local themeDrop = Instance.new("TextButton", c1)
        themeDrop.Size = UDim2.new(1, 0, 0, 30)
        themeDrop.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        themeDrop.Text = "Select Theme ▼"
        themeDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
        themeDrop.Font = Enum.Font.Gotham
        Instance.new("UICorner", themeDrop)

        local themeList = Instance.new("Frame", themeDrop)
        themeList.Size = UDim2.new(1, 0, 0, 150)
        themeList.Position = UDim2.new(0, 0, 1, 5)
        themeList.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        themeList.Visible = false
        themeList.ZIndex = 50
        Instance.new("UICorner", themeList)

        local tlsc = Instance.new("ScrollingFrame", themeList)
        tlsc.Size = UDim2.new(1, 0, 1, 0)
        tlsc.BackgroundTransparency = 1
        tlsc.CanvasSize = UDim2.new(0,0,0,250)
        tlsc.ScrollBarThickness = 2
        Instance.new("UIListLayout", tlsc)

        local themes = {
            ["Blue"] = Color3.fromRGB(80, 150, 255),
            ["Red"] = Color3.fromRGB(255, 80, 80),
            ["Green"] = Color3.fromRGB(80, 255, 120),
            ["Purple"] = Color3.fromRGB(160, 80, 255),
            ["Orange"] = Color3.fromRGB(255, 160, 80),
            ["Pink"] = Color3.fromRGB(255, 120, 200),
            ["Cyan"] = Color3.fromRGB(80, 255, 255),
            ["White"] = Color3.fromRGB(255, 255, 255)
        }

        for name, color in pairs(themes) do
            local tb = Instance.new("TextButton", tlsc)
            tb.Size = UDim2.new(1, 0, 0, 30)
            tb.BackgroundTransparency = 1
            tb.Text = name
            tb.TextColor3 = color
            tb.Font = Enum.Font.GothamSemibold
            tb.ZIndex = 51

            tb.Activated:Connect(function()
                UpdateThemeColor(color)
                themeDrop.Text = name .. " Theme"
                themeDrop.TextColor3 = color
                themeList.Visible = false
            end)
        end

        themeDrop.Activated:Connect(function() themeList.Visible = not themeList.Visible end)
    end

    -- Auto Sacrifice (Main page)
    if info.name == "Main" then
        local vim = game:GetService("VirtualInputManager")

        local SacConfigs = {
            ["Sacrifice 1W (Lvl 12)"] = { zone = "Sacrifice1W", btnText = "12 Level", reqLevel = 12 },
            ["Sacrifice 2W (Lvl 100)"] = { zone = "Sacrifice2W", btnText = "100 Level", reqLevel = 100 },
            ["Sacrifice 3W (Lvl 240)"] = { zone = "Sacrifice3W", btnText = "240 Level", reqLevel = 240 },
            ["Sacrifice 4W (Lvl 450)"] = { zone = "Sacrifice4W", btnText = "450 Level", reqLevel = 450 },
            ["Sacrifice 5W (Lvl 2K)"] = { zone = "Sacrifice5W", btnText = "2K Level", reqLevel = 2000 },
            ["Sacrifice 6W (Lvl 6K)"] = { zone = "Sacrifice6W", btnText = "6K Level", reqLevel = 6000 }
        }

        local function pressSacButton(textToFind)
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    local GuiService = game:GetService("GuiService") -- Добавляем сервис
    
    if pGui then
        for _, v in pairs(pGui:GetDescendants()) do
            if v:IsA("TextButton") and v.Visible and v.Text == textToFind then
                local pos = v.AbsolutePosition
                local size = v.AbsoluteSize
                
                -- Получаем автоматический отступ (обычно 36 или 58 пикселей)
                local inset = GuiService:GetGuiInset()
                
                -- Рассчитываем центр с учетом системного отступа
                local centerX = pos.X + (size.X / 2) + inset.X
                local centerY = pos.Y + (size.Y / 2) + inset.Y
                
                vim:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
                task.wait(0.01)
                vim:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
                return true
            end
        end
    end
    return false
end

        local function checkAndSacrifice()
            if not AutoSacEnabled or SelectedSacMode == "None" then return end
            local cfg = SacConfigs[SelectedSacMode]
            if not cfg then return end

            local stats = LocalPlayer:FindFirstChild("Stats")
            if stats and stats:FindFirstChild("Level") and stats.Level.Value >= cfg.reqLevel then
                local sacZone = Workspace:FindFirstChild("Allguimap") and Workspace.Allguimap:FindFirstChild(cfg.zone)
                if sacZone and sacZone:FindFirstChild("Open") then
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, sacZone.Open, 0)
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, sacZone.Open, 1)

                    task.delay(0.15, function()
                        pressSacButton(cfg.btnText)
                    end)
                end
            end
        end

        createToggleButton(c2, "Enable Auto Sacrifice", function(val)
            AutoSacEnabled = val
            if val then checkAndSacrifice() end
        end)

        local sacDrop = Instance.new("TextButton", c2)
        sacDrop.Size = UDim2.new(1, 0, 0, 30)
        sacDrop.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        sacDrop.Text = "Select World ▼"
        sacDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
        sacDrop.Font = Enum.Font.Gotham
        Instance.new("UICorner", sacDrop)

        local sacList = Instance.new("Frame", sacDrop)
        sacList.Size = UDim2.new(1, 0, 0, 150)
        sacList.Position = UDim2.new(0, 0, 1, 5)
        sacList.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        sacList.Visible = false
        sacList.ZIndex = 110
        Instance.new("UICorner", sacList)

        local slsc = Instance.new("ScrollingFrame", sacList)
        slsc.Size = UDim2.new(1, 0, 1, 0)
        slsc.BackgroundTransparency = 1
        slsc.ScrollBarThickness = 2
        slsc.CanvasSize = UDim2.new(0, 0, 0, 210)
        Instance.new("UIListLayout", slsc)

        local sacOptions = {"None", "Sacrifice 1W (Lvl 12)", "Sacrifice 2W (Lvl 100)", "Sacrifice 3W (Lvl 240)", "Sacrifice 4W (Lvl 450)", "Sacrifice 5W (Lvl 2K)", "Sacrifice 6W (Lvl 6K)"}
        for _, optName in pairs(sacOptions) do
            local ob = Instance.new("TextButton", slsc)
            ob.Size = UDim2.new(1, 0, 0, 30)
            ob.BackgroundTransparency = 1
            ob.Text = optName
            ob.TextColor3 = Color3.fromRGB(200, 200, 200)
            ob.Font = Enum.Font.GothamSemibold
            ob.ZIndex = 111

            ob.Activated:Connect(function()
                SelectedSacMode = optName
                sacDrop.Text = "Mode: " .. optName .. " ▼"
                sacList.Visible = false
                checkAndSacrifice()
            end)
        end

        sacDrop.Activated:Connect(function() sacList.Visible = not sacList.Visible end)

        task.spawn(function()
            while true do
                if AutoSacEnabled and SelectedSacMode ~= "None" then
                    checkAndSacrifice()
                end
                task.wait(1)
            end
        end)
    end

    -- Location (Teleport)
    if info.name == "Location" then
        local worldDrop = Instance.new("TextButton", c1)
        worldDrop.Size = UDim2.new(1, 0, 0, 30)
        worldDrop.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        worldDrop.Text = "Select World: World1 ▼"
        worldDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
        worldDrop.Font = Enum.Font.Gotham
        Instance.new("UICorner", worldDrop)

        local worldList = Instance.new("Frame", worldDrop)
        worldList.Size = UDim2.new(1, 0, 0, 150)
        worldList.Position = UDim2.new(0, 0, 1, 5)
        worldList.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        worldList.Visible = false
        worldList.ZIndex = 100
        Instance.new("UICorner", worldList)

        local wlsc = Instance.new("ScrollingFrame", worldList)
        wlsc.Size = UDim2.new(1, 0, 1, 0)
        wlsc.BackgroundTransparency = 1
        wlsc.ScrollBarThickness = 2
        wlsc.CanvasSize = UDim2.new(0, 0, 0, 300)
        Instance.new("UIListLayout", wlsc)

        local worlds = {"World", "World1", "World2", "World3", "World4", "World5", "World7", "World8", "World9"}
        for _, name in pairs(worlds) do
            local wb = Instance.new("TextButton", wlsc)
            wb.Size = UDim2.new(1, 0, 0, 30)
            wb.BackgroundTransparency = 1
            wb.Text = name
            wb.TextColor3 = Color3.fromRGB(200, 200, 200)
            wb.Font = Enum.Font.GothamSemibold
            wb.ZIndex = 101

            wb.Activated:Connect(function()
                SelectedWorld = name
                worldDrop.Text = "Select World: " .. name .. " ▼"
                worldList.Visible = false
            end)
        end

        worldDrop.Activated:Connect(function() worldList.Visible = not worldList.Visible end)

        
local tpBtn = Instance.new("TextButton", c1)
        tpBtn.Size = UDim2.new(1, 0, 0, 35)
        tpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        tpBtn.Text = "TELEPORT"
        tpBtn.TextColor3 = CurrentThemeColor
        tpBtn.Font = Enum.Font.GothamBold
        tpBtn.TextSize = 14
        Instance.new("UICorner", tpBtn)
        tpBtn.Activated:Connect(function()
            local target = Workspace:FindFirstChild(SelectedWorld)
            local character = LocalPlayer.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if target and root then
                root.CFrame = target.CFrame * CFrame.new(0, 22, 0)
            end
        end)
    end

    -- Player (Speed & Jump)
    if info.name == "Player" then
        local function createStatInput(parent, text, defaultText, callback)
            local Container = Instance.new("Frame", parent)
            Container.Size = UDim2.new(1, 0, 0, 45)
            Container.BackgroundTransparency = 1

            local Label = Instance.new("TextLabel", Container)
            Label.Text = text
            Label.Size = UDim2.new(0.6, 0, 1, 0)
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1

            local Input = Instance.new("TextBox", Container)
            Input.Size = UDim2.new(0.35, 0, 0.7, 0)
            Input.Position = UDim2.new(0.65, 0, 0.15, 0)
            Input.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
            Input.PlaceholderText = defaultText
            Input.Text = ""
            Input.TextColor3 = CurrentThemeColor
            Input.Font = Enum.Font.GothamBold
            Input.TextSize = 14
            Instance.new("UICorner", Input)

            Input.FocusLost:Connect(function()
                local num = tonumber(Input.Text)
                if num then callback(num) end
            end)
        end

        createStatInput(c1, "Walk Speed", "16", function(value)
            CurrentWalkSpeed = value
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = value
            end
        end)

        createStatInput(c2, "Jump Power", "50", function(value)
            CurrentJumpPower = value
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.UseJumpPower = true
                char.Humanoid.JumpPower = value
            end
        end)
    end

    -- Objects - Auto orbs + Auto open boxes
    if info.name == "Objects" then
        createToggleButton(c2, "Auto orbs", function(val)
            AutoBringEnabled = val
            if val then
                task.spawn(function()
                    while AutoBringEnabled do
                        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local addFolder = Workspace:FindFirstChild("Add")
                        if root and addFolder then
                            for _, item in pairs(addFolder:GetDescendants()) do
                                if item:IsA("BasePart") and item.Name:sub(1,1) == "B" then
                                    item.CanCollide = false
                                    item.AssemblyLinearVelocity = Vector3.new(0,0,0)
                                    item.AssemblyAngularVelocity = Vector3.new(0,0,0)
                                    item.CFrame = root.CFrame * CFrame.new(0, 3.5, 0)
                                end
                            end
                        end
                        task.wait(0.1)
                    end
                end)
            end
        end)

        -- AFK Farm боксов
        local CleanBoxList = {
            {"Box1", "Free"}, {"Box2", "1K cash"}, {"Box3", "1M cash"},
            {"Box4", "1T cash"}, {"Box5", "1Sx cash"}, {"Box6", "0.1 asc"},
            {"Box7", "100 asc"}, {"Box8", "1K asc"}, {"Box9", "10K asc"},
            {"Box10", "40K asc"}, {"Box11", "400K asc"},
            {"CrownBox1", "2B crown"}, {"CrownBox2", "1T crown"},
            {"DiamondBox1", "10 diamonds"}, {"DiamondBox2", "100 diamonds"}, {"DiamondBox3", "300 diamonds"}
        }

        local function DoStickyFarm()
            if not AFKFarmEnabled then return end
            local boxes = Workspace:FindFirstChild("Boxs")
            if not boxes then return end
            local target = boxes:FindFirstChild(SelectedBoxName)
            if target and target:FindFirstChild("Part") then
                local part = target.Part
                local prompt = part:FindFirstChild("E") or part:FindFirstChild("T")
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and prompt then
                    if not FloatForce or not FloatForce.Parent then
                        FloatForce = Instance.new("BodyVelocity")
                        FloatForce.Velocity = Vector3.new(0,0,0)
                        FloatForce.MaxForce = Vector3.new(9e9,9e9,9e9)
                        FloatForce.Parent = hrp
                    end
                    hrp.CFrame = part.CFrame * CFrame.new(0,4,0)
                    fireproximityprompt(prompt)
                end
            end
        end

        local bDrop = Instance.new("TextButton", c1)
        bDrop.Size = UDim2.new(1,0,0,30)
        bDrop.BackgroundColor3 = Color3.fromRGB(30,30,35)
        bDrop.Text = "Target: " .. SelectedBoxName .. " ▼"
        bDrop.TextColor3 = Color3.new(1,1,1)
        bDrop.Font = Enum.Font.GothamBold
        bDrop.TextSize = 13
        Instance.new("UICorner", bDrop)

        local bFrame = Instance.new("Frame", bDrop)
        bFrame.Size = UDim2.new(1,0,0,150)
        bFrame.Position = UDim2.new(0,0,1,5)
        bFrame.BackgroundColor3 = Color3.fromRGB(25,25,30)
        bFrame.Visible = false
        bFrame.ZIndex = 5000
        Instance.new("UICorner", bFrame)

        local bScroll = Instance.new("ScrollingFrame", bFrame)
        bScroll.Size = UDim2.new(1,-6,1,-6)
        bScroll.Position = UDim2.new(0,3,0,3)
        bScroll.BackgroundTransparency = 1
        bScroll.CanvasSize = UDim2.new(0,0,0, (#CleanBoxList * 27) + 15)
        bScroll.ScrollBarThickness = 2
        bScroll.ZIndex = 5001
        Instance.new("UIListLayout", bScroll)

        for _, data in pairs(CleanBoxList) do
            local name, note = data[1], data[2]
            local btn = Instance.new("TextButton", bScroll)
            btn.Size = UDim2.new(1,0,0,25)
            btn.BackgroundColor3 = Color3.fromRGB(35,35,40)
            btn.BackgroundTransparency = 0.6
            btn.Text = " " .. name .. " [" .. note .. "]"
            btn.TextColor3 = Color3.fromRGB(200,200,200)
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 11
            btn.ZIndex = 5002
            Instance.new("UICorner", btn)

            btn.Activated:Connect(function()
                SelectedBoxName = name
                bDrop.Text = "Target: " .. name .. " ▼"
                bFrame.Visible = false
            end)
        end

        bDrop.Activated:Connect(function() bFrame.Visible = not bFrame.Visible end)

        createToggleButton(c1, "Auto open", function(val)
            AFKFarmEnabled = val
            if not val and FloatForce then FloatForce:Destroy() FloatForce = nil end
            if val then
                task.spawn(function()
                    while AFKFarmEnabled do
                        DoStickyFarm()
                        task.wait(0.2)
                    end
                end)
            end
        end)
    end

    -- Visuals — ESP + Names
    if info.name == "Visuals" then
        local function ApplyVisuals(player)
            if player == LocalPlayer then return end
            local function setup(character)
                local hl = Instance.new("Highlight")
                hl.Name = "ESPHighlight"
                hl.Parent = character
                hl.FillTransparency = 0.5
                hl.OutlineColor = Color3.new(1,1,1)
                hl.FillColor = CurrentThemeColor
                hl.Enabled = ESP_Enabled

                local head = character:WaitForChild("Head", 5)
                if head and not head:FindFirstChild("ESPName") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESPName"
                    billboard.Parent = head
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Enabled = ESP_Enabled

                    local label = Instance.new("TextLabel")
                    label.Parent = billboard
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.Text = player.DisplayName or player.Name
                    label.TextColor3 = Color3.new(1,1,1)
                    label.Font = Enum.Font.GothamBold
                    label.TextSize = 14
                    label.TextStrokeTransparency = 0.5

                    local stroke = Instance.new("UIStroke", label)
                    stroke.Transparency = 0.2
                    stroke.Thickness = 1
                    stroke.Color = CurrentThemeColor
                end
            end

            if player.Character then setup(player.Character) end
            player.CharacterAdded:Connect(setup)
        end

        for _, p in pairs(Players:GetPlayers()) do ApplyVisuals(p) end
        Players.PlayerAdded:Connect(ApplyVisuals)

        createToggleButton(c1, "PLAYER ESP + NAMES", function(val)
            ESP_Enabled = val
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    local hl = p.Character:FindFirstChild("ESPHighlight")
                    if hl then hl.Enabled = val end
                    local head = p.Character:FindFirstChild("Head")
                    if head and head:FindFirstChild("ESPName") then
                        head.ESPName.Enabled = val
                    end
                end
            end
        end)
    end
end

-- Авто-экипировка Weight при AutoSac
task.spawn(function()
    while true do
        if AutoSacEnabled then
            local char = LocalPlayer.Character
            if char and not char:FindFirstChild("Weight") then
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                local weight = backpack and backpack:FindFirstChild("Weight")
                if weight then
                    char:FindFirstChildOfClass("Humanoid"):EquipTool(weight)
                end
            end
        end
        task.wait(0.5)
    end
end)

-- ────────────────────────────────
--          DRAG & RESIZE
-- ────────────────────────────────

local UIS = game:GetService("UserInputService")

-- Переменные для drag
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

-- Переменные для resize
local resizing = false
local resizeInput = nil
local resizeStart = nil
local startSize = nil

-- Функция начала drag
local function onDragInputBegan(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 
       and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    
    dragging = true
    dragStart = input.Position
    startPos = Main.Position
    
    -- Отслеживаем окончание именно этого ввода
    local conn
    conn = input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
            conn:Disconnect()
        end
    end)
end

-- Функция начала resize
local function onResizeInputBegan(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 
       and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    
    resizing = true
    resizeStart = input.Position
    startSize = Main.Size
    
    -- Отслеживаем окончание именно этого ввода
    local conn
    conn = input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            resizing = false
            conn:Disconnect()
        end
    end)
end

-- Движение мыши / пальца
UIS.InputChanged:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseMovement 
       and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    
    if dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
    
    if resizing then
        local delta = input.Position - resizeStart
        local newW = math.max(320, startSize.X.Offset + delta.X)
        local newH = math.max(240, startSize.Y.Offset + delta.Y)
        Main.Size = UDim2.new(0, newW, 0, newH)
    end
end)

-- Подключаем начало действий
DragIcon.InputBegan:Connect(onDragInputBegan)
ResizeIcon.InputBegan:Connect(onResizeInputBegan)

-- Дополнительная страховка (на случай багов Roblox с InputEnded)
DragIcon.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

ResizeIcon.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
       or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)
-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "BlueBird_Toggle"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
ToggleButton.Position = UDim2.new(0.5, -50, 0, 5)
ToggleButton.Size = UDim2.new(0, 100, 0, 35)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "MENU"
ToggleButton.TextColor3 = CurrentThemeColor
ToggleButton.TextSize = 14
ToggleButton.ZIndex = 100
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

ToggleButton.Activated:Connect(function()
    Main.Visible = not Main.Visible
    ToggleButton.Text = Main.Visible and "CLOSE" or "MENU"
end)

task.spawn(function()
    while true do
        ToggleButton.TextColor3 = CurrentThemeColor
        task.wait(1)
    end
end)

-- Навбар
local function showPage(name, sub)
    for _, page in pairs(createdPages) do page.Visible = false end
    if createdPages[name] then
        createdPages[name].Visible = true
        MainTitle.Text = name
        SubTitle.Text = sub
    end
end

for i, info in pairs(tabs) do
    local btn = Instance.new("ImageButton", NavButtons)
    btn.Size = UDim2.new(0, 24, 0, 24)
    btn.BackgroundTransparency = 1
    btn.Image = "rbxthumb://type=Asset&id="..info.id.."&w=420&h=420"
    btn.ImageColor3 = Color3.fromRGB(110, 115, 125)
    btn.ZIndex = 7

    btn.Activated:Connect(function()
        showPage(info.name, info.sub)
        for _, v in pairs(NavButtons:GetChildren()) do
            if v:IsA("ImageButton") then v.ImageColor3 = Color3.fromRGB(110, 115, 125) end
        end
        btn.ImageColor3 = CurrentThemeColor
    end)

    if i == 1 then
        showPage(info.name, info.sub)
        btn.ImageColor3 = CurrentThemeColor
    end
end

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

LoadAutoSettings()
UpdateThemeColor(CurrentThemeColor)

print("BlueBird_Final_V3 — полный функционал (боссы + боксы + аура + esp + sacrifice + weight) загружен")
    -- ⬆⬆⬆ ТВОЙ ОСНОВНОЙ СКРИПТ ⬆⬆⬆
end

--// GUI CREATION (RED THEME)
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "AnubisRedKeySystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame", gui)
MainFrame.Size = UDim2.fromOffset(580, 320)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

-- Левая часть
local LeftSide = Instance.new("Frame", MainFrame)
LeftSide.Size = UDim2.new(0.55, 0, 1, 0)
LeftSide.BackgroundTransparency = 1

-- КАРТИНКА
local Logo = Instance.new("ImageLabel", LeftSide)
Logo.Name = "Logo"
Logo.Size = UDim2.fromOffset(100, 100)
Logo.Position = UDim2.new(0.5, 0, 0.23, 0)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxthumb://type=Asset&id=12859565587&w=420&h=420"
Logo.ScaleType = Enum.ScaleType.Fit

local Title = Instance.new("TextLabel", LeftSide)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0.43, 0)
Title.Text = "ANUBIS"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 32
Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", LeftSide)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0.51, 0)
SubTitle.Text = "Key System"
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.TextSize = 14
SubTitle.BackgroundTransparency = 1

local box = Instance.new("TextBox", LeftSide)
box.Size = UDim2.new(0.85, 0, 0, 45)
box.Position = UDim2.new(0.5, 0, 0.65, 0)
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.PlaceholderText = "Enter your key here.."
box.Text = loadKey() or ""
box.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
box.TextColor3 = Color3.new(1, 1, 1)
box.Font = Enum.Font.Gotham
box.TextSize = 14
Instance.new("UICorner", box)

-- РАМКА ДЛЯ ПОДСВЕТКИ
local boxStroke = Instance.new("UIStroke", box)
boxStroke.Color = Color3.fromRGB(30, 30, 30)
boxStroke.Thickness = 2
boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- НАДПИСЬ МЕЖДУ ПОЛЕМ И КНОПКАМИ
local StatusLabel = Instance.new("TextLabel", LeftSide)
StatusLabel.Size = UDim2.new(0.85, 0, 0, 20)
StatusLabel.Position = UDim2.new(0.5, 0, 0.76, 0) 
StatusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200) -- Нейтральный цвет
StatusLabel.Text = ""
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12

-- Кнопки
local SubmitBtn = Instance.new("TextButton", LeftSide)
SubmitBtn.Size = UDim2.new(0.4, 0, 0, 42)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.84, 0)
SubmitBtn.Text = "SUBMIT"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
Instance.new("UICorner", SubmitBtn)

local GetKeyBtn = Instance.new("TextButton", LeftSide)
GetKeyBtn.Size = UDim2.new(0.4, 0, 0, 42)
GetKeyBtn.Position = UDim2.new(0.525, 0, 0.84, 0)
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", GetKeyBtn)

-- Правая часть
local RightSide = Instance.new("Frame", MainFrame)
RightSide.Size = UDim2.new(0.45, 0, 1, 0)
RightSide.Position = UDim2.new(0.55, 0, 0, 0)
RightSide.BackgroundTransparency = 1

local Line = Instance.new("Frame", RightSide)
Line.Size = UDim2.new(0, 1, 0.8, 0)
Line.Position = UDim2.new(0, 0, 0.1, 0)
Line.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Line.BorderSizePixel = 0

local InfoList = Instance.new("Frame", RightSide)
InfoList.Size = UDim2.new(0.9, 0, 0.7, 0)
InfoList.Position = UDim2.new(0.05, 10, 0.1, 0)
InfoList.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", InfoList)
layout.Padding = UDim.new(0, 15)

local function AddInfo(title, desc)
    local container = Instance.new("Frame", InfoList)
    container.Size = UDim2.new(1, 0, 0, 55)
    container.BackgroundTransparency = 1
    
    local t = Instance.new("TextLabel", container)
    t.Text = "⚠ " .. title
    t.Size = UDim2.new(1, 0, 0, 18)
    t.Font = Enum.Font.GothamBold
    t.TextColor3 = Color3.fromRGB(200, 30, 30)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.BackgroundTransparency = 1
    t.TextSize = 13

    local d = Instance.new("TextLabel", container)
    d.Text = desc
    d.Size = UDim2.new(1, 0, 0, 35)
    d.Position = UDim2.new(0, 0, 0, 18)
    d.Font = Enum.Font.Gotham
    d.TextColor3 = Color3.fromRGB(160, 160, 160)
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.TextWrapped = true
    d.BackgroundTransparency = 1
    d.TextSize = 11
end

AddInfo("Tired of the key system?", "You can get a premium key to skip this process entirely on our discord.")
AddInfo("Having an issue?", "Join our Discord server and dm me!")
AddInfo("How long does it take?", "It only takes 2 minutes to get a key!")

local DiscordBtn = Instance.new("TextButton", RightSide)
DiscordBtn.Size = UDim2.new(0.5, 0, 0, 30)
DiscordBtn.Position = UDim2.new(0.05, 10, 0.85, 0)
DiscordBtn.Text = "Discord Server"
DiscordBtn.Font = Enum.Font.Gotham
DiscordBtn.TextColor3 = Color3.fromRGB(150, 50, 50)
DiscordBtn.BackgroundTransparency = 1
DiscordBtn.TextSize = 13

--// ФУНКЦИЯ ПОДСВЕТКИ РАМКИ (На 2 секунды)
local function FlashStroke(color)
    boxStroke.Color = color
    task.delay(2, function()
        TweenService:Create(boxStroke, TweenInfo.new(0.5), {Color = Color3.fromRGB(30, 30, 30)}):Play()
    end)
end

--// LOGIC
SubmitBtn.MouseButton1Click:Connect(function()
    local key = box.Text:gsub("%s+","")
    if key == "" then
        StatusLabel.Text = "Please enter a key!"
        FlashStroke(Color3.fromRGB(255, 50, 50)) -- Красная рамка
        return
    end
    StatusLabel.Text = "Checking..."
    local ok, valid = pcall(function() return KeySystem().verifyKey(Config.api, key, Config.service) end)
    if ok and valid then
        StatusLabel.Text = "Key valid! Loading..."
        FlashStroke(Color3.fromRGB(50, 255, 50)) -- Зеленая рамка
        saveKey(key)
        task.wait(0.5)
        gui:Destroy()
        START_SCRIPT()
    else
        StatusLabel.Text = "Invalid key."
        FlashStroke(Color3.fromRGB(255, 50, 50)) -- Красная рамка
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    local ok, link = pcall(function() return KeySystem().getLink(Config.api, Config.provider, Config.service) end)
    if ok and link then
        if setclipboard then setclipboard(link) end
        StatusLabel.Text = "Link copied to clipboard!"
    end
end)

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then 
        setclipboard("https://discord.gg/FeSD9YyA4r") 
        StatusLabel.Text = "Discord link copied!"
    end
end)

-- AUTO CHECK
task.spawn(function()
    local saved = loadKey()
    if saved then
        local ok, valid = pcall(function() return KeySystem().verifyKey(Config.api, saved, Config.service) end)
        if ok and valid then
            StatusLabel.Text = "Saved key valid! Loading..."
            FlashStroke(Color3.fromRGB(50, 255, 50))
            task.wait(0.5)
            gui:Destroy()
            START_SCRIPT()
        end
    end
end)
