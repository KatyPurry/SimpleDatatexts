-- modules/LDBObjects.lua
-- Datatexts for LDB objects not already handled by other modules
local SDT = SimpleDatatexts
local SDTC = SDT.cache
local LDB = LibStub("LibDataBroker-1.1")

----------------------------------------------------
-- Lua Locals
----------------------------------------------------
local CreateFrame = CreateFrame
local format      = string.format
local tinsert     = table.insert
local tsort       = table.sort

----------------------------------------------------
-- Module wrapper for SDT
----------------------------------------------------
local function HandleLDBObject(name, obj)
    local cleanName = name:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    local cleanObjText = obj.text and obj.text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")

    -- Skip objects already handled by other modules or those that are known to be "blank".
    if cleanName == "Ara Friends" -- Handled by Friends module
      or cleanName == "Ara Guild"  -- Handled by Guild module
      or cleanName == "CraftSimLDB" -- Only opens the CraftSim config settings
      or cleanName == "ALL THE THINGS" -- Appears to do nothing
      then
        return
    end

    SDT.Print("LDB Object:", cleanName)

    local mod = {}

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
        -- Update function
        ----------------------------------------------------
        local function Update()
            local txt = ""
            if cleanName == "BugSack" then
                txt = cleanName .. ": " .. cleanObjText
            elseif cleanName == "WIM" then
                txt = cleanName
                if cleanObjText then
                    txt = txt .. ": " .. cleanObjText
                end
            else
                txt = cleanObjText or cleanName or "NO TEXT"
            end
            text:SetText(SDT:ColorText(txt))
        end
        f.Update = Update

        ----------------------------------------------------
        -- Tooltip from LDB object
        ----------------------------------------------------
        slotFrame:EnableMouse(true)
        slotFrame:SetScript("OnEnter", function(self)
            if obj.OnTooltipShow then
                local anchor = SDT:FindBestAnchorPoint(self)
                GameTooltip:SetOwner(self, anchor)
                GameTooltip:ClearLines()
                obj.OnTooltipShow(GameTooltip)
                GameTooltip:Show()
            elseif obj.OnEnter then
                obj.OnEnter(self)
            end
        end)
        slotFrame:SetScript("OnLeave", function(self)
            if obj.OnLeave then obj.OnLeave(self) end
            GameTooltip:Hide()
        end)

        ----------------------------------------------------
        -- Click from LDB object
        ----------------------------------------------------
        slotFrame:RegisterForClicks("AnyUp")
        slotFrame:SetScript("OnClick", function(self, button)
            if obj.OnClick then obj.OnClick(self, button) end
        end)

        Update()

        return f
    end

    ----------------------------------------------------
    -- Register with SDT
    ----------------------------------------------------
    SDT:RegisterDataText(cleanName, mod)

    --return mod
end

for name, obj in LDB:DataObjectIterator() do
    HandleLDBObject(name, obj)
end

LDB:RegisterCallback("LibDataBroker_DataObjectCreated",
    function(_, name, obj)
        local cleanName = name:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        -- Skip objects already handled by other modules or those that are known to be "blank".
        if cleanName == "Ara Friends" -- Handled by Friends module
          or cleanName == "Ara Guild"  -- Handled by Guild module
          or cleanName == "CraftSimLDB" -- Only opens the CraftSim config settings
          or cleanName == "ALL THE THINGS" -- Appears to do nothing
        then
            return
        end
        HandleLDBObject(name, obj)
        tinsert(SDT.cache.moduleNames, name)
        tsort(SDT.cache.moduleNames)
        SDT:UpdateAllModules()
        SDT:RebuildAllSlots()
    end
)