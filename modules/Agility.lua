-- modules/Agility.lua
-- Agility datatext adapted from ElvUI for Simple DataTexts (SDT)
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
local ITEM_MOD_AGILITY_SHORT = ITEM_MOD_AGILITY_SHORT
local LE_UNIT_STAT_AGILITY = LE_UNIT_STAT_AGILITY

----------------------------------------------------
-- File Locals
----------------------------------------------------
local moduleName = "Agility"

----------------------------------------------------
-- Module Config Settings
----------------------------------------------------
local function SetupModuleConfig()
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Show Label"], "showLabel", true)
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Show Short Label"], "showShortLabel", false)

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

    local currentAgi = 0

    ----------------------------------------------------
    -- Update logic
    ----------------------------------------------------
    local function UpdateAgility()
        currentAgi = UnitStat("player", LE_UNIT_STAT_AGILITY)
        local showLabel = SDT:GetModuleSetting(moduleName, "showLabel", true)
        local showShortLabel = SDT:GetModuleSetting(moduleName, "showShortLabel", false)
        local textString = (showLabel and (showShortLabel and L["Agi"] or ITEM_MOD_AGILITY_SHORT)..": " or "")..currentAgi
        text:SetText(SDT:ColorText(textString))
        SDT:ApplyModuleFont(moduleName, text)
    end
    f.Update = UpdateAgility

    ----------------------------------------------------
    -- Event Handler
    ----------------------------------------------------
    local function OnEvent(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD"
        or event == "UNIT_AURA"
        or event == "UNIT_STATS" then
            UpdateAgility()
        end
    end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("UNIT_AURA")
    f:RegisterEvent("UNIT_STATS")

    UpdateAgility()

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
SDT:RegisterDataText(moduleName, mod)

return mod
