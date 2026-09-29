-- ==============================================================================
--  HYPER HUB / MACLIB - UI Test Script (Slayers2 Style)
-- ==============================================================================

local REPO = "https://raw.githubusercontent.com/projecthyper10-stack/HYPER-UI/refs/heads/main/"

-- Step 0: Clean up any previous UI instances thoroughly
pcall(function()
    local globalEnv = (getgenv and getgenv()) or _G
    if globalEnv._MacLibScreenGui and typeof(globalEnv._MacLibScreenGui) == "Instance" then
        pcall(function() globalEnv._MacLibScreenGui:Destroy() end)
        globalEnv._MacLibScreenGui = nil
    end
    if _G._MacLibScreenGui and typeof(_G._MacLibScreenGui) == "Instance" then
        pcall(function() _G._MacLibScreenGui:Destroy() end)
        _G._MacLibScreenGui = nil
    end

    local containers = {}
    if typeof(gethui) == "function" then
        pcall(function() table.insert(containers, gethui()) end)
    end
    pcall(function()
        local CoreGui = game:GetService("CoreGui")
        if CoreGui then table.insert(containers, CoreGui) end
    end)
    pcall(function()
        local lp = game:GetService("Players").LocalPlayer
        if lp and lp:FindFirstChild("PlayerGui") then
            table.insert(containers, lp.PlayerGui)
        end
    end)

    for _, container in ipairs(containers) do
        pcall(function()
            for _, child in ipairs(container:GetChildren()) do
                if child:IsA("ScreenGui") then
                    if child.Name == "MacLibScreenGui"
                        or (child:FindFirstChild("Base") and child.Base:FindFirstChild("Sidebar"))
                        or child:FindFirstChild("Breadcrumb") then
                        child:Destroy()
                    end
                end
            end
        end)
    end
end)

-- Step 1: Pre-load icon.lua
pcall(function()
    local iconCode = ""
    if typeof(isfile) == "function" and isfile("icon.lua") then
        iconCode = readfile("icon.lua")
    elseif typeof(isfile) == "function" and isfile("Maclib/icon.lua") then
        iconCode = readfile("Maclib/icon.lua")
    else
        iconCode = game:HttpGet(REPO .. "icon.lua?t=" .. tostring(tick()))
    end
    local func = loadstring(iconCode)
    if func then
        local ok, result = pcall(func)
        if ok and result then _G._MacLibIconEngine = result end
    end
end)

-- Step 2: Load ui-main.lua
local MacLib
local okLoad, resLoad = pcall(function()
    local code = ""
    if typeof(isfile) == "function" and isfile("ui-main.lua") then
        code = readfile("ui-main.lua")
    elseif typeof(isfile) == "function" and isfile("Maclib/ui-main.lua") then
        code = readfile("Maclib/ui-main.lua")
    else
        code = game:HttpGet(REPO .. "ui-main.lua?t=" .. tostring(tick()))
    end
    local func, err = loadstring(code)
    if not func then error("[ui-main.lua Compile Error]: " .. tostring(err)) end
    local ok, result = pcall(func)
    if not ok then error("[ui-main.lua Runtime Error]: " .. tostring(result)) end
    return result
end)
if okLoad and resLoad then MacLib = resLoad
else warn("[MacLib] Failed to load: " .. tostring(resLoad)) return end

-- ==============================================================================
--  Window
-- ==============================================================================

local Window = MacLib:Window({
    Title = "Slayers2",
    Subtitle = "Primary",
    Size = UDim2.fromOffset(710, 450),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = true,
    Keybind = Enum.KeyCode.RightControl,
    AcrylicBlur = true,
})

Window:GlobalSetting({ Name = "UI Blur", Default = Window:GetAcrylicBlurState(), Callback = function(bool) Window:SetAcrylicBlurState(bool) end })
Window:GlobalSetting({ Name = "Notifications", Default = Window:GetNotificationsState(), Callback = function(bool) Window:SetNotificationsState(bool) end })

-- ==============================================================================
--  Tab Groups (Sidebar Categories)
-- ==============================================================================

local tabGroups = {
    Main       = Window:TabGroup(),
    AutoFarm   = Window:TabGroup(),
    Combat     = Window:TabGroup(),
    Character  = Window:TabGroup(),
    Training   = Window:TabGroup(),
    Navigation = Window:TabGroup(),
    Farms      = Window:TabGroup(),
    SettingsGroup = Window:TabGroup(),
}

-- ==============================================================================
--  Tabs
-- ==============================================================================

local tabs = {
    Home       = tabGroups.Main:Tab({ Name = "Home",       Icon = "lucide-home" }),
    Farming    = tabGroups.AutoFarm:Tab({ Name = "Farming",    Icon = "lucide-wheat" }),
    Loadout    = tabGroups.Combat:Tab({ Name = "Loadout",      Icon = "lucide-shield" }),
    Movement   = tabGroups.Character:Tab({ Name = "Movement",  Icon = "lucide-person-standing" }),
    Breathing  = tabGroups.Training:Tab({ Name = "Breathing",  Icon = "lucide-wind" }),
    DemonArt   = tabGroups.Training:Tab({ Name = "Demon Art",  Icon = "lucide-flame" }),
    Travel     = tabGroups.Navigation:Tab({ Name = "Travel",   Icon = "lucide-map-pin" }),
    Schematics = tabGroups.Farms:Tab({ Name = "Schematics",    Icon = "lucide-clipboard" }),
    UISettings = tabGroups.SettingsGroup:Tab({ Name = "UI Settings", Icon = "lucide-settings" }),
}

-- ==============================================================================
--  Sections
-- ==============================================================================

local sections = {
    HomeWelcome   = tabs.Home:Section({ Name = "Welcome", Side = "Left" }),
    HomeStats     = tabs.Home:Section({ Name = "System Information", Side = "Right" }),
    FarmingMain   = tabs.Farming:Section({ Name = "Auto Farm", Side = "Left" }),
    BossSection   = tabs.Farming:Section({ Name = "Bosses",    Side = "Left" }),
    BossHunt      = tabs.Farming:Section({ Name = "Boss Hunt", Side = "Left" }),
    LoadoutMain   = tabs.Loadout:Section({ Name = "Equipment", Side = "Left" }),
    MovementMain  = tabs.Movement:Section({ Name = "Movement", Side = "Left" }),
    BreathingMain = tabs.Breathing:Section({ Name = "Breathing Style", Side = "Left" }),
    DemonArtMain  = tabs.DemonArt:Section({ Name = "Demon Art", Side = "Left" }),
    TravelMain    = tabs.Travel:Section({ Name = "Navigation", Side = "Left" }),
    SchematicsMain = tabs.Schematics:Section({ Name = "Schematics", Side = "Left" }),
    SettingsMain   = tabs.UISettings:Section({ Name = "Settings", Side = "Left" }),
}

-- ==============================================================================
--  Home Tab
-- ==============================================================================

local plr = game:GetService("Players").LocalPlayer

sections.HomeWelcome:Label({ Text = "Welcome, " .. (plr and plr.DisplayName or "User") .. "!" })
sections.HomeWelcome:SubLabel({ Text = "Thanks for using HYPER HUB v2.6" })

sections.HomeStats:Label({ Text = "User" })
sections.HomeStats:SubLabel({ Text = plr and plr.Name or "Unknown" })

sections.HomeStats:Label({ Text = "Executor" })
sections.HomeStats:SubLabel({ Text = (identifyexecutor and identifyexecutor()) or "Unknown" })

sections.HomeStats:Label({ Text = "Device / OS" })
sections.HomeStats:SubLabel({ Text = "Windows / PC" })

sections.HomeStats:Label({ Text = "Current Time" })
-- Actually we don't have a returned object with SetText in Maclib Demo usually, 
-- but we can just set it once, or if Maclib supports it, update it.
local timeSub = sections.HomeStats:SubLabel({ Text = os.date("%X") })

task.spawn(function()
    while task.wait(1) do
        if timeSub and timeSub.SetText then
            pcall(function() timeSub:SetText(os.date("%X")) end)
        elseif timeSub and timeSub.SetDesc then
            pcall(function() timeSub:SetDesc(os.date("%X")) end)
        end
    end
end)

-- ==============================================================================
--  Farming Tab
-- ==============================================================================

sections.FarmingMain:Toggle({ Name = "Auto Farm", Description = "Turn auto-farming on or off.", Default = false, Callback = function(v) end }, "AutoFarm")
sections.FarmingMain:Toggle({ Name = "Auto Final Selection [WIP]", Description = "Travel to the Final Selection zone before its next cycle.", Default = false, Callback = function(v) end }, "AutoFinalSelection")
sections.FarmingMain:Label({ Text = "Next Final Selection" })
sections.FarmingMain:SubLabel({ Text = "9:36" })
sections.FarmingMain:Dropdown({ Name = "Quest Selection", Description = "Smart picks the best quest, or choose one.", Multi = false, Required = true, Options = { "Smart", "Slayer Quest", "Demon Quest", "Wisteria Quest" }, Default = 1, Callback = function(v) end }, "QuestSelection")

sections.BossSection:Toggle({ Name = "Enabled", Description = "Turn boss farming on or off.", Default = false, Callback = function(v) end }, "BossEnabled")
sections.BossSection:Dropdown({ Name = "Bosses", Description = "Select which boss to farm.", Multi = false, Required = true, Options = { "[Lv 45] [Boss] [Flame Trainee]", "[Lv 60] [Boss] [Thunder Trainee]", "[Lv 80] [Boss] [Water Trainee]" }, Default = 1, Callback = function(v) end }, "BossSelect")

sections.BossHunt:Toggle({ Name = "Enabled", Description = "Auto-accepts and fights the best available Boss Hunt quest.", Default = false, Callback = function(v) end }, "BossHuntEnabled")

-- ==============================================================================
--  Loadout Tab
-- ==============================================================================

sections.LoadoutMain:Dropdown({ Name = "Weapon", Description = "Select your current weapon.", Multi = false, Required = true, Options = { "Katana", "Nichirin Blade", "Wooden Sword" }, Default = 1, Callback = function(v) end }, "WeaponSelect")
sections.LoadoutMain:Toggle({ Name = "Auto Equip Best Gear", Description = "Automatically equips the strongest available gear.", Default = false, Callback = function(v) end }, "AutoEquip")

-- ==============================================================================
--  Movement Tab
-- ==============================================================================

sections.MovementMain:Toggle({ Name = "Speed Boost", Description = "Increases movement speed while active.", Default = false, Callback = function(v) end }, "SpeedBoost")
sections.MovementMain:Slider({ Name = "Walk Speed", Description = "Set your character walk speed.", Default = 16, Minimum = 16, Maximum = 100, DisplayMethod = "Value", Precision = 0, Callback = function(v) end }, "WalkSpeed")
sections.MovementMain:Toggle({ Name = "Infinite Jump", Description = "Allows jumping while in the air.", Default = false, Callback = function(v) end }, "InfJump")

-- ==============================================================================
--  Breathing Tab
-- ==============================================================================

sections.BreathingMain:Toggle({ Name = "Auto Breathing", Description = "Automatically uses your breathing style in combat.", Default = false, Callback = function(v) end }, "AutoBreathing")
sections.BreathingMain:Dropdown({ Name = "Breathing Style", Description = "Select your breathing style.", Multi = false, Required = true, Options = { "Flame Breathing", "Water Breathing", "Thunder Breathing", "Wind Breathing", "Stone Breathing" }, Default = 1, Callback = function(v) end }, "BreathingStyle")

-- ==============================================================================
--  Demon Art Tab
-- ==============================================================================

sections.DemonArtMain:Toggle({ Name = "Auto Demon Art", Description = "Automatically uses Demon Art abilities.", Default = false, Callback = function(v) end }, "AutoDemonArt")
sections.DemonArtMain:Dropdown({ Name = "Demon Art", Description = "Select your Demon Art.", Multi = false, Required = true, Options = { "Blood Demon Art", "Bone Manipulation", "Flesh Manipulation" }, Default = 1, Callback = function(v) end }, "DemonArtSelect")

-- ==============================================================================
--  Travel Tab
-- ==============================================================================

sections.TravelMain:Dropdown({ Name = "Destination", Description = "Select where to travel.", Multi = false, Required = true, Options = { "Final Selection", "Butterfly Mansion", "Swordsmith Village", "Infinity Castle" }, Default = 1, Callback = function(v) end }, "TravelDest")
sections.TravelMain:Button({ Name = "Travel Now", Description = "Teleport to selected destination.", Callback = function() Window:Notify({ Title = "Travel", Description = "Traveling...", Lifetime = 3 }) end })

-- ==============================================================================
--  Schematics Tab
-- ==============================================================================

sections.SchematicsMain:Toggle({ Name = "Auto Collect Schematics", Description = "Automatically picks up schematics in the world.", Default = false, Callback = function(v) end }, "AutoSchematics")

-- ==============================================================================
--  UI Settings Tab
-- ==============================================================================

sections.SettingsMain:Dropdown({
    Name = "Closed UI Style",
    Description = "Select the style of the minimized UI.",
    Options = { "Hidden", "Breadcrumb" },
    Default = 1,
    Callback = function(style)
        if Window.SetClosedUIStyle then
            Window:SetClosedUIStyle(style)
        end
    end
}, "ClosedUIStyle")

sections.SettingsMain:Colorpicker({
    Name = "Accent Color",
    Description = "Change the UI theme color (WIP).",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        -- Hook to your theme changer if implemented
    end
}, "AccentColor")

sections.SettingsMain:Slider({
    Name = "UI Scale",
    Description = "Adjust the overall size of the interface.",
    Default = 100,
    Minimum = 75,
    Maximum = 130,
    DisplayMethod = "%",
    Precision = 0,
    Callback = function(v)
        if Window and Window.SetScale then
            Window:SetScale(v / 100)
        end
    end
}, "UIScale")

-- ==============================================================================
--  Config & Init
-- ==============================================================================

MacLib:SetFolder("Maclib")
tabs.Farming:InsertConfigSection("Left")

Window.onUnloaded(function() print("[Slayers2] Unloaded!") end)

tabs.Home:Select()
MacLib:LoadAutoLoadConfig()
