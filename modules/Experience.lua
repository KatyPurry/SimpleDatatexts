-- modules/Experience.lua
-- Experience datatext for Simple DataTexts (SDT)
local SDT = SimpleDatatexts
local SDTC = SDT.cache
local L = SDT.L

local mod = {}

----------------------------------------------------
-- Library Instances
----------------------------------------------------
local LSM = LibStub("LibSharedMedia-3.0")

----------------------------------------------------
-- Lua Locals
----------------------------------------------------
local CreateFrame = CreateFrame
local format      = string.format

----------------------------------------------------
-- WoW API Locals
----------------------------------------------------
local UnitXP          = UnitXP
local UnitXPMax       = UnitXPMax
local UnitLevel       = UnitLevel
local GetBuildInfo    = GetBuildInfo

----------------------------------------------------
-- Helper Function: Format Large Numbers
----------------------------------------------------
local function FormatValue(value)
    if value >= 1000000 then
        return format("%.2fM", value / 1000000)
    elseif value >= 1000 then
        return format("%.2fK", value / 1000)
    else
        return tostring(value)
    end
end

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

    -- Bar frame for graphical display
    local barFrame
    local barBg
    local barFill
    local barDividers
    local barText

    local function CreateBarDisplay()
        if barFrame then return end

        barFrame = CreateFrame("Frame", nil, slotFrame)
        barFrame:SetAllPoints(slotFrame)
        barFrame:EnableMouse(false)

        -- Background
        barBg = barFrame:CreateTexture(nil, "BACKGROUND")
        barBg:SetColorTexture(0, 0, 0, 0.5)

        -- Fill
        barFill = barFrame:CreateTexture(nil, "ARTWORK")
        barFill:SetColorTexture(1, 1, 1, 0.8)
    
        -- Text overlay
        barText = barFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        barText:SetPoint("CENTER", barFrame, "CENTER")
        barText:SetShadowColor(0, 0, 0, 1)
        barText:SetShadowOffset(1, -1)

        -- Text font size
        local fontSize = SDT.SDTDB_CharDB.settings.expTextFontSize or 12
        barText:SetFont(barText:GetFont(), fontSize, "OUTLINE")

        -- Dividers (every 10%)
        barDividers = {}
        for i = 1, 9 do  -- 9 dividers for 10%, 20%, 30%, etc.
            local divider = barFrame:CreateTexture(nil, "OVERLAY")
            divider:SetWidth(1)
            divider:SetColorTexture(0.3, 0.3, 0.3, 0.8)
            table.insert(barDividers, divider)
        end

        -- Hide by default
        barFrame:Hide()
    end

    local function UpdateBarHeight()
        if not barFill then return end
    
        local heightPercent = SDT.SDTDB_CharDB.settings.expBarHeightPercent or 100
        local slotHeight = slotFrame:GetHeight()
        local barHeight = (slotHeight * heightPercent) / 100
        local slotWidth = slotFrame:GetWidth()
    
        -- Position background - centered
        barBg:SetHeight(barHeight)
        barBg:SetWidth(slotWidth)
        barBg:SetPoint("CENTER", barFrame, "CENTER", 0, 0)
        
        -- Position fill - anchor to left center
        barFill:SetHeight(barHeight)
        barFill:SetWidth(1)  -- Will be set by UpdateExperience
        barFill:SetPoint("LEFT", barFrame, "LEFT", 0, 0)
    end

    local function UpdateBarDividers()
        if not barDividers then return end
    
        local heightPercent = SDT.SDTDB_CharDB.settings.expBarHeightPercent or 100
        local slotHeight = slotFrame:GetHeight()
        local barHeight = (slotHeight * heightPercent) / 100
    
        local slotWidth = slotFrame:GetWidth()
        for i, divider in ipairs(barDividers) do
            local xPos = (slotWidth * (i / 10))
            divider:SetPoint("CENTER", barFrame, "CENTER", xPos - slotWidth / 2, 0)
            divider:SetHeight(barHeight)
        end
    end

    local function GetBarColor()
        if SDT.SDTDB_CharDB.settings.expBarUseClassColor then
            return SDTC.colorR, SDTC.colorG, SDTC.colorB, 1
        else
            local color = SDT.SDTDB_CharDB.settings.expBarColor:gsub("#", "")
            local r = tonumber(color:sub(1, 2), 16) / 255
            local g = tonumber(color:sub(3, 4), 16) / 255
            local b = tonumber(color:sub(5, 6), 16) / 255
            return r, g, b, 1
        end
    end

    local function GetColoredText(textString)
        if SDT.SDTDB_CharDB.settings.expTextUseClassColor then
            return SDT:ColorText(textString)
        else
            return format("|cff%s%s|r", SDT.SDTDB_CharDB.settings.expTextColor:gsub("#", ""), textString)
        end
    end

    local currentXP = 0
    local maxXP = 0
    local xpPercent = 0

    local function UpdateExperience()
        -- Check if player is max level
        local _, _, _, TOC = GetBuildInfo()
        local isMaxLevel = TOC < 120001 and SDTC.playerLevel >= 80 or SDTC.playerLevel >= 90
        
        if isMaxLevel then
            text:SetText(SDT:ColorText(L["Max Level"]))
            if barFrame then barFrame:Hide() end
            return
        end

        currentXP = UnitXP("player")
        maxXP = UnitXPMax("player")

        if maxXP <= 0 then
            text:SetText(SDT:ColorText(L["N/A"]))
            if barFrame then barFrame:Hide() end
            return
        end

        xpPercent = (currentXP / maxXP) * 100
        local xpRemaining = maxXP - currentXP

        local textString = ""
        local format_mode = SDT.SDTDB_CharDB.settings.expFormat or 1

        local showingBar = SDT.SDTDB_CharDB.settings.expShowGraphicalBar

        -- Format mode 1: XP / XPMax
        if format_mode == 1 then
            textString = format("%s / %s", 
                FormatValue(currentXP), 
                FormatValue(maxXP))

        -- Format mode 2: XP / XPMax (Percent %)
        elseif format_mode == 2 then
            textString = format("%s / %s (%.1f%%)", 
                FormatValue(currentXP), 
                FormatValue(maxXP),
                xpPercent)

        -- Format mode 3: XP / XPMax (Percent %) (Remaining)
        elseif format_mode == 3 then
            textString = format("%s / %s (%.1f%%) (%s)", 
                FormatValue(currentXP), 
                FormatValue(maxXP),
                xpPercent,
                FormatValue(xpRemaining))
        end

        if showingBar and barFrame then
            barFrame:Show()
        elseif barFrame then
            barFrame:Hide()
        end

        -- If bar should be shown, render it
        if not barFrame then CreateBarDisplay(); barFrame:Show() end
        if showingBar and barFrame:IsShown() then
            -- Update bar height based on setting
            UpdateBarHeight()
            UpdateBarDividers()

            -- Update bar fill width
            local slotWidth = slotFrame:GetWidth()
            local fillWidth = (slotWidth) * (currentXP / maxXP)
            barFill:SetWidth(fillWidth)

            -- Apply color
            local r, g, b, a = GetBarColor()
            barFill:SetColorTexture(r, g, b, 0.8)
            
            -- Update font size from settings
            local fontPath = LSM:Fetch("font", SDT.SDTDB_CharDB.settings.font) or STANDARD_TEXT_FONT
            local fontSize = SDT.SDTDB_CharDB.settings.expTextFontSize or 12
            barText:SetFont(fontPath, fontSize, "")
        elseif barFrame then
            barFrame:Hide()
        end

        local textOutput = showingBar and GetColoredText(textString) or SDT:ColorText(textString)
        if showingBar then
            text:SetText("")
            barText:SetText(textOutput)
        else
            barText:SetText("")
            text:SetText(textOutput)
        end

        -- Hide Blizzard XP bar
        if SDT.SDTDB_CharDB.settings.expHideBlizzardBar then
            StatusTrackingBarManager:UnregisterAllEvents()
		    StatusTrackingBarManager:Hide()
            SDT.BlizzardXPBarHidden = true
        else
            if SDT.BlizzardXPBarHidden then
                StatusTrackingBarManager:Show()
                StatusTrackingBarManager:OnLoad()
                SDT.BlizzardXPBarHidden = false
            end
        end
    end

    f.Update = UpdateExperience
    SDT.ExperienceModuleUpdate = UpdateExperience

    -- Event Handlers
    local function OnEvent(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD"
        or event == "PLAYER_XP_UPDATE"
        or event == "PLAYER_LEVEL_UP" then
            if event == "PLAYER_LEVEL_UP" then
                SDTC.playerLevel = UnitLevel("player")
            end
            UpdateExperience()
        end
    end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("PLAYER_XP_UPDATE")
    f:RegisterEvent("PLAYER_LEVEL_UP")

    -- Tooltip
    slotFrame:SetScript("OnEnter", function(self)
        local _, _, _, TOC = GetBuildInfo()
        local isMaxLevel = TOC < 120000 and SDTC.playerLevel >= 80 or SDTC.playerLevel >= 90
        
        if isMaxLevel then return end

        local anchor = SDT:FindBestAnchorPoint(self)
        GameTooltip:SetOwner(self, anchor)
        GameTooltip:ClearLines()

        local level = UnitLevel("player")
        GameTooltip:AddLine(L["Experience"], 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(format(L["Level %d"], SDTC.playerLevel), 1, 1, 1)
        GameTooltip:AddDoubleLine(
            "Progress:",
            format("%s / %s", 
                FormatValue(currentXP), 
                FormatValue(maxXP)),
            1, 0.82, 0, 1, 1, 1
        )
        GameTooltip:AddDoubleLine(
            "Remaining:",
            FormatValue(maxXP - currentXP),
            1, 0.82, 0, 1, 1, 1
        )
        GameTooltip:AddDoubleLine(
            "Percentage:",
            format("%.2f%%", xpPercent),
            1, 0.82, 0, 1, 1, 1
        )
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(L["Configure in settings"], 0.7, 0.7, 0.7)

        GameTooltip:Show()
    end)

    slotFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    UpdateExperience()

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
SDT:RegisterDataText("Experience", mod)

return mod