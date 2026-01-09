-- modules/Experience.lua
-- Experience datatext for Simple DataTexts (SDT)
local SDT = SimpleDatatexts
local SDTC = SDT.cache
local L = SDT.L

local mod = {}

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
        barBg:SetAllPoints(barFrame)
        barBg:SetColorTexture(0, 0, 0, 0.5)

        -- Fill
        barFill = barFrame:CreateTexture(nil, "ARTWORK")
        barFill:SetPoint("LEFT", barFrame, "LEFT", 2, 0)
        barFill:SetHeight(barFrame:GetHeight() - 4)

        -- Text overlay
        barText = barFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        barText:SetPoint("CENTER", barFrame, "CENTER")
        barText:SetShadowColor(0, 0, 0, 1)
        barText:SetShadowOffset(1, -1)

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

    local function UpdateBarDividers()
        if not barDividers then return end
        local slotWidth = slotFrame:GetWidth() - 4
        for i, divider in ipairs(barDividers) do
            local xPos = (slotWidth * (i / 10))
            divider:SetPoint("LEFT", barFrame, "LEFT", 2 + xPos, 0)
            divider:SetHeight(barFrame:GetHeight() - 4)
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
        local isMaxLevel = TOC < 120000 and SDTC.playerLevel >= 80 or SDTC.playerLevel >= 90
        
        if isMaxLevel then
            text:SetText(SDT:ColorText(L["Max Level"]))
            if barFrame then barFrame:Hide() end
            return
        end

        currentXP = UnitXP("player")
        maxXP = UnitXPMax("player")

        if maxXP <= 0 then
            text:SetText(SDT:ColorText("N/A"))
            if barFrame then barFrame:Hide() end
            return
        end

        xpPercent = (currentXP / maxXP) * 100
        local xpRemaining = maxXP - currentXP

        local textString = ""
        local format_mode = SDT.SDTDB_CharDB.settings.expFormat or 1

        -- Format mode 1: XP / XPMax
        if format_mode == 1 then
            textString = format("%s / %s", 
                FormatValue(currentXP), 
                FormatValue(maxXP))
            text:SetText(SDT:ColorText(textString))
            if barFrame then barFrame:Hide() end

        -- Format mode 2: XP / XPMax (Percent %)
        elseif format_mode == 2 then
            textString = format("%s / %s (%.1f%%)", 
                FormatValue(currentXP), 
                FormatValue(maxXP),
                xpPercent)
            text:SetText(SDT:ColorText(textString))
            if barFrame then barFrame:Hide() end

        -- Format mode 3: XP / XPMax (Percent %) (Remaining)
        elseif format_mode == 3 then
            textString = format("%s / %s (%.1f%%) (%s)", 
                FormatValue(currentXP), 
                FormatValue(maxXP),
                xpPercent,
                FormatValue(xpRemaining))
            text:SetText(SDT:ColorText(textString))
            if barFrame then barFrame:Hide() end

        -- Format mode 4: Graphical bar with text overlay
        elseif format_mode == 4 then
            if not barFrame then CreateBarDisplay() end
            barFrame:Show()
            text:SetText("")

            -- Update bar fill width
            local slotWidth = slotFrame:GetWidth()
            local fillWidth = (slotWidth - 4) * (currentXP / maxXP)
            barFill:SetWidth(fillWidth)

            -- Apply color
            local r, g, b, a = GetBarColor()
            if type(r) == "string" then
                -- It's a hex color string from GetTagColor
                barFill:SetColorTexture(0.2, 0.6, 1, 0.8)
            else
                barFill:SetColorTexture(r, g, b, 0.8)
            end

            -- Update divider positions
            UpdateBarDividers()

            -- Bar text
            textString = format("%s / %s (%.1f%%)", 
                FormatValue(currentXP), 
                FormatValue(maxXP),
                xpPercent)
            barText:SetText(GetColoredText(textString))
        end
    end

    f.Update = UpdateExperience

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
        GameTooltip:AddLine(format("Level %d Experience", level), 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine(
            "Progress:",
            format("%s / %s (%.2f%%)", 
                FormatValue(currentXP), 
                FormatValue(maxXP),
                xpPercent),
            1, 0.82, 0, 1, 1, 1
        )
        GameTooltip:AddDoubleLine(
            "Remaining:",
            FormatValue(maxXP - currentXP),
            1, 0.82, 0, 1, 1, 1
        )
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Configure in settings", 0.7, 0.7, 0.7)

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