-- Database.lua - AceDB Integration and Migration
local addonName, SDT = ...
local L = SDT.L

----------------------------------------------------
-- Database Defaults
----------------------------------------------------
local defaults = {
    profile = {
        -- Global settings
        locked = false,
        useClassColor = false,
        useCustomColor = false,
        customColorHex = "#ffffff",
        hideModuleTitle = false,
        use24HourClock = false,
        showLoginMessage = true,
        font = "Friz Quadrata TT",
        fontSize = 12,
        fontOutline = "NONE",
        
        -- Panel/bar data
        bars = {
            ['*'] = {
                numSlots = 3,
                slots = {},
                bgOpacity = 50,
                borderName = "None",
                border = "None",
                borderSize = 8,
                borderColor = "#000000",
                width = 300,
                height = 22,
                scale = 100,
                name = nil,
                point = nil,
            }
        },
        
        -- Module settings
        moduleSettings = {
            ['*'] = {}
        },
    },
    
    -- Character-specific data
    char = {
        useSpecProfiles = false,
        chosenProfile = {
            generic = nil, -- Will be set to charKey on init
            ['*'] = nil,
        }
    },
    
    -- Global (account-wide) data
    global = {
        gold = {
            ['*'] = { -- realm
                ['*'] = { -- character
                    amount = 0,
                    faction = "Neutral",
                }
            }
        },
        
        -- Ara Broker settings migration
        AraBroker = {},
    }
}

----------------------------------------------------
-- Initialize Database
----------------------------------------------------
function SDT:InitializeDatabase()
    -- Create AceDB instance
    self.db = LibStub("AceDB-3.0"):New("SimpleDatatextsDB", defaults, true)
    
    -- Migrate old data if it exists
    self:MigrateOldData()
    
    -- Set default profile name if needed
    if not self.db.char.chosenProfile.generic then
        self.db.char.chosenProfile.generic = self.cache.charKey
    end
    
    -- Initialize spec profiles
    self:InitializeSpecProfiles()
    
    -- Register profile callbacks
    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
    
    -- Ensure at least one bar exists
    if not next(self.db.profile.bars) then
        self:CreateDefaultBar()
    end
end

----------------------------------------------------
-- Create Default Bar
----------------------------------------------------
function SDT:CreateDefaultBar()
    self.db.profile.bars.SDT_Bar1 = {
        numSlots = 3,
        slots = {},
        bgOpacity = 50,
        borderName = "None",
        border = "None",
        borderSize = 8,
        borderColor = "#000000",
        width = 300,
        height = 22,
        scale = 100,
        name = "SDT_Bar1",
    }
end

----------------------------------------------------
-- Initialize Spec Profiles
----------------------------------------------------
function SDT:InitializeSpecProfiles()
    for i = 1, GetNumSpecializations() do
        local _, specName = GetSpecializationInfo(i)
        if specName and not self.db.char.chosenProfile[specName] then
            self.db.char.chosenProfile[specName] = self.cache.charKey .. "-" .. specName:lower()
        end
    end
end

----------------------------------------------------
-- Migrate Old Data
----------------------------------------------------
function SDT:MigrateOldData()
    -- Check if old SDTDB exists
    if not _G.SDTDB then return end
    
    local charKey = self.cache.charKey
    local oldDB = _G.SDTDB

    -- Skip if already migrated
    if oldDB._migrated then
        return
    end

    self:Print("Migrating old settings to new profile system...")
    
    -- Migrate ALL old profiles to AceDB profiles
    if oldDB.profiles then
        for profileName, oldProfile in pairs(oldDB.profiles) do
            -- Create this profile in AceDB if it doesn't exist
            local tempProfile = profileName
            self.db:SetProfile(tempProfile)
            
            -- Migrate bars
            if oldProfile.bars then
                for barName, barData in pairs(oldProfile.bars) do
                    self.db.profile.bars[barName] = CopyTable(barData)
                end
            end
            
            -- Migrate module settings
            if oldProfile.moduleSettings then
                for moduleName, settings in pairs(oldProfile.moduleSettings) do
                    self.db.profile.moduleSettings[moduleName] = CopyTable(settings)
                end
            end
        end
    end
    
    -- Switch back to this character's profile
    local activeProfileName = oldDB[charKey] and oldDB[charKey].chosenProfile and oldDB[charKey].chosenProfile.generic
    if activeProfileName then
        self.db:SetProfile(activeProfileName)
    else
        self.db:SetProfile(charKey)
    end
    
    -- Migrate character settings to current profile
    if oldDB[charKey] and oldDB[charKey].settings then
        local oldSettings = oldDB[charKey].settings
        
        self.db.profile.locked = oldSettings.locked or false
        self.db.profile.useClassColor = oldSettings.useClassColor or false
        self.db.profile.useCustomColor = oldSettings.useCustomColor or false
        self.db.profile.customColorHex = oldSettings.customColorHex or "#ffffff"
        self.db.profile.hideModuleTitle = oldSettings.hideModuleTitle or false
        self.db.profile.use24HourClock = oldSettings.use24HourClock or false
        self.db.profile.showLoginMessage = oldSettings.showLoginMessage ~= false
        self.db.profile.font = oldSettings.font or "Friz Quadrata TT"
        self.db.profile.fontSize = oldSettings.fontSize or 12
        self.db.profile.fontOutline = oldSettings.fontOutline or "NONE"
    end
    
    -- Migrate character profile choices
    if oldDB[charKey] then
        if oldDB[charKey].useSpecProfiles ~= nil then
            self.db.char.useSpecProfiles = oldDB[charKey].useSpecProfiles
        end
        
        if oldDB[charKey].chosenProfile then
            for k, v in pairs(oldDB[charKey].chosenProfile) do
                self.db.char.chosenProfile[k] = v
            end
        end
    end
    
    -- Migrate gold data
    if oldDB.gold then
        self.db.global.gold = CopyTable(oldDB.gold)
    end
    
    -- Migrate Ara Broker settings
    if oldDB.AraBroker then
        self.db.global.AraBroker = CopyTable(oldDB.AraBroker)
    end
    
    self:Print("Migration complete! All profiles have been migrated.")
    
    -- Mark as migrated
    oldDB._migrated = true
end

----------------------------------------------------
-- Profile Management
----------------------------------------------------
function SDT:RefreshConfig()
    -- Reload all bars
    for barName, bar in pairs(self.bars) do
        if bar then
            bar:Hide()
        end
    end
    wipe(self.bars)
    
    -- Recreate bars from current profile
    for barName, barData in pairs(self.db.profile.bars) do
        local id = tonumber(barName:match("SDT_Bar(%d+)"))
        if id and id > 0 then
            self:CreateDataBar(id, barData.numSlots)
        end
    end
    
    -- Update all modules
    self:UpdateAllModules()
    
    -- Update config GUI if open
    if self.configDialog and self.configDialog:IsShown() then
        LibStub("AceConfigRegistry-3.0"):NotifyChange("SimpleDatatexts")
    end
end

----------------------------------------------------
-- Get Module Setting
----------------------------------------------------
function SDT:GetModuleSetting(moduleName, settingKey, default)
    if self.db.profile.moduleSettings[moduleName] and self.db.profile.moduleSettings[moduleName][settingKey] ~= nil then
        return self.db.profile.moduleSettings[moduleName][settingKey]
    end
    return default
end

----------------------------------------------------
-- Set Module Setting
----------------------------------------------------
function SDT:SetModuleSetting(moduleName, settingKey, value)
    if not self.db.profile.moduleSettings[moduleName] then
        self.db.profile.moduleSettings[moduleName] = {}
    end
    self.db.profile.moduleSettings[moduleName][settingKey] = value
end

----------------------------------------------------
-- Export Profile
----------------------------------------------------
function SDT:ExportProfile()
    local profileData = {
        profile = CopyTable(self.db.profile),
        version = self.cache.version,
    }
    
    local serialized = self.AceSerializer:Serialize(profileData)
    if not serialized then
        self:Print("Error serializing profile data")
        return nil
    end
    
    local compressed = self.LibDeflate:CompressDeflate(serialized)
    if not compressed then
        self:Print("Error compressing profile data")
        return nil
    end
    
    local encoded = self.LibDeflate:EncodeForPrint(compressed)
    return encoded
end

----------------------------------------------------
-- Import Profile
----------------------------------------------------
function SDT:ImportProfile(importString)
    if not importString or importString == "" then
        self:Print("No import string provided")
        return false
    end
    
    local decoded = self.LibDeflate:DecodeForPrint(importString)
    if not decoded then
        self:Print("Error decoding import string")
        return false
    end
    
    local decompressed = self.LibDeflate:DecompressDeflate(decoded)
    if not decompressed then
        self:Print("Error decompressing data")
        return false
    end
    
    local success, profileData = self.AceSerializer:Deserialize(decompressed)
    if not success or not profileData then
        self:Print("Error deserializing profile data")
        return false
    end
    
    -- Validate version (optional)
    if profileData.version then
        self:Print(format("Importing profile from version %s", profileData.version))
    end
    
    -- Import the profile
    if profileData.profile then
        -- Clear current profile
        wipe(self.db.profile)
        
        -- Copy imported data
        for k, v in pairs(profileData.profile) do
            self.db.profile[k] = CopyTable(v)
        end
        
        self:Print("Profile imported successfully!")
        self:RefreshConfig()
        return true
    else
        self:Print("Invalid profile data")
        return false
    end
end