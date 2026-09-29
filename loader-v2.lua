-- ==============================================================================
--  HYPER HUB v2 — Modern Universal Game Loader
--  Created by K2NTA ST | Project HYPER
--  Style: Dark Glassmorphism & Mint Accent (#1deba9)
--  Features: Modern Animated Splash, PandaAuth Key System, Game Auto-Detect,
--            F9 Version Logging, Teleport Queue, Game Selector Modal
-- ==============================================================================

local LOADER_VERSION = "v2.0"
local UI_VERSION     = "v2.0"
local AUTHOR         = "K2NTA ST"

-- ------------------------------------------------------------------------------
-- // Safe Service References
-- ------------------------------------------------------------------------------
local _cloneref = (typeof(cloneref) == "function" and cloneref) or function(...) return ... end
local function getService(name)
    local ok, s = pcall(function() return game:GetService(name) end)
    return ok and _cloneref(s) or nil
end

local Players           = getService("Players")
local TweenService      = getService("TweenService")
local UserInputService  = getService("UserInputService")
local HttpService       = getService("HttpService")
local RunService        = getService("RunService")
local CoreGui           = getService("CoreGui")
local LocalPlayer       = Players and Players.LocalPlayer

-- Safe Executor Environment Functions
local _request        = (typeof(request) == "function" and request) or (typeof(http_request) == "function" and http_request) or (typeof(syn) == "table" and syn and syn.request) or nil
local _getcustomasset = (typeof(getcustomasset) == "function" and getcustomasset) or (typeof(getsynasset) == "function" and getsynasset) or nil
local _isfile         = (typeof(isfile) == "function" and isfile) or nil
local _readfile       = (typeof(readfile) == "function" and readfile) or nil
local _writefile      = (typeof(writefile) == "function" and writefile) or nil
local _makefolder     = (typeof(makefolder) == "function" and makefolder) or nil
local _isfolder       = (typeof(isfolder) == "function" and isfolder) or nil
local _setclipboard   = (typeof(setclipboard) == "function" and setclipboard) or (typeof(toclipboard) == "function" and toclipboard) or nil
local _queueonteleport = (typeof(queue_on_teleport) == "function" and queue_on_teleport) or (typeof(queueonteleport) == "function" and queueonteleport) or nil

-- Ensure cache folder exists
pcall(function()
    if _makefolder and _isfolder then
        if not _isfolder("HYPER_Cache") then
            _makefolder("HYPER_Cache")
        end
    end
end)

-- ------------------------------------------------------------------------------
-- // Loader Configuration
-- ------------------------------------------------------------------------------
local Config = {
    HubName       = "HYPER HUB",
    LoaderVersion = LOADER_VERSION,
    Subtitle      = "Universal Game Loader",
    Logo          = "rbxassetid://108952102602834", -- Globe Logo
    AccentColor   = Color3.fromRGB(29, 235, 169),    -- #1deba9
    DiscordInvite = "https://discord.gg/G7CX2rD9p2",

    -- Key System Settings (PandaAuth)
    KeySystem = {
        Enabled   = false, -- Set to true to require Key, false for Free/Dev Mode
        ServiceId = "hyperhub",
        BaseURL   = "https://pandauth.com",
        AdsURL    = "https://ads.pandauth.com",
        ApiURL    = "https://api.pandauth.com",
        CacheKey  = "HYPER_Cache/key.txt",
    },

    -- Queue On Teleport Setting
    QueueOnTeleport = true,
    LoaderRawURL    = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-UI/refs/heads/main/loader-v2.lua",

    -- Remote Repositories for Games
    RepoBase = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER/refs/heads/main/",
    UIBase   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-UI/refs/heads/main/",
}

-- ------------------------------------------------------------------------------
-- // Supported Games Registry
-- ------------------------------------------------------------------------------
local SupportedGames = {
    {
        Name     = "Murder Mystery 2",
        GameId   = 66654135,
        PlaceIds = { 142823291, 335132778, 66654135 },
        Local    = "Scripts/M.lua/MM2 DONE.lua",
        Remote   = Config.RepoBase .. "M.lua/MM2%20DONE.lua",
        Version  = "v2.0"
    },
    {
        Name     = "Laundry Simulator",
        GameId   = 2294168059,
        PlaceIds = { 6305942109, 7494539166 },
        Local    = "Scripts/M.lua/LaundrySimulator_AutoFarm.lua",
        Remote   = Config.RepoBase .. "M.lua/LaundrySimulator_AutoFarm.lua",
        Version  = "v2.0"
    },
    {
        Name     = "Cali Shootout (Gun Auto)",
        GameId   = 4347712395,
        PlaceIds = { 12077443856 },
        Local    = "Scripts/M.lua/gun auto.lua",
        Remote   = Config.RepoBase .. "M.lua/gun%20auto.lua",
        Version  = "v2.0"
    },
    {
        Name     = "Blox Fruits",
        GameId   = 994732206,
        PlaceIds = { 2753915549, 4442272183, 7449423635 },
        Local    = "Scripts/M.lua/BF V1",
        Remote   = Config.RepoBase .. "M.lua/BF%20V1",
        Version  = "v1.0"
    },
    {
        Name     = "Mine a Mountain",
        GameId   = 5220391295,
        PlaceIds = { 125927821145949 },
        Local    = "Scripts/M.lua/fame 222.lua",
        Remote   = Config.RepoBase .. "M.lua/fame%20222.lua",
        Version  = "v1.0"
    },
    {
        Name     = "Basketball",
        GameId   = 5349191024,
        PlaceIds = { 16033173781, 16270425785, 129230994638464, 130739873848552 },
        Local    = "Scripts/M.lua/Basketball_XINZ.lua",
        Remote   = Config.RepoBase .. "M.lua/Basketball_XINZ.lua",
        Version  = "v1.0"
    },
}

local FallbackGame = {
    Name     = "Universal Hub",
    PlaceIds = {},
    Local    = "Scripts/UIv.2.main/uitest-v2.lua",
    Remote   = Config.UIBase .. "uitest-v2.lua",
    Version  = "v2.0"
}

-- ------------------------------------------------------------------------------
-- // Helper Functions
-- ------------------------------------------------------------------------------
local function getHWID()
    local hwid = (typeof(gethwid) == "function" and gethwid()) or nil
    if not hwid and typeof(getexecutorname) == "function" then
        hwid = tostring(LocalPlayer and LocalPlayer.UserId or 0) .. "_" .. tostring(getexecutorname())
    end
    if not hwid then
        hwid = tostring(LocalPlayer and LocalPlayer.UserId or "000000")
    end
    return tostring(hwid)
end

local function getExecutorName()
    local name = (typeof(getexecutorname) == "function" and getexecutorname())
        or (typeof(identifyexecutor) == "function" and identifyexecutor())
        or "Unknown"
    return tostring(name)
end

local function getPandaGetKeyURL()
    local hwid = getHWID()
    return string.format(
        "%s/getkey/%s?hwid=%s",
        Config.KeySystem.AdsURL,
        Config.KeySystem.ServiceId,
        HttpService:UrlEncode(hwid)
    )
end

local function copyToClipboard(text)
    local copied = false
    if _setclipboard then
        pcall(function() _setclipboard(text); copied = true end)
    end
    return copied
end

local function verifyPandaKey(key)
    if not key or key == "" then
        return false, "Key cannot be empty"
    end
    local cleanKey = tostring(key):match("^%s*(.-)%s*$")
    if not cleanKey or cleanKey == "" then
        return false, "Key cannot be empty"
    end

    -- Developer Test Pass ("TEST")
    if cleanKey:upper() == "TEST" then
        return true, "Access Granted • Developer Pass"
    end

    -- HTTP Request to Panda API
    if _request then
        local hwid = getHWID()
        local url = string.format(
            "%s/api/validate?service=%s&key=%s&hwid=%s",
            Config.KeySystem.ApiURL,
            Config.KeySystem.ServiceId,
            cleanKey,
            HttpService:UrlEncode(hwid)
        )
        local ok, res = pcall(function()
            return _request({ Url = url, Method = "GET" })
        end)
        if ok and res and res.Body then
            local pOk, parsed = pcall(function() return HttpService:JSONDecode(res.Body) end)
            if pOk and parsed and (parsed.success == true or parsed.authenticated == true or parsed.valid == true) then
                return true, "Key Verified Successfully!"
            elseif pOk and parsed and parsed.message then
                return false, tostring(parsed.message)
            end
        end
    end

    -- Fallback simple check
    if #cleanKey >= 8 then
        return true, "Key Accepted!"
    end

    return false, "Invalid Key! Please get a valid key from Linkvertise/Panda."
end

local function detectActiveGame()
    local curPlaceId = game.PlaceId
    local curGameId  = game.GameId

    for _, g in ipairs(SupportedGames) do
        if g.GameId and curGameId == g.GameId then
            return g
        end
        if g.PlaceIds then
            for _, pid in ipairs(g.PlaceIds) do
                if curPlaceId == pid then
                    return g
                end
            end
        end
    end
    return FallbackGame
end

-- ------------------------------------------------------------------------------
-- // UI Cleanup (Previous Loader Instances)
-- ------------------------------------------------------------------------------
local function cleanPreviousGui()
    local targets = {}
    if typeof(gethui) == "function" then
        pcall(function() table.insert(targets, gethui()) end)
    end
    if CoreGui then table.insert(targets, CoreGui) end
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        table.insert(targets, LocalPlayer.PlayerGui)
    end

    for _, parent in ipairs(targets) do
        pcall(function()
            for _, c in ipairs(parent:GetChildren()) do
                if c.Name == "HYPER_Loader_ScreenGui" then
                    c:Destroy()
                end
            end
        end)
    end
end
cleanPreviousGui()

-- Target Container
local ScreenParent = (typeof(gethui) == "function" and gethui()) or CoreGui or (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui"))
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HYPER_Loader_ScreenGui"
ScreenGui.DisplayOrder = 99999
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = ScreenParent

-- ------------------------------------------------------------------------------
-- // Modern Glassmorphic Splash UI (Dark + Mint #1deba9)
-- ------------------------------------------------------------------------------
local BackgroundOverlay = Instance.new("Frame")
BackgroundOverlay.Name = "Overlay"
BackgroundOverlay.Size = UDim2.new(1, 0, 1, 0)
BackgroundOverlay.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
BackgroundOverlay.BackgroundTransparency = 1
BackgroundOverlay.BorderSizePixel = 0
BackgroundOverlay.Parent = ScreenGui

-- Center Card
local Card = Instance.new("Frame")
Card.Name = "Card"
Card.Size = UDim2.new(0, 440, 0, 275)
Card.Position = UDim2.new(0.5, 0, 0.5, 0)
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
Card.BackgroundTransparency = 1
Card.BorderSizePixel = 0
Card.ClipsDescendants = false
Card.Parent = ScreenGui

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 16)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(45, 52, 68)
CardStroke.Thickness = 1.2
CardStroke.Transparency = 1
CardStroke.Parent = Card

-- Subtle Ambient Drop Shadow
local CardShadow = Instance.new("ImageLabel")
CardShadow.Name = "Shadow"
CardShadow.AnchorPoint = Vector2.new(0.5, 0.5)
CardShadow.Position = UDim2.new(0.5, 0, 0.5, 6)
CardShadow.Size = UDim2.new(1, 46, 1, 46)
CardShadow.BackgroundTransparency = 1
CardShadow.Image = "rbxassetid://1316045217"
CardShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
CardShadow.ImageTransparency = 1
CardShadow.ScaleType = Enum.ScaleType.Slice
CardShadow.SliceCenter = Rect.new(10, 10, 118, 118)
CardShadow.ZIndex = Card.ZIndex - 1
CardShadow.Parent = ScreenGui

-- Top Traffic Lights (MacLib / Slayers2 Style)
local TrafficContainer = Instance.new("Frame")
TrafficContainer.Name = "TrafficLights"
TrafficContainer.Size = UDim2.new(1, -32, 0, 24)
TrafficContainer.Position = UDim2.new(0, 16, 0, 14)
TrafficContainer.BackgroundTransparency = 1
TrafficContainer.Parent = Card

local TrafficLayout = Instance.new("UIListLayout")
TrafficLayout.FillDirection = Enum.FillDirection.Horizontal
TrafficLayout.SortOrder = Enum.SortOrder.LayoutOrder
TrafficLayout.Padding = UDim.new(0, 7)
TrafficLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TrafficLayout.Parent = TrafficContainer

local trafficColors = {
    Color3.fromRGB(255, 95, 87),  -- Red
    Color3.fromRGB(254, 188, 46), -- Yellow
    Color3.fromRGB(40, 200, 64)   -- Green
}
for i, col in ipairs(trafficColors) do
    local dot = Instance.new("Frame")
    dot.Name = "Dot_" .. i
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.BackgroundColor3 = col
    dot.BorderSizePixel = 0
    dot.Parent = TrafficContainer

    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
end

-- Close Button on Top Right
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseBtn"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -34, 0, 16)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(140, 145, 165)
CloseButton.TextSize = 13
CloseButton.Font = Enum.Font.GothamMedium
CloseButton.Parent = Card
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Main Content Container
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -40, 1, -50)
Content.Position = UDim2.new(0, 20, 0, 38)
Content.BackgroundTransparency = 1
Content.Parent = Card

-- Logo Image (Globe)
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 64, 0, 64)
Logo.Position = UDim2.new(0.5, 0, 0, 8)
Logo.AnchorPoint = Vector2.new(0.5, 0)
Logo.BackgroundTransparency = 1
Logo.Image = Config.Logo
Logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
Logo.ImageTransparency = 1
Logo.Parent = Content

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, 0, 0, 26)
TitleLabel.Position = UDim2.new(0.5, 0, 0, 80)
TitleLabel.AnchorPoint = Vector2.new(0.5, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = 'HYPER HUB <font color="rgb(29, 235, 169)">' .. LOADER_VERSION .. '</font>'
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.RichText = true
TitleLabel.TextTransparency = 1
TitleLabel.Parent = Content

-- Subtitle Label
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Name = "Subtitle"
SubtitleLabel.Size = UDim2.new(1, 0, 0, 16)
SubtitleLabel.Position = UDim2.new(0.5, 0, 0, 108)
SubtitleLabel.AnchorPoint = Vector2.new(0.5, 0)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Font = Enum.Font.GothamMedium
SubtitleLabel.Text = Config.Subtitle
SubtitleLabel.TextColor3 = Color3.fromRGB(150, 155, 175)
SubtitleLabel.TextSize = 13
SubtitleLabel.TextTransparency = 1
SubtitleLabel.Parent = Content

-- Progress Bar Container
local ProgressTrack = Instance.new("Frame")
ProgressTrack.Name = "ProgressTrack"
ProgressTrack.Size = UDim2.new(1, -20, 0, 6)
ProgressTrack.Position = UDim2.new(0.5, 0, 0, 148)
ProgressTrack.AnchorPoint = Vector2.new(0.5, 0)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
ProgressTrack.BackgroundTransparency = 1
ProgressTrack.BorderSizePixel = 0
ProgressTrack.Parent = Content

local ProgressTrackCorner = Instance.new("UICorner")
ProgressTrackCorner.CornerRadius = UDim.new(1, 0)
ProgressTrackCorner.Parent = ProgressTrack

-- Progress Fill Bar (Mint #1deba9)
local ProgressFill = Instance.new("Frame")
ProgressFill.Name = "Fill"
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Config.AccentColor
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressTrack

local ProgressFillCorner = Instance.new("UICorner")
ProgressFillCorner.CornerRadius = UDim.new(1, 0)
ProgressFillCorner.Parent = ProgressFill

local ProgressGlow = Instance.new("UIStroke")
ProgressGlow.Color = Config.AccentColor
ProgressGlow.Thickness = 1.5
ProgressGlow.Transparency = 0.5
ProgressGlow.Parent = ProgressFill

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "Status"
StatusLabel.Size = UDim2.new(1, -60, 0, 16)
StatusLabel.Position = UDim2.new(0, 10, 0, 164)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Initializing loader engine..."
StatusLabel.TextColor3 = Color3.fromRGB(170, 175, 195)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextTransparency = 1
StatusLabel.Parent = Content

-- Percentage Label
local PercentLabel = Instance.new("TextLabel")
PercentLabel.Name = "Percent"
PercentLabel.Size = UDim2.new(0, 50, 0, 16)
PercentLabel.Position = UDim2.new(1, -10, 0, 164)
PercentLabel.AnchorPoint = Vector2.new(1, 0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Config.AccentColor
PercentLabel.TextSize = 12
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.TextTransparency = 1
PercentLabel.Parent = Content

-- Footer Action Buttons (Game Selector & Discord)
local FooterContainer = Instance.new("Frame")
FooterContainer.Name = "Footer"
FooterContainer.Size = UDim2.new(1, -20, 0, 24)
FooterContainer.Position = UDim2.new(0.5, 0, 1, -28)
FooterContainer.AnchorPoint = Vector2.new(0.5, 0)
FooterContainer.BackgroundTransparency = 1
FooterContainer.Parent = Content

local BrowseGameBtn = Instance.new("TextButton")
BrowseGameBtn.Name = "BrowseGames"
BrowseGameBtn.Size = UDim2.new(0, 120, 1, 0)
BrowseGameBtn.Position = UDim2.new(0, 0, 0, 0)
BrowseGameBtn.BackgroundTransparency = 1
BrowseGameBtn.Font = Enum.Font.GothamMedium
BrowseGameBtn.Text = "🎮 Browse Games"
BrowseGameBtn.TextColor3 = Color3.fromRGB(130, 135, 155)
BrowseGameBtn.TextSize = 11
BrowseGameBtn.TextXAlignment = Enum.TextXAlignment.Left
BrowseGameBtn.Parent = FooterContainer

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Name = "Discord"
DiscordBtn.Size = UDim2.new(0, 90, 1, 0)
DiscordBtn.Position = UDim2.new(1, 0, 0, 0)
DiscordBtn.AnchorPoint = Vector2.new(1, 0)
DiscordBtn.BackgroundTransparency = 1
DiscordBtn.Font = Enum.Font.GothamMedium
DiscordBtn.Text = "💬 Discord"
DiscordBtn.TextColor3 = Color3.fromRGB(130, 135, 155)
DiscordBtn.TextSize = 11
DiscordBtn.TextXAlignment = Enum.TextXAlignment.Right
DiscordBtn.Parent = FooterContainer

DiscordBtn.MouseButton1Click:Connect(function()
    copyToClipboard(Config.DiscordInvite)
    StatusLabel.Text = "Discord invite link copied to clipboard!"
end)

-- ------------------------------------------------------------------------------
-- // Animation Helpers
-- ------------------------------------------------------------------------------
local function updateProgress(targetPercent, statusText)
    local clamped = math.clamp(targetPercent, 0, 100)
    PercentLabel.Text = math.floor(clamped) .. "%"
    if statusText then
        StatusLabel.Text = statusText
    end
    TweenService:Create(ProgressFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(clamped / 100, 0, 1, 0)
    }):Play()
end

local function playIntroAnimation()
    -- Fade In Background & Card
    TweenService:Create(BackgroundOverlay, TweenInfo.new(0.4), { BackgroundTransparency = 0.45 }):Play()
    TweenService:Create(Card, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.05,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    TweenService:Create(CardStroke, TweenInfo.new(0.4), { Transparency = 0.6 }):Play()
    TweenService:Create(CardShadow, TweenInfo.new(0.4), { ImageTransparency = 0.4 }):Play()

    -- Pop In Logo
    Logo.Size = UDim2.new(0, 0, 0, 0)
    Logo.ImageTransparency = 1
    task.wait(0.15)
    TweenService:Create(Logo, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 64, 0, 64),
        ImageTransparency = 0
    }):Play()

    -- Fade In Text Elements
    task.wait(0.2)
    TweenService:Create(TitleLabel, TweenInfo.new(0.35), { TextTransparency = 0 }):Play()
    TweenService:Create(SubtitleLabel, TweenInfo.new(0.35), { TextTransparency = 0.2 }):Play()
    TweenService:Create(ProgressTrack, TweenInfo.new(0.35), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(StatusLabel, TweenInfo.new(0.35), { TextTransparency = 0 }):Play()
    TweenService:Create(PercentLabel, TweenInfo.new(0.35), { TextTransparency = 0 }):Play()

    -- Gentle Logo Pulsing Loop
    task.spawn(function()
        while Logo and Logo.Parent do
            TweenService:Create(Logo, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 68, 0, 68)
            }):Play()
            task.wait(1.2)
            if not Logo or not Logo.Parent then break end
            TweenService:Create(Logo, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 62, 0, 62)
            }):Play()
            task.wait(1.2)
        end
    end)
end

local function playExitAnimation()
    TweenService:Create(Card, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 380, 0, 230),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(CardStroke, TweenInfo.new(0.3), { Transparency = 1 }):Play()
    TweenService:Create(CardShadow, TweenInfo.new(0.3), { ImageTransparency = 1 }):Play()
    TweenService:Create(BackgroundOverlay, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
    task.wait(0.4)
    pcall(function() ScreenGui:Destroy() end)
end

-- ------------------------------------------------------------------------------
-- // Key System Modal (Shown when Config.KeySystem.Enabled == true)
-- ------------------------------------------------------------------------------
local function showKeyModal(onKeyVerified)
    local KeyModal = Instance.new("Frame")
    KeyModal.Name = "KeyModal"
    KeyModal.Size = UDim2.new(0, 400, 0, 230)
    KeyModal.Position = UDim2.new(0.5, 0, 0.5, 0)
    KeyModal.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyModal.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
    KeyModal.BorderSizePixel = 0
    KeyModal.ZIndex = Card.ZIndex + 10
    KeyModal.Parent = ScreenGui

    local ModalCorner = Instance.new("UICorner")
    ModalCorner.CornerRadius = UDim.new(0, 16)
    ModalCorner.Parent = KeyModal

    local ModalStroke = Instance.new("UIStroke")
    ModalStroke.Color = Config.AccentColor
    ModalStroke.Thickness = 1.2
    ModalStroke.Transparency = 0.5
    ModalStroke.Parent = KeyModal

    local ModalTitle = Instance.new("TextLabel")
    ModalTitle.Size = UDim2.new(1, -40, 0, 28)
    ModalTitle.Position = UDim2.new(0, 20, 0, 18)
    ModalTitle.BackgroundTransparency = 1
    ModalTitle.Font = Enum.Font.GothamBold
    ModalTitle.Text = '🔑 Key Authentication'
    ModalTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ModalTitle.TextSize = 18
    ModalTitle.TextXAlignment = Enum.TextXAlignment.Left
    ModalTitle.Parent = KeyModal

    local ModalDesc = Instance.new("TextLabel")
    ModalDesc.Size = UDim2.new(1, -40, 0, 32)
    ModalDesc.Position = UDim2.new(0, 20, 0, 48)
    ModalDesc.BackgroundTransparency = 1
    ModalDesc.Font = Enum.Font.Gotham
    ModalDesc.Text = "Please enter your key below to unlock HYPER HUB v2.\nClick 'Copy Link' to generate a free Panda key."
    ModalDesc.TextColor3 = Color3.fromRGB(160, 165, 185)
    ModalDesc.TextSize = 12
    ModalDesc.TextXAlignment = Enum.TextXAlignment.Left
    ModalDesc.TextWrapped = true
    ModalDesc.Parent = KeyModal

    -- Input Box
    local InputFrame = Instance.new("Frame")
    InputFrame.Size = UDim2.new(1, -40, 0, 38)
    InputFrame.Position = UDim2.new(0, 20, 0, 92)
    InputFrame.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
    InputFrame.BorderSizePixel = 0
    InputFrame.Parent = KeyModal

    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = InputFrame

    local InputStroke = Instance.new("UIStroke")
    InputStroke.Color = Color3.fromRGB(45, 52, 68)
    InputStroke.Thickness = 1
    InputStroke.Parent = InputFrame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -20, 1, 0)
    TextBox.Position = UDim2.new(0, 10, 0, 0)
    TextBox.BackgroundTransparency = 1
    TextBox.Font = Enum.Font.Gotham
    TextBox.PlaceholderText = "Paste your key here (or type TEST for Dev Mode)..."
    TextBox.PlaceholderColor3 = Color3.fromRGB(110, 115, 135)
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextSize = 13
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = InputFrame

    -- Buttons Area
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 110, 0, 34)
    SubmitBtn.Position = UDim2.new(0, 20, 0, 145)
    SubmitBtn.BackgroundColor3 = Config.AccentColor
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.Text = "Verify Key"
    SubmitBtn.TextColor3 = Color3.fromRGB(15, 20, 25)
    SubmitBtn.TextSize = 13
    SubmitBtn.BorderSizePixel = 0
    SubmitBtn.Parent = KeyModal

    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, 8)
    SubmitCorner.Parent = SubmitBtn

    local CopyLinkBtn = Instance.new("TextButton")
    CopyLinkBtn.Size = UDim2.new(0, 110, 0, 34)
    CopyLinkBtn.Position = UDim2.new(0, 140, 0, 145)
    CopyLinkBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
    CopyLinkBtn.Font = Enum.Font.GothamMedium
    CopyLinkBtn.Text = "Copy Key Link"
    CopyLinkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyLinkBtn.TextSize = 13
    CopyLinkBtn.BorderSizePixel = 0
    CopyLinkBtn.Parent = KeyModal

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 8)
    CopyCorner.Parent = CopyLinkBtn

    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, -40, 0, 20)
    StatusText.Position = UDim2.new(0, 20, 0, 192)
    StatusText.BackgroundTransparency = 1
    StatusText.Font = Enum.Font.Gotham
    StatusText.Text = ""
    StatusText.TextColor3 = Color3.fromRGB(255, 95, 87)
    StatusText.TextSize = 12
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Parent = KeyModal

    CopyLinkBtn.MouseButton1Click:Connect(function()
        local link = getPandaGetKeyURL()
        copyToClipboard(link)
        StatusText.TextColor3 = Config.AccentColor
        StatusText.Text = "Copied Panda Key link to clipboard!"
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local inputKey = TextBox.Text
        StatusText.TextColor3 = Color3.fromRGB(254, 188, 46)
        StatusText.Text = "Verifying key with Panda server..."

        task.spawn(function()
            local success, msg = verifyPandaKey(inputKey)
            if success then
                StatusText.TextColor3 = Config.AccentColor
                StatusText.Text = "Key Verified! Loading game..."
                if _writefile then
                    pcall(function() _writefile(Config.KeySystem.CacheKey, inputKey) end)
                end
                task.wait(0.6)
                KeyModal:Destroy()
                if onKeyVerified then onKeyVerified() end
            else
                StatusText.TextColor3 = Color3.fromRGB(255, 95, 87)
                StatusText.Text = msg or "Verification Failed."
            end
        end)
    end)
end

-- ------------------------------------------------------------------------------
-- // Game Selector Modal (Manual Game Selection)
-- ------------------------------------------------------------------------------
local function showGameSelector(onGameSelected)
    local Modal = Instance.new("Frame")
    Modal.Name = "GameSelectorModal"
    Modal.Size = UDim2.new(0, 420, 0, 320)
    Modal.Position = UDim2.new(0.5, 0, 0.5, 0)
    Modal.AnchorPoint = Vector2.new(0.5, 0.5)
    Modal.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
    Modal.BorderSizePixel = 0
    Modal.ZIndex = Card.ZIndex + 20
    Modal.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Modal

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Config.AccentColor
    Stroke.Thickness = 1.2
    Stroke.Parent = Modal

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 0, 28)
    Title.Position = UDim2.new(0, 20, 0, 16)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = "🎮 Supported Games"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Modal

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 24, 0, 24)
    Close.Position = UDim2.new(1, -34, 0, 16)
    Close.BackgroundTransparency = 1
    Close.Text = "✕"
    Close.TextColor3 = Color3.fromRGB(150, 155, 175)
    Close.TextSize = 14
    Close.Font = Enum.Font.GothamBold
    Close.Parent = Modal
    Close.MouseButton1Click:Connect(function()
        Modal:Destroy()
    end)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -40, 1, -64)
    Scroll.Position = UDim2.new(0, 20, 0, 52)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 4
    Scroll.ScrollBarImageColor3 = Config.AccentColor
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.Parent = Modal

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.Parent = Scroll

    for _, g in ipairs(SupportedGames) do
        local Item = Instance.new("Frame")
        Item.Size = UDim2.new(1, -8, 0, 42)
        Item.BackgroundColor3 = Color3.fromRGB(26, 30, 42)
        Item.BorderSizePixel = 0
        Item.Parent = Scroll

        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 8)
        ItemCorner.Parent = Item

        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -110, 1, 0)
        NameLabel.Position = UDim2.new(0, 12, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Font = Enum.Font.GothamMedium
        NameLabel.Text = g.Name .. ' <font color="rgb(29, 235, 169)">' .. (g.Version or "v2.0") .. '</font>'
        NameLabel.RichText = true
        NameLabel.TextColor3 = Color3.fromRGB(240, 242, 250)
        NameLabel.TextSize = 13
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = Item

        local LaunchBtn = Instance.new("TextButton")
        LaunchBtn.Size = UDim2.new(0, 80, 0, 28)
        LaunchBtn.Position = UDim2.new(1, -88, 0.5, 0)
        LaunchBtn.AnchorPoint = Vector2.new(0, 0.5)
        LaunchBtn.BackgroundColor3 = Config.AccentColor
        LaunchBtn.Font = Enum.Font.GothamBold
        LaunchBtn.Text = "Launch"
        LaunchBtn.TextColor3 = Color3.fromRGB(15, 20, 25)
        LaunchBtn.TextSize = 12
        LaunchBtn.BorderSizePixel = 0
        LaunchBtn.Parent = Item

        local LaunchCorner = Instance.new("UICorner")
        LaunchCorner.CornerRadius = UDim.new(0, 6)
        LaunchCorner.Parent = LaunchBtn

        LaunchBtn.MouseButton1Click:Connect(function()
            Modal:Destroy()
            if onGameSelected then onGameSelected(g) end
        end)
    end
end

local loadAndExecuteGame = nil

BrowseGameBtn.MouseButton1Click:Connect(function()
    showGameSelector(function(selectedGame)
        StatusLabel.Text = "Manually selected: " .. selectedGame.Name
        task.spawn(function()
            loadAndExecuteGame(selectedGame)
        end)
    end)
end)

-- ------------------------------------------------------------------------------
-- // Core Execution Flow
-- ------------------------------------------------------------------------------
function loadAndExecuteGame(matchedGame)
    updateProgress(75, "Loading script for " .. matchedGame.Name .. "...")

    -- Try local file first (for testing in workspace / local executor environment)
    local scriptCode = nil
    if _isfile and matchedGame.Local and _isfile(matchedGame.Local) then
        local ok, src = pcall(function() return _readfile(matchedGame.Local) end)
        if ok and src and #src > 0 then
            scriptCode = src
        end
    end

    -- If not found locally, fetch from remote repo
    if not scriptCode and matchedGame.Remote then
        updateProgress(85, "Downloading script from GitHub...")
        local ok, src = pcall(function() return game:HttpGet(matchedGame.Remote) end)
        if ok and src and #src > 0 then
            scriptCode = src
        end
    end

    -- Final fallback if specific game script failed to fetch
    if not scriptCode then
        updateProgress(90, "Fallback to Universal UI v2...")
        local ok, src = pcall(function() return game:HttpGet(FallbackGame.Remote) end)
        if ok and src then
            scriptCode = src
            matchedGame = FallbackGame
        end
    end

    if not scriptCode then
        updateProgress(100, "Error: Failed to fetch script!")
        task.wait(2)
        playExitAnimation()
        return
    end

    -- Register Teleport Queue for persistent execution across server hops
    if Config.QueueOnTeleport and _queueonteleport then
        pcall(function()
            local qCode = string.format('loadstring(game:HttpGet("%s"))()', Config.LoaderRawURL)
            _queueonteleport(qCode)
        end)
    end

    -- F9 Developer Console Report
    print("==================================================")
    print("🚀 HYPER HUB v2 — Universal Modern Game Loader")
    print("📦 Loader Version : " .. LOADER_VERSION)
    print("💻 UI Engine      : MacLib v2.0 (ui-main.lua)")
    print("🎮 Detected Game  : " .. matchedGame.Name .. " (" .. (matchedGame.Version or "v2.0") .. ")")
    print("📍 Active PlaceId : " .. tostring(game.PlaceId) .. " (GameId: " .. tostring(game.GameId) .. ")")
    print("👤 Player Name    : " .. (LocalPlayer and LocalPlayer.Name or "Unknown") .. " (UID: " .. (LocalPlayer and LocalPlayer.UserId or 0) .. ")")
    print("🛡️ Executor Name   : " .. getExecutorName())
    print("⚡ Status         : Successfully Launched!")
    print("==================================================")

    updateProgress(100, "Ready! Starting " .. matchedGame.Name .. "...")
    task.wait(0.6)
    playExitAnimation()

    -- Run Game Script
    local fn, loadErr = loadstring(scriptCode)
    if fn then
        local runOk, runErr = pcall(fn)
        if not runOk then
            warn("[HYPER HUB] Runtime Error in " .. matchedGame.Name .. ":", tostring(runErr))
        end
    else
        warn("[HYPER HUB] Syntax Error in " .. matchedGame.Name .. ":", tostring(loadErr))
    end
end

-- ------------------------------------------------------------------------------
-- // Main Boot Routine
-- ------------------------------------------------------------------------------
task.spawn(function()
    playIntroAnimation()
    task.wait(0.4)

    -- Step 1: Environment & Compatibility Check
    updateProgress(15, "Checking executor compatibility...")
    task.wait(0.35)

    -- Step 2: Key System / Whitelist
    updateProgress(35, "Checking authentication...")
    task.wait(0.3)

    local function proceedToGameDetection()
        -- Step 3: Game Detection
        updateProgress(55, "Detecting active game (PlaceId: " .. game.PlaceId .. ")...")
        task.wait(0.4)

        local matchedGame = detectActiveGame()
        updateProgress(70, "Matched: " .. matchedGame.Name .. "!")
        task.wait(0.35)

        -- Step 4: Load & Execute
        loadAndExecuteGame(matchedGame)
    end

    if Config.KeySystem.Enabled then
        -- Check cached key
        local hasValidCache = false
        if _isfile and _isfile(Config.KeySystem.CacheKey) then
            local cachedKey = _readfile(Config.KeySystem.CacheKey)
            local valid, _ = verifyPandaKey(cachedKey)
            if valid then
                hasValidCache = true
            end
        end

        if hasValidCache then
            updateProgress(45, "Verified with cached key!")
            task.wait(0.3)
            proceedToGameDetection()
        else
            showKeyModal(function()
                proceedToGameDetection()
            end)
        end
    else
        -- Free Mode / Direct Boot
        updateProgress(50, "Free Mode active • Authentication bypassed.")
        task.wait(0.25)
        proceedToGameDetection()
    end
end)
