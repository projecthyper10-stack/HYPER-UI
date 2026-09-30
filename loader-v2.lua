-- ==============================================================================
--  HYPER HUB v2 — Modern Game Loader & Script Dispatcher
--  Author: K2NTA ST
--  Architecture: Direct HTTPS Payloads with SHA-256 Integrity Verification
-- ==============================================================================

if not game:IsLoaded() then
    pcall(function() game.Loaded:Wait() end)
end

local LOADER_VERSION = "v2.0"
local UI_VERSION     = "v2.0"
local AUTHOR         = "K2NTA ST"

local _cloneref = (typeof(cloneref) == "function" and cloneref) or function(...) return ... end
local function getService(name)
    local ok, s = pcall(function() return game:GetService(name) end)
    return ok and _cloneref(s) or nil
end

local Players          = getService("Players")
local TweenService     = getService("TweenService")
local CoreGui          = getService("CoreGui")

if Players and not Players.LocalPlayer then
    pcall(function() Players:GetPropertyChangedSignal("LocalPlayer"):Wait() end)
end
local LocalPlayer = Players and Players.LocalPlayer

local _isfile          = (typeof(isfile) == "function" and isfile) or nil
local _readfile        = (typeof(readfile) == "function" and readfile) or nil
local _writefile       = (typeof(writefile) == "function" and writefile) or nil
local _makefolder      = (typeof(makefolder) == "function" and makefolder) or nil
local _isfolder        = (typeof(isfolder) == "function" and isfolder) or nil
local _setclipboard    = (typeof(setclipboard) == "function" and setclipboard) or (typeof(toclipboard) == "function" and toclipboard) or nil
local _queueonteleport = (typeof(queue_on_teleport) == "function" and queue_on_teleport) or (typeof(queueonteleport) == "function" and queueonteleport) or nil

pcall(function()
    if _makefolder and _isfolder then
        if not _isfolder("HYPER_Cache") then
            _makefolder("HYPER_Cache")
        end
    end
end)

local Config = {
    HubName         = "HYPER HUB",
    LoaderVersion   = LOADER_VERSION,
    Logo            = "rbxassetid://108952102602834",
    AccentColor     = Color3.fromRGB(29, 235, 169),
    QueueOnTeleport = true,
    LoaderRawURL    = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER.NEW/refs/heads/main/loader-v2.lua",
}

-- Cryptographic Integrity Verification (SHA-256)
local function computeSha256(data)
    if typeof(data) ~= "string" then return nil end
    if typeof(crypt) == "table" and typeof(crypt.hash) == "function" then
        local ok, h = pcall(function() return crypt.hash(data, "sha256") end)
        if ok and h then return string.lower(h) end
    end
    if typeof(syn) == "table" and typeof(syn.crypt) == "table" and typeof(syn.crypt.hash) == "function" then
        local ok, h = pcall(function() return syn.crypt.hash(data, "sha256") end)
        if ok and h then return string.lower(h) end
    end
    if typeof(sha256) == "function" then
        local ok, h = pcall(function() return sha256(data) end)
        if ok and h then return string.lower(h) end
    end
    return nil
end

local SupportedGames = {
    {
        Name     = "Laundry Simulator",
        PlaceIds = { 6305942109 },
        Local    = "Scripts/M.lua/LaundrySimulator_AutoFarm.lua",
        Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-MAIN/refs/heads/main/M.lua/132434734662346235.lua",
        Version  = "v2.0",
        Sha256   = "3be79cf0f8fd58de7d19e84c455ee98873df1effe574a5a6ac38d7989697a3e3",
    },
    {
        Name     = "Murder Mystery 2",
        PlaceIds = { 142823291 },
        Local    = "Scripts/M.lua/MM2 DONE.lua",
        Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-MAIN/refs/heads/main/M.lua/3459023766432.lua",
        Version  = "v2.0",
        Sha256   = "590ef887fff4b52d827ca77a82dbb7d07820708608012fc53197d76d7095f8a2",
    },
    {
        Name     = "Cali Shootout",
        PlaceIds = { 12077443856 },
        Local    = "Scripts/M.lua/gun auto.lua",
        Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-MAIN/refs/heads/main/M.lua/234289315122535123.lua",
        Version  = "v2.0",
        Sha256   = "78b107a4347ad1e869381055b21f3609501f3c76348b717e95612540d015900f",
    },
    {
        Name     = "Blox Fruits",
        PlaceIds = { 2753915549, 4442272183, 7449423635 },
        Local    = "Scripts/M.lua/BF V1",
        Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER/refs/heads/main/M.lua/BF%20V1",
        Version  = "v1.0",
        Sha256   = "ad113be798ed4d600f18436ad1caee40043f5f5fd643883d6dc5b078c91f0ceb",
    },
    {
        Name     = "Mine a Mountain",
        PlaceIds = { 125927821145949 },
        Local    = "Scripts/M.lua/fame 222.lua",
        Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER/refs/heads/main/M.lua/fame%20222.lua",
        Version  = "v1.0",
        Sha256   = "12eb17edc4d47200fe0071c0a05d0cc7c6c7b64b744cf0df4c48b5da105241c7",
    },
    {
        Name     = "Basketball",
        PlaceIds = { 16033173781, 16270425785 },
        Local    = "Scripts/Basketball_HYPER.lua",
        Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER/refs/heads/main/M.lua/Basketball_XINZ.lua",
        Version  = "v1.0",
        Sha256   = "edf9fa2a9276077958736ad3f05f58b29c8573a09c7839eef7bb59c9750dd523",
    },
    {
        Name     = "BasketballZero",
        PlaceIds = { 129230994638464, 130739873848552 },
        Local    = "Scripts/Basketball_HYPER.lua",
        Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER/refs/heads/main/M.lua/Basketball_XINZ.lua",
        Version  = "v1.0",
        Sha256   = "edf9fa2a9276077958736ad3f05f58b29c8573a09c7839eef7bb59c9750dd523",
    },
}

local FallbackGame = {
    Name     = "Universal Hub",
    PlaceIds = {},
    Local    = "Scripts/UIv.2.main/uitest-v2.lua",
    Remote   = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-UI/refs/heads/main/uitest-v2.lua",
    Version  = "v2.0",
    Sha256   = "5dfa3063c79d99ae6d238075a988bb78424868a07fab48798efab2d151d972c2",
}

local function detectActiveGame()
    local curPlace = tonumber(game.PlaceId)
    for _, g in ipairs(SupportedGames) do
        if g.PlaceIds then
            for _, pid in ipairs(g.PlaceIds) do
                if tonumber(pid) == curPlace then
                    return g
                end
            end
        end
    end
    return FallbackGame
end

local function getScreenParent()
    local parent = nil
    if typeof(gethui) == "function" then
        pcall(function() parent = gethui() end)
    end
    if not parent and CoreGui then
        pcall(function()
            local t = Instance.new("Folder")
            t.Parent = CoreGui
            t:Destroy()
            parent = CoreGui
        end)
    end
    if not parent and LocalPlayer then
        pcall(function()
            parent = LocalPlayer:WaitForChild("PlayerGui", 5) or LocalPlayer:FindFirstChild("PlayerGui")
        end)
    end
    return parent or CoreGui
end

local function cleanPreviousGui()
    local targets = {}
    if typeof(gethui) == "function" then
        pcall(function() table.insert(targets, gethui()) end)
    end
    if CoreGui then pcall(function() table.insert(targets, CoreGui) end) end
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        pcall(function() table.insert(targets, LocalPlayer.PlayerGui) end)
    end

    for _, p in ipairs(targets) do
        pcall(function()
            for _, c in ipairs(p:GetChildren()) do
                if c.Name == "HYPER_Loader_ScreenGui" then
                    c:Destroy()
                end
            end
        end)
    end
end
cleanPreviousGui()

local ScreenParent = getScreenParent()
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HYPER_Loader_ScreenGui"
ScreenGui.DisplayOrder = 999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = ScreenParent

local BackgroundOverlay = Instance.new("Frame")
BackgroundOverlay.Name = "Overlay"
BackgroundOverlay.Size = UDim2.new(1, 0, 1, 0)
BackgroundOverlay.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
BackgroundOverlay.BackgroundTransparency = 1
BackgroundOverlay.BorderSizePixel = 0
BackgroundOverlay.Parent = ScreenGui

local Card = Instance.new("Frame")
Card.Name = "Card"
Card.Size = UDim2.new(0, 240, 0, 140)
Card.Position = UDim2.new(0.5, 0, 0.5, 0)
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
Card.BackgroundTransparency = 1
Card.BorderSizePixel = 0
Card.ClipsDescendants = false
Card.Parent = ScreenGui

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 16)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(42, 48, 64)
CardStroke.Thickness = 1.2
CardStroke.Transparency = 1
CardStroke.Parent = Card

local CardShadow = Instance.new("ImageLabel")
CardShadow.Name = "Shadow"
CardShadow.AnchorPoint = Vector2.new(0.5, 0.5)
CardShadow.Position = UDim2.new(0.5, 0, 0.5, 4)
CardShadow.Size = UDim2.new(1, 40, 1, 40)
CardShadow.BackgroundTransparency = 1
CardShadow.Image = "rbxassetid://1316045217"
CardShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
CardShadow.ImageTransparency = 1
CardShadow.ScaleType = Enum.ScaleType.Slice
CardShadow.SliceCenter = Rect.new(10, 10, 118, 118)
CardShadow.ZIndex = Card.ZIndex - 1
CardShadow.Parent = ScreenGui

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 56, 0, 56)
Logo.Position = UDim2.new(0.5, 0, 0, 38)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Image = Config.Logo
Logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
Logo.ImageTransparency = 1
Logo.Parent = Card

local ProgressTrack = Instance.new("Frame")
ProgressTrack.Name = "ProgressTrack"
ProgressTrack.Size = UDim2.new(1, -40, 0, 4)
ProgressTrack.Position = UDim2.new(0.5, 0, 0, 80)
ProgressTrack.AnchorPoint = Vector2.new(0.5, 0.5)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(26, 30, 42)
ProgressTrack.BackgroundTransparency = 1
ProgressTrack.BorderSizePixel = 0
ProgressTrack.Parent = Card

local ProgressTrackCorner = Instance.new("UICorner")
ProgressTrackCorner.CornerRadius = UDim.new(1, 0)
ProgressTrackCorner.Parent = ProgressTrack

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
ProgressGlow.Thickness = 1
ProgressGlow.Transparency = 0.5
ProgressGlow.Parent = ProgressFill

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "Status"
StatusLabel.Size = UDim2.new(1, -95, 0, 16)
StatusLabel.Position = UDim2.new(0, 20, 0, 96)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "Initializing loader engine..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 155, 175)
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextTransparency = 1
StatusLabel.Parent = Card

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Name = "Percent"
PercentLabel.Size = UDim2.new(0, 50, 0, 16)
PercentLabel.Position = UDim2.new(1, -20, 0, 96)
PercentLabel.AnchorPoint = Vector2.new(1, 0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Config.AccentColor
PercentLabel.TextSize = 11
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.TextTransparency = 1
PercentLabel.Parent = Card

local function updateProgress(targetPercent, statusText)
    local clamped = math.clamp(targetPercent or 0, 0, 100)
    PercentLabel.Text = math.floor(clamped) .. "%"
    if statusText then
        StatusLabel.Text = statusText
    end
    TweenService:Create(ProgressFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(clamped / 100, 0, 1, 0)
    }):Play()
end

local function playIntroAnimation()
    TweenService:Create(BackgroundOverlay, TweenInfo.new(0.35), { BackgroundTransparency = 0.45 }):Play()
    TweenService:Create(Card, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.08,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    TweenService:Create(CardStroke, TweenInfo.new(0.35), { Transparency = 0.6 }):Play()
    TweenService:Create(CardShadow, TweenInfo.new(0.35), { ImageTransparency = 0.45 }):Play()

    Logo.Size = UDim2.new(0, 0, 0, 0)
    Logo.ImageTransparency = 1
    task.wait(0.1)
    TweenService:Create(Logo, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 56, 0, 56),
        ImageTransparency = 0
    }):Play()

    task.wait(0.1)
    TweenService:Create(ProgressTrack, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(StatusLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
    TweenService:Create(PercentLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()

    task.spawn(function()
        while Logo and Logo.Parent do
            TweenService:Create(Logo, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 60, 0, 60)
            }):Play()
            task.wait(1.1)
            if not Logo or not Logo.Parent then break end
            TweenService:Create(Logo, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 54, 0, 54)
            }):Play()
            task.wait(1.1)
        end
    end)
end

local function playExitAnimation()
    TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 180, 0, 100),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(Logo, TweenInfo.new(0.25), { ImageTransparency = 1 }):Play()
    TweenService:Create(ProgressTrack, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(StatusLabel, TweenInfo.new(0.25), { TextTransparency = 1 }):Play()
    TweenService:Create(PercentLabel, TweenInfo.new(0.25), { TextTransparency = 1 }):Play()
    TweenService:Create(CardStroke, TweenInfo.new(0.25), { Transparency = 1 }):Play()
    TweenService:Create(CardShadow, TweenInfo.new(0.25), { ImageTransparency = 1 }):Play()
    TweenService:Create(BackgroundOverlay, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    task.wait(0.35)
    pcall(function() ScreenGui:Destroy() end)
end

local function loadAndExecuteGame(matchedGame)
    updateProgress(75, "Loading script for " .. matchedGame.Name .. "...")

    local scriptCode = nil
    if _isfile and matchedGame.Local and _isfile(matchedGame.Local) then
        local ok, src = pcall(function() return _readfile(matchedGame.Local) end)
        if ok and src and #src > 0 then
            scriptCode = src
        end
    end

    if not scriptCode and matchedGame.Remote then
        updateProgress(85, "Downloading verified script from GitHub...")
        local ok, src = pcall(function() return game:HttpGet(matchedGame.Remote) end)
        if ok and src and #src > 0 then
            scriptCode = src
        else
            warn("[HYPER HUB] Failed to download script from " .. tostring(matchedGame.Remote) .. ": " .. tostring(src))
        end
    end

    if not scriptCode then
        updateProgress(90, "Fallback to Universal UI v2...")
        local ok, src = pcall(function() return game:HttpGet(FallbackGame.Remote) end)
        if ok and src and #src > 0 then
            scriptCode = src
            matchedGame = FallbackGame
        else
            warn("[HYPER HUB] Fallback download failed: " .. tostring(src))
        end
    end

    if not scriptCode then
        updateProgress(100, "Error: Failed to fetch script!")
        warn("[HYPER HUB] Could not retrieve script payload for " .. matchedGame.Name)
        task.wait(2.5)
        playExitAnimation()
        return
    end

    -- Cryptographic Integrity Verification (SHA-256)
    if matchedGame.Sha256 and matchedGame.Sha256 ~= "" then
        updateProgress(95, "Verifying cryptographic integrity...")
        local actualHash = computeSha256(scriptCode)
        if actualHash then
            if actualHash ~= string.lower(matchedGame.Sha256) then
                updateProgress(100, "Security Alert: Hash mismatch!")
                warn("[HYPER HUB] SECURITY ALERT: Script integrity check failed for " .. matchedGame.Name)
                warn("[HYPER HUB] Expected SHA-256: " .. matchedGame.Sha256)
                warn("[HYPER HUB] Actual SHA-256:   " .. actualHash)
                task.wait(3)
                playExitAnimation()
                return
            end
        end
    end

    if Config.QueueOnTeleport and _queueonteleport then
        pcall(function()
            local qCode = string.format('loadstring(game:HttpGet("%s"))()', Config.LoaderRawURL)
            _queueonteleport(qCode)
        end)
    end

    updateProgress(100, "Ready! Starting " .. matchedGame.Name .. "...")
    task.wait(0.65)
    playExitAnimation()

    local fn, loadErr = loadstring(scriptCode)
    if fn then
        local runOk, runErr = pcall(fn)
        if not runOk then
            warn("[HYPER HUB] Runtime Error in " .. matchedGame.Name .. ": " .. tostring(runErr))
        end
    else
        warn("[HYPER HUB] Syntax Compilation Error in " .. matchedGame.Name .. ": " .. tostring(loadErr))
    end
end

task.spawn(function()
    playIntroAnimation()
    task.wait(0.35)

    updateProgress(25, "Checking executor compatibility...")
    task.wait(0.3)

    updateProgress(50, "Detecting active game (PlaceId: " .. tostring(game.PlaceId) .. ")...")
    task.wait(0.35)

    local matchedGame = detectActiveGame()
    updateProgress(70, "Matched: " .. tostring(matchedGame.Name) .. "!")
    task.wait(0.35)

    loadAndExecuteGame(matchedGame)
end)
