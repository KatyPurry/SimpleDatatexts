-- Core.lua - Main addon initialization
local addonName, SDT = ...

-- Create the addon object using Ace3
for k, v in pairs(LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")) do
    SDT[k] = v
end
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
    self.cache.version = GetAddOnMetadata(addonName, "Version") or "not defined"
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
    
    -- Register config (handled in Config.lua)
    self:RegisterConfig()
    
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
        self:Print(format("%s: |cff8888ff%s|r", self.L["Simple Datatexts Version"], self.cache.version))
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