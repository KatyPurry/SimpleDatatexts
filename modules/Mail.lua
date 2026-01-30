-- modules/Mail.lua
-- Mail datatext adapted from ElvUI for Simple DataTexts (SDT)
local SDT = SimpleDatatexts
local L = SDT.L

local mod = {}

----------------------------------------------------
-- WoW API locals
----------------------------------------------------
local HasNewMail = HasNewMail
local GetLatestThreeSenders = GetLatestThreeSenders
local HAVE_MAIL_FROM = HAVE_MAIL_FROM
local MAIL_LABEL = MAIL_LABEL

----------------------------------------------------
-- File locals
----------------------------------------------------
local moduleName = "Mail"

----------------------------------------------------
-- Module Config Settings
----------------------------------------------------
local function SetupModuleConfig()
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

    ----------------------------------------------------
    -- Event Handler
    ----------------------------------------------------
    local function OnEvent(self, event, ...)
        local mailText = HasNewMail() and L["New Mail"] or L["No Mail"]
        text:SetText(SDT:ColorModuleText(moduleName, mailText))
        SDT:ApplyModuleFont(moduleName, text)
    end

    f.Update = function() OnEvent(f) end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("MAIL_INBOX_UPDATE")
    f:RegisterEvent("UPDATE_PENDING_MAIL")
    f:RegisterEvent("MAIL_CLOSED")
    f:RegisterEvent("MAIL_SHOW")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")

    ----------------------------------------------------
    -- Tooltip
    ----------------------------------------------------
    slotFrame:EnableMouse(true)
    slotFrame:SetScript("OnEnter", function(self)
        local anchor = SDT:FindBestAnchorPoint(self)
        GameTooltip:SetOwner(self, anchor)
        GameTooltip:ClearLines()

        local senders = { GetLatestThreeSenders() }
        if next(senders) then
            local header = HasNewMail() and HAVE_MAIL_FROM or MAIL_LABEL
            SDT:AddTooltipHeader(GameTooltip, 14, header)
            SDT:AddTooltipLine(GameTooltip, 12, " ")

            for _, sender in pairs(senders) do
                SDT:AddTooltipLine(GameTooltip, 12, sender)
            end

            GameTooltip:Show()
        end
    end)

    slotFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    OnEvent(f)

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
SDT:RegisterDataText(moduleName, mod)

return mod
