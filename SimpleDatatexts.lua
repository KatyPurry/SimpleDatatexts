-- Simple DataTexts

----------------------------------------------------
-- Addon Locals
----------------------------------------------------
local addonName, SDT = ...

----------------------------------------------------
-- Library Instances
----------------------------------------------------
local LSM = LibStub("LibSharedMedia-3.0")

----------------------------------------------------
-- Defaults
----------------------------------------------------
local defaultsTable = {
    bars = {},
    settings = { 
        locked = false,
        useClassColor = false,
        useCustomColor = false,
        customColorHex = "#ffffff",
        use24HourClock = false,
        font = "Friz Quadrata TT",
        fontSize = 12,
        debug = false,
    },
    gold = {}
}
local function checkDefaultDBTable()
    if not _G.SDTDB.bars then _G.SDTDB.bars = {} end
    if not _G.SDTDB.settings then _G.SDTDB.settings = {} end
    if not _G.SDTDB.gold then _G.SDTDB.gold = {} end
    for k,v in pairs(defaultsTable.settings) do
        if _G.SDTDB.settings[k] == nil then _G.SDTDB.settings[k] = v end
    end
end
_G.SDTDB = _G.SDTDB or defaultsTable

SDT.modules = SDT.modules or {}
SDT.bars = SDT.bars or {}
SimpleDatatexts = SDT

----------------------------------------------------
-- Lua Locals
----------------------------------------------------
local format           = string.format
local print            = print
local strsplit         = strsplit
local stringlower      = string.lower
local tconcat          = table.concat
local tinsert          = table.insert
local tonumber         = tonumber
local tostring         = tostring
local tsort            = table.sort
local wipe             = table.wipe

-------------------------------------------------
-- Utility: Print function
-------------------------------------------------
function SDT.Print(...)
    print("[|cFFFF6600SDT|r]", ...)
end

----------------------------------------------------
-- Register Fonts
----------------------------------------------------
LSM:Register("font", "Action Man", [[Interface\AddOns\SimpleDatatexts\fonts\ActionMan.ttf]])
LSM:Register("font", "Continuum Medium", [[Interface\AddOns\SimpleDatatexts\fonts\ContinuumMedium.ttf]])
LSM:Register("font", "Die Die Die", [[Interface\AddOns\SimpleDatatexts\fonts\DieDieDie.ttf]])
LSM:Register("font", "Expressway", [[Interface\AddOns\SimpleDatatexts\fonts\Expressway.ttf]])
LSM:Register("font", "Homespun", [[Interface\AddOns\SimpleDatatexts\fonts\Homespun.ttf]])
LSM:Register("font", "Invisible", [[Interface\AddOns\SimpleDatatexts\fonts\Invisible.ttf]])
LSM:Register("font", "PT Sans Narrow", [[Interface\AddOns\SimpleDatatexts\fonts\PTSansNarrow.ttf]])
local fonts

----------------------------------------------------
-- WoW API Locals
----------------------------------------------------
local CreateFrame               = CreateFrame
local GetAddOnMetadata          = C_AddOns.GetAddOnMetadata
local GetClassColor             = C_ClassColor.GetClassColor
local IsControlKeyDown          = IsControlKeyDown
local IsShiftKeyDown            = IsShiftKeyDown
local ToggleDropDownMenu        = ToggleDropDownMenu
local UIDropDownMenu_AddButton  = UIDropDownMenu_AddButton
local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize
local UIDropDownMenu_SetText    = UIDropDownMenu_SetText
local UIParent                  = UIParent
local UnitClass                 = UnitClass
local UnitName                  = UnitName

-------------------------------------------------
-- Build Our Cache
-------------------------------------------------
SDT.cache = {}
SDT.cache.playerName = UnitName("player")
SDT.cache.playerClass = select(2, UnitClass("player"))
local colors = { GetClassColor(SDT.cache.playerClass):GetRGB() }
SDT.cache.colorR = colors[1]
SDT.cache.colorG = colors[2]
SDT.cache.colorB = colors[3]
--SDT.cache.colorRGB = format("|cff%02x%02x%02x", SDT.cache.colorR * 255, SDT.cache.colorG * 255, SDT.cache.colorB * 255)
SDT.cache.colorHex = GetClassColor(SDT.cache.playerClass):GenerateHexColor()
SDT.cache.version = GetAddOnMetadata(addonName, "Version") or "not defined"
SDT.cache.moduleNames = {}

-------------------------------------------------
-- Module Registration
-------------------------------------------------
function SDT:RegisterDataText(name, module)
    SDT.modules[name] = module
end

-------------------------------------------------
-- Utility: Get Tag Color
-------------------------------------------------
function SDT:GetTagColor()
    if SDTDB.settings.useCustomColor then
        local color = SDTDB.settings.customColorHex:gsub("#", "")
        return "ff"..color
    elseif SDTDB.settings.useClassColor then
        return SDT.cache.colorHex
    end
    return "ffffffff"
end

-------------------------------------------------
-- Utility: Color Text
-------------------------------------------------
function SDT:ColorText(text)
    local color = SDT:GetTagColor()
    return "|c"..color..text.."|r"
end

-------------------------------------------------
-- Utility: Apply Chosen Font
-------------------------------------------------
function SDT:ApplyFont()
    local fontPath = LSM:Fetch("font", SDTDB.settings.font) or STANDARD_TEXT_FONT
    local fontSize = SDTDB.settings.fontSize or 12

    for _, bar in pairs(SDT.bars) do
        for k, slot in pairs(bar.slots) do
            if slot.text then
                slot.text:SetFont(fontPath, fontSize, "")
            end
            if slot.moduleFrame and slot.moduleFrame.text and slot.moduleFrame.text.SetFont then
                slot.moduleFrame.text:SetFont(fontPath, fontSize, "")
            end
        end
    end
end

-------------------------------------------------
-- Utility: Format Percentage
-------------------------------------------------
function SDT:FormatPercent(v)
    return string.format("%.2f%%", v)
end

-------------------------------------------------
-- Utility: Format Percentage
-------------------------------------------------
function SDT:FindBestAnchorPoint(frame)
    local x, y = frame:GetCenter()
    local screenWidth = UIParent:GetRight()
    local screenHeight = UIParent:GetTop()

    local anchor, relPoint
    if not x or not y then
        return "ANCHOR_BOTTOM"
    else
        if y < screenHeight / 2 then
            return "ANCHOR_TOP"
        else
            return "ANCHOR_BOTTOM"
        end
    end
end

-------------------------------------------------
-- Utility: find next free bar ID
-------------------------------------------------
local function NextBarID()
    local n = 1
    while SDTDB.bars["SDT_Bar" .. n] do
        n = n + 1
    end
    return n
end

-------------------------------------------------
-- Movable Frame Helper
-------------------------------------------------
local function CreateMovableFrame(name)
    local f = CreateFrame("Frame", name, UIParent, "BackdropTemplate")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")

    f:SetScript("OnDragStart", function(self)
        if not SDTDB.settings.locked then
            self:StartMoving()
        end
    end)

    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
        if SDTDB.bars[self:GetName()] then
            SDTDB.bars[self:GetName()].point = { point = point, relativePoint = relativePoint, x = xOfs, y = yOfs }
        end
    end)

    return f
end

-------------------------------------------------
-- Create or Restore a Data Bar
-------------------------------------------------
function SDT:CreateDataBar(id, numSlots)
    local name = "SDT_Bar" .. id
    if not SDTDB.bars[name] then
        SDTDB.bars[name] = { numSlots = numSlots or 3, slots = {}, showBackground = true, showBorder = true, width = 300, height = 22, name = name }
    end
    local saved = SDTDB.bars[name]

    local bar = CreateMovableFrame(name)
    SDT.bars[name] = bar

    bar:SetSize(300, 22)
    if saved.point then
        bar:SetPoint(saved.point.point, UIParent, saved.point.relativePoint, saved.point.x, saved.point.y)
    else
        bar:SetPoint("CENTER")
    end

    local scale = saved.scale or 100
    bar:SetScale(scale / 100)

    function bar:ApplyBackground()
        if saved.showBackground then
            bar:SetBackdrop({ 
                bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                edgeFile = saved.showBorder and "Interface/Tooltips/UI-Tooltip-Border" or nil, 
                edgeSize = saved.showBorder and 8 or 0 
            })
            local alpha = (saved.bgOpacity or 50) / 100
            bar:SetBackdropColor(0,0,0,alpha)
        else
            bar:SetBackdrop(nil)
        end
    end

    bar:ApplyBackground()
    SDT:RebuildSlots(bar)
    return bar
end

-------------------------------------------------
-- Rebuild Slots (size/assignments)
-------------------------------------------------
function SDT:RebuildSlots(bar)
    if not bar then return end

    -- hide and clear existing slot frames
    for _, s in ipairs(bar.slots or {}) do
        s:SetParent(nil)
        s:Hide()
    end
    bar.slots = {}

    local saved = SDTDB.bars[bar:GetName()]
    if not saved then return end
    local numSlots = saved.numSlots or 3

    -- Horizontal layout
    local totalW = saved.width or 300
    local totalH = saved.height or 22
    local slotW = totalW / numSlots
    local slotH = totalH
    bar:SetSize(totalW, totalH)
    
    for i = 1, numSlots do
        local slotName = bar:GetName() .. "_Slot" .. i
        local slot = CreateFrame("Button", slotName, bar)
        slot:SetSize(slotW, slotH)
        slot.index = i
        slot:SetPoint("LEFT", bar, "LEFT", (i - 1) * slotW, 0)

        slot.text = slot.text or slot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slot.text:SetPoint("CENTER")
        slot.text:SetText("")

        local assignedName = saved.slots[i]
        if assignedName and SDT.modules[assignedName] then
            local mod = SDT.modules[assignedName]
            if slot.moduleFrame and slot.moduleFrame.Hide then slot.moduleFrame:Hide() end
            slot.module = assignedName
            slot.moduleFrame = mod.Create(slot)
        else
            slot.module = nil
            if slot.moduleFrame and slot.moduleFrame.Hide then slot.moduleFrame:Hide() end
            slot.text:SetText(assignedName or "(empty)")
        end

        slot:EnableMouse(true)
        slot:RegisterForClicks("AnyUp")
        slot:SetScript("OnMouseUp", function(self, btn)
            if btn == "RightButton" and not IsShiftKeyDown() and not IsControlKeyDown() then
                SDT:ShowSlotDropdown(self, bar)
            end
        end)

        -- Forward drag events to parent bar
        slot:RegisterForDrag("LeftButton")
        slot:SetScript("OnDragStart", function(self)
            if not SDTDB.settings.locked then
                bar:StartMoving()
            end
        end)
        slot:SetScript("OnDragStop", function(self)
            bar:StopMovingOrSizing()
            local point, relativeTo, relativePoint, xOfs, yOfs = bar:GetPoint()
            if SDTDB.bars[bar:GetName()] then
                SDTDB.bars[bar:GetName()].point = { point = point, relativePoint = relativePoint, x = xOfs, y = yOfs }
            end
        end)

        bar.slots[i] = slot
    end

    SDT:ApplyFont()
end

-------------------------------------------------
-- Rebuild Slots on All Bars
-------------------------------------------------
function SDT:RebuildAllSlots()
    for _, bar in pairs(SDTDB.bars) do
        SDT.Print("Rebuilding slots for bar " .. bar.name)
        SDT:RebuildSlots(bar)
    end
end

-------------------------------------------------
-- Update All Modules
-------------------------------------------------
function SDT:UpdateAllModules()
    for _, bar in pairs(SDT.bars) do
        for _, slot in pairs(bar.slots) do
            if slot.moduleFrame and slot.moduleFrame.Update then
                slot.moduleFrame.Update()
            end
        end
    end
end

-------------------------------------------------
-- Slot Selection Dropdown
-------------------------------------------------
local dropdownFrame = CreateFrame("Frame", addonName .. "_SlotDropdown", UIParent, "UIDropDownMenuTemplate")
function SDT:ShowSlotDropdown(slot, bar)
    local function InitializeDropdown()
        local info = UIDropDownMenu_CreateInfo()
        info.notCheckable = true

        for _, moduleName in ipairs(SDT.cache.moduleNames) do
            info.text = moduleName
            info.func = function()
                SDTDB.bars[bar:GetName()].slots[slot.index] = moduleName
                SDT:RebuildSlots(bar)
            end
            UIDropDownMenu_AddButton(info)
        end
    end

	UIDropDownMenu_Initialize(dropdownFrame, InitializeDropdown)
    ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 0, 0)
end

-------------------------------------------------
-- Settings Panel UI
-------------------------------------------------
local panel = CreateFrame("Frame", addonName .. "_Settings", UIParent)
panel.name = "Simple DataTexts"

local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText(panel.name)

local version = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
version:SetPoint("LEFT", title, "RIGHT", 6, -1)
version:SetText("v" .. SDT.cache.version)

local function MakeLabel(parent, text, point, x, y)
    local t = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    t:SetPoint(point, x, y)
    t:SetText(text)
    return t
end

local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
category.ID = panel.name
Settings.RegisterAddOnCategory(category)

-------------------------------------------------
-- Left Column Controls
-------------------------------------------------
-- Lock Panels
local lockCheckbox = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
lockCheckbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)
lockCheckbox.Text:SetText("Lock Panels (disable movement)")
lockCheckbox:SetChecked(SDTDB.settings.locked)
lockCheckbox:SetScript("OnClick", function(self)
    SDTDB.settings.locked = self:GetChecked()
end)

-- Use Class Color
local classColorCheckbox = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
classColorCheckbox:SetPoint("TOPLEFT", lockCheckbox, "BOTTOMLEFT", 0, -20)
classColorCheckbox.Text:SetText("Use Class Color")
classColorCheckbox:SetChecked(SDTDB.settings.useClassColor)

local use24HourClockCheckbox = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
use24HourClockCheckbox:SetPoint("LEFT", classColorCheckbox, "RIGHT", 100, 0)
use24HourClockCheckbox.Text:SetText("Use 24Hr Clock")
use24HourClockCheckbox:SetChecked(SDTDB.settings.use24HourClock)
use24HourClockCheckbox:SetScript("OnClick", function(self)
    SDTDB.settings.use24HourClock = self:GetChecked()
    SDT:UpdateAllModules()
end)

local customColorCheckbox = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
customColorCheckbox:SetPoint("TOPLEFT", classColorCheckbox, "BOTTOMLEFT", 0, -20)
customColorCheckbox.Text:SetText("Use Custom Color")
customColorCheckbox:SetChecked(SDTDB.settings.useCustomColor)

classColorCheckbox:SetScript("OnClick", function(self)
    SDTDB.settings.useClassColor = self:GetChecked()
    if self:GetChecked() then
        SDTDB.settings.useCustomColor = false
        customColorCheckbox:SetChecked(false)
    end
    SDT:UpdateAllModules()
end)
customColorCheckbox:SetScript("OnClick", function(self)
    SDTDB.settings.useCustomColor = self:GetChecked()
    if self:GetChecked() then
        SDTDB.settings.useClassColor = false
        classColorCheckbox:SetChecked(false)
    end
    SDT:UpdateAllModules()
end)

local colorPickerButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
colorPickerButton:SetPoint("LEFT", customColorCheckbox, "RIGHT", 120, 0)
colorPickerButton:SetSize(80, 24)
colorPickerButton:SetScript("OnShow", function(self)
    self:SetText(SDTDB.settings.customColorHex)
end)

local function showColorPicker()
    ColorPickerFrame:Hide()
    
    local initColor = SDTDB.settings.customColorHex:gsub("#", "")
    local initR = tonumber(initColor:sub(1, 2), 16) / 255
    local initG = tonumber(initColor:sub(3, 4), 16) / 255
    local initB = tonumber(initColor:sub(5, 6), 16) / 255

    local function onColorPicked()
        local r, g, b = ColorPickerFrame:GetColorRGB()
        SDTDB.settings.customColorHex = format("#%02X%02X%02X", r*255, g*255, b*255)
        SDT:UpdateAllModules()
        colorPickerButton:SetText(SDTDB.settings.customColorHex)
    end

    local function onCancel()
        SDTDB.settings.customColorHex = format("#%02X%02X%02X", initR*255, initG*255, initB*255)
        SDT:UpdateAllModules()
        colorPickerButton:SetText(SDTDB.settings.customColorHex)
    end

    local previousValues = { initR, initG, initB }

    local options = {
        swatchFunc = onColorPicked,
        cancelFunc = onCancel,
        hasOpacity = false,
        opacity = 1,
        r = initR,
        g = initG,
        b = initB,
    }
    
    ColorPickerFrame:SetupColorPickerAndShow(options)
end

colorPickerButton:SetScript("OnClick", function()
    showColorPicker()
end)

local fontLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
fontLabel:SetPoint("TOPLEFT", customColorCheckbox, "BOTTOMLEFT", 0, -20)
fontLabel:SetText("Display Font:")

local fontDropdown = CreateFrame("Frame", addonName .. "_FontDropdown", panel, "UIDropDownMenuTemplate")
fontDropdown:SetPoint("TOPLEFT", fontLabel, "BOTTOMLEFT", -20, -4)
UIDropDownMenu_SetWidth(fontDropdown, 160)

local fontSizeSlider = CreateFrame("Slider", addonName.."_FontSizeSlider", panel, "OptionsSliderTemplate")
fontSizeSlider:SetPoint("TOPLEFT", fontDropdown, "BOTTOMLEFT", 20, -20)
fontSizeSlider:SetMinMaxValues(4, 40)
fontSizeSlider:SetValueStep(1)
fontSizeSlider:SetWidth(160)
getglobal(fontSizeSlider:GetName().."Text"):SetText("Font Size")
getglobal(fontSizeSlider:GetName().."Low"):SetText(tostring(4))
getglobal(fontSizeSlider:GetName().."High"):SetText(tostring(40))
fontSizeSlider:SetScript("OnShow", function(self)
    self:SetValue(SDTDB.settings.fontSize)
end)

local fontSizeBox = CreateFrame("EditBox", addonName.."_FontSizeEditBox", panel, "InputBoxTemplate")
fontSizeBox:SetSize(50, 20)
fontSizeBox:SetPoint("LEFT", fontSizeSlider, "RIGHT", 25, 0)
fontSizeBox:SetAutoFocus(false)
fontSizeBox:SetJustifyH("CENTER")
fontSizeBox:SetJustifyV("MIDDLE")
fontSizeBox:SetScript("OnShow", function(self)
    self:SetText(SDTDB.settings.fontSize)
end)

-- Sync slider -> editbox
fontSizeSlider:SetScript("OnValueChanged", function(self, value)
    local val = math.floor(value + 0.5)
    fontSizeBox:SetText(val)
    SDTDB.settings.fontSize = val
    SDT:ApplyFont()
end)
    
    -- Sync editbox -> slider
fontSizeBox:SetScript("OnEnterPressed", function(self)
    local val = tonumber(self:GetText())
    if val then
        val = math.max(4, math.min(40, val))
        fontSizeSlider:SetValue(val)
        self:SetText(val)
    else
        self:SetText(math.floor(fontSizeSlider:GetValue()+0.5))
    end
    SDT:ApplyFont()
end)

-- Add Panel
local addBarButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
addBarButton:SetPoint("TOPLEFT", fontSizeSlider, "BOTTOMLEFT", 0, -30)
addBarButton:SetSize(140, 24)
addBarButton:SetText("Create New Panel")

-- Panel Selector
local panelLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
panelLabel:SetPoint("TOPLEFT", addBarButton, "BOTTOMLEFT", 0, -16)
panelLabel:SetText("Select Panel:")
local panelDropdown = CreateFrame("Frame", addonName .. "_PanelDropdown", panel, "UIDropDownMenuTemplate")
panelDropdown:SetPoint("TOPLEFT", panelLabel, "BOTTOMLEFT", -20, -6)
UIDropDownMenu_SetWidth(panelDropdown, 160)

-- Rename Panel
local renameLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
renameLabel:SetPoint("TOPLEFT", panelDropdown, "BOTTOMLEFT", 20, -16)
renameLabel:SetText("Rename Panel:")
renameLabel:Hide()
local nameEditBox = CreateFrame("EditBox", addonName .. "_PanelNameEditBox", panel, "InputBoxTemplate")
nameEditBox:SetSize(170, 20)
nameEditBox:SetPoint("TOPLEFT", renameLabel, "BOTTOMLEFT", 4, -6)
nameEditBox:SetAutoFocus(false)
nameEditBox:SetJustifyH("CENTER")
nameEditBox:SetJustifyV("MIDDLE")
nameEditBox:SetText("")
nameEditBox:Hide()

nameEditBox:SetScript("OnEnterPressed", function(self)
    local newName = self:GetText():trim()
    if newName ~= "" and panel.selectedBar then
        SDTDB.bars[panel.selectedBar].name = newName
        UIDropDownMenu_Initialize(panelDropdown, PanelDropdown_Initialize)
        UIDropDownMenu_SetText(panelDropdown, newName)
    end
end)

-------------------------------------------------
-- Right Column Controls (per-panel)
-------------------------------------------------
local removeBarButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
removeBarButton:SetSize(160, 24)
removeBarButton:SetPoint("LEFT", lockCheckbox, "RIGHT", 280, 0)
removeBarButton:SetText("Remove Selected Panel")
removeBarButton:Hide()

local bgCheckbox = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
bgCheckbox:SetPoint("TOPLEFT", removeBarButton, "BOTTOMLEFT", 0, -12)
bgCheckbox.Text:SetText("Show Background")
bgCheckbox:Hide()

local borderCheckbox = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
borderCheckbox:SetPoint("LEFT", bgCheckbox, "RIGHT", 100, 0)
borderCheckbox.Text:SetText("Show Border")
borderCheckbox:Hide()

local slotSelectors = {}
local function buildSlotSelectors(barName)
    for _, f in ipairs(slotSelectors) do f:Hide() end
    slotSelectors = {}

    local b = SDTDB.bars[barName]
    if not b then return end

    for i = 1, b.numSlots do
        local lbl = MakeLabel(panel, "Slot " .. i .. ":", "TOPLEFT", 320, -290 - ((i - 1) * 50))
        local dd = CreateFrame("Frame", addonName .. "_SlotSel_" .. i, panel, "UIDropDownMenuTemplate")
        dd:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", -20, -6)
        UIDropDownMenu_SetWidth(dd, 140)

        UIDropDownMenu_Initialize(dd, function(self, level)
            local info = UIDropDownMenu_CreateInfo()
            info.text = "(empty)"
            info.func = function()
                SDTDB.bars[barName].slots[i] = nil
                UIDropDownMenu_SetText(dd, "(empty)")
                if SDT.bars[barName] then SDT:RebuildSlots(SDT.bars[barName]) end
            end
            UIDropDownMenu_AddButton(info)

            for _, name in ipairs(SDT.cache.moduleNames) do
                local moduleName = name
                info.text = moduleName
                info.func = function()
                    SDTDB.bars[barName].slots[i] = name
                    UIDropDownMenu_SetText(dd, name)
                    if SDT.bars[barName] then SDT:RebuildSlots(SDT.bars[barName]) end
                end
                UIDropDownMenu_AddButton(info)
            end
        end)

        UIDropDownMenu_SetText(dd, b.slots[i] or "(empty)")
        table.insert(slotSelectors, lbl)
        table.insert(slotSelectors, dd)
    end
end

-------------------------------------------------
-- Custom Slider with EditBox
-------------------------------------------------
local function CreateSliderWithBox(parent, name, text, min, max, step, attach, x, y)
    -- Slider
    local slider = CreateFrame("Slider", addonName.."_"..name.."Slider", parent, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", attach, "BOTTOMLEFT", x, y)
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step)
    slider:SetWidth(160)
    getglobal(slider:GetName().."Text"):SetText(text)
    getglobal(slider:GetName().."Low"):SetText(tostring(min))
    getglobal(slider:GetName().."High"):SetText(tostring(max))
    slider:Hide()
    
    -- Edit Box
    local eb = CreateFrame("EditBox", addonName.."_"..name.."EditBox", parent, "InputBoxTemplate")
    eb:SetSize(50, 20)
    eb:SetPoint("LEFT", slider, "RIGHT", 25, 0)
    eb:SetAutoFocus(false)
    eb:SetJustifyH("CENTER")
    eb:SetJustifyV("MIDDLE")
    eb:SetText(min)
    eb:Hide()
    
    -- Sync slider -> editbox
    slider:SetScript("OnValueChanged", function(self, value)
        local val = math.floor(value + 0.5)
        eb:SetText(val)
        if panel.selectedBar then
            local barData = SDTDB.bars[panel.selectedBar]
            if name == "Slots" then
                barData.numSlots = val
            elseif name == "Width" then
                barData.width = val
            elseif name == "Height" then
                barData.height = val
            elseif name == "Scale" then
                barData.scale = val
                if SDT.bars[panel.selectedBar] then
                    SDT.bars[panel.selectedBar]:SetScale(val / 100)
                end
            elseif name == "Background Opacity" then
                barData.bgOpacity = val
                if SDT.bars[panel.selectedBar] then
                    SDT.bars[panel.selectedBar]:ApplyBackground()
                end
            end
            if SDT.bars[panel.selectedBar] then
                SDT:RebuildSlots(SDT.bars[panel.selectedBar])
            end
            if name == "Slots" then
                buildSlotSelectors(panel.selectedBar)
            end
        end
    end)
    
    -- Sync editbox -> slider
    eb:SetScript("OnEnterPressed", function(self)
        local val = tonumber(self:GetText())
        if val then
            val = math.max(min, math.min(max, val))
            slider:SetValue(val)
            self:SetText(val)
            if name == "Scale" and SDT.bars[panel.selectedBar] then
                SDT.bars[panel.selectedBar]:SetScale(val / 100)
            elseif name == "Background Opacity" and SDT.bars[panel.selectedBar] then
                SDT.bars[panel.selectedBar]:ApplyBackground()
            end
        else
            -- reset to slider value if invalid
            self:SetText(math.floor(slider:GetValue()+0.5))
        end
    end)
    
    return slider, eb
end

local opacitySlider, opacityBox = CreateSliderWithBox(panel, "Background Opacity", "Background Opacity", 0, 100, 1, bgCheckbox, 0, -20)
local slotSlider, slotBox = CreateSliderWithBox(panel, "Slots", "Slots", 1, 5, 1, opacitySlider, 0, -20)
local widthSlider, widthBox = CreateSliderWithBox(panel, "Width", "Width", 100, 800, 1, slotSlider, 0, -20)
local heightSlider, heightBox = CreateSliderWithBox(panel, "Height", "Height", 16, 128, 1, widthSlider, 0, -20)
local scaleSlider, scaleBox = CreateSliderWithBox(panel, "Scale", "Scale", 50, 500, 1, nameEditBox, 3, -30)

-- Panel dropdown initializer
local function PanelDropdown_Initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()
    for barName, _ in pairs(SDTDB.bars) do
        local displayName = SDTDB.bars[barName].name or barName
        info.text = displayName
        info.func = function()
            UIDropDownMenu_SetText(panelDropdown, displayName)
            panel.selectedBar = barName
            updateSelectedBarControls()
        end
        UIDropDownMenu_AddButton(info)
    end
end

-- Font dropdown initializer
local function FontDropdown_Initialize(self, level)
    for _, fontName in ipairs(fonts) do
        local info = UIDropDownMenu_CreateInfo()
        info.notCheckable = true
        info.text = fontName
        info.value = fontName
        info.func = function()
            SDTDB.settings.font = fontName
            UIDropDownMenu_SetSelectedValue(fontDropdown, fontName)
            UIDropDownMenu_SetText(fontDropdown, fontName)
            SDT:ApplyFont()
        end
        UIDropDownMenu_AddButton(info)
    end
end

-- Update per-panel controls
function updateSelectedBarControls()
    local barName = panel.selectedBar
    if not barName then
        removeBarButton:Hide()
        bgCheckbox:Hide()
        borderCheckbox:Hide()
        opacitySlider:Hide()
        opacityBox:Hide()
        slotSlider:Hide()
        slotBox:Hide()
        widthSlider:Hide()
        widthBox:Hide()
        heightSlider:Hide()
        heightBox:Hide()
        renameLabel:Hide()
        nameEditBox:Hide()
        scaleSlider:Hide()
        scaleBox:Hide()
        for _, f in ipairs(slotSelectors) do f:Hide() end
        return
    end

    removeBarButton:Show()
    bgCheckbox:Show()
    borderCheckbox:Show()
    opacitySlider:Show()
    opacityBox:Show()
    slotSlider:Show()
    slotBox:Show()
    widthSlider:Show()
    widthBox:Show()
    heightSlider:Show()
    heightBox:Show()
    renameLabel:Show()
    nameEditBox:SetText(SDTDB.bars[barName].name or barName)
    nameEditBox:Show()
    scaleSlider:Show()
    scaleBox:Show()

    local b = SDTDB.bars[barName]
    if not b then return end

    -- Background / Border
    bgCheckbox:SetChecked(b.showBackground)
    bgCheckbox:SetScript("OnClick", function(self)
        b.showBackground = self:GetChecked()
        if SDT.bars[barName] then SDT.bars[barName]:ApplyBackground() end
    end)
    borderCheckbox:SetChecked(b.showBorder)
    borderCheckbox:SetScript("OnClick", function(self)
        b.showBorder = self:GetChecked()
        if SDT.bars[barName] then SDT.bars[barName]:ApplyBackground() end
    end)

    -- Slots
    local numSlots = b.numSlots or 3
    slotSlider:SetValue(numSlots)
    slotBox:SetText(numSlots)

    -- Width
    local width = b.width or 300
    widthSlider:SetValue(width)
    widthBox:SetText(width)

    -- Height
    local height = b.height or 22
    heightSlider:SetValue(height)
    heightBox:SetText(height)

    -- Scale
    local scale = b.scale or 100
    scaleSlider:SetValue(scale)
    scaleBox:SetText(scale)

    -- Opacity
    local opacity = b.bgOpacity or 50
    opacitySlider:SetValue(opacity)
    opacityBox:SetText(opacity)

    -- Rebuild slots & selectors
    if SDT.bars[barName] then SDT:RebuildSlots(SDT.bars[barName]) end
    buildSlotSelectors(barName)
end

-- Add Panel button click
addBarButton:SetScript("OnClick", function()
    local id = NextBarID()
    local name = "SDT_Bar" .. id
    SDTDB.bars[name] = { numSlots = 3, slots = {}, showBackground = true, showBorder = true, width = 300, height = 22 }
    SDT:CreateDataBar(id, 3)
    UIDropDownMenu_Initialize(panelDropdown, PanelDropdown_Initialize)
    UIDropDownMenu_SetText(panelDropdown, name)
    panel.selectedBar = name
    updateSelectedBarControls()
end)

-- Remove selected panel
removeBarButton:SetScript("OnClick", function()
    local barName = panel.selectedBar
    if not barName then return end

    StaticPopup_Show("SDT_CONFIRM_DELETE_BAR", nil, nil, barName)
end)

-- Confirmation Pop-up
StaticPopupDialogs["SDT_CONFIRM_DELETE_BAR"] = {
    text = "Are you sure you want to delete this bar?\nThis action cannot be undone.",
    button1 = "Yes",
    button2 = "No",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3, -- avoids taint issues (3–4 are safest)
    OnAccept = function(self, barName)
        -- Perform the delete
        if SDT.bars[barName] then
            SDT.bars[barName]:Hide()
            SDT.bars[barName] = nil
        end
        SDTDB.bars[barName] = nil

        -- Clear UI state
        panel.selectedBar = nil
        UIDropDownMenu_SetText(panelDropdown, "(none)")
        UIDropDownMenu_Initialize(panelDropdown, PanelDropdown_Initialize)

        for _, f in ipairs(slotSelectors) do f:Hide() end
        slotSelectors = {}

        removeBarButton:Hide()
        bgCheckbox:Hide()
        borderCheckbox:Hide()
        opacitySlider:Hide()
        opacityBox:Hide()
        slotSlider:Hide()
        slotBox:Hide()
        widthSlider:Hide()
        widthBox:Hide()
        heightSlider:Hide()
        heightBox:Hide()
        renameLabel:Hide()
        nameEditBox:Hide()
        scaleSlider:Hide()
        scaleBox:Hide()
    end,
}

-------------------------------------------------
-- Create Module List
-------------------------------------------------
local function CreateModuleList()
    wipe(SDT.cache.moduleNames)
    for name in pairs(SDT.modules) do
        tinsert(SDT.cache.moduleNames, name)
    end
    tsort(SDT.cache.moduleNames)
end

-------------------------------------------------
-- Loader to restore bars on addon load
-------------------------------------------------
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, arg)
    if arg == addonName then
        checkDefaultDBTable()

        CreateModuleList()      

        -- If no bars exist, create our first bar
        if not next(SDTDB.bars) then
            SDTDB.bars["SDT_Bar1"] = { numSlots = 3, slots = {}, showBackground = true, showBorder = true }
        end

        -- Create our bars
        for barName, data in pairs(SDTDB.bars) do
            local id = tonumber(barName:match("SDT_Bar(%d+)") or "0")
            if id > 0 and not SDT.bars[barName] then
                SDT:CreateDataBar(id, data.numSlots)
            end
        end

        -- Create and verify our fonts
        fonts = LSM:List("font")
        tsort(fonts)
        local currentFont = SDTDB.settings.font
        local found = false
        for _, f in ipairs(fonts) do
            if f == currentFont then
                found = true
                break
            end
        end
        if not found then
            SDT.Print("Saved font not found. Resetting font to Friz Quadrata TT.")
            currentFont = "Friz Quadrata TT"
            SDTDB.settings.font = currentFont
        end

        -- Sync settings after the addon is fully loaded
        UIDropDownMenu_Initialize(panelDropdown, PanelDropdown_Initialize)
        UIDropDownMenu_Initialize(fontDropdown, FontDropdown_Initialize)
        UIDropDownMenu_SetSelectedValue(fontDropdown, currentFont)
        UIDropDownMenu_SetText(fontDropdown, currentFont)
        lockCheckbox:SetChecked(SDTDB.settings.locked)
        classColorCheckbox:SetChecked(SDTDB.settings.useClassColor)
        customColorCheckbox:SetChecked(SDTDB.settings.useCustomColor)
    end
end)

local function SlashHelp()
    SDT.Print("|cffffff00--[Options]--|r")
    SDT.Print("Lock/Unlock: |cff8888ff/sdt lock|r")
    SDT.Print("Width: |cff8888ff/sdt width <barName> <newWidth>|r")
    SDT.Print("Height: |cff8888ff/sdt height <barName> <newHeight>|r")
    SDT.Print("Scale: |cff8888ff/sdt scale <barName> <newScale>|r")
    SDT.Print("Settings: |cff8888ff/sdt config|r")
    SDT.Print("Version: |cff8888ff/sdt version|r")
end

local function BarAdjustments(adj, bar, num)
    -- Make sure we have all of our values
    if not adj or not bar or not num then
        SDT.Print("Usage: /sdt " .. adj .. " <barName> <value>")
        SlashHelp()
        return
    end

    -- Check custom name if supplied instead of the bar key
    if not SDTDB.bars[bar] then
        local resolved = nil
        for barItem, settings in pairs(SDTDB.bars) do
            if stringlower(settings.name) == stringlower(bar) then
                resolved = barItem
                break
            end
        end
        if not resolved then
            SDT.Print("Invalid panel name supplied. Valid panel names are:")
            for j,k in pairs(SDTDB.bars) do
                SDT.Print("- ", tostring(j), "("..tostring(k.name)..")")
            end
            return
        end
        bar = resolved
    end

    -- Validate the number supplied
    if type(num) ~= "number" then
        SDT.Print("A valid numeric value for the adjustment must be specified.")
        SlashHelp()
        return
    end

    -- Further validate the value is within parameters, then make the adjustment
    if adj == "width" then
        if num >= 100 and num <= 800 then
            SDTDB.bars[bar].width = num
            widthSlider:SetValue(num)
            widthBox:SetText(num)
            SDT:RebuildSlots(SDT.bars[bar])
        else
            SDT.Print("Invalid panel width specified.")
        end
    elseif adj == "height" then
        if num >= 16 and num <= 128 then
            SDTDB.bars[bar].height = num
            heightSlider:SetValue(num)
            heightBox:SetText(num)
            SDT:RebuildSlots(SDT.bars[bar])
        else
            SDT.Print("Invalid panel height specified.")
        end
    elseif adj == "scale" then
        if num >= 50 and num <= 500 then
            SDTDB.bars[bar].scale = num
            scaleSlider:SetValue(num)
            scaleBox:SetText(num)
            SDT.bars[bar]:SetScale(num / 100)
        else
            SDT.Print("Invalid panel scale specified.")
        end
    else
        SDT.Print("Invalid adjustment type specified.")
    end
end

-- Slash command
SLASH_SDT1 = "/sdt"
SlashCmdList["SDT"] = function(msg)
    local args = {}
    for word in msg:gmatch("%S+") do
        tinsert(args, word)
    end
    local command = args[1] and stringlower(args[1]) or ""
    local bar, num
    if #args > 2 then
        num = tonumber(args[#args])
        bar = tconcat(args, " ", 2, #args - 1)
    end
    if command == "config" then
        Settings.OpenToCategory(panel.name)
    elseif command == "lock" then
        SDTDB.settings.locked = not SDTDB.settings.locked
        lockCheckbox:SetChecked(SDTDB.settings.locked)
        SDT.Print("SDT panels are now: ", SDTDB.settings.locked and "|cffff0000LOCKED|r" or "|cff00ff00UNLOCKED|r")
    elseif command == "width" or command == "height" or command == "scale" then
        BarAdjustments(command, bar, num)
    elseif command == "update" then
        SDT:UpdateAllModules()
    elseif command == "version" then
        SDT.Print("Simple Datatexts Version: |cff8888ff" ..tostring(SDT.cache.version) .. "|r")
    else
        SlashHelp()
    end
end
