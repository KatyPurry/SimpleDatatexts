-- modules/Gold.lua
-- Gold & Currency datatext adapted from ElvUI for Simple DataTexts (SDT)
local SDT = SimpleDatatexts
local SDTC = SDT.cache
local L = SDT.L

local mod = {}

----------------------------------------------------
-- lua locals
----------------------------------------------------
local format  = string.format
local tinsert = table.insert
local sort    = table.sort

----------------------------------------------------
-- WoW API locals
----------------------------------------------------
local C_Bank_FetchDepositedMoney             = C_Bank and C_Bank.FetchDepositedMoney
local C_CurrencyInfo_GetBackpackCurrencyInfo = C_CurrencyInfo and C_CurrencyInfo.GetBackpackCurrencyInfo
local C_Timer_NewTicker                      = C_Timer and C_Timer.NewTicker
local C_WowTokenPublic_GetCurrentMarketPrice = C_WowTokenPublic.GetCurrentMarketPrice
local C_WowTokenPublic_UpdateMarketPrice     = C_WowTokenPublic.UpdateMarketPrice
local BreakUpLargeNumbers                    = BreakUpLargeNumbers
local GetBuildInfo                           = GetBuildInfo
local GetMoney                               = GetMoney
local GetRealmName                           = GetRealmName
local IsLoggedIn                             = IsLoggedIn
local IsShiftKeyDown                         = IsShiftKeyDown
local IsControlKeyDown                       = IsControlKeyDown
local UnitName                               = UnitName
local WARBANDBANK_TYPE                       = (Enum.BankType and Enum.BankType.Account) or 2

----------------------------------------------------
-- State
----------------------------------------------------
SDTDB.gold = SDTDB.gold or {}
local Profit, Spent = 0, 0
local Ticker = nil
local myGold = {}
local totalGold, totalHorde, totalAlliance, warbandGold = 0, 0, 0, 0
local iconStringName = '|T%s:16:16:0:0:64:64:4:60:4:60|t %s'
local GOLD_ICON = "|TInterface\\AddOns\\SimpleDatatexts\\textures\\Coins:10:10:0:0:64:32:22:42:1:20|t"
local SILVER_ICON = "|TInterface\\AddOns\\SimpleDatatexts\\textures\\Coins:10:10:0:0:64:32:43:64:1:20|t"
local COPPER_ICON = "|TInterface\\AddOns\\SimpleDatatexts\\textures\\Coins:10:10:0:0:64:32:0:21:1:20|t"

----------------------------------------------------
-- Module Config Settings
----------------------------------------------------
local function SetupModuleConfig()
    SDT:AddModuleConfigSetting("Gold", "checkbox", L["Show Silver"], "showSilver", true)
    SDT:AddModuleConfigSetting("Gold", "checkbox", L["Show Copper"], "showCopper", true)
    SDT:AddModuleConfigSetting("Gold", "checkbox", L["Use Coin Icons"], "useCoinIcons", true)
end

SetupModuleConfig()

----------------------------------------------------
-- Helpers
----------------------------------------------------
local function SortFunction(a,b) return (a.amount or 0) > (b.amount or 0) end

local function UpdateMarketPrice()
    return C_WowTokenPublic_UpdateMarketPrice()
end

local function InitTicker()
    if not Ticker then
        UpdateMarketPrice()
        Ticker = C_Timer_NewTicker(60, UpdateMarketPrice)
    end
end

local function UpdateTotal(faction, change)
    if faction == 'Alliance' then
        totalAlliance = totalAlliance + change
    elseif faction == 'Horde' then
        totalHorde = totalHorde + change
    end
    totalGold = totalGold + change
end

local function UpdateWarbandGold()
    warbandGold = C_Bank_FetchDepositedMoney and C_Bank_FetchDepositedMoney(WARBANDBANK_TYPE) or 0
end

local function DisplayCurrencyInfo(tooltip)
    local index = 1
    local info = C_CurrencyInfo_GetBackpackCurrencyInfo(index)
    local _, _, _, toc = GetBuildInfo()
    while info and info.name do
        if index == 1 then GameTooltip:AddLine(" ") end
        if (info.name ~= "Valorstones" or toc < 120001) and info.quantity then
            GameTooltip:AddDoubleLine(format(iconStringName, info.iconFileID, info.name), BreakUpLargeNumbers(info.quantity), 1,1,1, 1,1,1)
        end
        index = index + 1
        info, name = C_CurrencyInfo_GetBackpackCurrencyInfo(index)
    end
end

local function FormatMoney(copper, classColor)
    local showCopper = SDT:GetModuleSetting("Gold", "showCopper", true)
    local showSilver = SDT:GetModuleSetting("Gold", "showSilver", true)
    local useCoinIcons = SDT:GetModuleSetting("Gold", "useCoinIcons", true)
    local g = BreakUpLargeNumbers(floor(copper / 10000))
    local s = floor((copper % 10000) / 100)
    local c = copper % 100
    if classColor then
        local goldPart = SDT:ColorText(g) .. (useCoinIcons and GOLD_ICON or SDT:ColorText("g"))
        local silverPart = SDT:ColorText(s) .. (useCoinIcons and SILVER_ICON or SDT:ColorText("s"))
        local copperPart = SDT:ColorText(c) .. (useCoinIcons and COPPER_ICON or SDT:ColorText("c"))
        local retString = goldPart
        if showSilver then
            retString = retString .. " " .. silverPart
        end
        if showCopper then
            retString = retString .. " " .. copperPart
        end
        return retString
    else
        local retString = "|cffffd700" .. g .. "|r" .. (useCoinIcons and GOLD_ICON or "|cffffd700g|r")
        if showSilver then
            retString = retString .. " |cffc7c7c7" .. s .. "|r" .. (useCoinIcons and SILVER_ICON or "|cffc7c7c7s|r")
        end
        if showCopper then
            retString = retString .. " |cffeda55f" .. c .. "|r" .. (useCoinIcons and COPPER_ICON or "|cffeda55fc|r")
        end
        return retString
    end
end

local function RebuildGoldCache()
    wipe(myGold)
    totalGold, totalHorde, totalAlliance = 0, 0, 0
    for realm, chars in pairs(SDTDB.gold) do
        for name, charValues in pairs(chars) do
            tinsert(myGold, {
                name = name,
                realm = realm,
                amount = charValues.amount,
                amountText = FormatMoney(charValues.amount),
                faction = charValues.faction,
                r = 1, g = 1, b = 1,
            })
            UpdateTotal(charValues.faction, charValues.amount)
        end
    end
end

----------------------------------------------------
-- Update logic
----------------------------------------------------
local function UpdateGold(self)
    if not IsLoggedIn() then return end

    local playerName = SDT.cache.playerName
    local realmName = SDT.cache.playerRealmProper
    local faction = SDT.cache.playerFaction
    SDTDB.gold[realmName] = SDTDB.gold[realmName] or {}
    SDTDB.gold[realmName][playerName] = SDTDB.gold[realmName][playerName] or {}
    SDTDB.gold[realmName][playerName].faction = faction

    local oldMoney = SDTDB.gold[realmName][playerName].amount
    local newMoney = GetMoney()
    SDTDB.gold[realmName][playerName].amount = newMoney

    local change = (oldMoney and (newMoney - oldMoney)) or 0
    if change ~= 0 then
        if change > 0 then
            Profit = Profit + change
        else
            Spent = Spent - change
        end

        -- Update faction and overall totals
        UpdateTotal(faction, change)

        -- Update cache with new gold amount
        for _, g in ipairs(myGold) do
            if g.name == playerName and g.realm == realmName then
                g.amount = newMoney
                g.amountText = FormatMoney(newMoney)
                break
            end
        end
    end

    -- Update displayed text
    if self.text then
        self.text:SetText(FormatMoney(newMoney, true))
    end
end

----------------------------------------------------
-- Tooltip
----------------------------------------------------
local function ShowTooltip(self)
    local tooltip = GameTooltip
    local anchor = SDT:FindBestAnchorPoint(self)
    tooltip:SetOwner(self, anchor)
    tooltip:ClearLines()
    tooltip:AddLine(L["GOLD"])
    tooltip:AddLine(" ")

    -- Session info
    tooltip:AddLine(L["Session:"])
    tooltip:AddDoubleLine(L["Earned:"], FormatMoney(Profit), 1,1,1,1,1,1)
    tooltip:AddDoubleLine(L["Spent:"], FormatMoney(Spent), 1,1,1,1,1,1)
    if Spent ~= 0 then
        local gained = Profit > Spent
        tooltip:AddDoubleLine(gained and L["Profit:"] or L["Deficit:"],
            FormatMoney(Profit-Spent),
            gained and 0 or 1, gained and 1 or 0, 0, 1,1,1)
    end

    tooltip:AddLine(" ")
    tooltip:AddLine(L["Character:"])
    sort(myGold, SortFunction)
    local total, limit = #myGold, nil
    local useLimit = limit and limit > 0
    for _, g in ipairs(myGold) do
        local toonName = g.name .. (g.realm and g.realm ~= _G.GetRealmName() and ' - '..g.realm or '')
        if g.faction and g.faction ~= 'Neutral' and g.faction ~= '' then
            toonName = format('|TInterface\\FriendsFrame\\PlusManz-%s:14|t ', g.faction) .. toonName
        end
        tooltip:AddDoubleLine((g.name == _G.UnitName("player") and toonName..' |TInterface\\COMMON\\Indicator-Green:14|t' or toonName),
            g.amountText, g.r, g.g, g.b, 1,1,1)
    end

    tooltip:AddLine(" ")
    tooltip:AddLine(L["Server:"])
    if totalAlliance > 0 then tooltip:AddDoubleLine(L["Alliance:"], FormatMoney(totalAlliance), 0, .376,1,1,1,1) end
    if totalHorde > 0 then tooltip:AddDoubleLine(L["Horde:"], FormatMoney(totalHorde), 1, .2, .2, 1,1,1) end
    tooltip:AddLine(" ")
    tooltip:AddDoubleLine(L["Total:"], FormatMoney(totalGold), 1,1,1,1,1,1)
    tooltip:AddDoubleLine(L["Warband:"], FormatMoney(warbandGold), 1,1,1,1,1,1)
    if C_WowTokenPublic_GetCurrentMarketPrice then
        tooltip:AddLine(" ")
        tooltip:AddDoubleLine(L["WoW Token:"], FormatMoney(C_WowTokenPublic_GetCurrentMarketPrice() or 0), 0,.8,1,1,1,1)
    end
    DisplayCurrencyInfo()

    tooltip:AddLine(" ")
    tooltip:AddLine("|cffaaaaaa" .. L["Reset Session Data: Hold Ctrl + Right Click"] .. "|r")
    tooltip:Show()
end

----------------------------------------------------
-- Module Creation
----------------------------------------------------
function mod.Create(slotFrame)
    local f = CreateFrame("Frame", nil, slotFrame)
    f:SetAllPoints(slotFrame)
    f:EnableMouse(false)

    local text = slotFrame.text or slotFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    text:SetPoint("CENTER")
    slotFrame.text = text

    -- Build myGold cache
    if not next(myGold) then
        RebuildGoldCache()
    end

    InitTicker()

    ----------------------------------------------------
    -- Event Handler
    ----------------------------------------------------
    local function OnEvent(_, event)
        UpdateWarbandGold()
        UpdateGold(slotFrame)
    end
    f.Update = function() OnEvent(f) end

    f:SetScript("OnEvent", OnEvent)
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("PLAYER_MONEY")
    f:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
    f:RegisterEvent("SEND_MAIL_COD_CHANGED")
    f:RegisterEvent("PLAYER_TRADE_MONEY")
    f:RegisterEvent("TRADE_MONEY_CHANGED")
    f:RegisterEvent("CURRENCY_DISPLAY_UPDATE")

    ----------------------------------------------------
    -- Tooltip Handler
    ----------------------------------------------------
    slotFrame:EnableMouse(true)
    slotFrame:SetScript("OnEnter", ShowTooltip)
    slotFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)

    ----------------------------------------------------
    -- Click Handler
    ----------------------------------------------------
    slotFrame:SetScript("OnClick", function(self, button)
        if button == "RightButton" then
            if IsShiftKeyDown() then
                -- Show menu for deleting characters
            elseif IsControlKeyDown() then
                Profit, Spent = 0,0
            end
        else
            _G.ToggleAllBags()
        end
    end)

    UpdateGold(slotFrame)

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
SDT:RegisterDataText("Gold", mod)

return mod
