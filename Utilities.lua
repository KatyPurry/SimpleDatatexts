-- Utility Functions

----------------------------------------------------
-- Addon Locals
----------------------------------------------------
local addonName, SDT = ...
local L = SDT.L

----------------------------------------------------
-- Library Instances
----------------------------------------------------
local LSM = LibStub("LibSharedMedia-3.0")

----------------------------------------------------
-- Lua Locals
----------------------------------------------------
local format           = string.format
local ipairs           = ipairs
local pairs            = pairs
local print            = print
local tonumber         = tonumber
local tostring         = tostring
local wipe             = table.wipe

----------------------------------------------------
-- WoW API Locals
----------------------------------------------------
local CopyTable                 = CopyTable
local GetAddOnMetadata          = C_AddOns.GetAddOnMetadata
local GetClassColor             = C_ClassColor.GetClassColor
local GetRealmName              = GetRealmName
local UIParent                  = UIParent
local UnitClass                 = UnitClass
local UnitName                  = UnitName

-------------------------------------------------
-- Build Our Addon Table and Cache
-------------------------------------------------
SDT.modules = SDT.modules or {}
SDT.bars = SDT.bars or {}
SimpleDatatexts = SDT

SDT.cache = {}
SDT.cache.playerName = UnitName("player")
SDT.cache.playerNameLower = SDT.cache.playerName:lower()
SDT.cache.playerClass = select(2, UnitClass("player"))
SDT.cache.playerRealmProper = GetRealmName()
SDT.cache.playerRealm = SDT.cache.playerRealmProper:gsub("[^%w]", ""):lower()
SDT.cache.playerFaction = UnitFactionGroup("player")
SDT.cache.playerLevel = UnitLevel("player")
SDT.cache.charKey = SDT.cache.playerNameLower.."-"..SDT.cache.playerRealm
local colors = { GetClassColor(SDT.cache.playerClass):GetRGB() }
SDT.cache.colorR = colors[1]
SDT.cache.colorG = colors[2]
SDT.cache.colorB = colors[3]
SDT.cache.colorHex = GetClassColor(SDT.cache.playerClass):GenerateHexColor()
SDT.cache.version = GetAddOnMetadata(addonName, "Version") or "not defined"
SDT.cache.moduleNames = {}

-------------------------------------------------
-- Utility: No Operation Function
-------------------------------------------------
local noop = function() end

-------------------------------------------------
-- Utility: Module Settings Exclusions
-------------------------------------------------
-- Create a table of modules to exclude (aka modules that have no settings)
SDT.excludedModules = {
    ["Coordinates"] = true,
    ["Currency"] = true,
    ["Experience"] = true,
    ["Friends"] = true,
    ["Guild"] = true,
    ["HidingBar1"] = true,
    ["Mail"] = true,
    ["System"] = true,
    ["Time"] = true,
    -- Some LDB modules aren't getting tagged with "LDB:". Needs investigated.
    ["Core Loot Manager"] = true,
    ["QuaziiUI"] = true,
}

SDT.allowedLDBModules = {
    ["LDB: BugSack"] = true,
    ["LDB: WIM"] = true,
}

function SDT:ExcludedModule(moduleName)
    if SDT.excludedModules[moduleName] then
        return true
    end

    if moduleName:sub(1, 3) == "LDB" and not SDT.allowedLDBModules[moduleName] then
        return true
    end

    return false
end

----------------------------------------------------
-- Utility: Get Module Setting
----------------------------------------------------
function SDT:GetModuleSetting(moduleName, settingsKey, default)
    local profileName = self.activeProfile
    
    -- Try to get from active profile first
    if profileName and SDTDB.profiles[profileName] and SDTDB.profiles[profileName].moduleSettings then
        if SDTDB.profiles[profileName].moduleSettings[moduleName] then
            local value = SDTDB.profiles[profileName].moduleSettings[moduleName][settingsKey]
            if value ~= nil then
                return value
            end
        end
    end
    
    -- Fallback to character settings for backward compatibility
    if SDT.SDTDB_CharDB.moduleSettings and SDT.SDTDB_CharDB.moduleSettings[moduleName] then
        return SDT.SDTDB_CharDB.moduleSettings[moduleName][settingsKey]
    end
    
    return default
end

-------------------------------------------------
-- Utility: Set Module Config Value
-------------------------------------------------
function SDT:SetModuleConfigValue(moduleName, settingKey, value)
    local profileName = self.activeProfile
    
    if profileName and SDTDB.profiles[profileName] then
        -- Initialize if needed
        if not SDTDB.profiles[profileName].moduleSettings then
            SDTDB.profiles[profileName].moduleSettings = {}
        end
        if not SDTDB.profiles[profileName].moduleSettings[moduleName] then
            SDTDB.profiles[profileName].moduleSettings[moduleName] = {}
        end
        
        -- Set the value in the profile
        SDTDB.profiles[profileName].moduleSettings[moduleName][settingKey] = value
    else
        -- Fallback to character settings
        SDT.SDTDB_CharDB.moduleSettings = SDT.SDTDB_CharDB.moduleSettings or {}
        SDT.SDTDB_CharDB.moduleSettings[moduleName] = SDT.SDTDB_CharDB.moduleSettings[moduleName] or {}
        SDT.SDTDB_CharDB.moduleSettings[moduleName][settingKey] = value
    end
end

-------------------------------------------------
-- Utility: Add Module Config
-------------------------------------------------
-- Modules can call this function to add settings to their config panel
-- Example usage in a module:
-- SDT:AddModuleConfigSetting("Agility", "checkbox", "Show Icon", "showIcon", true)
function SDT:AddModuleConfigSetting(moduleName, settingType, label, settingKey, defaultValue)
    local panel = SDT.ModuleConfigPanels[moduleName]
    if not panel then
        -- Panel doesn't exist yet, queue it
        SDT.queuedModuleSettings = SDT.queuedModuleSettings or {}
        SDT.queuedModuleSettings[moduleName] = SDT.queuedModuleSettings[moduleName] or {}
        table.insert(SDT.queuedModuleSettings[moduleName], {
            settingType = settingType,
            label = label,
            settingKey = settingKey,
            defaultValue = defaultValue
        })
        return
    end
    
    -- Initialize module settings in saved variables
    local profileName = SDT.activeProfile
    if not profileName or not SDTDB.profiles[profileName] then
        -- Fallback to character settings if no profile is active yet
        SDT.SDTDB_CharDB.moduleSettings = SDT.SDTDB_CharDB.moduleSettings or {}
        SDT.SDTDB_CharDB.moduleSettings[moduleName] = SDT.SDTDB_CharDB.moduleSettings[moduleName] or {}
        if SDT.SDTDB_CharDB.moduleSettings[moduleName][settingKey] == nil then
            SDT.SDTDB_CharDB.moduleSettings[moduleName][settingKey] = defaultValue
        end
    else
        -- Use profile-based settings
        SDTDB.profiles[profileName].moduleSettings = SDTDB.profiles[profileName].moduleSettings or {}
        SDTDB.profiles[profileName].moduleSettings[moduleName] = SDTDB.profiles[profileName].moduleSettings[moduleName] or {}
        if SDTDB.profiles[profileName].moduleSettings[moduleName][settingKey] == nil then
            SDTDB.profiles[profileName].moduleSettings[moduleName][settingKey] = defaultValue
        end
    end
    
    -- Track last anchor point
    panel.lastAnchor = panel.lastAnchor or panel.contentAnchor
    
    if settingType == "checkbox" then
        local checkbox = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
        checkbox:SetPoint("TOPLEFT", panel.lastAnchor, "BOTTOMLEFT", 0, -20)
        checkbox.Text:SetText(label)

        -- Get initial value from profile
        local currentValue = SDT:GetModuleSetting(moduleName, settingKey, true)
        if currentValue == nil then
            currentValue = defaultValue
        end
        checkbox:SetChecked(currentValue)

        checkbox:SetScript("OnClick", function(self)
            SDT:SetModuleConfigValue(moduleName, settingKey, self:GetChecked())
            SDT:UpdateAllModules()
        end)
        panel.lastAnchor = checkbox

        --[[checkbox:SetChecked(SDT.SDTDB_CharDB.moduleSettings[moduleName][settingKey])
        checkbox:SetScript("OnClick", function(self)
            SDT.SDTDB_CharDB.moduleSettings[moduleName][settingKey] = self:GetChecked()
            -- Trigger module update if it has an Update function
            local module = SDT.modules[moduleName]
            if module and module.OnConfigChanged then
                module.OnConfigChanged()
            end
            SDT:UpdateAllModules()
        end)
        panel.lastAnchor = checkbox]]
        
    elseif settingType == "slider" then
        -- Add slider implementation here if needed
        -- This is a placeholder for future expansion
        
    elseif settingType == "dropdown" then
        -- Add dropdown implementation here if needed
        -- This is a placeholder for future expansion
    end
end

-------------------------------------------------
-- Utility: Module Tooltip Functions
-------------------------------------------------
function SDT:AddTooltipHeader(tooltip, fontSize, text, r, g, b, wrap)
    tooltip = tooltip or GameTooltip
    r = r or 1
    g = g or 0.82
    b = b or 0
    
    tooltip:AddLine(text, r, g, b, wrap or false)
    
    -- Force the header to use a specific font size
    local textLeft = _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()]
    if textLeft then
        local font, _, flags = textLeft:GetFont()
        textLeft:SetFont(font, fontSize or 14, flags)
    end
end

function SDT:AddTooltipLine(tooltip, fontSize, textLeft, textRight, r1, g1, b1, r2, g2, b2, wrap)
    tooltip = tooltip or GameTooltip

    -- Handle single or double lines
    if textRight then
        r1 = r1 or 1
        g1 = g1 or 1
        b1 = b1 or 1
        r2 = r2 or 0.5
        g2 = g2 or 0.5
        b2 = b2 or 0.5
        tooltip:AddDoubleLine(textLeft, textRight, r1, g1, b1, r2, g2, b2, wrap or false)
    else
        r1 = r1 or 1
        g1 = g1 or 1
        b1 = b1 or 1
        tooltip:AddLine(textLeft, r1, g1, b1, wrap or false)
    end

    -- Normal lines get a 12pt font.
    local lineNum = tooltip:NumLines()
    local textLeftObj = _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()]
    local textRightObj = _G[tooltip:GetName() .. "TextRight" .. tooltip:NumLines()]
    if textLeftObj then
        local font, _, flags = textLeftObj:GetFont()
        textLeftObj:SetFont(font, fontSize or 12, flags)
    end
    if textRightObj then
        local font, _, flags = textRightObj:GetFont()
        textRightObj:SetFont(font, fontSize or 12, flags)
    end
end

-------------------------------------------------
-- Utility: Apply Chosen Font
-------------------------------------------------
function SDT:ApplyFont()
    local fontPath = LSM:Fetch("font", SDT.SDTDB_CharDB.settings.font) or STANDARD_TEXT_FONT
    local fontSize = SDT.SDTDB_CharDB.settings.fontSize or 12
    local fontOutline = SDT.SDTDB_CharDB.settings.fontOutline or "NONE"

    -- Convert "NONE" to empty string for SetFont
    local outline = (fontOutline == "NONE") and "" or fontOutline

    for _, bar in pairs(SDT.bars) do
        for _, slot in ipairs(bar.slots) do
            if slot.text then
                slot.text:SetFont(fontPath, fontSize, outline)
            end
            if slot.moduleFrame and slot.moduleFrame.text and slot.moduleFrame.text.SetFont then
                slot.moduleFrame.text:SetFont(fontPath, fontSize, outline)
            end
        end
    end
end

-------------------------------------------------
-- Utility: Color Text
-------------------------------------------------
function SDT:ColorText(text)
    local color = SDT:GetTagColor()
    return "|c"..color..text.."|r"
end

-------------------------------------------------
-- Utility: Find Best Anchor Point
-------------------------------------------------
function SDT:FindBestAnchorPoint(frame)
    local x, y = frame:GetCenter()
    local screenWidth = UIParent:GetRight()
    local screenHeight = UIParent:GetTop()

    if not x or not y then
        return "ANCHOR_BOTTOM"
    else
        if y < screenHeight / 2 then
            return "ANCHOR_TOP"
        else
            return "ANCHOR_BOTTOM"
        end
    end
end

-------------------------------------------------
-- Utility: Format Percentage
-------------------------------------------------
function SDT:FormatPercent(v)
    return string.format("%.2f%%", v)
end

-------------------------------------------------
-- Utility: Get Character Key
-------------------------------------------------
function SDT:GetCharKey()
    return SDT.cache.charKey
end

-------------------------------------------------
-- Utility: Get Tag Color
-------------------------------------------------
function SDT:GetTagColor()
    if SDT.SDTDB_CharDB.settings.useCustomColor then
        local color = SDT.SDTDB_CharDB.settings.customColorHex:gsub("#", "")
        return "ff"..color
    elseif SDT.SDTDB_CharDB.settings.useClassColor then
        return SDT.cache.colorHex
    end
    return "ffffffff"
end

-------------------------------------------------
-- Utility: Handle Menu List
-------------------------------------------------
function SDT:HandleMenuList(root, menuList, submenu, depth)
    if submenu then root = submenu end

    for _, list in next, menuList do
        local previous
        if list.isTitle then
            root:CreateTitle(list.text)
        elseif list.func or list.hasArrow then
            local name = list.text or ('test'..depth)

            local func = (list.arg1 or list.arg2) and (function() list.func(nil, list.arg1, list.arg2) end) or list.func
            local checked = list.checked and (not list.notCheckable and function() return list.checked(list) end or noop)
            if checked then
                previous = root:CreateCheckbox(list.text or name, checked, func)
            else
                previous = root:CreateButton(list.text or name, func)
            end
        end

        if list.menuList then -- loop it
            HandleMenuList(root, list.menuList, list.hasArrow and previous, depth + 1)
        end
    end
end

-------------------------------------------------
-- Utility: Initialize Module Config Panels
-------------------------------------------------
function SDT:InitializeModuleConfigPanels()
    -- Wait for modules to be registered
    if not SDT.cache.moduleNames or #SDT.cache.moduleNames == 0 then
        return
    end
    
    -- Create a config panel for each module
    for _, moduleName in ipairs(SDT.cache.moduleNames) do
        if not SDT.ModuleConfigPanels[moduleName] then
            CreateModuleConfigPanel(moduleName)
        end
    end
end

-------------------------------------------------
-- Utility: Find next free bar ID
-------------------------------------------------
function SDT:NextBarID()
    local n = 1
    while SDT.profileBars["SDT_Bar" .. n] do
        n = n + 1
    end
    return n
end

-------------------------------------------------
-- Utility: Print Function
-------------------------------------------------
function SDT.Print(...)
    print("[|cFFFF6600SDT|r]", ...)
end

-------------------------------------------------
-- Utility: Local Bar Creation Helper
-------------------------------------------------
local function CreateBarsFromProfile()
    for barName, barData in pairs(SDT.profileBars) do
        local id = tonumber(barName:match("SDT_Bar(%d+)"))
        local newBar = SDT:CreateDataBar(id, barData.numSlots)
        SDT.bars[barName] = newBar
        SDT.bars[barName]:Show()
    end
end

-------------------------------------------------
-- Utility: Profile Activate
-------------------------------------------------
function SDT:ProfileActivate(profileName, spec)
    SDT.SDTDB_CharDB.chosenProfile[spec] = profileName
    SDT.activeProfile = profileName

    for _, bar in pairs(SDT.bars) do
        bar:Hide()
    end
    wipe(SDT.bars)

    SDT.profileBars = SDTDB.profiles[profileName].bars
    CreateBarsFromProfile()

    SDT:RefreshProfileList()
    SDT:UpdateActiveProfile(profileName, spec)

    SDT:UpdateAllModules()
end

-------------------------------------------------
-- Utility: Profile Copy
-------------------------------------------------
function SDT:ProfileCopy(profileName)
    if not profileName or profileName == "" then return end
    if profileName == SDT.activeProfile then
        StaticPopup_Show("SDT_CANT_COPY_ACTIVE_PROFILE")
        return
    end
    local confirmString = format(L["Are you sure you want to overwrite your\n'%s' profile?\nThis action cannot be undone."], SDT.activeProfile)
    StaticPopupDialogs.SDT_CONFIRM_COPY_PROFILE.text = confirmString
    StaticPopup_Show("SDT_CONFIRM_COPY_PROFILE", nil, nil, profileName)
end

StaticPopupDialogs["SDT_CANT_COPY_ACTIVE_PROFILE"] = {
    text = L["You cannot copy the active profile onto itself. Please change your active profile first."],
    button1 = L["Ok"],
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
StaticPopupDialogs["SDT_CONFIRM_COPY_PROFILE"] = {
    text = L["Are you sure you want to overwrite your\n'%s' profile?\nThis action cannot be undone."],
    button1 = L["Yes"],
    button2 = L["No"],
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, profileName)
        local src = SDTDB.profiles[profileName]
        if not src then
            SDT.Print(L["Invalid source profile specified."])
            SDT:RefreshProfileList()
            return
        end
        local newProfile = CopyTable(src)
        for _, bar in pairs(SDT.bars) do
            bar:Hide()
        end
        wipe(SDTDB.profiles[SDT.activeProfile])
        SDTDB.profiles[SDT.activeProfile] = newProfile
        SDT.profileBars = SDTDB.profiles[SDT.activeProfile].bars
        CreateBarsFromProfile()
        SDT:RefreshProfileList()
        SDT:UpdateAllModules()
    end,
}

-------------------------------------------------
-- Utility: Profile Create
-------------------------------------------------
function SDT:ProfileCreate(profileName)
    SDTDB.profiles[profileName] = {
        bars = {},
        moduleSettings = {}
    }
    SDT.profileBars = SDTDB.profiles[profileName].bars
    SDT:CreateDataBar(1, 3)
    SDT:ProfileActivate(profileName, "generic")
end

-------------------------------------------------
-- Utility: Profile Delete
-------------------------------------------------
function SDT:ProfileDelete(profileName)
    if profileName == "" then return end
    if SDT.activeProfile == profileName then
        StaticPopup_Show("SDT_CANT_DELETE_ACTIVE_PROFILE")
        return
    else
        StaticPopup_Show("SDT_CONFIRM_DELETE_PROFILE", nil, nil, profileName)
    end
end

StaticPopupDialogs["SDT_CANT_DELETE_ACTIVE_PROFILE"] = {
    text = L["You cannot delete the active profile. Please change your active profile first."],
    button1 = L["Ok"],
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
StaticPopupDialogs["SDT_CONFIRM_DELETE_PROFILE"] = {
    text = L["Are you sure you want to delete this profile?\nThis action cannot be undone."],
    button1 = L["Yes"],
    button2 = L["No"],
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, profileName)
        SDTDB.profiles[profileName] = nil
        SDT:RefreshProfileList()
    end,
}

-------------------------------------------------
-- Module Registration
-------------------------------------------------
function SDT:RegisterDataText(name, module)
    SDT.modules[name] = module
end

-------------------------------------------------
-- Utility: SetCVar
-------------------------------------------------
function SDT:SetCVar(cvar, value)
    local valStr = ((type(value) == "boolean") and (value and '1' or '0')) or tostring(value)
    if GetCVar(cvar) ~= valStr then
        SetCVar(cvar, valStr)
    end
end
