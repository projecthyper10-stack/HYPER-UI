if not game:IsLoaded() then
    pcall(function() game.Loaded:Wait() end)
end

local _0x_LOADER_VER = "v2.0"
local _0x_UI_VER     = "v2.0"
local _0x_AUTHOR     = "K2NTA ST"

local _cloneref = (typeof(cloneref) == "function" and cloneref) or function(...) return ... end
local function getService(name)
    local ok, s = pcall(function() return game:GetService(name) end)
    return ok and _cloneref(s) or nil
end

local Players          = getService("Players")
local TweenService     = getService("TweenService")
local UserInputService = getService("UserInputService")
local HttpService      = getService("HttpService")
local RunService       = getService("RunService")
local CoreGui          = getService("CoreGui")

if Players and not Players.LocalPlayer then
    pcall(function() Players:GetPropertyChangedSignal("LocalPlayer"):Wait() end)
end
local LocalPlayer = Players and Players.LocalPlayer

local _request        = (typeof(request) == "function" and request) or (typeof(http_request) == "function" and http_request) or (typeof(syn) == "table" and syn and syn.request) or nil
local _getcustomasset = (typeof(getcustomasset) == "function" and getcustomasset) or (typeof(getsynasset) == "function" and getsynasset) or nil
local _isfile         = (typeof(isfile) == "function" and isfile) or nil
local _readfile       = (typeof(readfile) == "function" and readfile) or nil
local _writefile      = (typeof(writefile) == "function" and writefile) or nil
local _makefolder     = (typeof(makefolder) == "function" and makefolder) or nil
local _isfolder       = (typeof(isfolder) == "function" and isfolder) or nil
local _setclipboard   = (typeof(setclipboard) == "function" and setclipboard) or (typeof(toclipboard) == "function" and toclipboard) or nil
local _queueonteleport = (typeof(queue_on_teleport) == "function" and queue_on_teleport) or (typeof(queueonteleport) == "function" and queueonteleport) or nil

pcall(function()
    if _makefolder and _isfolder then
        if not _isfolder("HYPER_Cache") then
            _makefolder("HYPER_Cache")
        end
    end
end)

local _0x_DECOY_MIRRORS = {
    [0x01] = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER/refs/heads/main/Core/AntiCheatBypass_v4.lua",
    [0x02] = "https://pastebin.com/raw/d8F9aK2x",
    [0x03] = "https://api.hyperhub.net/v2/telemetry/heartbeat",
    [0x04] = "https://cdn.hyper-network.org/auth/keys/session_token.enc",
    [0x05] = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-MAIN/refs/heads/main/M.lua/Protected_Core_Stub.lua",
    [0x06] = "https://discord.com/api/webhooks/134981928472910/aZ89fk_FakeSecurityWebhook",
    [0x07] = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-LOADER/refs/heads/main/M.lua/Universal_v4_Deobf.lua",
    [0x08] = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-MAIN/refs/heads/main/M.lua/Payload_Sec_99214.lua",
    [0x09] = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-SECURITY/refs/heads/main/Bypass/Guard_Core.luau"
}
local _0x_DUMMY_CHECKSUMS = {
    [0x1A4F] = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    [0x3B8C] = "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8",
    [0x9F01] = "4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a",
    [0xC0DE] = "8f48a56b6238b02130e9d1a84f32901aef12d49c8942b1029cba489f012bceaa"
}
local _0x_SEC_META = {
    _seed = 0x5F2D99,
    _sig = "0x89A_PROTECT_HYPER_SEC_BUILD_2026_X4",
    _tamperLog = _0x_DECOY_MIRRORS[6],
    _probe = function(...) local a = {...}; return a[1] end
}

local _0x_cache = {}
local function _0x_dec(bytes, shift)
    shift = shift or 53
    local hash = #bytes .. "_" .. shift
    if _0x_cache[hash] then return _0x_cache[hash] end
    local str = {}
    for i = 1, #bytes do
        str[i] = string.char(bytes[i] - shift)
    end
    local res = table.concat(str)
    _0x_cache[hash] = res
    return res
end

local _0x_STR_LOADER_RAW = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 129, 132, 118, 121, 122, 135, 99, 131, 122, 140, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 161, 164, 150, 153, 154, 167, 98, 171, 103, 99, 161, 170, 150}
local _0x_STR_LOGO = {155, 139, 161, 138, 156, 156, 142, 157, 146, 141, 99, 88, 88, 90, 89, 97, 98, 94, 91, 90, 89, 91, 95, 89, 91, 97, 92, 93}
local _0x_STR_LAUNDRY = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 130, 118, 126, 131, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 130, 99, 161, 170, 150, 100, 102, 104, 103, 105, 104, 105, 108, 104, 105, 107, 107, 103, 104, 105, 107, 103, 104, 106, 99, 161, 170, 150}
local _0x_STR_MM2 = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 130, 118, 126, 131, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 130, 99, 161, 170, 150, 100, 104, 105, 106, 110, 101, 103, 104, 108, 107, 107, 105, 104, 103, 99, 161, 170, 150}
local _0x_STR_GUN = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 130, 118, 126, 131, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 130, 99, 161, 170, 150, 100, 103, 104, 105, 103, 109, 110, 104, 102, 106, 102, 103, 103, 106, 104, 106, 102, 103, 104, 99, 161, 170, 150}
local _0x_STR_BF = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 129, 132, 118, 121, 122, 135, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 130, 99, 161, 170, 150, 100, 119, 123, 90, 103, 101, 139, 102}
local _0x_STR_FAME = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 129, 132, 118, 121, 122, 135, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 130, 99, 161, 170, 150, 100, 155, 150, 162, 154, 90, 103, 101, 103, 103, 103, 99, 161, 170, 150}
local _0x_STR_BASKET = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 129, 132, 118, 121, 122, 135, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 130, 99, 161, 170, 150, 100, 119, 150, 168, 160, 154, 169, 151, 150, 161, 161, 148, 141, 126, 131, 143, 99, 161, 170, 150}
local _0x_STR_UNIVERSAL = {157, 169, 169, 165, 168, 111, 100, 100, 167, 150, 172, 99, 156, 158, 169, 157, 170, 151, 170, 168, 154, 167, 152, 164, 163, 169, 154, 163, 169, 99, 152, 164, 162, 100, 165, 167, 164, 159, 154, 152, 169, 157, 174, 165, 154, 167, 102, 101, 98, 168, 169, 150, 152, 160, 100, 125, 142, 133, 122, 135, 98, 138, 126, 100, 167, 154, 155, 168, 100, 157, 154, 150, 153, 168, 100, 162, 150, 158, 163, 100, 170, 158, 169, 154, 168, 169, 98, 171, 103, 99, 161, 170, 150}
local _0x_LOC_LAUNDRY = {130, 146, 161, 152, 159, 163, 162, 94, 124, 93, 155, 164, 144, 94, 123, 144, 164, 157, 147, 161, 168, 130, 152, 156, 164, 155, 144, 163, 158, 161, 142, 112, 164, 163, 158, 117, 144, 161, 156, 93, 155, 164, 144}
local _0x_LOC_MM2 = {130, 146, 161, 152, 159, 163, 162, 94, 124, 93, 155, 164, 144, 94, 124, 124, 97, 79, 115, 126, 125, 116, 93, 155, 164, 144}
local _0x_LOC_GUN = {130, 146, 161, 152, 159, 163, 162, 94, 124, 93, 155, 164, 144, 94, 150, 164, 157, 79, 144, 164, 163, 158, 93, 155, 164, 144}
local _0x_LOC_BF = {130, 146, 161, 152, 159, 163, 162, 94, 124, 93, 155, 164, 144, 94, 113, 117, 79, 133, 96}
local _0x_LOC_FAME = {130, 146, 161, 152, 159, 163, 162, 94, 124, 93, 155, 164, 144, 94, 149, 144, 156, 148, 79, 97, 97, 97, 93, 155, 164, 144}
local _0x_LOC_BASKET = {130, 146, 161, 152, 159, 163, 162, 94, 113, 144, 162, 154, 148, 163, 145, 144, 155, 155, 142, 119, 136, 127, 116, 129, 93, 155, 164, 144}
local _0x_LOC_UNIVERSAL = {130, 146, 161, 152, 159, 163, 162, 94, 132, 120, 165, 93, 97, 93, 156, 144, 152, 157, 94, 164, 152, 163, 148, 162, 163, 92, 165, 97, 93, 155, 164, 144}

local Config = {
    HubName         = "HYPER HUB",
    LoaderVersion   = _0x_LOADER_VER,
    Subtitle        = "Universal Game Loader",
    Logo            = _0x_dec(_0x_STR_LOGO, 41),
    AccentColor     = Color3.fromRGB(29, 235, 169),
    QueueOnTeleport = true,
    LoaderRawURL    = _0x_dec(_0x_STR_LOADER_RAW, 53),
}

local SupportedGames = {
    {
        Name     = "Arsenal (Universal Silent)",
        PlaceIds = { 88888888881, 88888888882 },
        Local    = "Scripts/M.lua/_decoy_arsenal.lua",
        Remote   = _0x_DECOY_MIRRORS[1],
        Version  = "v4.5-PRO",
        _vSign   = 0xCAFEBABE,
        _isDecoy = true,
    },
    {
        Name     = "Blox Fruits (V3 Enterprise)",
        PlaceIds = { 99999999911, 99999999922 },
        Local    = "Scripts/M.lua/_decoy_v3.lua",
        Remote   = _0x_DECOY_MIRRORS[7],
        Version  = "v9.9-SEC",
        _vSign   = 0xDEADBEEF,
        _isDecoy = true,
    },
    {
        Name     = "Laundry Simulator",
        PlaceIds = { 6305942109 },
        Local    = _0x_dec(_0x_LOC_LAUNDRY, 47),
        Remote   = _0x_dec(_0x_STR_LAUNDRY, 53),
        Version  = "v2.0",
        _vSign   = 0x8C33E1,
    },
    {
        Name     = "Murder Mystery 2",
        PlaceIds = { 142823291 },
        Local    = _0x_dec(_0x_LOC_MM2, 47),
        Remote   = _0x_dec(_0x_STR_MM2, 53),
        Version  = "v2.0",
        _vSign   = 0x4A1F9B,
    },
    {
        Name     = "Cali Shootout",
        PlaceIds = { 12077443856 },
        Local    = _0x_dec(_0x_LOC_GUN, 47),
        Remote   = _0x_dec(_0x_STR_GUN, 53),
        Version  = "v2.0",
        _vSign   = 0x127EEF,
    },
    {
        Name     = "Blox Fruits",
        PlaceIds = { 2753915549, 4442272183, 7449423635 },
        Local    = _0x_dec(_0x_LOC_BF, 47),
        Remote   = _0x_dec(_0x_STR_BF, 53),
        Version  = "v1.0",
        _vSign   = 0xAA2211,
    },
    {
        Name     = "Mine a Mountain",
        PlaceIds = { 125927821145949 },
        Local    = _0x_dec(_0x_LOC_FAME, 47),
        Remote   = _0x_dec(_0x_STR_FAME, 53),
        Version  = "v1.0",
        _vSign   = 0x66AB81,
    },
    {
        Name     = "Basketball",
        PlaceIds = { 16033173781, 16270425785 },
        Local    = _0x_dec(_0x_LOC_BASKET, 47),
        Remote   = _0x_dec(_0x_STR_BASKET, 53),
        Version  = "v1.0",
        _vSign   = 0x334455,
    },
    {
        Name     = "BasketballZero",
        PlaceIds = { 129230994638464, 130739873848552 },
        Local    = _0x_dec(_0x_LOC_BASKET, 47),
        Remote   = _0x_dec(_0x_STR_BASKET, 53),
        Version  = "v1.0",
        _vSign   = 0x556677,
    },
}

local FallbackGame = {
    Name     = "Universal Hub",
    PlaceIds = {},
    Local    = _0x_dec(_0x_LOC_UNIVERSAL, 47),
    Remote   = _0x_dec(_0x_STR_UNIVERSAL, 53),
    Version  = "v2.0",
    _vSign   = 0x000000,
}

local function detectActiveGame()
    local curPlace = tonumber(game.PlaceId)
    for _, g in ipairs(SupportedGames) do
        if g.PlaceIds and not g._isDecoy then
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
        updateProgress(85, "Downloading script payload...")
        local ok, src = pcall(function() return game:HttpGet(matchedGame.Remote) end)
        if ok and src and #src > 0 then
            scriptCode = src
        end
    end

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
            warn("[HYPER HUB] Runtime Error in " .. matchedGame.Name .. ":", tostring(runErr))
        end
    else
        warn("[HYPER HUB] Syntax Error in " .. matchedGame.Name .. ":", tostring(loadErr))
    end
end

task.spawn(function()
    playIntroAnimation()
    task.wait(0.4)

    updateProgress(25, "Checking executor compatibility...")
    task.wait(0.3)

    updateProgress(55, "Detecting active game (PlaceId: " .. tostring(game.PlaceId) .. ")...")
    task.wait(0.35)

    local matchedGame = detectActiveGame()
    updateProgress(75, "Matched: " .. tostring(matchedGame.Name) .. "!")
    task.wait(0.35)

    loadAndExecuteGame(matchedGame)
end)
