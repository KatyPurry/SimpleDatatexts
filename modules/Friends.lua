-- modules/Friends.lua
-- Friends list datatext adapted Ara_Broker_Guild_Friends for Simple DataTexts (SDT)
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
    local function UpdateFriends()
        local numFriends = C_FriendList.GetNumFriends() or 0
        text:SetFormattedText("|cff%sFriends:|r %d", addon:GetTagColor(), numFriends)
    end

    ----------------------------------------------------
    -- Event Handler
    ----------------------------------------------------
    local function OnEvent(self, event, ...)
        if event == "FRIENDLIST_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
            UpdateFriends()
        end
    end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("FRIENDLIST_UPDATE")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")

    ----------------------------------------------------
    -- Tooltip
    ----------------------------------------------------
    slotFrame:EnableMouse(true)
    slotFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine("Friends")
        GameTooltip:AddLine(" ")

        local numFriends = C_FriendList.GetNumFriends() or 0
        for i = 1, numFriends do
            local info = C_FriendList.GetFriendInfoByIndex(i)
            if info then
                local name = info.fullName or info.name
                local status = info.connected and "|cff00ff00Online|r" or "|cffff0000Offline|r"
                GameTooltip:AddDoubleLine(name, status)
            end
        end
        GameTooltip:Show()
    end)

    slotFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)

    ----------------------------------------------------
    -- Click to open friends frame
    ----------------------------------------------------
    slotFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    slotFrame:SetScript("OnClick", function(self)
        ToggleFriendsFrame(1)
    end)

    -- initial update
    UpdateFriends()

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
addon:RegisterDataText("Friends", mod)

return mod
