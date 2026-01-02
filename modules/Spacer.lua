-- modules/Spacer.lua
-- An empty datatext to allow for spacing between other datatexts
local SDT = SimpleDatatexts
local SDTC = SDT.cache

local mod = {}

----------------------------------------------------
-- Lua Locals
----------------------------------------------------
local CreateFrame = CreateFrame

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

    local function UpdateSpacer()
        text:SetText("")
    end
    f.Update = UpdateSpacer

    UpdateSpacer()

    return f
end

----------------------------------------------------
-- Register with SDT
----------------------------------------------------
SDT:RegisterDataText("(Spacer)", mod)

return mod
