-- modules/Dodge.lua
-- Dodge datatext adapted from ElvUI for Simple DataTexts (SDT)
local SDT = SimpleDatatexts
local L = SDT.L

local mod = {}

----------------------------------------------------
-- Lua Locals
----------------------------------------------------
local format = string.format

----------------------------------------------------
-- WoW API Locals
----------------------------------------------------
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local GetCombatRating = GetCombatRating
local GetCombatRatingBonus = GetCombatRatingBonus
local GetDodgeChance = GetDodgeChance

----------------------------------------------------
-- Constants Locals
----------------------------------------------------
local CR_DODGE = CR_DODGE or 3
local CR_DODGE_TOOLTIP = CR_DODGE_TOOLTIP
local STAT_DODGE = STAT_DODGE

----------------------------------------------------
-- File Locals
----------------------------------------------------
local moduleName = "Dodge"

----------------------------------------------------
-- Module Config Settings
----------------------------------------------------
local function SetupModuleConfig()
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Show Label"], "showLabel", true)
    SDT:AddModuleConfigSetting(moduleName, "checkbox", L["Hide Decimals"], "hideDecimals", false)

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

    local dodgeChance = 0
    local dodgeRating = 0
    local dodgeBonus = 0

    ----------------------------------------------------
    -- Update logic
    ----------------------------------------------------
    local function UpdateDodge()
        dodgeChance = GetDodgeChance()
        dodgeRating = GetCombatRating(CR_DODGE)
        dodgeBonus = GetCombatRatingBonus(CR_DODGE)
        
        local showLabel = SDT:GetModuleSetting(moduleName, "showLabel", true)
        local hideDecimals = SDT:GetModuleSetting(moduleName, "hideDecimals", false)
        local textString = (showLabel and STAT_DODGE..": " or "") .. SDT:FormatPercent(dodgeChance, hideDecimals)
        text:SetText(SDT:ColorModuleText(moduleName, textString))
        SDT:ApplyModuleFont(moduleName, text)
    end

    f.Update = UpdateDodge

    ----------------------------------------------------
    -- Event Handler
    ----------------------------------------------------
    local function OnEvent(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD"
        or event == "UNIT_STATS"
        or event == "PLAYER_EQUIPMENT_CHANGED"
        or event == "UNIT_AURA" then
            UpdateDodge()
        end
    end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("UNIT_STATS")
    f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    f:RegisterEvent("UNIT_AURA")

    ----------------------------------------------------
    -- Tooltip
    ----------------------------------------------------
    slotFrame:EnableMouse(true)
    slotFrame:SetScript("OnEnter", function(self)
        local anchor = SDT:FindBestAnchorPoint(self)
        GameTooltip:SetOwner(self, anchor)
        GameTooltip:ClearLines()

        local text = format('%s: |cffFFFFFF%.2f%%|r', STAT_DODGE, dodgeChance)
        local tooltip = format(CR_DODGE_TOOLTIP, dodgeRating, dodgeBonus)

        SDT:AddTooltipHeader(GameTooltip, 14, text)
        SDT:AddTooltipLine(GameTooltip, 12, " ")
        SDT:AddTooltipLine(GameTooltip, 12, tooltip, nil, nil, nil, nil, nil, nil, nil, true)

        GameTooltip:Show()
    end)

    slotFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    UpdateDodge()
    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
SDT:RegisterDataText(moduleName, mod)

return mod