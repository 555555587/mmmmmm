-- ============================================
--  时脚本 · 主脚本 v5 第 1 段
--  开源免费 · 拒绝倒卖
--  我们的自由才是发展的方向
-- ============================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================
--  全局引用
-- ============================================
local CLIPBOARD_GROUP = "XXXXXXX"
local CLOUD_PICK_URL = "https://raw.githubusercontent.com/555555587/mmmmmm/main/vvv.lua"

if playerGui:FindFirstChild("ShiSplash") then
    playerGui.ShiSplash:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ShiSplash"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 799
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

-- ============================================
--  开屏
-- ============================================
local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
overlay.BackgroundTransparency = 1
overlay.BorderSizePixel = 0
overlay.ZIndex = 1
overlay.Parent = gui

local card = Instance.new("Frame")
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.44)
card.Size = UDim2.fromScale(0, 0)
card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
card.BackgroundTransparency = 0.35
card.BorderSizePixel = 0
card.ZIndex = 3
card.Parent = overlay

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 24)
cardCorner.Parent = card

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = Color3.fromRGB(255, 255, 255)
cardStroke.Thickness = 1.5
cardStroke.Transparency = 0.3
cardStroke.Parent = card

local function createTypewriter(parent, text, size, position, color, font)
    local container = Instance.new("Frame")
    container.Size = size
    container.Position = position
    container.BackgroundTransparency = 1
    container.ZIndex = 4
    container.Parent = parent

    local chars = {}
    local count = utf8.len(text) or #text
    if count == 0 then count = 1 end
    local charW = 1 / count
    local i = 0
    for _, code in utf8.codes(text) do
        local ch = utf8.char(code)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromScale(charW, 1)
        label.BackgroundTransparency = 1
        label.Text = ch
        label.TextColor3 = color
        label.TextScaled = true
        label.Font = font
        label.TextTransparency = 1
        label.ZIndex = 5
        label.AnchorPoint = Vector2.new(0.5, 0.5)
        label.Position = UDim2.fromScale(i * charW + charW / 2, 0.5)
        label.Parent = container
        table.insert(chars, label)
        i = i + 1
    end
    return container, chars
end

local function tween(obj, time, props, style, dir)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local titleContainer, titleChars = createTypewriter(
    card, "时脚本",
    UDim2.fromScale(1, 0.44), UDim2.fromScale(0, 0.06),
    Color3.fromRGB(0, 0, 0), Enum.Font.GothamBold
)

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.fromScale(1, 0.1)
subtitle.Position = UDim2.fromScale(0, 0.52)
subtitle.BackgroundTransparency = 1
subtitle.Text = "开源免费 · 拒绝倒卖"
subtitle.TextColor3 = Color3.fromRGB(80, 80, 80)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.TextTransparency = 1
subtitle.ZIndex = 4
subtitle.Parent = card

local sloganContainer, sloganChars = createTypewriter(
    card, "我们的自由才是发展的方向",
    UDim2.fromScale(1, 0.14), UDim2.fromScale(0, 0.66),
    Color3.fromRGB(0, 0, 0), Enum.Font.GothamBold
)

local barBg = Instance.new("Frame")
barBg.AnchorPoint = Vector2.new(0.5, 0.5)
barBg.Position = UDim2.fromScale(0.5, 0.64)
barBg.Size = UDim2.fromScale(0.6, 0.016)
barBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
barBg.BackgroundTransparency = 0.85
barBg.BorderSizePixel = 0
barBg.ZIndex = 3
barBg.Parent = overlay

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.fromScale(0, 1)
barFill.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
barFill.BorderSizePixel = 0
barFill.ZIndex = 4
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = barFill

local loadingText = Instance.new("TextLabel")
loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
loadingText.Position = UDim2.fromScale(0.5, 0.72)
loadingText.Size = UDim2.fromScale(0.7, 0.04)
loadingText.BackgroundTransparency = 1
loadingText.Text = "正在唤醒时脚本..."
loadingText.TextColor3 = Color3.fromRGB(30, 30, 30)
loadingText.TextScaled = true
loadingText.Font = Enum.Font.Gotham
loadingText.TextTransparency = 1
loadingText.ZIndex = 4
loadingText.Parent = overlay

local funnyTexts = {
    "正在唤醒时脚本...",
    "正在给代码泡茶...",
    "正在劝服务器别摆烂...",
    "正在数你的帧数...",
    "正在偷偷变强...",
    "马上就好，别急...",
}

local function playTypewriter(chars, speed)
    if #chars == 0 then return end
    for _, label in ipairs(chars) do
        label.Position = UDim2.fromScale(label.Position.X.Scale, 0.9)
        label.TextTransparency = 1
        tween(label, speed, {
            Position = UDim2.fromScale(label.Position.X.Scale, 0.5),
            TextTransparency = 0,
        }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        task.wait(0.06)
    end
    task.wait(speed + 0.1)

    local container = chars[1].Parent
    local originalSize = container.Size
    tween(container, 0.12, {
        Size = UDim2.fromScale(originalSize.X.Scale * 0.92, originalSize.Y.Scale * 0.92)
    }, Enum.EasingStyle.Quad, Enum.EasingDirection.In).Completed:Wait()
    tween(container, 0.18, {
        Size = originalSize
    }, Enum.EasingStyle.Back, Enum.EasingDirection.Out).Completed:Wait()
end

-- ============================================
--  黑白毛玻璃配色
-- ============================================
local GLASS_BG      = Color3.fromRGB(18, 18, 20)
local GLASS_STROKE  = Color3.fromRGB(255, 255, 255)
local GLASS_TRANS   = 0.15
local STROKE_TRANS  = 0.75
local TEXT_MAIN     = Color3.fromRGB(240, 240, 245)
local TEXT_SUB      = Color3.fromRGB(170, 170, 180)
local ACTIVE_BG     = Color3.fromRGB(60, 60, 68)
local ACTIVE_TEXT   = Color3.fromRGB(255, 255, 255)
local ROW_BG        = Color3.fromRGB(255, 255, 255)
local ROW_TRANS     = 0.5

local SW_OFF_BG     = Color3.fromRGB(70, 70, 78)
local SW_ON_BG      = Color3.fromRGB(52, 199, 89)
local SW_KNOB       = Color3.fromRGB(255, 255, 255)

local ISLAND_W = 180
local ISLAND_H = 42

-- ============================================
--  设置状态（全局可读写）
-- ============================================
local settings = {
    fancyClose = false,
    sideNav = false,
    squareToggle = false,
    espEnabled = false,
    aimEnabled = false,
}

-- 一周年状态
local anniversaryOn = false

-- ============================================
--  背景模糊（清旧）
-- ============================================
for _, v in ipairs(Lighting:GetChildren()) do
    if v:IsA("BlurEffect") and v.Name == "ShiBlur" then
        v:Destroy()
    end
end

local blur = Instance.new("BlurEffect")
blur.Name = "ShiBlur"
blur.Size = 0
blur.Parent = Lighting

-- ============================================
--  剪贴板
-- ============================================
local function tryCopy(text)
    if setclipboard then
        local ok = pcall(setclipboard, text)
        if ok then return true end
    end
    if clipboard ~= nil then
        local ok = pcall(function() clipboard = text end)
        if ok then return true end
    end
    return false
end

local function playCopyCheck(parentGui)
    local old = parentGui:FindFirstChild("CopyCheckToast")
    if old then old:Destroy() end

    local toast = Instance.new("Frame")
    toast.Name = "CopyCheckToast"
    toast.AnchorPoint = Vector2.new(0.5, 0)
    toast.Position = UDim2.new(0.5, 0, 0, -120)
    toast.Size = UDim2.fromOffset(200, 90)
    toast.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    toast.BackgroundTransparency = 0.08
    toast.BorderSizePixel = 0
    toast.ZIndex = 200
    toast.Parent = parentGui

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 20)
    tc.Parent = toast

    local ts = Instance.new("UIStroke")
    ts.Color = Color3.fromRGB(255, 255, 255)
    ts.Thickness = 1
    ts.Transparency = 0.7
    ts.Parent = toast

    local circle = Instance.new("Frame")
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.Position = UDim2.new(0.5, 0, 0, 34)
    circle.Size = UDim2.fromOffset(0, 0)
    circle.BackgroundColor3 = Color3.fromRGB(52, 199, 89)
    circle.BorderSizePixel = 0
    circle.ZIndex = 201
    circle.Parent = toast

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(1, 0)
    cc.Parent = circle

    local tick1 = Instance.new("Frame")
    tick1.AnchorPoint = Vector2.new(0.5, 0.5)
    tick1.Position = UDim2.new(0.38, 0, 0.55, 0)
    tick1.Size = UDim2.fromOffset(0, 2.4)
    tick1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tick1.BorderSizePixel = 0
    tick1.Rotation = 45
    tick1.ZIndex = 202
    tick1.Parent = circle

    local tc1 = Instance.new("UICorner")
    tc1.CornerRadius = UDim.new(1, 0)
    tc1.Parent = tick1

    local tick2 = Instance.new("Frame")
    tick2.AnchorPoint = Vector2.new(0.5, 0.5)
    tick2.Position = UDim2.new(0.62, 0, 0.42, 0)
    tick2.Size = UDim2.fromOffset(0, 2.4)
    tick2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tick2.BorderSizePixel = 0
    tick2.Rotation = -50
    tick2.ZIndex = 202
    tick2.Parent = circle

    local tc2 = Instance.new("UICorner")
    tc2.CornerRadius = UDim.new(1, 0)
    tc2.Parent = tick2

    local label = Instance.new("TextLabel")
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Position = UDim2.new(0.5, 0, 1, -22)
    label.Size = UDim2.new(1, -12, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "✓ 已复制"
    label.TextColor3 = Color3.fromRGB(240, 240, 245)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextTransparency = 1
    label.ZIndex = 201
    label.Parent = toast

    TweenService:Create(toast, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0, 8)
    }):Play()

    task.wait(0.2)

    TweenService:Create(circle, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(36, 36)
    }):Play()

    task.wait(0.18)

    TweenService:Create(tick1, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(11, 2.4)
    }):Play()
    TweenService:Create(tick2, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(18, 2.4)
    }):Play()

    TweenService:Create(label, TweenInfo.new(0.25), {
        TextTransparency = 0
    }):Play()

    task.wait(1.4)

    TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, 0, 0, -120),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(label, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
    TweenService:Create(circle, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(tick1, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(tick2, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()

    task.wait(0.45)
    toast:Destroy()
end

-- ============================================
--  iOS 胶囊开关
-- ============================================
local function createIOSToggle(parent, pos, initState, onChange)
    local W, H = 40, 22
    local PAD = 2
    local KNOB = H - PAD * 2

    local track = Instance.new("TextButton")
    track.Size = UDim2.fromOffset(W, H)
    track.Position = pos
    track.AnchorPoint = Vector2.new(1, 0.5)
    track.BackgroundColor3 = initState and SW_ON_BG or SW_OFF_BG
    track.BackgroundTransparency = 0
    track.BorderSizePixel = 0
    track.Text = ""
    track.AutoButtonColor = false
    track.ZIndex = 19
    track.Parent = parent

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    local trackStroke = Instance.new("UIStroke")
    trackStroke.Color = GLASS_STROKE
    trackStroke.Thickness = 1
    trackStroke.Transparency = 0.85
    trackStroke.Parent = track

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(KNOB, KNOB)
    knob.Position = initState
        and UDim2.new(1, -PAD - KNOB, 0.5, -KNOB / 2)
        or UDim2.new(0, PAD, 0.5, -KNOB / 2)
    knob.BackgroundColor3 = SW_KNOB
    knob.BorderSizePixel = 0
    knob.ZIndex = 20
    knob.Parent = track

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local state = initState

    local function render(animated)
        local targetPos = state
            and UDim2.new(1, -PAD - KNOB, 0.5, -KNOB / 2)
            or UDim2.new(0, PAD, 0.5, -KNOB / 2)

        if animated then
            TweenService:Create(
                knob,
                TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                { Position = targetPos }
            ):Play()
            TweenService:Create(
                track,
                TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { BackgroundColor3 = state and SW_ON_BG or SW_OFF_BG }
            ):Play()
        else
            knob.Position = targetPos
            track.BackgroundColor3 = state and SW_ON_BG or SW_OFF_BG
        end
    end

    track.MouseButton1Click:Connect(function()
        state = not state
        render(true)
        if onChange then onChange(state) end
    end)

    return {
        set = function(v, animated)
            if state == v then return end
            state = v
            render(animated ~= false)
            if onChange then onChange(state) end
        end,
        get = function() return state end,
        instance = track,
    }
end

-- ============================================
--  Slider 拖动条
-- ============================================
local function createSlider(parent, labelText, initValue, minVal, maxVal, step, onChange)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 42)
    row.BackgroundColor3 = ROW_BG
    row.BackgroundTransparency = ROW_TRANS
    row.BorderSizePixel = 0
    row.ZIndex = 18
    row.Parent = parent

    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 6)
    rc.Parent = row

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 0, 20)
    label.Position = UDim2.new(0, 8, 0, 2)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = TEXT_MAIN
    label.TextSize = 10
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 19
    label.Parent = row

    local valueLabel = Instance.new("TextLabel")
    valueLabel.AnchorPoint = Vector2.new(1, 0)
    valueLabel.Position = UDim2.new(1, -8, 0, 2)
    valueLabel.Size = UDim2.new(0.4, 0, 0, 20)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(initValue)
    valueLabel.TextColor3 = TEXT_SUB
    valueLabel.TextSize = 10
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.ZIndex = 19
    valueLabel.Parent = row

    local trackBg = Instance.new("Frame")
    trackBg.AnchorPoint = Vector2.new(0.5, 1)
    trackBg.Position = UDim2.new(0.5, 0, 1, -8)
    trackBg.Size = UDim2.new(1, -16, 0, 4)
    trackBg.BackgroundColor3 = Color3.fromRGB(70, 70, 78)
    trackBg.BorderSizePixel = 0
    trackBg.ZIndex = 19
    trackBg.Parent = row

    local tbc = Instance.new("UICorner")
    tbc.CornerRadius = UDim.new(1, 0)
    tbc.Parent = trackBg

    local trackFill = Instance.new("Frame")
    trackFill.Size = UDim2.new(0, 0, 1, 0)
    trackFill.BackgroundColor3 = Color3.fromRGB(100, 180, 240)
    trackFill.BorderSizePixel = 0
    trackFill.ZIndex = 20
    trackFill.Parent = trackBg

    local tfc = Instance.new("UICorner")
    tfc.CornerRadius = UDim.new(1, 0)
    tfc.Parent = trackFill

    local knob = Instance.new("Frame")
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(0, 0, 0.5, 0)
    knob.Size = UDim2.fromOffset(14, 14)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 21
    knob.Parent = trackBg

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local value = initValue
    local dragging = false

    local function clamp(v, lo, hi)
        if v < lo then return lo end
        if v > hi then return hi end
        return v
    end

    local function updateFromInput(inputX)
        local absPos = trackBg.AbsolutePosition.X
        local absSize = trackBg.AbsoluteSize.X
        local ratio = clamp((inputX - absPos) / absSize, 0, 1)
        local raw = minVal + (maxVal - minVal) * ratio
        local stepped = math.floor(raw / step + 0.5) * step
        value = clamp(stepped, minVal, maxVal)

        local fillRatio = (value - minVal) / (maxVal - minVal)
        trackFill.Size = UDim2.new(fillRatio, 0, 1, 0)
        knob.Position = UDim2.new(fillRatio, 0, 0.5, 0)
        valueLabel.Text = tostring(value)

        if onChange then onChange(value) end
    end

    local function renderInitial()
        local fillRatio = (value - minVal) / (maxVal - minVal)
        trackFill.Size = UDim2.new(fillRatio, 0, 1, 0)
        knob.Position = UDim2.new(fillRatio, 0, 0.5, 0)
        valueLabel.Text = tostring(value)
    end

    renderInitial()

    trackBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromInput(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            updateFromInput(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return {
        set = function(v)
            value = clamp(v, minVal, maxVal)
            renderInitial()
            if onChange then onChange(value) end
        end,
        get = function() return value end,
    }
end

-- ============================================
--  通用条目工厂
-- ============================================
local function makeRow(parent, text)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 26)
    row.BackgroundColor3 = ROW_BG
    row.BackgroundTransparency = ROW_TRANS
    row.BorderSizePixel = 0
    row.ZIndex = 18
    row.Parent = parent

    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 6)
    rc.Parent = row

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(0.58, 1)
    label.Position = UDim2.fromScale(0.06, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = TEXT_MAIN
    label.TextSize = 10
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.ZIndex = 19
    label.Parent = row

    return row, label
end

local function makeToggleRow(parent, text, initState, onChange)
    local row = makeRow(parent, text)
    local tg = createIOSToggle(row, UDim2.new(1, -6, 0.5, 0), initState, onChange)
    return row, tg
end

local function makeButtonRow(parent, text, onClick)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 26)
    row.BackgroundColor3 = ROW_BG
    row.BackgroundTransparency = ROW_TRANS
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.ZIndex = 18
    row.Parent = parent

    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 6)
    rc.Parent = row

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(0.8, 1)
    label.Position = UDim2.fromScale(0.06, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = TEXT_MAIN
    label.TextSize = 10
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 19
    label.Parent = row

    local arrow = Instance.new("TextLabel")
    arrow.AnchorPoint = Vector2.new(1, 0.5)
    arrow.Position = UDim2.new(1, -8, 0.5, 0)
    arrow.Size = UDim2.fromOffset(20, 20)
    arrow.BackgroundTransparency = 1
    arrow.Text = "›"
    arrow.TextColor3 = TEXT_SUB
    arrow.TextSize = 14
    arrow.Font = Enum.Font.GothamBold
    arrow.ZIndex = 19
    arrow.Parent = row

    row.MouseButton1Click:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.08), { BackgroundTransparency = 0.2 }):Play()
        task.wait(0.09)
        TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = ROW_TRANS }):Play()
        if onClick then onClick() end
    end)

    return row
end

-- ============================================
--  云服取物 · 云端加载
-- ============================================
local cloudPickLoaded = false
local cloudPickLoading = false

local function loadCloudPick()
    if cloudPickLoaded or cloudPickLoading then return end
    cloudPickLoading = true

    task.spawn(function()
        local ok, err = pcall(function()
            local source = game:HttpGet(CLOUD_PICK_URL)
            local fn, compileErr = loadstring(source)
            if not fn then
                error("编译失败：" .. tostring(compileErr))
            end
            fn()
        end)

        if ok then
            cloudPickLoaded = true
            print("[云服取物] 加载成功")
        else
            warn("[云服取物] 加载失败：" .. tostring(err))
        end

        cloudPickLoading = false
    end)
end

local function unloadCloudPick()
    local cp = playerGui:FindFirstChild("ShiCloudPick")
    if cp then cp:Destroy() end
    cloudPickLoaded = false
end

-- ============================================
--  第 1 段结束
--  第 2 段：悬浮窗 + 分类 + 所有条目
-- ============================================-- ============================================
--  第 2 段：悬浮窗 + 8 分类 + 全部功能条目
-- ============================================

local island
local floatWindow
local animating = false
local halfScreen = false

local navbar, rightTop, rightBottom, leftPanel
local leftListFrame, rightTopContent, rightBottomContent
local navBtns = {}
local activeCategory = 1

-- ============================================
--  分类定义
-- ============================================
local CATEGORIES = {
    { name = "公告",     desc = "时脚本 · 脚本中心 v1.0\n\n更新日志：\n（留空占位）\n\n点击右下角复制群号", usage = "复制群号：XXXXXXX" },
    { name = "通用",     desc = "通用功能\n\n· 角色属性\n· 移动类\n· 道具类\n· 其他", usage = "部分服务器没有效果" },
    { name = "通用2",    desc = "通用功能 2\n\n· 重新加入服务器\n· 点击传送\n· 飞车", usage = "部分服务器没有效果" },
    { name = "动作fe",   desc = "动作 FE\n\n· 飞车动作\n· 商城免费动作\n· 翅膀", usage = "部分服务器没有效果" },
    { name = "FE粒子",   desc = "FE 粒子特效\n\n· F1 粒子\n· 鬼灭之刃\n· 手持特效", usage = "部分服务器没有效果" },
    { name = "ESP",      desc = "ESP 透视\n\n· 方框 / 射线 / 骨骼\n· 名字 / 血量 / 距离\n· 队友区分", usage = "开关开启后自动生效" },
    { name = "hook自瞄", desc = "Hook 自瞄\n\n· 平滑跟随\n· 部位选择\n· FOV 圆圈", usage = "按住开火键自动瞄准" },
    { name = "设置",     desc = "个性化你的时脚本\n\n· 收回动画\n· 开关形状\n· 侧边导航\n· 云服取物", usage = "点击开关切换" },
}

-- ============================================
--  功能实现区（真函数）
-- ============================================

-- ---- 通用：角色属性 ----
local function setWalkSpeed(v)
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = v
    end
end

local function setJumpPower(v)
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").JumpPower = v
    end
end

local function setJumpHeight(v)
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").UseJumpPower = false
        char:FindFirstChildOfClass("Humanoid").JumpHeight = v
    end
end

-- ---- 通用：无限连跳 ----
local infiniteJumpConn = nil
local infiniteJumpOn = false
local function toggleInfiniteJump(state)
    infiniteJumpOn = state
    if state then
        if infiniteJumpConn then return end
        infiniteJumpConn = UserInputService.JumpRequest:Connect(function()
            local char = player.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if infiniteJumpConn then
            infiniteJumpConn:Disconnect()
            infiniteJumpConn = nil
        end
    end
end

-- ---- 通用：飞行 ----
local flyConn = nil
local flyBodyVel = nil
local flyBodyGyro = nil
local function toggleFly(state)
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if state then
        if flyBodyVel then return end
        flyBodyVel = Instance.new("BodyVelocity")
        flyBodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyBodyVel.Velocity = Vector3.zero
        flyBodyVel.Parent = hrp

        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        flyBodyGyro.P = 1000
        flyBodyGyro.Parent = hrp

        flyConn = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            local move = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end

            if move.Magnitude > 0 then
                flyBodyVel.Velocity = move.Unit * 60
            else
                flyBodyVel.Velocity = Vector3.zero
            end
            flyBodyGyro.CFrame = cam.CFrame
        end)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if flyBodyVel then flyBodyVel:Destroy() flyBodyVel = nil end
        if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
    end
end

-- ---- 通用：穿墙 ----
local noclipConn = nil
local function toggleNoclip(state)
    if state then
        if noclipConn then return end
        noclipConn = RunService.Stepped:Connect(function()
            local char = player.Character
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- ---- 通用：传送类 ----
local function teleportTo(cframe)
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = cframe end
end

local function randomTeleport()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local x = math.random(-300, 300)
    local z = math.random(-300, 300)
    hrp.CFrame = CFrame.new(x, 50, z)
end

local function killSelf()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
end

-- ---- 通用：显示 FPS ----
local fpsGui = nil
local function toggleFps(state)
    if state then
        if fpsGui then return end
        fpsGui = Instance.new("ScreenGui")
        fpsGui.Name = "ShiFps"
        fpsGui.ResetOnSpawn = false
        fpsGui.IgnoreGuiInset = true
        fpsGui.Parent = playerGui

        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromOffset(120, 24)
        label.Position = UDim2.new(0, 8, 0, 8)
        label.BackgroundTransparency = 0.5
        label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        label.TextColor3 = Color3.fromRGB(0, 255, 120)
        label.TextSize = 14
        label.Font = Enum.Font.Code
        label.Text = "FPS: --"
        label.Parent = fpsGui

        task.spawn(function()
            while fpsGui and fpsGui.Parent do
                local fps = math.floor(1 / RunService.RenderStepped:Wait())
                if label and label.Parent then
                    label.Text = "FPS: " .. fps
                end
            end
        end)
    else
        if fpsGui then fpsGui:Destroy() fpsGui = nil end
    end
end

-- ---- 通用：人物显示 ----
local function toggleCharVisible(state)
    local char = player.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = state and 1 or 0
        end
    end
end

-- ---- 通用：强接口（服务器权威 / 需要 Remote）----
-- 用法：把 REMOTE_MAP 里的名字改成你这游戏的真实 Remote 名即可
local REMOTE_MAP = {
    getAllBackpack   = nil,
    getCurrentItems  = nil,
    equipAllItems    = nil,
    deleteItem       = nil,
    deleteAllItems   = nil,
    autoInteract     = nil,
    quickInteract    = nil,
    flingAll         = nil,
    teleportToPlayer = nil,
    command          = nil,
    soulFollow       = nil,
    forceLock        = nil,
}

local function findRemote(name)
    if not name then return nil end
    local function walk(container, depth)
        if depth > 4 then return nil end
        for _, inst in ipairs(container:GetChildren()) do
            if (inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction")) and inst.Name == name then
                return inst
            end
            if inst:IsA("Folder") or inst:IsA("Model") then
                local r = walk(inst, depth + 1)
                if r then return r end
            end
        end
        return nil
    end
    return walk(ReplicatedStorage, 0)
end

local function fireRemote(key, ...)
    local remoteName = REMOTE_MAP[key]
    local remote = findRemote(remoteName)
    if not remote then
        warn("[时脚本] 未找到 Remote：" .. tostring(remoteName) .. "（key=" .. key .. "）")
        return false
    end
    local args = {...}
    pcall(function()
        if remote:IsA("RemoteEvent") then
            remote:FireServer(unpack(args))
        else
            remote:InvokeServer(unpack(args))
        end
    end)
    return true
end

-- ============================================
--  悬浮窗主体
-- ============================================
local function createFloatWindow()
    local CM = 63
    local winW = 11 * CM
    local winH = 5.5 * CM
    local gap = 0.15 * CM

    floatWindow = Instance.new("Frame")
    floatWindow.Name = "FloatWindow"
    floatWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    floatWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
    floatWindow.Size = UDim2.fromOffset(winW, winH)
    floatWindow.BackgroundTransparency = 1
    floatWindow.BorderSizePixel = 0
    floatWindow.Visible = false
    floatWindow.ZIndex = 15
    floatWindow.Parent = overlay

    -- ===== 导航栏 =====
    local navH = 36
    navbar = Instance.new("Frame")
    navbar.Name = "Navbar"
    navbar.Size = UDim2.new(1, 0, 0, navH)
    navbar.Position = UDim2.new(0, 0, 0, 0)
    navbar.BackgroundColor3 = GLASS_BG
    navbar.BackgroundTransparency = GLASS_TRANS
    navbar.BorderSizePixel = 0
    navbar.ZIndex = 16
    navbar.Parent = floatWindow

    local navCorner = Instance.new("UICorner")
    navCorner.CornerRadius = UDim.new(0, 12)
    navCorner.Parent = navbar

    local navStroke = Instance.new("UIStroke")
    navStroke.Color = GLASS_STROKE
    navStroke.Thickness = 1
    navStroke.Transparency = STROKE_TRANS
    navStroke.Parent = navbar

    local titleBtn = Instance.new("TextButton")
    titleBtn.Name = "TitleBtn"
    titleBtn.Size = UDim2.fromScale(0.24, 1)
    titleBtn.Position = UDim2.fromScale(0.02, 0)
    titleBtn.BackgroundTransparency = 1
    titleBtn.Text = "时脚本 · 脚本中心"
    titleBtn.TextColor3 = TEXT_MAIN
    titleBtn.TextSize = 13
    titleBtn.Font = Enum.Font.GothamBold
    titleBtn.TextXAlignment = Enum.TextXAlignment.Left
    titleBtn.ZIndex = 17
    titleBtn.Parent = navbar

    local navBtnsFrame = Instance.new("Frame")
    navBtnsFrame.Name = "NavBtnsFrame"
    navBtnsFrame.Size = UDim2.new(0.66, 0, 1, 0)
    navBtnsFrame.Position = UDim2.new(0.26, 0, 0, 0)
    navBtnsFrame.BackgroundTransparency = 1
    navBtnsFrame.ZIndex = 17
    navBtnsFrame.Parent = navbar

    local navList = Instance.new("UIListLayout")
    navList.FillDirection = Enum.FillDirection.Horizontal
    navList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    navList.VerticalAlignment = Enum.VerticalAlignment.Center
    navList.Padding = UDim.new(0, 4)
    navList.Parent = navBtnsFrame

    -- ===== 左列 ScrollingFrame =====
    local leftListContent

    local function rebuildLeftList(index)
        if leftListContent then
            leftListContent:Destroy()
            leftListContent = nil
        end

        leftListContent = Instance.new("ScrollingFrame")
        leftListContent.Name = "LeftListContent"
        leftListContent.Size = UDim2.new(1, -8, 1, -32)
        leftListContent.Position = UDim2.new(0, 4, 0, 28)
        leftListContent.BackgroundTransparency = 1
        leftListContent.BorderSizePixel = 0
        leftListContent.ScrollBarThickness = 4
        leftListContent.ScrollBarImageColor3 = TEXT_SUB
        leftListContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        leftListContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        leftListContent.ZIndex = 17
        leftListContent.Parent = leftPanel

        local listLayout = Instance.new("UIListLayout")
        listLayout.FillDirection = Enum.FillDirection.Vertical
        listLayout.Padding = UDim.new(0, 4)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Parent = leftListContent

        local cat = CATEGORIES[index]
        if not cat then return end

        -- ============ 公告 ============
        if cat.name == "公告" then
            local verRow = Instance.new("Frame")
            verRow.Size = UDim2.new(1, 0, 0, 22)
            verRow.BackgroundColor3 = ACTIVE_BG
            verRow.BackgroundTransparency = 0.1
            verRow.BorderSizePixel = 0
            verRow.ZIndex = 18
            verRow.Parent = leftListContent

            local vrc = Instance.new("UICorner")
            vrc.CornerRadius = UDim.new(1, 0)
            vrc.Parent = verRow

            local vLabel = Instance.new("TextLabel")
            vLabel.Size = UDim2.fromScale(1, 1)
            vLabel.BackgroundTransparency = 1
            vLabel.Text = "时脚本 · 脚本中心 v1.0"
            vLabel.TextColor3 = ACTIVE_TEXT
            vLabel.TextSize = 10
            vLabel.Font = Enum.Font.GothamBold
            vLabel.ZIndex = 19
            vLabel.Parent = verRow

            local lines = {
                "· 纯客户端实现",
                "· 基于官方 API",
                "· 开源免费 拒绝倒卖",
                "· 我们的自由才是发展的方向",
            }
            for _, line in ipairs(lines) do
                local il = Instance.new("TextLabel")
                il.Size = UDim2.new(1, 0, 0, 16)
                il.BackgroundTransparency = 1
                il.Text = line
                il.TextColor3 = TEXT_MAIN
                il.TextSize = 9
                il.Font = Enum.Font.Gotham
                il.TextXAlignment = Enum.TextXAlignment.Left
                il.ZIndex = 18
                il.Parent = leftListContent
            end

        -- ============ 通用 ============
        elseif cat.name == "通用" then
            createSlider(leftListContent, "行走速度", 16, 0, 300, 1, setWalkSpeed)
            createSlider(leftListContent, "超级快跑", 60, 0, 500, 1, setWalkSpeed)
            createSlider(leftListContent, "跳跃高度", 50, 0, 500, 1, setJumpHeight)
            createSlider(leftListContent, "设置缩放", 1, 0.1, 5, 0.1, function(v)
                local cam = workspace.CurrentCamera
                if cam then cam.FieldOfView = 70 / v end
            end)
            createSlider(leftListContent, "聚焦设置", 0, -5, 5, 0.1, function() end)
            createSlider(leftListContent, "炫亮设置", 1, 0, 5, 0.1, function(v)
                Lighting.Brightness = v
            end)

            makeToggleRow(leftListContent, "无限连跳", false, toggleInfiniteJump)
            makeToggleRow(leftListContent, "人物显示", true, toggleCharVisible)
            makeButtonRow(leftListContent, "自动互动", function()
                fireRemote("autoInteract")
            end)
            makeToggleRow(leftListContent, "穿墙", false, toggleNoclip)
            makeButtonRow(leftListContent, "获取所有玩家背包", function()
                fireRemote("getAllBackpack")
            end)
            makeButtonRow(leftListContent, "获取当前道具", function()
                fireRemote("getCurrentItems")
            end)
            makeButtonRow(leftListContent, "装备全部道具", function()
                fireRemote("equipAllItems")
            end)
            makeButtonRow(leftListContent, "删除道具", function()
                fireRemote("deleteItem")
            end)
            makeButtonRow(leftListContent, "删除所有道具", function()
                fireRemote("deleteAllItems")
            end)
            makeButtonRow(leftListContent, "快速互动", function()
                fireRemote("quickInteract")
            end)
            makeButtonRow(leftListContent, "随机传送", randomTeleport)
            makeToggleRow(leftListContent, "飞行 Fly", false, toggleFly)
            makeButtonRow(leftListContent, "甩飞所有人", function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= player then fireRemote("flingAll", p) end
                end
            end)
            makeButtonRow(leftListContent, "死亡", killSelf)
            makeButtonRow(leftListContent, "传送至玩家身边", function()
                local closest, best = nil, math.huge
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                            if d < best then best = d closest = p end
                        end
                    end
                end
                if closest and closest.Character then
                    local hrp = closest.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then teleportTo(hrp.CFrame + Vector3.new(0, 0, 3)) end
                end
            end)
            makeButtonRow(leftListContent, "指令", function()
                fireRemote("command")
            end)
            makeButtonRow(leftListContent, "魂魄跟随其他玩家", function()
                fireRemote("soulFollow")
            end)
            makeToggleRow(leftListContent, "显示 FPS", false, toggleFps)
            makeButtonRow(leftListContent, "穿墙踏空行走", function()
                local char = player.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local bv = Instance.new("BodyVelocity")
                        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                        bv.Velocity = Vector3.new(0, 30, 0)
                        bv.Parent = hrp
                        task.delay(0.5, function() bv:Destroy() end)
                    end
                end
            end)
            makeToggleRow(leftListContent, "修改移速", false, function(state)
                setWalkSpeed(state and 100 or 16)
            end)
            makeButtonRow(leftListContent, "强制锁人", function()
                fireRemote("forceLock")
            end)

            local tip = Instance.new("TextLabel")
            tip.Size = UDim2.new(1, 0, 0, 14)
            tip.BackgroundTransparency = 1
            tip.Text = "部分服务器没有效果"
            tip.TextColor3 = TEXT_SUB
            tip.TextSize = 9
            tip.Font = Enum.Font.Gotham
            tip.TextXAlignment = Enum.TextXAlignment.Left
            tip.ZIndex = 18
            tip.Parent = leftListContent

        -- ============ 通用2 ============
        elseif cat.name == "通用2" then
            makeButtonRow(leftListContent, "重新加入服务器", function()
                game:GetService("TeleportService"):Teleport(game.PlaceId, player)
            end)
            makeButtonRow(leftListContent, "点击传送", function()
                UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                        local mouse = player:GetMouse()
                        if mouse and mouse.Hit then
                            teleportTo(mouse.Hit + Vector3.new(0, 3, 0))
                        end
                    end
                end)
            end)
            makeButtonRow(leftListContent, "飞车", function()
                local char = player.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local v = Instance.new("BodyVelocity")
                        v.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                        v.Velocity = hrp.CFrame.LookVector * 200
                        v.Parent = hrp
                        task.delay(1, function() v:Destroy() end)
                    end
                end
            end)

        -- ============ 动作fe ============
        elseif cat.name == "动作fe" then
            makeButtonRow(leftListContent, "飞车动作 Fly（默认）", function()
                fireRemote("freeEmote", "fly")
            end)
            makeButtonRow(leftListContent, "超速飞车", function()
                fireRemote("freeEmote", "superfly")
            end)
            makeButtonRow(leftListContent, "猫动作", function()
                fireRemote("freeEmote", "cat")
            end)
            makeButtonRow(leftListContent, "祖国人", function()
                fireRemote("freeEmote", "homelander")
            end)
            makeButtonRow(leftListContent, "挥手", function()
                fireRemote("freeEmote", "wave")
            end)
            makeButtonRow(leftListContent, "跳舞", function()
                fireRemote("freeEmote", "dance")
            end)
            makeButtonRow(leftListContent, "天使翅膀", function()
                fireRemote("freeWing", "angel")
            end)
            makeButtonRow(leftListContent, "恶魔翅膀", function()
                fireRemote("freeWing", "demon")
            end)

        -- ============ FE粒子 ============
        elseif cat.name == "FE粒子" then
            makeButtonRow(leftListContent, "F1 粒子效果 v1", function()
                fireRemote("particle", "f1_v1")
            end)
            makeButtonRow(leftListContent, "F1 粒子效果 v2", function()
                fireRemote("particle", "f1_v2")
            end)
            makeButtonRow(leftListContent, "光环", function()
                fireRemote("particle", "aura")
            end)
            makeButtonRow(leftListContent, "爆炸", function()
                fireRemote("particle", "explode")
            end)
            makeButtonRow(leftListContent, "日之呼吸", function()
                fireRemote("particle", "sun")
            end)
            makeButtonRow(leftListContent, "水之呼吸", function()
                fireRemote("particle", "water")
            end)
            makeButtonRow(leftListContent, "手持特效", function()
                fireRemote("particle", "held")
            end)

        -- ============ ESP ============
        elseif cat.name == "ESP" then
            makeToggleRow(leftListContent, "ESP 总开关", false, function(state)
                settings.espEnabled = state
                toggleESP(state)
            end)
            makeToggleRow(leftListContent, "头顶名称", false, function(v)
                ESP_OPTIONS.showName = v
            end)
            makeToggleRow(leftListContent, "显示血量", false, function(v)
                ESP_OPTIONS.showHealth = v
            end)
            makeToggleRow(leftListContent, "显示距离", false, function(v)
                ESP_OPTIONS.showDistance = v
            end)
            makeToggleRow(leftListContent, "方框透视", false, function(v)
                ESP_OPTIONS.box = v
            end)
            makeToggleRow(leftListContent, "射线透视", false, function(v)
                ESP_OPTIONS.tracer = v
            end)
            makeToggleRow(leftListContent, "骨骼透视", false, function(v)
                ESP_OPTIONS.skeleton = v
            end)
            makeToggleRow(leftListContent, "武器显示", false, function(v)
                ESP_OPTIONS.weapon = v
            end)
            makeToggleRow(leftListContent, "穿墙 ESP", false, function(v)
                ESP_OPTIONS.throughWall = v
            end)
            makeToggleRow(leftListContent, "区分队友颜色", true, function(v)
                ESP_OPTIONS.teamColor = v
            end)
            createSlider(leftListContent, "最大渲染距离", 500, 50, 3000, 50, function(v)
                ESP_OPTIONS.maxDist = v
            end)

        -- ============ hook自瞄 ============
        elseif cat.name == "hook自瞄" then
            makeToggleRow(leftListContent, "自瞄总开关", false, function(state)
                settings.aimEnabled = state
                toggleAim(state)
            end)
            makeToggleRow(leftListContent, "自追总开关", false, function(state)
                settings.aimFollow = state
            end)
            createSlider(leftListContent, "判定箱大小", 2, 0.5, 10, 0.5, function(v)
                AIM_OPTIONS.boxSize = v
            end)
            createSlider(leftListContent, "自瞄范围", 200, 50, 1000, 10, function(v)
                AIM_OPTIONS.range = v
            end)
            createSlider(leftListContent, "平滑系数", 0.2, 0.01, 1, 0.01, function(v)
                AIM_OPTIONS.smooth = v
            end)
            createSlider(leftListContent, "判定强度", 1, 0, 5, 0.1, function(v)
                AIM_OPTIONS.strength = v
            end)
            createSlider(leftListContent, "弹道速度", 100, 0, 1000, 10, function(v)
                AIM_OPTIONS.bulletSpeed = v
            end)
            createSlider(leftListContent, "弹道下坠", 0, 0, 100, 1, function(v)
                AIM_OPTIONS.bulletDrop = v
            end)
            makeButtonRow(leftListContent, "自瞄部位：头", function()
                AIM_OPTIONS.part = "Head"
            end)
            makeButtonRow(leftListContent, "自瞄部位：身", function()
                AIM_OPTIONS.part = "Torso"
            end)
            makeButtonRow(leftListContent, "自瞄部位：最近", function()
                AIM_OPTIONS.part = "Nearest"
            end)
            makeToggleRow(leftListContent, "掩体判断", false, function(v)
                AIM_OPTIONS.coverCheck = v
            end)
            makeToggleRow(leftListContent, "显示 FOV 圆圈", false, function(v)
                AIM_OPTIONS.showFov = v
                toggleFovCircle(v)
            end)
            makeToggleRow(leftListContent, "显示自瞄射线", false, function(v)
                AIM_OPTIONS.showRay = v
            end)
            makeToggleRow(leftListContent, "区分队友", true, function(v)
                AIM_OPTIONS.teamCheck = v
            end)
            makeToggleRow(leftListContent, "跳打", false, function(v)
                AIM_OPTIONS.jumpShot = v
            end)
            makeToggleRow(leftListContent, "预判", false, function(v)
                AIM_OPTIONS.predict = v
            end)

        -- ============ 设置 ============
        elseif cat.name == "设置" then
            makeToggleRow(leftListContent, "侧边导航栏", false, function(v)
                settings.sideNav = v
            end)
            makeToggleRow(leftListContent, "改变收回动画", false, function(v)
                settings.fancyClose = v
            end)
            makeToggleRow(leftListContent, "修改开关形状", false, function(v)
                settings.squareToggle = v
            end)
            makeButtonRow(leftListContent, "上方导航栏", function()
                -- 上方模式
            end)
            makeButtonRow(leftListContent, "侧面导航栏", function()
                -- 侧面模式
            end)
            makeButtonRow(leftListContent, "搜索栏", function()
                -- 搜索
            end)
            makeToggleRow(leftListContent, "云服取物", false, function(v)
                if v then
                    loadCloudPick()
                else
                    unloadCloudPick()
                end
            end)
        end
    end

    -- ============================================
    --  导航按钮
    -- ============================================
    local function setActiveButton(targetBtn)
        for _, b in ipairs(navBtns) do
            local isActive = (b == targetBtn)
            TweenService:Create(b, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                BackgroundColor3 = isActive and ACTIVE_BG or GLASS_BG,
                BackgroundTransparency = isActive and 0.05 or 0.35,
                TextColor3 = isActive and ACTIVE_TEXT or TEXT_SUB,
                Size = isActive and UDim2.fromOffset(52, 28) or UDim2.fromOffset(48, 26),
            }):Play()
        end
    end

    local function switchCategory(index)
        local cat = CATEGORIES[index]
        if not cat then return end
        activeCategory = index

        if leftListFrame then leftListFrame.Text = cat.name .. " · 功能列表" end
        if rightTopContent then
            rightTopContent.Text = cat.desc
            rightTopContent.TextTransparency = 1
            rightTopContent.Position = UDim2.fromScale(0.05, 0.32)
            TweenService:Create(rightTopContent, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
            TweenService:Create(rightTopContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.05, 0.28)
            }):Play()
        end
        if rightBottomContent and rightBottomContent:IsA("TextLabel") then
            rightBottomContent.Text = cat.usage
        end

        rebuildLeftList(index)
    end

    for i, cat in ipairs(CATEGORIES) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.fromOffset(48, 26)
        btn.BackgroundColor3 = GLASS_BG
        btn.BackgroundTransparency = 0.35
        btn.BorderSizePixel = 0
        btn.Text = cat.name
        btn.TextColor3 = TEXT_SUB
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamMedium
        btn.ZIndex = 18
        btn.Parent = navBtnsFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = GLASS_STROKE
        btnStroke.Thickness = 1
        btnStroke.Transparency = 0.8
        btnStroke.Parent = btn

        table.insert(navBtns, btn)

        btn.MouseButton1Click:Connect(function()
            if activeCategory == i then return end
            TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(44, 24)
            }):Play()
            task.wait(0.08)
            setActiveButton(btn)
            switchCategory(i)
        end)
    end

    if navBtns[1] then
        navBtns[1].BackgroundColor3 = ACTIVE_BG
        navBtns[1].BackgroundTransparency = 0.05
        navBtns[1].TextColor3 = ACTIVE_TEXT
        navBtns[1].Size = UDim2.fromOffset(52, 28)
    end

    -- ============================================
    --  右上三按钮
    -- ============================================
    local btnSize = 26
    local btnGap = 4
    local btnY = 5

    local function makeTopBtn(name, text, xFromRight)
        local b = Instance.new("TextButton")
        b.Name = name
        b.AnchorPoint = Vector2.new(1, 0)
        b.Position = UDim2.new(1, xFromRight, 0, btnY)
        b.Size = UDim2.fromOffset(btnSize, btnSize)
        b.BackgroundColor3 = GLASS_BG
        b.BackgroundTransparency = 0.25
        b.BorderSizePixel = 0
        b.Text = text
        b.TextColor3 = TEXT_MAIN
        b.TextSize = 14
        b.Font = Enum.Font.GothamBold
        b.ZIndex = 22
        b.Parent = navbar

        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(1, 0)
        c.Parent = b

        local s = Instance.new("UIStroke")
        s.Color = GLASS_STROKE
        s.Thickness = 1
        s.Transparency = 0.75
        s.Parent = b

        return b
    end

    local minBtn = makeTopBtn("MinBtn", "−", -6)
    local maxBtn = makeTopBtn("MaxBtn", "+", -6 - (btnSize + btnGap))
    local closeBtn = makeTopBtn("CloseBtn", "X", -6 - (btnSize + btnGap) * 2)

    -- − 最小化
    minBtn.MouseButton1Click:Connect(function()
        if animating or not floatWindow.Visible then return end
        animating = true
        TweenService:Create(blur, TweenInfo.new(0.3), { Size = 0 }):Play()
        TweenService:Create(floatWindow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(1.5, 0, 0.5, 0), BackgroundTransparency = 1
        }):Play()
        task.wait(0.42)
        floatWindow.Visible = false
        floatWindow.BackgroundTransparency = 1
        floatWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
        task.wait(0.05)

        island.Visible = true
        island.Size = UDim2.fromOffset(0, ISLAND_H)
        TweenService:Create(island, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(ISLAND_W, ISLAND_H)
        }):Play()
        animating = false
    end)

    -- + 全屏 / 还原
    maxBtn.MouseButton1Click:Connect(function()
        if animating or not floatWindow.Visible then return end
        animating = true
        halfScreen = not halfScreen

        if halfScreen then
            maxBtn.Text = "−"
            floatWindow.AnchorPoint = Vector2.new(0, 0)
            floatWindow.Position = UDim2.fromScale(0, 0)
            TweenService:Create(floatWindow, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1, 1)
            }):Play()
        else
            maxBtn.Text = "+"
            floatWindow.AnchorPoint = Vector2.new(0.5, 0.5)
            floatWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
            TweenService:Create(floatWindow, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(winW, winH)
            }):Play()
        end
        task.wait(0.42)
        animating = false
    end)

    -- X 关闭确认
    local confirmOpen = false
    closeBtn.MouseButton1Click:Connect(function()
        if animating or confirmOpen or not floatWindow.Visible then return end
        confirmOpen = true

        local confirm = Instance.new("Frame")
        confirm.Name = "ConfirmBox"
        confirm.AnchorPoint = Vector2.new(0.5, 0.5)
        confirm.Position = UDim2.fromScale(0.5, 0.5)
        confirm.Size = UDim2.fromOffset(0, 0)
        confirm.BackgroundColor3 = GLASS_BG
        confirm.BackgroundTransparency = 0.05
        confirm.BorderSizePixel = 0
        confirm.ZIndex = 60
        confirm.Parent = gui

        local cc = Instance.new("UICorner")
        cc.CornerRadius = UDim.new(0, 14)
        cc.Parent = confirm

        local cs = Instance.new("UIStroke")
        cs.Color = GLASS_STROKE
        cs.Thickness = 1
        cs.Transparency = 0.7
        cs.Parent = confirm

        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1, -20, 0, 50)
        txt.Position = UDim2.new(0, 10, 0, 14)
        txt.BackgroundTransparency = 1
        txt.Text = "Close this awesome UI?"
        txt.TextColor3 = TEXT_MAIN
        txt.TextSize = 14
        txt.Font = Enum.Font.GothamBold
        txt.TextWrapped = true
        txt.ZIndex = 61
        txt.Parent = confirm

        local function makeConfirmBtn(text, xPos, color)
            local b = Instance.new("TextButton")
            b.AnchorPoint = Vector2.new(0.5, 0.5)
            b.Position = UDim2.fromScale(xPos, 0.75)
            b.Size = UDim2.fromOffset(90, 30)
            b.BackgroundColor3 = color
            b.BackgroundTransparency = 0.1
            b.BorderSizePixel = 0
            b.Text = text
            b.TextColor3 = TEXT_MAIN
            b.TextSize = 13
            b.Font = Enum.Font.GothamBold
            b.ZIndex = 61
            b.Parent = confirm

            local bc = Instance.new("UICorner")
            bc.CornerRadius = UDim.new(0, 8)
            bc.Parent = b

            local bs = Instance.new("UIStroke")
            bs.Color = GLASS_STROKE
            bs.Thickness = 1
            bs.Transparency = 0.8
            bs.Parent = b

            return b
        end

        local yesBtn = makeConfirmBtn("YES", 0.3, Color3.fromRGB(180, 60, 60))
        local noBtn  = makeConfirmBtn("NO",  0.7, Color3.fromRGB(60, 60, 68))

        TweenService:Create(confirm, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(260, 130)
        }):Play()

        local function closeConfirm()
            TweenService:Create(confirm, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.fromOffset(0, 0)
            }):Play()
            task.wait(0.22)
            confirm:Destroy()
            confirmOpen = false
        end

        noBtn.MouseButton1Click:Connect(closeConfirm)

        yesBtn.MouseButton1Click:Connect(function()
            closeConfirm()
            task.wait(0.05)
            if animating then return end
            animating = true

            TweenService:Create(blur, TweenInfo.new(0.3), { Size = 0 }):Play()

            if settings.fancyClose then
                local function pullAway(module, delay, duration)
                    if not module then return end
                    task.spawn(function()
                        task.wait(delay)
                        local startPos = module.Position
                        TweenService:Create(module, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                            Position = UDim2.new(
                                startPos.X.Scale + 1.2, startPos.X.Offset,
                                startPos.Y.Scale - 0.8, startPos.Y.Offset
                            ),
                            BackgroundTransparency = 1,
                            Rotation = 45,
                        }):Play()
                    end)
                end

                pullAway(navbar, 0, 0.3)
                pullAway(rightTop, 0.08, 0.3)
                pullAway(rightBottom, 0.16, 0.3)

                task.spawn(function()
                    task.wait(0.24)
                    local taunt = Instance.new("TextLabel")
                    taunt.Size = UDim2.new(0, 180, 0, 24)
                    taunt.Position = UDim2.new(0.5, 0, 0, leftPanel.Position.Y.Offset - 30)
                    taunt.AnchorPoint = Vector2.new(0.5, 0.5)
                    taunt.BackgroundTransparency = 1
                    taunt.Text = "等等我呀，我跟不上了！"
                    taunt.TextColor3 = TEXT_MAIN
                    taunt.TextSize = 12
                    taunt.Font = Enum.Font.GothamMedium
                    taunt.TextTransparency = 1
                    taunt.ZIndex = 20
                    taunt.Parent = floatWindow

                    TweenService:Create(taunt, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
                    TweenService:Create(taunt, TweenInfo.new(0.3), {
                        Position = UDim2.new(0.5, 0, 0, leftPanel.Position.Y.Offset - 42)
                    }):Play()

                    task.wait(0.5)

                    local startPos = taunt.Position
                    TweenService:Create(taunt, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Position = UDim2.new(startPos.X.Scale + 1.2, startPos.X.Offset, startPos.Y.Scale - 0.8, startPos.Y.Offset),
                        TextTransparency = 1,
                        Rotation = 45,
                    }):Play()

                    task.wait(0.65)
                    taunt:Destroy()
                end)

                pullAway(leftPanel, 0.24, 0.7)
                task.wait(1.5)
            else
                floatWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
                TweenService:Create(floatWindow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Position = UDim2.new(1.5, 0, 0.5, 0), BackgroundTransparency = 1
                }):Play()
                task.wait(0.45)
            end

            floatWindow.Visible = false
            task.wait(0.05)

            local contentTopReset = 36 + gap
            local contentHReset = winH - contentTopReset
            local rightWReset = 8 * CM * 0.56 - gap
            local rightModuleHReset = (contentHReset - gap) / 2

            if navbar then
                navbar.Position = UDim2.new(0, 0, 0, 0)
                navbar.BackgroundTransparency = GLASS_TRANS
                navbar.Rotation = 0
            end
            if rightTop then
                rightTop.Size = UDim2.fromOffset(rightWReset, rightModuleHReset)
                rightTop.Position = UDim2.new(1, -rightWReset, 0, contentTopReset)
                rightTop.BackgroundTransparency = GLASS_TRANS
                rightTop.Rotation = 0
            end
            if rightBottom then
                rightBottom.Size = UDim2.fromOffset(rightWReset, rightModuleHReset)
                rightBottom.Position = UDim2.new(1, -rightWReset, 0, contentTopReset + rightModuleHReset + gap)
                rightBottom.BackgroundTransparency = GLASS_TRANS
                rightBottom.Rotation = 0
            end
            if leftPanel then
                leftPanel.Size = UDim2.fromOffset(winW - rightWReset - gap, contentHReset)
                leftPanel.Position = UDim2.new(0, 0, 0, contentTopReset)
                leftPanel.BackgroundTransparency = GLASS_TRANS
                leftPanel.Rotation = 0
            end

            if halfScreen then
                halfScreen = false
                maxBtn.Text = "+"
                floatWindow.AnchorPoint = Vector2.new(0.5, 0.5)
                floatWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
                floatWindow.Size = UDim2.fromOffset(winW, winH)
            end

            island.Visible = true
            island.Size = UDim2.fromOffset(0, ISLAND_H)
            TweenService:Create(island, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(ISLAND_W, ISLAND_H)
            }):Play()

            animating = false
        end)
    end)

    -- ============================================
    --  布局
    -- ============================================
    local contentTop = navH + gap
    local contentH = winH - contentTop
    local rightW = 8 * CM * 0.56 - gap
    local rightModuleH = (contentH - gap) / 2
    local leftW = winW - rightW - gap

    leftPanel = Instance.new("Frame")
    leftPanel.Name = "LeftPanel"
    leftPanel.Size = UDim2.fromOffset(leftW, contentH)
    leftPanel.Position = UDim2.new(0, 0, 0, contentTop)
    leftPanel.BackgroundColor3 = GLASS_BG
    leftPanel.BackgroundTransparency = GLASS_TRANS
    leftPanel.BorderSizePixel = 0
    leftPanel.ZIndex = 16
    leftPanel.Parent = floatWindow

    local leftCorner = Instance.new("UICorner")
    leftCorner.CornerRadius = UDim.new(0, 12)
    leftCorner.Parent = leftPanel

    local leftStroke = Instance.new("UIStroke")
    leftStroke.Color = GLASS_STROKE
    leftStroke.Thickness = 1
    leftStroke.Transparency = STROKE_TRANS
    leftStroke.Parent = leftPanel

    leftListFrame = Instance.new("TextLabel")
    leftListFrame.Size = UDim2.new(1, -8, 0, 24)
    leftListFrame.Position = UDim2.fromScale(0, 0)
    leftListFrame.BackgroundTransparency = 1
    leftListFrame.Text = "公告 · 功能列表"
    leftListFrame.TextColor3 = TEXT_MAIN
    leftListFrame.TextSize = 11
    leftListFrame.Font = Enum.Font.GothamBold
    leftListFrame.ZIndex = 17
    leftListFrame.Parent = leftPanel

    rightTop = Instance.new("Frame")
    rightTop.Name = "RightTop"
    rightTop.Size = UDim2.fromOffset(rightW, rightModuleH)
    rightTop.Position = UDim2.new(1, -rightW, 0, contentTop)
    rightTop.BackgroundColor3 = GLASS_BG
    rightTop.BackgroundTransparency = GLASS_TRANS
    rightTop.BorderSizePixel = 0
    rightTop.ZIndex = 16
    rightTop.Parent = floatWindow

    local rightTopCorner = Instance.new("UICorner")
    rightTopCorner.CornerRadius = UDim.new(0, 12)
    rightTopCorner.Parent = rightTop

    local rightTopStroke = Instance.new("UIStroke")
    rightTopStroke.Color = GLASS_STROKE
    rightTopStroke.Thickness = 1
    rightTopStroke.Transparency = STROKE_TRANS
    rightTopStroke.Parent = rightTop

    local rightTopTitle = Instance.new("TextLabel")
    rightTopTitle.Size = UDim2.new(1, 0, 0, 22)
    rightTopTitle.Position = UDim2.fromScale(0, 0)
    rightTopTitle.BackgroundTransparency = 1
    rightTopTitle.Text = "功能介绍"
    rightTopTitle.TextColor3 = TEXT_MAIN
    rightTopTitle.TextSize = 11
    rightTopTitle.Font = Enum.Font.GothamBold
    rightTopTitle.ZIndex = 17
    rightTopTitle.Parent = rightTop

    rightTopContent = Instance.new("TextLabel")
    rightTopContent.Size = UDim2.new(0.9, 0, 0.68, 0)
    rightTopContent.Position = UDim2.fromScale(0.05, 0.28)
    rightTopContent.BackgroundTransparency = 1
    rightTopContent.Text = CATEGORIES[1].desc
    rightTopContent.TextColor3 = TEXT_MAIN
    rightTopContent.TextSize = 10
    rightTopContent.TextWrapped = true
    rightTopContent.TextXAlignment = Enum.TextXAlignment.Left
    rightTopContent.TextYAlignment = Enum.TextYAlignment.Top
    rightTopContent.Font = Enum.Font.Gotham
    rightTopContent.ZIndex = 17
    rightTopContent.Parent = rightTop

    rightBottom = Instance.new("Frame")
    rightBottom.Name = "RightBottom"
    rightBottom.Size = UDim2.fromOffset(rightW, rightModuleH)
    rightBottom.Position = UDim2.new(1, -rightW, 0, contentTop + rightModuleH + gap)
    rightBottom.BackgroundColor3 = GLASS_BG
    rightBottom.BackgroundTransparency = GLASS_TRANS
    rightBottom.BorderSizePixel = 0
    rightBottom.ZIndex = 16
    rightBottom.Parent = floatWindow

    local rightBottomCorner = Instance.new("UICorner")
    rightBottomCorner.CornerRadius = UDim.new(0, 12)
    rightBottomCorner.Parent = rightBottom

    local rightBottomStroke = Instance.new("UIStroke")
    rightBottomStroke.Color = GLASS_STROKE
    rightBottomStroke.Thickness = 1
    rightBottomStroke.Transparency = STROKE_TRANS
    rightBottomStroke.Parent = rightBottom

    local rightBottomTitle = Instance.new("TextLabel")
    rightBottomTitle.Size = UDim2.new(1, 0, 0, 22)
    rightBottomTitle.Position = UDim2.fromScale(0, 0)
    rightBottomTitle.BackgroundTransparency = 1
    rightBottomTitle.Text = "实时 / 演示"
    rightBottomTitle.TextColor3 = TEXT_MAIN
    rightBottomTitle.TextSize = 11
    rightBottomTitle.Font = Enum.Font.GothamBold
    rightBottomTitle.ZIndex = 17
    rightBottomTitle.Parent = rightBottom

    -- 复制群号按钮
    local copyBtn = Instance.new("TextButton")
    copyBtn.Name = "CopyGroupBtn"
    copyBtn.Size = UDim2.new(1, -12, 0, 26)
    copyBtn.Position = UDim2.new(0, 6, 1, -32)
    copyBtn.BackgroundColor3 = GLASS_BG
    copyBtn.BackgroundTransparency = 0.3
    copyBtn.BorderSizePixel = 0
    copyBtn.Text = "复制群号：" .. CLIPBOARD_GROUP
    copyBtn.TextColor3 = TEXT_MAIN
    copyBtn.TextSize = 10
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.AutoButtonColor = false
    copyBtn.ZIndex = 25
    copyBtn.Parent = rightBottom

    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 8)
    copyCorner.Parent = copyBtn

    local copyStroke = Instance.new("UIStroke")
    copyStroke.Color = GLASS_STROKE
    copyStroke.Thickness = 1
    copyStroke.Transparency = 0.8
    copyStroke.Parent = copyBtn

    local copyCooldown = false
    copyBtn.MouseButton1Click:Connect(function()
        if copyCooldown then return end
        copyCooldown = true
        TweenService:Create(copyBtn, TweenInfo.new(0.08), { Size = UDim2.new(1, -16, 0, 24) }):Play()
        task.wait(0.09)
        TweenService:Create(copyBtn, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(1, -12, 0, 26) }):Play()

        local ok = tryCopy(CLIPBOARD_GROUP)
        if ok then
            playCopyCheck(gui)
        else
            local box = Instance.new("TextBox")
            box.AnchorPoint = Vector2.new(0.5, 0.5)
            box.Position = UDim2.fromScale(0.5, 0.5)
            box.Size = UDim2.fromOffset(220, 60)
            box.BackgroundColor3 = GLASS_BG
            box.BackgroundTransparency = 0.05
            box.BorderSizePixel = 0
            box.Text = CLIPBOARD_GROUP
            box.TextColor3 = TEXT_MAIN
            box.TextSize = 16
            box.Font = Enum.Font.GothamBold
            box.ClearTextOnFocus = false
            box.ZIndex = 210
            box.Parent = gui

            local bc = Instance.new("UICorner")
            bc.CornerRadius = UDim.new(0, 12)
            bc.Parent = box

            local bs = Instance.new("UIStroke")
            bs.Color = GLASS_STROKE
            bs.Thickness = 1
            bs.Transparency = 0.7
            bs.Parent = box

            task.delay(3, function()
                if box and box.Parent then box:Destroy() end
            end)
        end
        task.wait(0.6)
        copyCooldown = false
    end)

    rightBottomContent = copyBtn

    rebuildLeftList(1)

    -- 一周年双击
    local lastClick = 0
    titleBtn.MouseButton1Click:Connect(function()
        local now = tick()
        if now - lastClick < 0.35 then
            if anniversaryOn then return end
            anniversaryOn = true

            TweenService:Create(titleBtn, TweenInfo.new(0.4), { TextColor3 = Color3.fromRGB(230, 60, 60) }):Play()

            local topText = Instance.new("TextLabel")
            topText.AnchorPoint = Vector2.new(0.5, 0.5)
            topText.Position = UDim2.new(0.5, 0, 0, -20)
            topText.Size = UDim2.new(1, 0, 0, 24)
            topText.BackgroundTransparency = 1
            topText.Text = "一周年快乐"
            topText.TextColor3 = Color3.fromRGB(255, 80, 80)
            topText.TextSize = 16
            topText.Font = Enum.Font.GothamBold
            topText.TextTransparency = 1
            topText.ZIndex = 30
            topText.Parent = navbar

            TweenService:Create(topText, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
            TweenService:Create(topText, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0, -22)
            }):Play()

            local bottomText = Instance.new("TextLabel")
            bottomText.AnchorPoint = Vector2.new(0.5, 0.5)
            bottomText.Position = UDim2.new(0.5, 0, 1, 20)
            bottomText.Size = UDim2.new(1, 0, 0, 20)
            bottomText.BackgroundTransparency = 1
            bottomText.Text = "一周年"
            bottomText.TextColor3 = Color3.fromRGB(255, 80, 80)
            bottomText.TextSize = 13
            bottomText.Font = Enum.Font.GothamBold
            bottomText.TextTransparency = 1
            bottomText.ZIndex = 30
            bottomText.Parent = navbar

            TweenService:Create(bottomText, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
            TweenService:Create(bottomText, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 1, 22)
            }):Play()

            local logo = Instance.new("ImageLabel")
            logo.AnchorPoint = Vector2.new(0.5, 0.5)
            logo.Position = UDim2.new(0.5, 0, 0, -50)
            logo.Size = UDim2.fromOffset(28, 28)
            logo.BackgroundTransparency = 1
            logo.Image = "rbxassetid://103726281238887"
            logo.ImageTransparency = 1
            logo.ZIndex = 30
            logo.Parent = navbar

            TweenService:Create(logo, TweenInfo.new(0.4), { ImageTransparency = 0 }):Play()
            TweenService:Create(logo, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0, -52)
            }):Play()

            for i = 1, 28 do
                local bit = Instance.new("Frame")
                bit.AnchorPoint = Vector2.new(0.5, 0.5)
                bit.Position = UDim2.new(0.5, 0, 0.5, 0)
                bit.Size = UDim2.fromOffset(math.random(4, 7), math.random(6, 12))
                bit.BackgroundColor3 = Color3.fromHSV(math.random(), 0.7, 1)
                bit.BorderSizePixel = 0
                bit.ZIndex = 29
                bit.Rotation = math.random(0, 360)
                bit.Parent = navbar

                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0, 2)
                c.Parent = bit

                local angle = math.random() * math.pi * 2
                local dist = math.random(40, 130)
                local tx = math.cos(angle) * dist
                local ty = math.sin(angle) * dist - 20

                TweenService:Create(bit, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, tx, 0.5, ty),
                    Rotation = math.random(-360, 360),
                    BackgroundTransparency = 0.2,
                }):Play()

                task.delay(0.75, function()
                    TweenService:Create(bit, TweenInfo.new(0.5), {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, tx * 1.2, 0.5, ty + 40),
                    }):Play()
                    task.wait(0.55)
                    if bit and bit.Parent then bit:Destroy() end
                end)
            end

            lastClick = 0
        else
            lastClick = now
        end
    end)
end

-- ============================================
--  第 2 段结束
--  第 3 段：ESP + 自瞄 实际逻辑 + 灵动岛 + 主流程
-- ============================================-- ============================================
--  第 3 段：ESP + 自瞄 + 灵动岛 + 主流程
-- ============================================

-- ============================================
--  ESP 配置 + 实现
-- ============================================
ESP_OPTIONS = {
    showName = false,
    showHealth = false,
    showDistance = false,
    box = false,
    tracer = false,
    skeleton = false,
    weapon = false,
    throughWall = false,
    teamColor = true,
    maxDist = 500,
}

local espGui = nil
local espDrawings = {}
local espConn = nil

local function getESPColor(plr)
    if ESP_OPTIONS.teamColor then
        if plr.Team and player.Team and plr.Team == player.Team then
            return Color3.fromRGB(0, 255, 120)
        end
    end
    return Color3.fromRGB(255, 80, 80)
end

local function makeDrawing(class, props)
    local ok, d = pcall(function() return Drawing.new(class) end)
    if not ok then return nil end
    if d then
        for k, v in pairs(props) do
            d[k] = v
        end
    end
    return d
end

local function clearESP()
    for _, set in pairs(espDrawings) do
        for _, d in pairs(set) do
            pcall(function() d:Remove() end)
        end
    end
    espDrawings = {}
    if espConn then
        espConn:Disconnect()
        espConn = nil
    end
    if espGui then
        espGui:Destroy()
        espGui = nil
    end
end

local function toggleESP(state)
    if not state then
        clearESP()
        return
    end
    if espConn then return end

    local cam = workspace.CurrentCamera

    espConn = RunService.RenderStepped:Connect(function()
        if not settings.espEnabled then return end
        local myChar = player.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")

        -- 清理已离开的玩家
        for plr, set in pairs(espDrawings) do
            if not plr.Parent or not plr.Character then
                for _, d in pairs(set) do
                    pcall(function() d:Remove() end)
                end
                espDrawings[plr] = nil
            end
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == player then continue end

            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChildOfClass("Humanoid")

            if not (hrp and head and hum and hum.Health > 0) then
                if espDrawings[plr] then
                    for _, d in pairs(espDrawings[plr]) do
                        pcall(function() d:Remove() end)
                    end
                    espDrawings[plr] = nil
                end
                continue
            end

            -- 距离
            local dist = myHRP and (hrp.Position - myHRP.Position).Magnitude or 0
            if dist > ESP_OPTIONS.maxDist then
                if espDrawings[plr] then
                    for _, d in pairs(espDrawings[plr]) do
                        pcall(function() d:Remove() end)
                    end
                    espDrawings[plr] = nil
                end
                continue
            end

            -- 屏幕坐标
            local headPos, headOn = cam:WorldToViewportPoint(head.Position)
            local hrpPos, hrpOn = cam:WorldToViewportPoint(hrp.Position)
            local feetPos, feetOn = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))

            if not (headOn and hrpOn and feetOn) then continue end

            local color = getESPColor(plr)
            espDrawings[plr] = espDrawings[plr] or {}

            local set = espDrawings[plr]

            -- 方框
            if ESP_OPTIONS.box then
                if not set.box then
                    set.box = makeDrawing("Square", {
                        Thickness = 1,
                        Filled = false,
                        Color = color,
                        Transparency = 0.9,
                        ZIndex = 5,
                    })
                end
                if set.box then
                    local topY = headPos.Y - 8
                    local botY = feetPos.Y + 8
                    local h = botY - topY
                    local w = h * 0.55
                    set.box.Size = Vector2.new(w, h)
                    set.box.Position = Vector2.new(headPos.X - w / 2, topY)
                    set.box.Color = color
                    set.box.Visible = true
                end
            elseif set.box then
                set.box.Visible = false
            end

            -- 名字
            if ESP_OPTIONS.showName then
                if not set.name then
                    set.name = makeDrawing("Text", {
                        Size = 13,
                        Center = true,
                        Outline = true,
                        Font = 2,
                        Color = color,
                        Transparency = 0.9,
                    })
                end
                if set.name then
                    set.name.Text = plr.Name
                    set.name.Position = Vector2.new(headPos.X, headPos.Y - 22)
                    set.name.Color = color
                    set.name.Visible = true
                end
            elseif set.name then
                set.name.Visible = false
            end

            -- 血量
            if ESP_OPTIONS.showHealth then
                if not set.health then
                    set.health = makeDrawing("Text", {
                        Size = 12,
                        Center = true,
                        Outline = true,
                        Font = 2,
                        Color = Color3.fromRGB(0, 255, 120),
                        Transparency = 0.9,
                    })
                end
                if set.health then
                    set.health.Text = math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth)
                    set.health.Position = Vector2.new(headPos.X, feetPos.Y + 12)
                    set.health.Visible = true
                end
            elseif set.health then
                set.health.Visible = false
            end

            -- 距离
            if ESP_OPTIONS.showDistance then
                if not set.dist then
                    set.dist = makeDrawing("Text", {
                        Size = 12,
                        Center = true,
                        Outline = true,
                        Font = 2,
                        Color = Color3.fromRGB(220, 220, 240),
                        Transparency = 0.9,
                    })
                end
                if set.dist then
                    set.dist.Text = math.floor(dist) .. "m"
                    set.dist.Position = Vector2.new(hrpPos.X, hrpPos.Y)
                    set.dist.Visible = true
                end
            elseif set.dist then
                set.dist.Visible = false
            end

            -- 射线
            if ESP_OPTIONS.tracer then
                if not set.tracer then
                    set.tracer = makeDrawing("Line", {
                        Thickness = 1,
                        Color = color,
                        Transparency = 0.8,
                        ZIndex = 4,
                    })
                end
                if set.tracer then
                    set.tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                    set.tracer.To = Vector2.new(hrpPos.X, hrpPos.Y)
                    set.tracer.Color = color
                    set.tracer.Visible = true
                end
            elseif set.tracer then
                set.tracer.Visible = false
            end

            -- 骨骼
            if ESP_OPTIONS.skeleton then
                local bones = {
                    {"Head", "UpperTorso"},
                    {"UpperTorso", "LowerTorso"},
                    {"LowerTorso", "LeftUpperLeg"},
                    {"LowerTorso", "RightUpperLeg"},
                    {"UpperTorso", "LeftUpperArm"},
                    {"UpperTorso", "RightUpperArm"},
                }
                for i, pair in ipairs(bones) do
                    local a = char:FindFirstChild(pair[1])
                    local b = char:FindFirstChild(pair[2])
                    if a and b then
                        if not set["sk" .. i] then
                            set["sk" .. i] = makeDrawing("Line", {
                                Thickness = 1,
                                Color = color,
                                Transparency = 0.9,
                                ZIndex = 4,
                            })
                        end
                        local ap, aOn = cam:WorldToViewportPoint(a.Position)
                        local bp, bOn = cam:WorldToViewportPoint(b.Position)
                        if set["sk" .. i] then
                            if aOn and bOn then
                                set["sk" .. i].From = Vector2.new(ap.X, ap.Y)
                                set["sk" .. i].To = Vector2.new(bp.X, bp.Y)
                                set["sk" .. i].Color = color
                                set["sk" .. i].Visible = true
                            else
                                set["sk" .. i].Visible = false
                            end
                        end
                    end
                end
            else
                for i = 1, 6 do
                    if set["sk" .. i] then set["sk" .. i].Visible = false end
                end
            end
        end
    end)
end

-- ============================================
--  自瞄配置 + 实现
-- ============================================
AIM_OPTIONS = {
    boxSize = 2,
    range = 200,
    smooth = 0.2,
    strength = 1,
    bulletSpeed = 100,
    bulletDrop = 0,
    part = "Head",
    coverCheck = false,
    showFov = false,
    showRay = false,
    teamCheck = true,
    jumpShot = false,
    predict = false,
}

local fovCircle = nil
local aimConn = nil
local aimRay = nil

local function getAimTarget()
    local cam = workspace.CurrentCamera
    local myChar = player.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end

    local best, bestScore = nil, math.huge

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == player then continue end
        if AIM_OPTIONS.teamCheck and plr.Team and player.Team and plr.Team == player.Team then
            continue
        end

        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not (hrp and hum and hum.Health > 0) then continue end

        local dist = (hrp.Position - myHRP.Position).Magnitude
        if dist > AIM_OPTIONS.range then continue end

        -- 掩体判断
        if AIM_OPTIONS.coverCheck then
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = { myChar, char }
            params.FilterType = Enum.RaycastFilterType.Exclude
            local res = workspace:Raycast(cam.CFrame.Position, (hrp.Position - cam.CFrame.Position), params)
            if res then continue end
        end

        -- 屏幕距离
        local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
        if not onScreen then continue end
        local screenDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)).Magnitude

        if screenDist < bestScore then
            bestScore = screenDist
            best = plr
        end
    end

    return best
end

local function getAimPart(plr)
    local char = plr.Character
    if not char then return nil end

    if AIM_OPTIONS.part == "Head" then
        return char:FindFirstChild("Head")
    elseif AIM_OPTIONS.part == "Torso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    else
        return char:FindFirstChild("Head")
    end
end

local function toggleFovCircle(state)
    local cam = workspace.CurrentCamera
    if state then
        if fovCircle then fovCircle:Remove() end
        fovCircle = makeDrawing("Circle", {
            Thickness = 1,
            Color = Color3.fromRGB(0, 255, 180),
            Transparency = 0.7,
            Filled = false,
            NumSides = 60,
        })
        if fovCircle then
            fovCircle.Radius = AIM_OPTIONS.range / 6
            fovCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
            fovCircle.Visible = true

            task.spawn(function()
                while AIM_OPTIONS.showFov and fovCircle do
                    fovCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                    fovCircle.Radius = AIM_OPTIONS.range / 6
                    task.wait(0.05)
                end
            end)
        end
    else
        if fovCircle then
            fovCircle:Remove()
            fovCircle = nil
        end
    end
end

local function toggleAim(state)
    local cam = workspace.CurrentCamera
    if not state then
        if aimConn then
            aimConn:Disconnect()
            aimConn = nil
        end
        if aimRay then
            aimRay:Remove()
            aimRay = nil
        end
        return
    end
    if aimConn then return end

    aimConn = RunService.RenderStepped:Connect(function()
        if not settings.aimEnabled then return end
        local target = getAimTarget()
        if not target then
            if aimRay then aimRay.Visible = false end
            return
        end

        local part = getAimPart(target)
        if not part then return end

        local targetPos = part.Position
        if AIM_OPTIONS.predict then
            local vel = part.AssemblyLinearVelocity or Vector3.zero
            local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local dist = myHRP and (part.Position - myHRP.Position).Magnitude or 0
            local t = AIM_OPTIONS.bulletSpeed > 0 and (dist / AIM_OPTIONS.bulletSpeed) or 0
            targetPos = targetPos + vel * t
            if AIM_OPTIONS.bulletDrop > 0 then
                targetPos = targetPos + Vector3.new(0, 0.5 * AIM_OPTIONS.bulletDrop * t * t, 0)
            end
        end

        local newCFrame = CFrame.new(cam.CFrame.Position, targetPos)
        cam.CFrame = cam.CFrame:Lerp(newCFrame, AIM_OPTIONS.smooth * AIM_OPTIONS.strength)

        -- 射线
        if AIM_OPTIONS.showRay then
            if not aimRay then
                aimRay = makeDrawing("Line", {
                    Thickness = 1,
                    Color = Color3.fromRGB(255, 100, 100),
                    Transparency = 0.6,
                })
            end
            if aimRay then
                local sp, on = cam:WorldToViewportPoint(part.Position)
                aimRay.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                aimRay.To = Vector2.new(sp.X, sp.Y)
                aimRay.Visible = on
            end
        elseif aimRay then
            aimRay.Visible = false
        end
    end)
end

-- ============================================
--  顶部灵动岛
-- ============================================
local function createIsland()
    local islandY = 1

    island = Instance.new("TextButton")
    island.Name = "Island"
    island.AnchorPoint = Vector2.new(0.5, 0)
    island.Position = UDim2.new(0.5, 0, 0, islandY)
    island.Size = UDim2.fromOffset(0, 0)
    island.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    island.BackgroundTransparency = 0
    island.BorderSizePixel = 0
    island.Text = ""
    island.AutoButtonColor = false
    island.ZIndex = 20
    island.Parent = overlay

    local islandCorner = Instance.new("UICorner")
    islandCorner.CornerRadius = UDim.new(1, 0)
    islandCorner.Parent = island

    local islandStroke = Instance.new("UIStroke")
    islandStroke.Color = Color3.fromRGB(255, 255, 255)
    islandStroke.Thickness = 1
    islandStroke.Transparency = 0.7
    islandStroke.Parent = island

    local islandText = Instance.new("TextLabel")
    islandText.Size = UDim2.fromScale(1, 1)
    islandText.BackgroundTransparency = 1
    islandText.Text = "时脚本"
    islandText.TextColor3 = Color3.fromRGB(255, 255, 255)
    islandText.TextSize = 14
    islandText.Font = Enum.Font.GothamMedium
    islandText.TextTransparency = 1
    islandText.ZIndex = 21
    islandText.Active = false
    islandText.Parent = island

    TweenService:Create(island, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(ISLAND_W, ISLAND_H)
    }):Play()

    TweenService:Create(islandText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()

    task.wait(0.7)

    island.MouseButton1Click:Connect(function()
        if animating then return end
        if island.Visible == false then return end
        animating = true

        local tw1 = TweenService:Create(island, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(0, ISLAND_H)
        })
        tw1:Play()
        tw1.Completed:Wait()
        island.Visible = false

        task.wait(0.05)

        TweenService:Create(blur, TweenInfo.new(0.4), { Size = 18 }):Play()

        floatWindow.Visible = true
        floatWindow.AnchorPoint = Vector2.new(0.5, 0.5)
        floatWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
        floatWindow.Size = UDim2.fromOffset(11 * 63 * 0.85, 5.5 * 63 * 0.85)

        local slide = TweenService:Create(floatWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        slide:Play()

        TweenService:Create(floatWindow, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(11 * 63, 5.5 * 63)
        }):Play()

        slide.Completed:Wait()
        animating = false
    end)
end

-- ============================================
--  主流程
-- ============================================
local ok, err = pcall(function()
    tween(overlay, 0.5, { BackgroundTransparency = 0.15 }).Completed:Wait()
    tween(card, 0.6, { Size = UDim2.fromScale(0.78, 0.34) }, Enum.EasingStyle.Back).Completed:Wait()

    playTypewriter(titleChars, 0.18)
    tween(subtitle, 0.4, { TextTransparency = 0 }).Completed:Wait()
    playTypewriter(sloganChars, 0.12)

    tween(barBg, 0.3, { BackgroundTransparency = 0.85 })
    tween(loadingText, 0.4, { TextTransparency = 0 }).Completed:Wait()

    local loadTime = 2.4
    local steps = 30
    for i = 1, steps do
        tween(barFill, loadTime / steps, { Size = UDim2.fromScale(i / steps, 1) }, Enum.EasingStyle.Sine)
        task.wait(loadTime / steps)
        if i == math.floor(steps / 3) then
            loadingText.Text = funnyTexts[2]
        elseif i == math.floor(steps * 2 / 3) then
            loadingText.Text = funnyTexts[3]
        end
    end

    loadingText.Text = "时脚本已就绪 ✓"
    task.wait(0.6)

    for _, d in ipairs(overlay:GetDescendants()) do
        if d:IsA("TextLabel") then
            tween(d, 0.35, { TextTransparency = 1 })
        elseif d:IsA("Frame") then
            tween(d, 0.35, { BackgroundTransparency = 1 })
        elseif d:IsA("UIStroke") then
            tween(d, 0.35, { Transparency = 1 })
        end
    end
    tween(overlay, 0.35, { BackgroundTransparency = 1 }).Completed:Wait()

    createFloatWindow()
    createIsland()
end)

if not ok then
    warn("时脚本开屏出错：" .. tostring(err))
end

print("[时脚本] 已加载 · 开源免费 · 拒绝倒卖")
