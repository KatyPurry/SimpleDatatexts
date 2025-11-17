-- modules/Guild.lua
-- Guild list datatext adapted Ara_Broker_Guild_Friends for Simple DataTexts (SDT)
local addonName, addon = ...
local SDTC = addon.cache

local mod = {}

----------------------------------------------------
-- Module Creation
----------------------------------------------------
function mod.Create(slotFrame)
    local f = CreateFrame("Frame", nil, slotFrame)
    f:SetAllPoints(slotFrame)

    local text = slotFrame.text
    if not text then
        text = slotFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("CENTER")
        slotFrame.text = text
    end

    ----------------------------------------------------
    -- Update logic
    ----------------------------------------------------
    local function UpdateGuild()
        local guildName = GetGuildInfo("player")
        if guildName then
            local numGuild = GetNumGuildMembers()
            text:SetFormattedText("|cff%sGuild:|r %d", addon:GetTagColor(), numGuild)
        else
            text:SetFormattedText("|cff%sGuild:|r None", addon:GetTagColor())
        end
    end

    ----------------------------------------------------
    -- Event Handler
    ----------------------------------------------------
    local function OnEvent(self, event, ...)
        if event == "GUILD_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
            UpdateGuild()
        end
    end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("GUILD_ROSTER_UPDATE")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")

    ----------------------------------------------------
    -- Tooltip
    ----------------------------------------------------
    slotFrame:EnableMouse(true)
    slotFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:ClearLines()

        local guildName, guildRankName = GetGuildInfo("player")
        if guildName then
            GameTooltip:AddLine("Guild: " .. guildName .. " (" .. guildRankName .. ")")
            GameTooltip:AddLine(" ")

            local numGuild = GetNumGuildMembers()
            for i = 1, numGuild do
                local name, rank, rankIndex, level, class, zone, note, officernote, connected = GetGuildRosterInfo(i)
                local status = connected and "|cff00ff00Online|r" or "|cffff0000Offline|r"
                GameTooltip:AddDoubleLine(name, status)
            end
        else
            GameTooltip:AddLine("You are not in a guild")
        end

        GameTooltip:Show()
    end)

    slotFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)

    ----------------------------------------------------
    -- Click to open guild frame
    ----------------------------------------------------
    slotFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    slotFrame:SetScript("OnClick", function(self)
        ToggleGuildFrame()
    end)

    -- Request guild roster for initial update
    GuildRoster()
    UpdateGuild()

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
addon:RegisterDataText("Guild", mod)

return mod
