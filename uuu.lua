-- ============================================
--  时脚本 · 开屏动画 + 灵动岛 + 悬浮窗
--  版本：胶囊波动开关 · 演示模式版
--  开源免费 · 拒绝倒卖
--  我们的自由才是发展的方向
-- ============================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

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

-- ===== 全屏磨砂白底板 =====
local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
overlay.BackgroundTransparency = 1
overlay.BorderSizePixel = 0
overlay.ZIndex = 1
overlay.Parent = gui

-- ===== 中央磨砂卡片 =====
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

-- ===== 打字机工具 =====
local function createTypewriter(parent, text, size, position, color, font)
    local container = Instance.new("Frame")
    container.Size = size
    container.Position = position
    container.BackgroundTransparency = 1
    container.ZIndex = 4
    container.Parent = parent

    local chars = {}
    local count = utf8.len(text)
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
--  配色
-- ============================================
local CYAN_BG      = Color3.fromRGB(150, 210, 235)
local CYAN_STROKE  = Color3.fromRGB(90, 160, 200)
local TEXT_DARK    = Color3.fromRGB(15, 45, 65)
local MODULE_TRANS = 0.25
local ACTIVE_BG    = Color3.fromRGB(90, 160, 200)
local ACTIVE_TEXT  = Color3.fromRGB(255, 255, 255)

local SW_OFF_BG    = Color3.fromRGB(210, 210, 215)
local SW_ON_BG     = Color3.fromRGB(52, 199, 89)
local SW_KNOB      = Color3.fromRGB(255, 255, 255)

local SHIFT_X = 95
local ISLAND_W = 180
local ISLAND_H = 42

-- ============================================
--  设置状态
-- ============================================
local settings = {
    fancyClose = false,
    espEnabled = false,
    aimEnabled = false,
}

-- ============================================
--  分类内容
-- ============================================
local CATEGORIES = {
    {
        name = "主页",
        desc = "时脚本 · 轻量辅助面板\n\n基于 Roblox 官方 API\n纯客户端 · 无注入 · 安全",
        usage = "开源免费 · 拒绝倒卖",
    },
    {
        name = "设置",
        desc = "个性化你的时脚本\n\n· 改变收回动画\n  ON  = 抽纸卡片式收回\n  OFF = 正常淡出收回",
        usage = "点击右侧开关切换",
    },
    {
        name = "透视",
        desc = "穿透墙体看到目标\n\n· 玩家描边高亮\n· 距离显示\n· 队友好友识别",
        usage = "开关开启后自动生效",
    },
    {
        name = "自瞄",
        desc = "自动锁定最近目标\n\n· 平滑跟随\n· 可调速度\n· 头部优先",
        usage = "按住开火键自动瞄准",
    },
}

-- ============================================
--  背景模糊
-- ============================================
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- ============================================
--  ★ iOS 胶囊波动开关 组件 ★
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
    trackStroke.Color = Color3.fromRGB(0, 0, 0)
    trackStroke.Thickness = 1
    trackStroke.Transparency = 0.92
    trackStroke.Parent = track

    local glow = Instance.new("Frame")
    glow.Size = UDim2.fromScale(1, 1)
    glow.Position = UDim2.fromScale(0, 0)
    glow.BackgroundColor3 = SW_ON_BG
    glow.BackgroundTransparency = 1
    glow.BorderSizePixel = 0
    glow.ZIndex = 18
    glow.Parent = track

    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(1, 0)
    glowCorner.Parent = glow

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

    local knobStroke = Instance.new("UIStroke")
    knobStroke.Color = Color3.fromRGB(0, 0, 0)
    knobStroke.Thickness = 1
    knobStroke.Transparency = 0.9
    knobStroke.Parent = knob

    local state = initState
    local enabled = true
    local glowConn = nil

    local function startGlow()
        if glowConn then return end
        local t = 0
        glowConn = RunService.Heartbeat:Connect(function(dt)
            t = t + dt
            local a = (math.sin(t * 3) + 1) / 2
            glow.BackgroundTransparency = 0.85 - a * 0.25
            glow.Size = UDim2.fromScale(1 + a * 0.18, 1 + a * 0.5)
            glow.Position = UDim2.fromScale(-a * 0.09, -a * 0.25)
        end)
    end

    local function stopGlow()
        if glowConn then
            glowConn:Disconnect()
            glowConn = nil
        end
        glow.BackgroundTransparency = 1
        glow.Size = UDim2.fromScale(1, 1)
        glow.Position = UDim2.fromScale(0, 0)
    end

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

        if state then startGlow() else stopGlow() end
    end

    local function ripple()
        local r = Instance.new("Frame")
        r.AnchorPoint = Vector2.new(0.5, 0.5)
        r.Position = UDim2.fromScale(0.5, 0.5)
        r.Size = UDim2.fromScale(1, 1)
        r.BackgroundColor3 = SW_KNOB
        r.BackgroundTransparency = 0.6
        r.BorderSizePixel = 0
        r.ZIndex = 17
        r.Parent = track

        local rc = Instance.new("UICorner")
        rc.CornerRadius = UDim.new(1, 0)
        rc.Parent = r

        TweenService:Create(
            r,
            TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Size = UDim2.fromScale(2.2, 2.6), BackgroundTransparency = 1 }
        ):Play()

        task.delay(0.5, function()
            if r and r.Parent then r:Destroy() end
        end)
    end

    track.MouseButton1Click:Connect(function()
        if not enabled then return end
        state = not state
        ripple()
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
        setEnabled = function(v) enabled = v end,
        instance = track,
    }
end

-- ============================================
--  第一段结束
--  第二段继续
-- ============================================-- ============================================
--  顶部灵动岛 + 悬浮窗
-- ============================================
local island
local floatWindow
local animating = false

local navbar, rightTop, rightBottom, leftPanel
local leftListFrame, rightTopContent, rightBottomContent
local navBtns = {}
local leftListContent
local rightBottomDemo
local activeCategory = 1

-- ============================================
--  ★ 右下角演示区 ★
--  默认：北京时间 / 美东时间 竖排
--  开启功能：演示卡片滑下，播完动画自动滑回
-- ============================================
local function buildDemo(parent)
    local holder = Instance.new("Frame")
    holder.Name = "DemoHolder"
    holder.Size = UDim2.new(1, -12, 1, -34)
    holder.Position = UDim2.new(0, 6, 0, 30)
    holder.BackgroundColor3 = Color3.fromRGB(22, 32, 42)
    holder.BackgroundTransparency = 0.1
    holder.BorderSizePixel = 0
    holder.ClipsDescendants = true
    holder.ZIndex = 17
    holder.Parent = parent

    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(0, 8)
    hc.Parent = holder

    local hs = Instance.new("UIStroke")
    hs.Color = CYAN_STROKE
    hs.Thickness = 1
    hs.Transparency = 0.6
    hs.Parent = holder

    -- ============ 时间层 ============
    local timeLayer = Instance.new("Frame")
    timeLayer.Name = "TimeLayer"
    timeLayer.Size = UDim2.fromScale(1, 1)
    timeLayer.BackgroundTransparency = 1
    timeLayer.ZIndex = 18
    timeLayer.Parent = holder

    local function makeClock(yPos, cityName, color)
        local box = Instance.new("Frame")
        box.AnchorPoint = Vector2.new(0.5, 0.5)
        box.Size = UDim2.fromScale(0.86, 0.34)
        box.Position = UDim2.fromScale(0.5, yPos)
        box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        box.BackgroundTransparency = 0.88
        box.BorderSizePixel = 0
        box.ZIndex = 19
        box.Parent = timeLayer

        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 8)
        bc.Parent = box

        local bs = Instance.new("UIStroke")
        bs.Color = color
        bs.Thickness = 1
        bs.Transparency = 0.5
        bs.Parent = box

        local city = Instance.new("TextLabel")
        city.Size = UDim2.fromScale(0.4, 1)
        city.Position = UDim2.fromScale(0.06, 0)
        city.BackgroundTransparency = 1
        city.Text = cityName
        city.TextColor3 = Color3.fromRGB(190, 215, 235)
        city.TextSize = 10
        city.Font = Enum.Font.GothamBold
        city.TextXAlignment = Enum.TextXAlignment.Left
        city.ZIndex = 20
        city.Parent = box

        local timeLbl = Instance.new("TextLabel")
        timeLbl.Size = UDim2.fromScale(0.5, 1)
        timeLbl.Position = UDim2.fromScale(0.46, 0)
        timeLbl.BackgroundTransparency = 1
        timeLbl.Text = "--:--:--"
        timeLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        timeLbl.TextSize = 15
        timeLbl.Font = Enum.Font.GothamBold
        timeLbl.TextXAlignment = Enum.TextXAlignment.Right
        timeLbl.ZIndex = 20
        timeLbl.Parent = box

        return timeLbl
    end

    local bjLabel = makeClock(0.3, "北京时间", Color3.fromRGB(90, 200, 255))
    local etLabel = makeClock(0.7, "美东时间", Color3.fromRGB(255, 160, 90))

    -- ============ 演示层 ============
    local demoLayer = Instance.new("Frame")
    demoLayer.Name = "DemoLayer"
    demoLayer.Size = UDim2.fromScale(1, 1)
    demoLayer.Position = UDim2.fromScale(0, -1)
    demoLayer.BackgroundColor3 = Color3.fromRGB(18, 28, 38)
    demoLayer.BackgroundTransparency = 0.05
    demoLayer.BorderSizePixel = 0
    demoLayer.ZIndex = 22
    demoLayer.Parent = holder

    local dlc = Instance.new("UICorner")
    dlc.CornerRadius = UDim.new(0, 8)
    dlc.Parent = demoLayer

    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(1, 0, 0, 14)
    hint.Position = UDim2.new(0, 0, 1, -16)
    hint.BackgroundTransparency = 1
    hint.Text = "演示模式"
    hint.TextColor3 = Color3.fromRGB(180, 205, 225)
    hint.TextSize = 9
    hint.Font = Enum.Font.Gotham
    hint.ZIndex = 30
    hint.Parent = demoLayer

    -- ===== 透视场景 =====
    local espScene = Instance.new("Frame")
    espScene.Size = UDim2.fromScale(1, 1)
    espScene.BackgroundTransparency = 1
    espScene.Visible = false
    espScene.ZIndex = 23
    espScene.Parent = demoLayer

    local wall = Instance.new("Frame")
    wall.Size = UDim2.fromScale(0.7, 0.46)
    wall.Position = UDim2.fromScale(0.15, 0.18)
    wall.BackgroundColor3 = Color3.fromRGB(60, 78, 95)
    wall.BorderSizePixel = 0
    wall.ZIndex = 24
    wall.Parent = espScene

    local wallC = Instance.new("UICorner")
    wallC.CornerRadius = UDim.new(0, 4)
    wallC.Parent = wall

    local function makeDummy(x, color)
        local d = Instance.new("Frame")
        d.AnchorPoint = Vector2.new(0.5, 0.5)
        d.Size = UDim2.fromScale(0.1, 0.3)
        d.Position = UDim2.fromScale(x, 0.4)
        d.BackgroundColor3 = color
        d.BorderSizePixel = 0
        d.ZIndex = 26
        d.Parent = espScene

        local dc = Instance.new("UICorner")
        dc.CornerRadius = UDim.new(0, 3)
        dc.Parent = d

        local head = Instance.new("Frame")
        head.AnchorPoint = Vector2.new(0.5, 0.5)
        head.Size = UDim2.fromScale(0.6, 0.3)
        head.Position = UDim2.fromScale(0.5, 0.1)
        head.BackgroundColor3 = color
        head.BorderSizePixel = 0
        head.ZIndex = 27
        head.Parent = d

        local hdc = Instance.new("UICorner")
        hdc.CornerRadius = UDim.new(1, 0)
        hdc.Parent = head

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 70, 70)
        stroke.Thickness = 2
        stroke.Transparency = 1
        stroke.Parent = d

        local headStroke = Instance.new("UIStroke")
        headStroke.Color = Color3.fromRGB(255, 70, 70)
        headStroke.Thickness = 2
        headStroke.Transparency = 1
        headStroke.Parent = head

        return { body = d, stroke = stroke, headStroke = headStroke }
    end

    local dummy1 = makeDummy(0.38, Color3.fromRGB(230, 120, 120))
    local dummy2 = makeDummy(0.62, Color3.fromRGB(120, 160, 230))

    -- ===== 自瞄场景 =====
    local aimScene = Instance.new("Frame")
    aimScene.Size = UDim2.fromScale(1, 1)
    aimScene.BackgroundTransparency = 1
    aimScene.Visible = false
    aimScene.ZIndex = 23
    aimScene.Parent = demoLayer

    local aimDummy = Instance.new("Frame")
    aimDummy.AnchorPoint = Vector2.new(0.5, 0.5)
    aimDummy.Size = UDim2.fromScale(0.12, 0.34)
    aimDummy.Position = UDim2.fromScale(0.58, 0.42)
    aimDummy.BackgroundColor3 = Color3.fromRGB(230, 120, 120)
    aimDummy.BorderSizePixel = 0
    aimDummy.ZIndex = 24
    aimDummy.Parent = aimScene

    local aimDummyC = Instance.new("UICorner")
    aimDummyC.CornerRadius = UDim.new(0, 3)
    aimDummyC.Parent = aimDummy

    local aimHead = Instance.new("Frame")
    aimHead.AnchorPoint = Vector2.new(0.5, 0.5)
    aimHead.Size = UDim2.fromScale(0.6, 0.3)
    aimHead.Position = UDim2.fromScale(0.5, 0.1)
    aimHead.BackgroundColor3 = Color3.fromRGB(230, 120, 120)
    aimHead.BorderSizePixel = 0
    aimHead.ZIndex = 25
    aimHead.Parent = aimDummy

    local aimHeadC = Instance.new("UICorner")
    aimHeadC.CornerRadius = UDim.new(1, 0)
    aimHeadC.Parent = aimHead

    local cross = Instance.new("Frame")
    cross.AnchorPoint = Vector2.new(0.5, 0.5)
    cross.Size = UDim2.fromOffset(28, 28)
    cross.Position = UDim2.fromScale(0.5, 0.5)
    cross.BackgroundTransparency = 1
    cross.ZIndex = 26
    cross.Parent = aimScene

    local crossH = Instance.new("Frame")
    crossH.AnchorPoint = Vector2.new(0.5, 0.5)
    crossH.Size = UDim2.new(1, 0, 0, 2)
    crossH.Position = UDim2.fromScale(0.5, 0.5)
    crossH.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
    crossH.BorderSizePixel = 0
    crossH.BackgroundTransparency = 1
    crossH.ZIndex = 26
    crossH.Parent = cross

    local crossV = Instance.new("Frame")
    crossV.AnchorPoint = Vector2.new(0.5, 0.5)
    crossV.Size = UDim2.new(0, 2, 1, 0)
    crossV.Position = UDim2.fromScale(0.5, 0.5)
    crossV.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
    crossV.BorderSizePixel = 0
    crossV.BackgroundTransparency = 1
    crossV.ZIndex = 26
    crossV.Parent = cross

    local lockBox = Instance.new("Frame")
    lockBox.AnchorPoint = Vector2.new(0.5, 0.5)
    lockBox.Size = UDim2.fromScale(0.16, 0.4)
    lockBox.Position = UDim2.fromScale(0.58, 0.42)
    lockBox.BackgroundTransparency = 1
    lockBox.ZIndex = 27
    lockBox.Parent = aimScene

    local lockStroke = Instance.new("UIStroke")
    lockStroke.Color = Color3.fromRGB(0, 255, 180)
    lockStroke.Thickness = 2
    lockStroke.Transparency = 1
    lockStroke.Parent = lockBox

    -- ===== 收回动画场景 =====
    local closeScene = Instance.new("Frame")
    closeScene.Size = UDim2.fromScale(1, 1)
    closeScene.BackgroundTransparency = 1
    closeScene.Visible = false
    closeScene.ZIndex = 23
    closeScene.Parent = demoLayer

    local function makeMini(pos, size)
        local m = Instance.new("Frame")
        m.Size = size
        m.Position = pos
        m.BackgroundColor3 = CYAN_BG
        m.BackgroundTransparency = 0.2
        m.BorderSizePixel = 0
        m.ZIndex = 24
        m.Parent = closeScene

        local mc = Instance.new("UICorner")
        mc.CornerRadius = UDim.new(0, 4)
        mc.Parent = m

        local ms = Instance.new("UIStroke")
        ms.Color = CYAN_STROKE
        ms.Thickness = 1
        ms.Transparency = 0.5
        ms.Parent = m

        return m
    end

    local miniRoot = Instance.new("Frame")
    miniRoot.AnchorPoint = Vector2.new(0.5, 0.5)
    miniRoot.Size = UDim2.fromScale(0.78, 0.72)
    miniRoot.Position = UDim2.fromScale(0.5, 0.5)
    miniRoot.BackgroundTransparency = 1
    miniRoot.ZIndex = 24
    miniRoot.Parent = closeScene

    local mNav = makeMini(UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 12))
    mNav.Parent = miniRoot
    local mLeft = makeMini(UDim2.new(0, 0, 0, 16), UDim2.new(0.44, 0, 1, -16))
    mLeft.Parent = miniRoot
    local mRT = makeMini(UDim2.new(0.48, 0, 0, 16), UDim2.new(0.52, 0, 0.42, -16))
    mRT.Parent = miniRoot
    local mRB = makeMini(UDim2.new(0.48, 0, 0.46, 14), UDim2.new(0.52, 0, 0.54, -16))
    mRB.Parent = miniRoot

    -- ===== 演示状态 =====
    local demoVisible = false
    local currentDemo = "none"
    local autoHideToken = 0

    local function resetEspAim()
        for _, d in ipairs({dummy1, dummy2}) do
            d.stroke.Transparency = 1
            d.headStroke.Transparency = 1
            d.stroke.Thickness = 2
            d.headStroke.Thickness = 2
        end
        crossH.BackgroundTransparency = 1
        crossV.BackgroundTransparency = 1
        lockStroke.Transparency = 1
        lockBox.Size = UDim2.fromScale(0.18, 0.42)
    end

    local function resetMini()
        mNav.Position = UDim2.new(0, 0, 0, 0)
        mNav.Rotation = 0
        mNav.BackgroundTransparency = 0.2
        mLeft.Position = UDim2.new(0, 0, 0, 16)
        mLeft.Rotation = 0
        mLeft.BackgroundTransparency = 0.2
        mRT.Position = UDim2.new(0.48, 0, 0, 16)
        mRT.Rotation = 0
        mRT.BackgroundTransparency = 0.2
        mRB.Position = UDim2.new(0.48, 0, 0.46, 14)
        mRB.Rotation = 0
        mRB.BackgroundTransparency = 0.2
    end

    local function playEspAnim()
        resetEspAim()
        for _, d in ipairs({dummy1, dummy2}) do
            TweenService:Create(d.stroke, TweenInfo.new(0.25), { Transparency = 0 }):Play()
            TweenService:Create(d.headStroke, TweenInfo.new(0.25), { Transparency = 0 }):Play()
        end
        task.spawn(function()
            local t0 = tick()
            while tick() - t0 < 1.6 and currentDemo == "esp" do
                local a = (math.sin(tick() * 6) + 1) / 2
                for _, d in ipairs({dummy1, dummy2}) do
                    if d.stroke.Parent then
                        d.stroke.Thickness = 2 + a * 1.2
                        d.headStroke.Thickness = 2 + a * 1.2
                    end
                end
                task.wait(0.03)
            end
        end)
    end

    local function playAimAnim()
        resetEspAim()
        TweenService:Create(crossH, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
        TweenService:Create(crossV, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
        TweenService:Create(lockStroke, TweenInfo.new(0.2), { Transparency = 0 }):Play()

        lockBox.Size = UDim2.fromScale(0.34, 0.62)
        TweenService:Create(lockBox, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(0.18, 0.42)
        }):Play()

        task.spawn(function()
            local t0 = tick()
            while tick() - t0 < 1.6 and currentDemo == "aim" do
                local a = (math.sin(tick() * 8) + 1) / 2
                lockStroke.Thickness = 2 + a * 1
                task.wait(0.03)
            end
        end)
    end

    local function playCloseAnim()
        resetMini()
        task.wait(0.3)

        local function pull(m, delay)
            task.spawn(function()
                task.wait(delay)
                TweenService:Create(m, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Position = UDim2.new(m.Position.X.Scale + 1.2, m.Position.X.Offset,
                                         m.Position.Y.Scale - 0.8, m.Position.Y.Offset),
                    BackgroundTransparency = 1,
                    Rotation = 45,
                }):Play()
            end)
        end
        pull(mNav, 0)
        pull(mRT, 0.08)
        pull(mRB, 0.16)
        pull(mLeft, 0.24)
        task.wait(0.9)
        resetMini()
    end

    local function hideDemo()
        if not demoVisible then return end
        demoVisible = false
        currentDemo = "none"
        TweenService:Create(demoLayer, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0, -1)
        }):Play()
    end

    local function showDemo(kind)
        autoHideToken = autoHideToken + 1
        local myToken = autoHideToken

        currentDemo = kind

        espScene.Visible = (kind == "esp")
        aimScene.Visible = (kind == "aim")
        closeScene.Visible = (kind == "close")

        if kind == "esp" then hint.Text = "透视 · 墙后目标显形"
        elseif kind == "aim" then hint.Text = "自瞄 · 自动锁定"
        elseif kind == "close" then hint.Text = "收回动画 · 演示"
        else hint.Text = "演示模式" end

        if not demoVisible then
            demoVisible = true
            TweenService:Create(demoLayer, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0, 0)
            }):Play()
            task.wait(0.35)
        end

        -- 播动画
        if kind == "esp" then
            playEspAnim()
            task.wait(2)
        elseif kind == "aim" then
            playAimAnim()
            task.wait(2)
        elseif kind == "close" then
            playCloseAnim()
            task.wait(0.3)
        end

        -- 播完自动收回
        if myToken == autoHideToken then
            hideDemo()
        end
    end

    -- 时间刷新
    task.spawn(function()
        while holder.Parent do
            local now = os.time()
            local bj = os.date("!*t", now + 8 * 3600)
            bjLabel.Text = string.format("%02d:%02d:%02d", bj.hour, bj.min, bj.sec)
            local et = os.date("!*t", now - 4 * 3600)
            etLabel.Text = string.format("%02d:%02d:%02d", et.hour, et.min, et.sec)
            task.wait(1)
        end
    end)

    return {
        show = showDemo,
        hide = hideDemo,
        isVisible = function() return demoVisible end,
    }
end

-- ============================================
--  悬浮窗
-- ============================================
local function createFloatWindow()
    local CM = 63
    local winW = 8 * CM
    local winH = 5.5 * CM
    local gap = 0.2 * CM

    floatWindow = Instance.new("Frame")
    floatWindow.Name = "FloatWindow"
    floatWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    floatWindow.Position = UDim2.new(0.5, SHIFT_X, 0.5, 0)
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
    navbar.BackgroundColor3 = CYAN_BG
    navbar.BackgroundTransparency = MODULE_TRANS
    navbar.BorderSizePixel = 0
    navbar.ZIndex = 16
    navbar.Parent = floatWindow

    local navCorner = Instance.new("UICorner")
    navCorner.CornerRadius = UDim.new(0, 12)
    navCorner.Parent = navbar

    local navStroke = Instance.new("UIStroke")
    navStroke.Color = CYAN_STROKE
    navStroke.Thickness = 1
    navStroke.Transparency = 0.5
    navStroke.Parent = navbar

    local projName = Instance.new("TextLabel")
    projName.Size = UDim2.fromScale(0.22, 1)
    projName.Position = UDim2.fromScale(0.03, 0)
    projName.BackgroundTransparency = 1
    projName.Text = "时脚本"
    projName.TextColor3 = TEXT_DARK
    projName.TextSize = 13
    projName.Font = Enum.Font.GothamBold
    projName.TextXAlignment = Enum.TextXAlignment.Left
    projName.ZIndex = 17
    projName.Parent = navbar

    local navBtnsFrame = Instance.new("Frame")
    navBtnsFrame.Size = UDim2.fromScale(0.62, 1)
    navBtnsFrame.Position = UDim2.fromScale(0.25, 0)
    navBtnsFrame.BackgroundTransparency = 1
    navBtnsFrame.ZIndex = 17
    navBtnsFrame.Parent = navbar

    local navList = Instance.new("UIListLayout")
    navList.FillDirection = Enum.FillDirection.Horizontal
    navList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    navList.VerticalAlignment = Enum.VerticalAlignment.Center
    navList.Padding = UDim.new(0, 4)
    navList.Parent = navBtnsFrame

    -- ===== 左列 =====
    local function rebuildLeftList(index)
        if leftListContent then
            leftListContent:Destroy()
            leftListContent = nil
        end

        leftListContent = Instance.new("Frame")
        leftListContent.Name = "LeftListContent"
        leftListContent.Size = UDim2.new(1, -8, 1, -32)
        leftListContent.Position = UDim2.new(0, 4, 0, 28)
        leftListContent.BackgroundTransparency = 1
        leftListContent.ZIndex = 17
        leftListContent.Parent = leftPanel

        local listLayout = Instance.new("UIListLayout")
        listLayout.FillDirection = Enum.FillDirection.Vertical
        listLayout.Padding = UDim.new(0, 4)
        listLayout.Parent = leftListContent

        local cat = CATEGORIES[index]

        local function addToggleRow(text, initState, onChange)
            local item = Instance.new("Frame")
            item.Size = UDim2.new(1, 0, 0, 26)
            item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            item.BackgroundTransparency = 0.5
            item.BorderSizePixel = 0
            item.ZIndex = 18
            item.Parent = leftListContent

            local ic = Instance.new("UICorner")
            ic.CornerRadius = UDim.new(0, 6)
            ic.Parent = item

            local label = Instance.new("TextLabel")
            label.Size = UDim2.fromScale(0.58, 1)
            label.Position = UDim2.fromScale(0.06, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = TEXT_DARK
            label.TextSize = 10
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 19
            label.Parent = item

            local tg = createIOSToggle(item, UDim2.new(1, -6, 0.5, 0), initState, onChange)
            return tg
        end

        if cat.name == "主页" then
            local version = Instance.new("Frame")
            version.Size = UDim2.new(1, 0, 0, 20)
            version.BackgroundColor3 = ACTIVE_BG
            version.BackgroundTransparency = 0.1
            version.BorderSizePixel = 0
            version.ZIndex = 18
            version.Parent = leftListContent

            local vc = Instance.new("UICorner")
            vc.CornerRadius = UDim.new(1, 0)
            vc.Parent = version

            local vLabel = Instance.new("TextLabel")
            vLabel.Size = UDim2.fromScale(1, 1)
            vLabel.BackgroundTransparency = 1
            vLabel.Text = "v 1.0 · 稳定版"
            vLabel.TextColor3 = ACTIVE_TEXT
            vLabel.TextSize = 10
            vLabel.Font = Enum.Font.GothamBold
            vLabel.ZIndex = 19
            vLabel.Parent = version

            local infoLines = {
                "· 纯客户端实现",
                "· 基于官方 API",
                "· 开源免费 拒绝倒卖",
                "· 我们的自由才是发展的方向",
            }
            for _, line in ipairs(infoLines) do
                local il = Instance.new("TextLabel")
                il.Size = UDim2.new(1, 0, 0, 16)
                il.BackgroundTransparency = 1
                il.Text = line
                il.TextColor3 = TEXT_DARK
                il.TextSize = 9
                il.Font = Enum.Font.Gotham
                il.TextXAlignment = Enum.TextXAlignment.Left
                il.TextTruncate = Enum.TextTruncate.AtEnd
                il.ZIndex = 18
                il.Parent = leftListContent
            end
        elseif cat.name == "设置" then
            addToggleRow("改变收回动画", settings.fancyClose, function(v)
                settings.fancyClose = v
                if rightBottomDemo then
                    if v then rightBottomDemo.show("close") end
                end
            end)
        elseif cat.name == "透视" then
            addToggleRow("启用透视", settings.espEnabled, function(v)
                settings.espEnabled = v
                if rightBottomDemo then
                    if v then rightBottomDemo.show("esp") end
                end
            end)
        elseif cat.name == "自瞄" then
            addToggleRow("启用自瞄", settings.aimEnabled, function(v)
                settings.aimEnabled = v
                if rightBottomDemo then
                    if v then rightBottomDemo.show("aim") end
                end
            end)
        end
    end

    local function setActiveButton(targetBtn)
        for _, b in ipairs(navBtns) do
            local isActive = (b == targetBtn)
            TweenService:Create(b, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                BackgroundColor3 = isActive and ACTIVE_BG or Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = isActive and 0.15 or 0.5,
                TextColor3 = isActive and ACTIVE_TEXT or TEXT_DARK,
                Size = isActive and UDim2.fromOffset(52, 28) or UDim2.fromOffset(48, 26),
            }):Play()
        end
    end

    local function switchCategory(index)
        local cat = CATEGORIES[index]
        if not cat then return end
        activeCategory = index

        if leftListFrame then
            leftListFrame.Text = cat.name .. " · 功能列表"
        end
        if rightTopContent then
            rightTopContent.Text = cat.desc
            rightTopContent.TextTransparency = 1
            rightTopContent.Position = UDim2.fromScale(0.05, 0.32)
            TweenService:Create(rightTopContent, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
            TweenService:Create(rightTopContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.05, 0.28)
            }):Play()
        end
        if rightBottomContent then
            rightBottomContent.Text = cat.usage
        end

        if rightBottomDemo then rightBottomDemo.hide() end

        rebuildLeftList(index)
    end

    for i, cat in ipairs(CATEGORIES) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.fromOffset(48, 26)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0.5
        btn.BorderSizePixel = 0
        btn.Text = cat.name
        btn.TextColor3 = TEXT_DARK
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamMedium
        btn.ZIndex = 18
        btn.Parent = navBtnsFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = CYAN_STROKE
        btnStroke.Thickness = 1
        btnStroke.Transparency = 0.5
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
        navBtns[1].BackgroundTransparency = 0.15
        navBtns[1].TextColor3 = ACTIVE_TEXT
        navBtns[1].Size = UDim2.fromOffset(52, 28)
    end

    -- ===== X =====
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.AnchorPoint = Vector2.new(1, 0)
    closeBtn.Position = UDim2.new(1, -6, 0, 5)
    closeBtn.Size = UDim2.fromOffset(26, 26)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BackgroundTransparency = 0.3
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "X"
    closeBtn.TextColor3 = TEXT_DARK
    closeBtn.TextSize = 13
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 22
    closeBtn.Parent = navbar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn

    local closeStroke = Instance.new("UIStroke")
    closeStroke.Color = CYAN_STROKE
    closeStroke.Thickness = 1
    closeStroke.Transparency = 0.5
    closeStroke.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        if animating then return end
        if not floatWindow.Visible then return end
        animating = true

        TweenService:Create(blur, TweenInfo.new(0.3), { Size = 0 }):Play()

        if settings.fancyClose then
            local function pullAway(module, delay, duration)
                if not module then return end
                task.spawn(function()
                    task.wait(delay)
                    local startPos = module.Position
                    TweenService:Create(
                        module,
                        TweenInfo.new(duration or 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                        {
                            Position = UDim2.new(
                                startPos.X.Scale + 1.2, startPos.X.Offset,
                                startPos.Y.Scale - 0.8, startPos.Y.Offset
                            ),
                            BackgroundTransparency = 1,
                            Rotation = 45,
                        }
                    ):Play()
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
                taunt.TextColor3 = TEXT_DARK
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
            floatWindow.Position = UDim2.new(0.5, SHIFT_X, 0.5, 0)
            TweenService:Create(
                floatWindow,
                TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                { Position = UDim2.new(-0.5, SHIFT_X, 0.5, 0), BackgroundTransparency = 1 }
            ):Play()
            task.wait(0.45)
        end

        floatWindow.Visible = false
        task.wait(0.05)

        local contentTopReset = 36 + 0.2 * CM
        local contentHReset = 5.5 * CM - contentTopReset
        local rightModuleHReset = (contentHReset - 0.2 * CM) / 2

        if navbar then
            navbar.Position = UDim2.new(0, 0, 0, 0)
            navbar.BackgroundTransparency = MODULE_TRANS
            navbar.Rotation = 0
        end
        if rightTop then
            rightTop.Position = UDim2.new(0, 8 * CM * 0.44 + 0.2 * CM, 0, contentTopReset)
            rightTop.BackgroundTransparency = MODULE_TRANS
            rightTop.Rotation = 0
        end
        if rightBottom then
            rightBottom.Position = UDim2.new(0, 8 * CM * 0.44 + 0.2 * CM, 0, contentTopReset + rightModuleHReset + 0.2 * CM)
            rightBottom.BackgroundTransparency = MODULE_TRANS
            rightBottom.Rotation = 0
        end
        if leftPanel then
            leftPanel.Position = UDim2.new(0, 0, 0, contentTopReset)
            leftPanel.BackgroundTransparency = MODULE_TRANS
            leftPanel.Rotation = 0
        end

        island.Visible = true
        island.Size = UDim2.fromOffset(0, ISLAND_H)
        TweenService:Create(
            island,
            TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            { Size = UDim2.fromOffset(ISLAND_W, ISLAND_H) }
        ):Play()

        animating = false
    end)

    -- ===== 布局 =====
    local contentTop = navH + gap
    local contentH = winH - contentTop
    local leftW = winW * 0.44
    local rightW = winW - leftW - gap
    local rightModuleH = (contentH - gap) / 2

    leftPanel = Instance.new("Frame")
    leftPanel.Name = "LeftPanel"
    leftPanel.Size = UDim2.fromOffset(leftW, contentH)
    leftPanel.Position = UDim2.new(0, 0, 0, contentTop)
    leftPanel.BackgroundColor3 = CYAN_BG
    leftPanel.BackgroundTransparency = MODULE_TRANS
    leftPanel.BorderSizePixel = 0
    leftPanel.ZIndex = 16
    leftPanel.Parent = floatWindow

    local leftCorner = Instance.new("UICorner")
    leftCorner.CornerRadius = UDim.new(0, 12)
    leftCorner.Parent = leftPanel

    local leftStroke = Instance.new("UIStroke")
    leftStroke.Color = CYAN_STROKE
    leftStroke.Thickness = 1
    leftStroke.Transparency = 0.5
    leftStroke.Parent = leftPanel

    leftListFrame = Instance.new("TextLabel")
    leftListFrame.Size = UDim2.new(1, -8, 0, 24)
    leftListFrame.Position = UDim2.fromScale(0, 0)
    leftListFrame.BackgroundTransparency = 1
    leftListFrame.Text = "主页 · 功能列表"
    leftListFrame.TextColor3 = TEXT_DARK
    leftListFrame.TextSize = 11
    leftListFrame.Font = Enum.Font.GothamBold
    leftListFrame.ZIndex = 17
    leftListFrame.Parent = leftPanel

    rightTop = Instance.new("Frame")
    rightTop.Name = "RightTop"
    rightTop.Size = UDim2.fromOffset(rightW, rightModuleH)
    rightTop.Position = UDim2.new(0, leftW + gap, 0, contentTop)
    rightTop.BackgroundColor3 = CYAN_BG
    rightTop.BackgroundTransparency = MODULE_TRANS
    rightTop.BorderSizePixel = 0
    rightTop.ZIndex = 16
    rightTop.Parent = floatWindow

    local rightTopCorner = Instance.new("UICorner")
    rightTopCorner.CornerRadius = UDim.new(0, 12)
    rightTopCorner.Parent = rightTop

    local rightTopStroke = Instance.new("UIStroke")
    rightTopStroke.Color = CYAN_STROKE
    rightTopStroke.Thickness = 1
    rightTopStroke.Transparency = 0.5
    rightTopStroke.Parent = rightTop

    local rightTopTitle = Instance.new("TextLabel")
    rightTopTitle.Size = UDim2.new(1, 0, 0, 22)
    rightTopTitle.Position = UDim2.fromScale(0, 0)
    rightTopTitle.BackgroundTransparency = 1
    rightTopTitle.Text = "功能介绍"
    rightTopTitle.TextColor3 = TEXT_DARK
    rightTopTitle.TextSize = 11
    rightTopTitle.Font = Enum.Font.GothamBold
    rightTopTitle.ZIndex = 17
    rightTopTitle.Parent = rightTop

    rightTopContent = Instance.new("TextLabel")
    rightTopContent.Size = UDim2.new(0.9, 0, 0.68, 0)
    rightTopContent.Position = UDim2.fromScale(0.05, 0.28)
    rightTopContent.BackgroundTransparency = 1
    rightTopContent.Text = CATEGORIES[1].desc
    rightTopContent.TextColor3 = TEXT_DARK
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
    rightBottom.Position = UDim2.new(0, leftW + gap, 0, contentTop + rightModuleH + gap)
    rightBottom.BackgroundColor3 = CYAN_BG
    rightBottom.BackgroundTransparency = MODULE_TRANS
    rightBottom.BorderSizePixel = 0
    rightBottom.ZIndex = 16
    rightBottom.Parent = floatWindow

    local rightBottomCorner = Instance.new("UICorner")
    rightBottomCorner.CornerRadius = UDim.new(0, 12)
    rightBottomCorner.Parent = rightBottom

    local rightBottomStroke = Instance.new("UIStroke")
    rightBottomStroke.Color = CYAN_STROKE
    rightBottomStroke.Thickness = 1
    rightBottomStroke.Transparency = 0.5
    rightBottomStroke.Parent = rightBottom

    local rightBottomTitle = Instance.new("TextLabel")
    rightBottomTitle.Size = UDim2.new(1, 0, 0, 22)
    rightBottomTitle.Position = UDim2.fromScale(0, 0)
    rightBottomTitle.BackgroundTransparency = 1
    rightBottomTitle.Text = "实时 / 演示"
    rightBottomTitle.TextColor3 = TEXT_DARK
    rightBottomTitle.TextSize = 11
    rightBottomTitle.Font = Enum.Font.GothamBold
    rightBottomTitle.ZIndex = 17
    rightBottomTitle.Parent = rightBottom

    rightBottomDemo = buildDemo(rightBottom)

    rightBottomContent = Instance.new("TextLabel")
    rightBottomContent.Size = UDim2.new(1, -12, 0, 14)
    rightBottomContent.Position = UDim2.new(0, 6, 1, -16)
    rightBottomContent.BackgroundTransparency = 1
    rightBottomContent.Text = CATEGORIES[1].usage
    rightBottomContent.TextColor3 = TEXT_DARK
    rightBottomContent.TextSize = 9
    rightBottomContent.TextWrapped = true
    rightBottomContent.TextXAlignment = Enum.TextXAlignment.Left
    rightBottomContent.Font = Enum.Font.Gotham
    rightBottomContent.ZIndex = 25
    rightBottomContent.Parent = rightBottom

    rebuildLeftList(1)
end

-- ============================================
--  顶部灵动岛
-- ============================================
local function createIsland()
    local islandY = 1
    overlay.BackgroundTransparency = 1

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
        floatWindow.Position = UDim2.new(-0.5, SHIFT_X, 0.5, 0)
        floatWindow.Size = UDim2.fromOffset(8 * 63 * 0.85, 5.5 * 63 * 0.85)

        local slide = TweenService:Create(floatWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, SHIFT_X, 0.5, 0)
        })
        slide:Play()

        TweenService:Create(floatWindow, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(8 * 63, 5.5 * 63)
        }):Play()

        slide.Completed:Wait()
        animating = false
    end)
end

-- ===== 主流程 =====
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
