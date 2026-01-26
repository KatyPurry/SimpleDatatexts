-- Core.lua - Main addon initialization
local addonName, SDT = ...

-- Create the addon object using Ace3
LibStub("AceAddon-3.0"):NewAddon(SDT, addonName, "AceEvent-3.0")
_G.SimpleDatatexts = SDT

----------------------------------------------------
-- Initialize Localization
----------------------------------------------------
SDT.L = SDT.L or {}
local L = SDT.L

if not getmetatable(L) then
    setmetatable(L, {
        __index = function(_, key)
            return key
        end
    })
end

----------------------------------------------------
-- Library Instances
----------------------------------------------------
SDT.LSM = LibStub("LibSharedMedia-3.0")
SDT.LDB = LibStub("LibDataBroker-1.1")
SDT.LibDeflate = LibStub:GetLibrary("LibDeflate")
SDT.AceSerializer = LibStub("AceSerializer-3.0")

----------------------------------------------------
-- Addon Tables
----------------------------------------------------
SDT.modules = SDT.modules or {}
SDT.bars = SDT.bars or {}
SDT.cache = SDT.cache or {}

----------------------------------------------------
-- WoW API Locals
----------------------------------------------------
local GetAddOnMetadata = C_AddOns.GetAddOnMetadata
local GetClassColor = C_ClassColor.GetClassColor
local GetRealmName = GetRealmName
local UnitClass = UnitClass
local UnitName = UnitName

----------------------------------------------------
-- Build Cache
----------------------------------------------------
function SDT:BuildCache()
    self.cache.playerName = UnitName("player")
    self.cache.playerNameLower = self.cache.playerName:lower()
    self.cache.playerClass = select(2, UnitClass("player"))
    self.cache.playerRealmProper = GetRealmName()
    self.cache.playerRealm = self.cache.playerRealmProper:gsub("[^%w]", ""):lower()
    self.cache.playerFaction = UnitFactionGroup("player")
    self.cache.playerLevel = UnitLevel("player")
    self.cache.charKey = self.cache.playerNameLower.."-"..self.cache.playerRealm
    
    local colors = { GetClassColor(self.cache.playerClass):GetRGB() }
    self.cache.colorR = colors[1]
    self.cache.colorG = colors[2]
    self.cache.colorB = colors[3]
    self.cache.colorHex = GetClassColor(self.cache.playerClass):GenerateHexColor()
    self.cache.version = GetAddOnMetadata(addonName, "Version") or L["Not Defined"]
    self.cache.moduleNames = {}
end

----------------------------------------------------
-- Addon Initialization
----------------------------------------------------
function SDT:OnInitialize()
    -- Build cache first
    self:BuildCache()

    -- Initialize database (handled in Database.lua)
    self:InitializeDatabase()

    -- Register slash commands
    self:RegisterSlashCommands()
end

function SDT:OnEnable()
    -- Register fonts
    self:RegisterFonts()

    -- Create module list
    self:CreateModuleList()

    -- Create addon list
    self:CreateAddonList()

    -- Register config (handled in Config.lua)
    self:RegisterConfig()

    -- Create bars from current profile
    for barName, barData in pairs(self.db.profile.bars) do
        local id = tonumber(barName:match("SDT_Bar(%d+)"))
        if id and id > 0 then
            self:CreateDataBar(id, barData.numSlots)
        end
    end
end

----------------------------------------------------
-- Register Fonts
----------------------------------------------------
function SDT:RegisterFonts()
    self.LSM:Register("font", "Action Man", [[Interface\AddOns\SimpleDatatexts\fonts\ActionMan.ttf]])
    self.LSM:Register("font", "Continuum Medium", [[Interface\AddOns\SimpleDatatexts\fonts\ContinuumMedium.ttf]])
    self.LSM:Register("font", "Die Die Die", [[Interface\AddOns\SimpleDatatexts\fonts\DieDieDie.ttf]])
    self.LSM:Register("font", "Expressway", [[Interface\AddOns\SimpleDatatexts\fonts\Expressway.ttf]])
    self.LSM:Register("font", "Homespun", [[Interface\AddOns\SimpleDatatexts\fonts\Homespun.ttf]])
    self.LSM:Register("font", "Invisible", [[Interface\AddOns\SimpleDatatexts\fonts\Invisible.ttf]])
    self.LSM:Register("font", "PT Sans Narrow", [[Interface\AddOns\SimpleDatatexts\fonts\PTSansNarrow.ttf]])
end

----------------------------------------------------
-- Create Module List
----------------------------------------------------
function SDT:CreateModuleList()
    wipe(self.cache.moduleNames)
    for name in pairs(self.modules) do
        tinsert(self.cache.moduleNames, name)
    end
    table.sort(self.cache.moduleNames)
end

----------------------------------------------------
-- Create Addon List
----------------------------------------------------
function SDT:CreateAddonList()
    self.cache.addonList = self.cache.addonList or {}
    wipe(self.cache.addonList)
    local addOnCount = C_AddOns.GetNumAddOns()
    local counter = 1
    for i = 1, addOnCount do
        local name, title, _, loadable, reason = C_AddOns.GetAddOnInfo(i)
        if loadable or reason == "DEMAND_LOADED" then
            self.cache.addonList[counter] = {name = name, title = title, index = i}
            counter = counter + 1
        end
    end
end

----------------------------------------------------
-- Slash Commands
----------------------------------------------------
function SDT:RegisterSlashCommands()
    SLASH_SIMPLEDATATEXTS1 = "/sdt"
    SLASH_SIMPLEDATATEXTS2 = "/simpledatatexts"
    
    SlashCmdList["SIMPLEDATATEXTS"] = function(msg)
        self:HandleSlashCommand(msg)
    end
end

function SDT:HandleSlashCommand(msg)
    local args = {}
    for word in msg:gmatch("%S+") do
        tinsert(args, word)
    end
    local command = args[1] and args[1]:lower() or ""
    
    if command == "config" or command == "" then
        -- Open config GUI
        self:OpenConfig()
    elseif command == "lock" then
        self:ToggleLock()
    elseif command == "version" then
        self:Print(format("%s %s: |cff8888ff%s|r", self.L["Simple Datatexts"], self.L["Version"], self.cache.version))
    else
        self:Print(self.L["Usage"] .. ":")
        self:Print("/sdt config - " .. self.L["Settings"])
        self:Print("/sdt lock - " .. self.L["Lock/Unlock"])
        self:Print("/sdt version - " .. self.L["Version"])
    end
end

----------------------------------------------------
-- Utility: Print Function
----------------------------------------------------
function SDT:Print(...)
    print("[|cFFFF6600SDT|r]", ...)
end

----------------------------------------------------
-- Utility: Get Character Key
----------------------------------------------------
function SDT:GetCharKey()
    return self.cache.charKey
end

----------------------------------------------------
-- Module Registration
----------------------------------------------------
function SDT:RegisterDataText(name, module)
    self.modules[name] = module
end

----------------------------------------------------
-- Save Bar Position
----------------------------------------------------
local function SaveBarPosition(bar)
    local point, _, relativePoint, x, y = bar:GetPoint()
    local barName = bar:GetName()
    SDT.db.profile.bars[barName].point = {
        point = point,
        relativePoint = relativePoint,
        x = x,
        y = y
    }
end

----------------------------------------------------
-- Create Movable Frame
----------------------------------------------------
local function CreateMovableFrame(name)
    local f = CreateFrame("Frame", name, UIParent, "BackdropTemplate")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetClampedToScreen(true)

    f:SetScript("OnDragStart", function(self)
        if not SDT.db.profile.locked then
            self:StartMoving()
        end
    end)

    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        SaveBarPosition(self)
    end)

    return f
end

----------------------------------------------------
-- Create Data Bar
----------------------------------------------------
function SDT:CreateDataBar(id, numSlots)
    local name = "SDT_Bar" .. id
    if not self.db.profile.bars[name] then
        self.db.profile.bars[name] = {
            numSlots = numSlots or 3,
            slots = {},
            bgOpacity = 50,
            borderName = "None",
            border = "None",
            width = 300,
            height = 22,
            name = name
        }
    end
    
    local saved = self.db.profile.bars[name]
    local bar = CreateMovableFrame(name)
    self.bars[name] = bar

    bar:SetSize(300, 22)
    if saved.point then
        bar:SetPoint(saved.point.point, UIParent, saved.point.relativePoint, saved.point.x, saved.point.y)
    else
        bar:SetPoint("CENTER")
    end

    local scale = saved.scale or 100
    bar:SetScale(scale / 100)

    function bar:ApplyBackground()
        local hasBackground = saved.bgOpacity and saved.bgOpacity > 0
        local hasBorder = saved.borderName and saved.borderName ~= "None"

        if hasBackground or hasBorder then
            bar:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = hasBorder and saved.border or nil,
                edgeSize = hasBorder and saved.borderSize or 0
            })
            local alpha = (saved.bgOpacity or 50) / 100
            bar:SetBackdropColor(0, 0, 0, alpha)
            if saved.borderColor then
                local color = saved.borderColor:gsub("#", "")
                local r = tonumber(color:sub(1, 2), 16) / 255
                local g = tonumber(color:sub(3, 4), 16) / 255
                local b = tonumber(color:sub(5, 6), 16) / 255
                bar:SetBackdropBorderColor(r, g, b, alpha)
            end
        else
            bar:SetBackdrop(nil)
        end
    end

    bar:ApplyBackground()
    self:RebuildSlots(bar)
    return bar
end

----------------------------------------------------
-- Rebuild Slots
----------------------------------------------------
function SDT:RebuildSlots(bar)
    if not bar then return end

    -- Hide and clear existing slot frames
    if bar.slots then
        for _, s in ipairs(bar.slots) do
            if s.moduleFrame then
                s.moduleFrame:Hide()
                s.moduleFrame:SetParent(nil)
                s.moduleFrame = nil
            end
            s:SetParent(nil)
            s:Hide()
        end
    end
    bar.slots = {}

    local barName = bar:GetName()
    local saved = self.db.profile.bars[barName]
    if not saved then return end
    
    local numSlots = saved.numSlots or 3
    local totalW = saved.width or 300
    local totalH = saved.height or 22
    local slotW = totalW / numSlots
    local slotH = totalH
    
    bar:SetSize(totalW, totalH)

    for i = 1, numSlots do
        local slotName = barName .. "_Slot" .. i
        local slot = CreateFrame("Button", slotName, bar)
        slot:SetSize(slotW, slotH)
        slot.index = i
        slot:SetPoint("LEFT", bar, "LEFT", (i - 1) * slotW, 0)

        slot.text = slot.text or slot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slot.text:SetPoint("CENTER")
        slot.text:SetText("")

        local assignedName = saved.slots[i]
        if assignedName == "(spacer)" then
            slot.module = "(spacer)"
            slot.text:SetText("")
            if slot.moduleFrame then slot.moduleFrame:Hide() end
        elseif assignedName and self.modules[assignedName] then
            local mod = self.modules[assignedName]
            if slot.moduleFrame then slot.moduleFrame:Hide() end
            slot.module = assignedName
            slot.moduleFrame = mod.Create(slot)
        else
            slot.module = nil
            if slot.moduleFrame then slot.moduleFrame:Hide() end
            slot.text:SetText(assignedName or self.L["(empty)"])
        end

        slot:EnableMouse(true)
        slot:RegisterForClicks("AnyUp")
        slot:SetScript("OnMouseUp", function(self, btn)
            if btn == "RightButton" and IsControlKeyDown() then
                SDT:ShowSlotDropdown(self, bar)
            end
        end)

        -- Forward drag events to parent bar
        slot:RegisterForDrag("LeftButton")
        slot:SetScript("OnDragStart", function(self)
            if not SDT.db.profile.locked then
                bar:StartMoving()
            end
        end)
        slot:SetScript("OnDragStop", function(self)
            bar:StopMovingOrSizing()
            SaveBarPosition(bar)
        end)

        bar.slots[i] = slot
    end

    self:ApplyFont()
end

----------------------------------------------------
-- Rebuild All Slots
----------------------------------------------------
function SDT:RebuildAllSlots()
    for _, bar in pairs(self.bars) do
        self:RebuildSlots(bar)
    end
end

----------------------------------------------------
-- Slot Selection Dropdown
----------------------------------------------------
function SDT:ShowSlotDropdown(slot, bar)
    -- Create the context menu at the cursor
    MenuUtil.CreateContextMenu(slot, function(owner, root)
        -- Empty option
        root:CreateButton(self.L["(empty)"], function()
            self.db.profile.bars[bar:GetName()].slots[slot.index] = nil
            self:RebuildSlots(bar)
        end)

        -- Spacer option
        root:CreateButton(self.L["(spacer)"], function()
            self.db.profile.bars[bar:GetName()].slots[slot.index] = "(spacer)"
            self:RebuildSlots(bar)
        end)

        -- Module options
        for _, moduleName in ipairs(self.cache.moduleNames) do
            root:CreateButton(moduleName, function()
                self.db.profile.bars[bar:GetName()].slots[slot.index] = moduleName
                self:RebuildSlots(bar)
            end)
        end
    end)
end