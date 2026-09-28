-- ============================================
--  时脚本 · 云服取物（精准轰炸版）
--  2遍 · 每遍20次 · 共40次
-- ============================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local oldGui = game:GetService("CoreGui"):FindFirstChild("CloudItem")
if oldGui then oldGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CloudItem"
screenGui.Parent = game:GetService("CoreGui")
screenGui.DisplayOrder = 999
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

-- 主面板
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 320)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ZIndex = 100
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = Color3.fromRGB(0, 200, 255)
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

-- 拖动
local dragging = false
local dragStart = nil
local frameStart = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        frameStart = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- 标题栏
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.BorderSizePixel = 0
topBar.ZIndex = 101
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "云服取物 · 糯米"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 102
title.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.GothamBold
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 102
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 13)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- 搜索框
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -10, 0, 30)
searchBox.Position = UDim2.new(0, 5, 0, 40)
searchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
searchBox.BorderSizePixel = 0
searchBox.Text = ""
searchBox.PlaceholderText = "搜索道具..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.TextSize = 12
searchBox.Font = Enum.Font.GothamMedium
searchBox.ZIndex = 102
searchBox.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 8)
searchCorner.Parent = searchBox

-- 滚动列表
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -120)
scrollFrame.Position = UDim2.new(0, 5, 0, 75)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ZIndex = 101
scrollFrame.Parent = mainFrame

-- 状态栏
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 20)
statusLabel.Position = UDim2.new(0, 5, 1, -25)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "准备就绪"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 102
statusLabel.Parent = mainFrame

-- ============================================
--  扫描：只搜 Tool
-- ============================================
local function scanAllTools()
    local items = {}
    local seen = {}
    
    local function scan(container, depth)
        if depth > 5 then return end
        for _, obj in ipairs(container:GetChildren()) do
            if obj:IsA("Tool") then
                local key = obj.Name
                if not seen[key] then
                    seen[key] = true
                    table.insert(items, obj)
                end
            elseif obj:IsA("Folder") or obj:IsA("Model") or obj:IsA("Configuration") then
                scan(obj, depth + 1)
            end
        end
    end
    
    scan(ReplicatedStorage, 0)
    scan(game:GetService("ServerStorage"), 0)
    scan(game:GetService("StarterPack"), 0)
    scan(game:GetService("Lighting"), 0)
    scan(workspace, 0)
    
    for _, plr in ipairs(Players:GetPlayers()) do
        local bp = plr:FindFirstChild("Backpack")
        if bp then
            for _, obj in ipairs(bp:GetChildren()) do
                if obj:IsA("Tool") and not seen[obj.Name] then
                    seen[obj.Name] = true
                    table.insert(items, obj)
                end
            end
        end
        local char = plr.Character
        if char then
            for _, obj in ipairs(char:GetChildren()) do
                if obj:IsA("Tool") and not seen[obj.Name] then
                    seen[obj.Name] = true
                    table.insert(items, obj)
                end
            end
        end
    end
    
    return items
end

-- ============================================
--  收集 Remote
-- ============================================
local function collectRemotes()
    local remotes = {}
    local function walk(container, depth)
        if depth > 4 then return end
        for _, inst in ipairs(container:GetChildren()) do
            if inst:IsA("RemoteEvent") then
                table.insert(remotes, inst)
            elseif inst:IsA("Folder") or inst:IsA("Model") then
                walk(inst, depth + 1)
            end
        end
    end
    walk(ReplicatedStorage, 0)
    return remotes
end

local cachedRemotes = nil

-- ============================================
--  精准轰炸：2遍 · 每遍20次 · 共40次
-- ============================================
local function spamBuy(itemName)
    if not cachedRemotes then
        cachedRemotes = collectRemotes()
    end
    
    local rounds = 2        -- 2遍
    local perRound = 20     -- 每遍20次
    local interval = 0.1    -- 间隔0.1秒
    
    local totalSent = 0
    
    for round = 1, rounds do
        print("🔥 第 " .. round .. " 遍开始...")
        statusLabel.Text = "轰炸中：第 " .. round .. " / " .. rounds .. " 遍"
        
        for i = 1, perRound do
            for _, r in ipairs(cachedRemotes) do
                pcall(function()
                    -- 多种参数格式全试一遍
                    r:FireServer("Buy", itemName)
                    r:FireServer("Purchase", itemName)
                    r:FireServer("Get", itemName)
                    r:FireServer(itemName)
                    r:FireServer("buy", itemName, 1)
                    r:FireServer(itemName, 1)
                    r:FireServer("Acquire", itemName)
                    r:FireServer("Take", itemName)
                    r:FireServer("Claim", itemName)
                end)
            end
            
            totalSent = totalSent + 1
            task.wait(interval)
        end
        
        print("✅ 第 " .. round .. " 遍完成")
        
        if round < rounds then
            task.wait(1)
        end
    end
    
    print("✅ 全部完成！共发送 " .. totalSent .. " 次请求")
    statusLabel.Text = "轰炸完成：" .. totalSent .. " 次"
end

-- ============================================
--  渲染列表
-- ============================================
local itemRows = {}

local function clearList()
    for _, row in ipairs(itemRows) do
        row:Destroy()
    end
    itemRows = {}
end

local function renderItems(items)
    clearList()
    
    local yPos = 5
    
    for _, item in ipairs(items) do
        local itemBtn = Instance.new("TextButton")
        itemBtn.Size = UDim2.new(1, -5, 0, 32)
        itemBtn.Position = UDim2.new(0, 0, 0, yPos)
        itemBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        itemBtn.BorderSizePixel = 0
        itemBtn.Text = ""
        itemBtn.AutoButtonColor = false
        itemBtn.ZIndex = 102
        itemBtn.Parent = scrollFrame
        
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 8)
        itemCorner.Parent = itemBtn
        
        local itemLabel = Instance.new("TextLabel")
        itemLabel.Size = UDim2.new(1, -60, 1, 0)
        itemLabel.Position = UDim2.new(0, 10, 0, 0)
        itemLabel.BackgroundTransparency = 1
        itemLabel.Text = item.Name
        itemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemLabel.TextSize = 12
        itemLabel.Font = Enum.Font.GothamMedium
        itemLabel.TextXAlignment = Enum.TextXAlignment.Left
        itemLabel.TextTruncate = Enum.TextTruncate.AtEnd
        itemLabel.ZIndex = 103
        itemLabel.Parent = itemBtn
        
        local addBtn = Instance.new("TextButton")
        addBtn.Size = UDim2.new(0, 45, 0, 22)
        addBtn.Position = UDim2.new(1, -50, 0.5, -11)
        addBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        addBtn.BorderSizePixel = 0
        addBtn.Text = "取物"
        addBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        addBtn.TextSize = 11
        addBtn.Font = Enum.Font.GothamBold
        addBtn.AutoButtonColor = false
        addBtn.ZIndex = 103
        addBtn.Parent = itemBtn
        
        local addCorner = Instance.new("UICorner")
        addCorner.CornerRadius = UDim.new(0, 6)
        addCorner.Parent = addBtn
        
        addBtn.MouseButton1Click:Connect(function()
            addBtn.Text = "..."
            addBtn.BackgroundColor3 = Color3.fromRGB(180, 150, 60)
            
            task.spawn(function()
                -- 先本地复制
                pcall(function()
                    local clone = item:Clone()
                    clone.Parent = player.Backpack
                end)
                
                -- 再精准轰炸
                spamBuy(item.Name)
                
                addBtn.Text = "✓"
                addBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                
                task.wait(1.5)
                addBtn.Text = "取物"
                addBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            end)
        end)
        
        table.insert(itemRows, itemBtn)
        yPos = yPos + 37
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 5)
    statusLabel.Text = "共 " .. #items .. " 个物品"
end

-- 搜索过滤
local allItems = {}

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q = searchBox.Text:Lower()
    if q == "" then
        renderItems(allItems)
        return
    end
    
    local filtered = {}
    for _, item in ipairs(allItems) do
        if item.Name:lower():find(q, 1, true) then
            table.insert(filtered, item)
        end
    end
    renderItems(filtered)
end)

-- 启动扫描
task.spawn(function()
    task.wait(0.3)
    allItems = scanAllTools()
    cachedRemotes = collectRemotes()
    renderItems(allItems)
    statusLabel.Text = "扫描完成：共 " .. #allItems .. " 个物品 · " .. #cachedRemotes .. " 个Remote"
end)

print("✅ 云服取物·精准轰炸版已加载")
print("📦 2遍 · 每遍20次 · 共40次")
