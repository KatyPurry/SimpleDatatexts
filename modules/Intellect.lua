-- modules/Intellect.lua
-- Intellect datatext adapted from ElvUI for Simple DataTexts (SDT)
local SDT = SimpleDatatexts
local L = SDT.L

local mod = {}

----------------------------------------------------
-- Lua Locals
----------------------------------------------------
local CreateFrame = CreateFrame

----------------------------------------------------
-- WoW API Locals
----------------------------------------------------
local UnitStat = UnitStat

----------------------------------------------------
-- Constants Locals
----------------------------------------------------
local ITEM_MOD_INTELLECT_SHORT = ITEM_MOD_INTELLECT_SHORT
local LE_UNIT_STAT_INTELLECT = LE_UNIT_STAT_INTELLECT

----------------------------------------------------
-- File Locals
----------------------------------------------------
local moduleName = "Intellect"

----------------------------------------------------
-- Module Config Settings
----------------------------------------------------
local function SetupModuleConfig()
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Show Label"], "showLabel", true)
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Show Short Label"], "showShortLabel", false)

    -- Text Settings
    SDT:AddModuleConfigSeparator(moduleName, L["Text Color"])
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Override Text Color"], "overrideTextColor", false)
    SDT:AddModuleConfigSetting(moduleName, "color", L["Text Custom Color"], "customTextColor", "#FFFFFF")

    -- Font Settings
    SDT:AddModuleConfigSeparator(moduleName, L["Font Settings"])
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Override Global Font"], "overrideFont", false)
    SDT:AddModuleConfigSetting(moduleName, "font", L["Display Font:"], "font", "Friz Quadrata TT")
    SDT:AddModuleConfigSetting(moduleName, "fontSize", L["Font Size"], "fontSize", 12, 4, 40, 1)
    SDT:AddModuleConfigSetting(moduleName, "fontOutline", L["Font Outline"], "fontOutline", "NONE", {
        ["NONE"] = L["None"],
        ["OUTLINE"] = "Outline",
        ["THICKOUTLINE"] = "Thick Outline",
        ["MONOCHROME"] = "Monochrome",
        ["OUTLINE, MONOCHROME"] = "Outline + Monochrome",
        ["THICKOUTLINE, MONOCHROME"] = "Thick Outline + Monochrome",
    })
end

SetupModuleConfig()

----------------------------------------------------
-- Module Creation
----------------------------------------------------
function mod.Create(slotFrame)
    local f = CreateFrame("Frame", nil, slotFrame)
    f:SetAllPoints(slotFrame)
    f:EnableMouse(false)

    local text = slotFrame.text
    if not text then
        text = slotFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("CENTER")
        slotFrame.text = text
    end

    local currentInt = 0

    ----------------------------------------------------
    -- Update logic
    ----------------------------------------------------
    local function UpdateIntellect()
        currentInt = UnitStat("player", LE_UNIT_STAT_INTELLECT)
        local showLabel = SDT:GetModuleSetting(moduleName, "showLabel", true)
        local showShortLabel = SDT:GetModuleSetting(moduleName, "showShortLabel", false)
        local textString = (showLabel and (showShortLabel and L["Int"] or ITEM_MOD_INTELLECT_SHORT) .. ": " or "") .. currentInt
        text:SetText(SDT:ColorModuleText(moduleName, textString))
        SDT:ApplyModuleFont(moduleName, text)
    end
    f.Update = UpdateIntellect

    ----------------------------------------------------
    -- Event Handler
    ----------------------------------------------------
    local function OnEvent(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD"
        or event == "UNIT_AURA"
        or event == "UNIT_STATS" then
            UpdateIntellect()
        end
    end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("UNIT_AURA")
    f:RegisterEvent("UNIT_STATS")

    UpdateIntellect()

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
SDT:RegisterDataText(moduleName, mod)

return mod
