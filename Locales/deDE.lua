local SDT = _G.SimpleDatatexts
local L = SDT.L

if GetLocale() ~= "deDE" then
    return
end

-- ----------------------------
-- SimpleDatatexts.lua
-- ----------------------------
L["(empty)"] = "(leer)"
L["(spacer)"] = "(abstand)"
L["Simple Datatexts loaded. Total modules:"] = "Simple Datatexts geladen. Gesamtanzahl Module:"
L["Options"] = "Optionen"
L["Lock/Unlock"] = "Sperren/Freigeben"
L["Width"] = "Breite"
L["Height"] = "Höhe"
L["Scale"] = "Skalierung"
L["Settings"] = "Einstellungen"
L["Version"] = "Version"
L["Usage"] = "Verwendung"
L["barName"] = "Balkenname"
L["value"] = "Wert"
L["Invalid panel name supplied. Valid panel names are:"] = "Ungültiger Panelname. Gültige Namen sind:"
L["A valid numeric value for the adjustment must be specified."] = "Es muss ein gültiger Zahlenwert angegeben werden."
L["Invalid panel width specified."] = "Ungültige Panelbreite angegeben."
L["Invalid panel height specified."] = "Ungültige Panelhöhe angegeben."
L["Invalid panel scale specified."] = "Ungültige Panelskalierung angegeben."
L["Invalid adjustment type specified."] = "Ungültiger Anpassungstyp angegeben."
L["SDT panels are now"] = "SDT Panels sind jetzt"
L["LOCKED"] = "GESPERRT"
L["UNLOCKED"] = "ENTSPERRT"
L["Simple Datatexts Version"] = "Simple Datatexts Version"

-- ----------------------------
-- Settings.lua
-- ----------------------------
L["Simple DataTexts"] = "Simple Datatexts"
L["Global"] = "Global"
L["Simple DataTexts - Global Settings"] = "Simple Datatexts - Globale Einstellungen"
L["Panels"] = "Panels"
L["Simple DataTexts - Panel Settings"] = "Simple Datatexts - Panel-Einstellungen"
L["Module Settings"] = "Moduleinstellungen"
L["Configure settings for the "] = "Einstellungen konfigurieren für das "
L["module."] = "Modul."
L["Configuration"] = "Konfiguration"
L["Experience Module"] = "Erfahrungsmodul"
L["Simple DataTexts - Experience Settings"] = "Simple DataTexts - Erfahrungseinstellungen"
L["Profiles"] = "Profile"
L["Simple DataTexts - Profile Settings"] = "Simple Datatexts - Profileinstellungen"
L["Lock Panels (disable movement)"] = "Panels sperren (Bewegung deaktivieren)"
L["Show login message"] = "Anmeldemeldung anzeigen"
L["Use Class Color"] = "Klassenfarbe verwenden"
L["Use 24Hr Clock"] = "24-Stunden-Uhr verwenden"
L["Use Custom Color"] = "Eigene Farbe verwenden"
L["Hide Module Title in Tooltip"] = "Modultitel im Tooltip ausblenden"
L["Display Font:"] = "Schriftart anzeigen:"
L["Font Size"] = "Schriftgröße"
L["Create New Panel"] = "Neues Panel erstellen"
L["Select Panel:"] = "Panel auswählen:"
L["Rename Panel:"] = "Panel umbenennen:"
L["Remove Selected Panel"] = "Ausgewähltes Panel entfernen"
L["Slot %d:"] = "Slot %d:"
L["Scale"] = "Skalierung"
L["Background Opacity"] = "Hintergrund-Transparenz"
L["Slots"] = "Slots"
L["Width"] = "Breite"
L["Height"] = "Höhe"
L["Select Border:"] = "Rahmen auswählen:"
L["Border Size"] = "Rahmengröße"
L["Are you sure you want to delete this bar?\nThis action cannot be undone."] = "Willst du diesen Balken wirklich löschen?\nDieser Vorgang kann nicht rückgängig gemacht werden."
L["Yes"] = "Ja"
L["No"] = "Nein"
L["(none)"] = "(keine)"
L["Display Format:"] = "Anzeigeformat:"
L["Show Bar"] = "Leiste anzeigen"
L["Hide Blizzard XP Bar"] = "Blizzard-Erfahrungsleiste ausblenden"
L["Bar Height (%)"] = "Leistenhöhe (%)"
L["Bar Font Size"] = "Leisten-Schriftgröße"
L["Bar Color:"] = "Leistenfarbe:"
L["Bar Text Color:"] = "Leisten-Textfarbe:"
L["Create New Profile:"] = "Neues Profil erstellen:"
L["Current Profile:"] = "Aktuelles Profil:"
L["Enable Per-Spec Profiles"] = "Profile pro Spezialisierung aktivieren"
L["Copy Profile:"] = "Profil kopieren:"
L["Delete Profile:"] = "Profil löschen:"
L["NYI:"] = "NYI:"
L["The profile name you have entered already exists. Please enter a new name."] = "Der Profilname existiert bereits. Bitte einen neuen Namen eingeben."
L["Ok"] = "Ok"
L["Saved font not found. Resetting font to Friz Quadrata TT."] = "Gespeicherte Schriftart nicht gefunden. Schriftart wird auf Friz Quadrata TT zurückgesetzt."

-- ----------------------------
-- Utilities.lua
-- ----------------------------
L["Are you sure you want to overwrite your\n'%s' profile?\nThis action cannot be undone."] = "Willst du dein Profil\n'%s' wirklich überschreiben?\nDieser Vorgang kann nicht rückgängig gemacht werden."
L["You cannot copy the active profile onto itself. Please change your active profile first."] = "Das aktive Profil kann nicht auf sich selbst kopiert werden. Bitte aktives Profil ändern."
L["Invalid source profile specified."] = "Ungültiges Quellprofil angegeben."
L["You cannot delete the active profile. Please change your active profile first."] = "Das aktive Profil kann nicht gelöscht werden. Bitte aktives Profil ändern."
L["Are you sure you want to delete this profile?\nThis action cannot be undone."] = "Willst du dieses Profil wirklich löschen?\nDieser Vorgang kann nicht rückgängig gemacht werden."

-- ----------------------------
-- Module Settings
-- ----------------------------
L["Show Label"] = "Beschriftung anzeigen"
L["Show Short Label"] = "Kurze Beschriftung anzeigen"
L["Show Silver"] = "Silber anzeigen"
L["Show Copper"] = "Kupfer anzeigen"
L["Use Coin Icons"] = "Münzsymbole verwenden"
L["Show as Percentage"] = "Als Prozentsatz anzeigen"

-- ----------------------------
-- modules/Agility.lua
-- ----------------------------
L["Agi"] = "Agi"

-- ----------------------------
-- modules/Armor.lua
-- ----------------------------
L["Mitigation By Level:"] = "Schadensminderung nach Stufe:"
L["Level %d"] = "Stufe %d"
L["Target Mitigation"] = "Ziel-Schadensminderung"

-- ----------------------------
-- modules/AttackPower.lua
-- ----------------------------
L["AP"] = "AP"

-- ----------------------------
-- modules/Bags.lua
-- ----------------------------
L["Bags"] = "Taschen"

-- ----------------------------
-- modules/Crit.lua
-- ----------------------------
L["Crit"] = "Krit"

-- ----------------------------
-- modules/Currency.lua
-- ----------------------------
L["CURRENCIES"] = "WÄHRUNGEN"
L["GOLD"] = "GOLD"

-- ----------------------------
-- modules/Durability.lua
-- ----------------------------
L["Durability:"] = "Haltbarkeit:"

-------------------------------
-- modules/Experience.lua
-------------------------------
L["Max Level"] = "Maximale Stufe"
L["N/A"] = "N/V"
L["Experience"] = "Erfahrung"
L["Configure in settings"] = "In den Einstellungen konfigurieren"

-- ----------------------------
-- modules/Friends.lua
-- ----------------------------
L["Ara Friends LDB object not found! SDT Friends datatext disabled."] = "Ara Friends LDB Objekt nicht gefunden! SDT Friends Datatext deaktiviert."

-- ----------------------------
-- modules/Gold.lua
-- ----------------------------
L["Session:"] = "Sitzung:"
L["Earned:"] = "Erhalten:"
L["Spent:"] = "Ausgegeben:"
L["Profit:"] = "Gewinn:"
L["Deficit:"] = "Defizit:"
L["Character:"] = "Charakter:"
L["Server:"] = "Server:"
L["Alliance:"] = "Allianz:"
L["Horde:"] = "Horde:"
L["Total:"] = "Gesamt:"
L["Warband:"] = "Kriegstrupp:"
L["WoW Token:"] = "WoW Token:"
L["Reset Session Data: Hold Ctrl + Right Click"] = "Sitzungsdaten zurücksetzen: Halte Strg + Rechtsklick"

-- ----------------------------
-- modules/Guild.lua
-- ----------------------------
L["Ara Guild LDB object not found! SDT Guild datatext disabled."] = "Ara Guild LDB Objekt nicht gefunden! SDT Guild Datatext deaktiviert."

-- ----------------------------
-- modules/Haste.lua
-- ----------------------------
L["Haste:"] = "Tempotwertung:"

-- ----------------------------
-- modules/Intellect.lua
-- ----------------------------
L["Int"] = "Int"

-- ----------------------------
-- modules/LDBObjects.lua
-- ----------------------------
L["NO TEXT"] = "KEIN TEXT"

-- ----------------------------
-- modules/Mail.lua
-- ----------------------------
L["New Mail"] = "Neue Nachricht"
L["No Mail"] = "Keine Nachricht"

-- ----------------------------
-- modules/Mastery.lua
-- ----------------------------
L["Mastery:"] = "Meisterschaft:"

-- ----------------------------
-- modules/SpecSwitch.lua
-- ----------------------------
L["Active"] = "Aktiv"
L["Inactive"] = "Inaktiv"
L["Loadouts"] = "Loadouts"
L["Failed to load Blizzard_PlayerSpells: %s"] = "Fehler beim Laden von Blizzard_PlayerSpells: %s"
L["Starter Build"] = "Starter-Build"
L["Spec"] = "Spez."
L["Left Click: Change Talent Specialization"] = "Linksklick: Talentspezialisierung ändern"
L["Control + Left Click: Change Loadout"] = "Strg + Linksklick: Loadout ändern"
L["Shift + Left Click: Show Talent Specialization UI"] = "Shift + Linksklick: Talentspezialisierungs-UI öffnen"
L["Shift + Right Click: Change Loot Specialization"] = "Shift + Rechtsklick: Beutespezialisierung ändern"
L["Show Specialization Icon"] = "Spezialisierungssymbol anzeigen"
L["Show Specialization Text"] = "Spezialisierungstext anzeigen"
L["Show Loot Specialization Icon"] = "Beutespezialisierungssymbol anzeigen"
L["Show Loot Specialization Text"] = "Beutespezialisierungstext anzeigen"
L["Show Loadout"] = "Ausrüstung anzeigen"

-- ----------------------------
-- modules/Speed.lua
-- ----------------------------
L["Speed: "] = "Geschwindigkeit: "

-- ----------------------------
-- modules/Strength.lua
-- ----------------------------
L["Str"] = "Str"

-- ----------------------------
-- modules/System.lua
-- ----------------------------
L["MB_SUFFIX"] = "mb"
L["KB_SUFFIX"] = "kb"
L["SYSTEM"] = "SYSTEM"
L["FPS:"] = "FPS:"
L["Home Latency:"] = "Heimat-Latenz:"
L["World Latency:"] = "Welt-Latenz:"
L["Total Memory:"] = "Gesamtspeicher:"
L["(Shift Click) Collect Garbage"] = "(Shift-Klick) Speicher freigeben"
L["FPS"] = "FPS"
L["MS"] = "MS"

-- ----------------------------
-- modules/Time.lua
-- ----------------------------
L["TIME"] = "ZEIT"
L["Saved Raid(s)"] = "Gespeicherte Raids"
L["Saved Dungeon(s)"] = "Gespeicherte Dungeons"

-- ----------------------------
-- modules/Versatility.lua
-- ----------------------------
L["Vers:"] = "Vielseitig:"

-- ----------------------------
-- modules/Volume.lua
-- ----------------------------
L["Select Volume Stream"] = "Audiostream auswählen"
L["Toggle Volume Stream"] = "Audiostream umschalten"
L["Output Audio Device"] = "Ausgabegerät"
L["Active Output Audio Device"] = "Aktives Ausgabegerät"
L["Volume Streams"] = "Audiostreams"
L["Left Click: Select Volume Stream"] = "Linksklick: Audiostream auswählen"
L["Middle Click: Toggle Mute Master Stream"] = "Mittelklick: Masterstream stummschalten"
L["Shift + Middle Click: Toggle Volume Stream"] = "Shift + Mittelklick: Audiostream umschalten"
L["Shift + Left Click: Open System Audio Panel"] = "Shift + Linksklick: System-Audio-Panel öffnen"
L["Shift + Right Click: Select Output Audio Device"] = "Shift + Rechtsklick: Ausgabegerät auswählen"
L["M. Vol"] = "Haupt"
L["FX"] = "Eff"
L["Amb"] = "Umg"
L["Dlg"] = "Dlg"
L["Mus"] = "Mus"

-- ----------------------------
-- Ara_Broker_Guild_Friends.lua
-- ----------------------------
L["Guild"] = "Gilde"
L["No Guild"] = "Keine Gilde"
L["Friends"] = "Freunde"
L["<Mobile>"] = "<Mobil>"
L["Hints"] = "Hinweise"
L["Block"] = "Blockieren"
L["Click"] = "Klick"
L["RightClick"] = "Rechtsklick"
L["MiddleClick"] = "Mittelklick"
L["Modifier+Click"] = "Modifikator+Klick"
L["Shift+Click"] = "Shift+Klick"
L["Shift+RightClick"] = "Shift+Rechtsklick"
L["Ctrl+Click"] = "Strg+Klick"
L["Ctrl+RightClick"] = "Strg+Rechtsklick"
L["Alt+RightClick"] = "Alt+Rechtsklick"
L["Ctrl+MouseWheel"] = "Strg+Mausrad"
L["Button4"] = "Taste4"
L["to open panel."] = "um Panel zu öffnen."
L["to display config menu."] = "um das Konfigurationsmenü zu öffnen."
L["to add a friend."] = "um einen Freund hinzuzufügen."
L["to toggle notes."] = "um Notizen umzuschalten."
L["to whisper."] = "um zu flüstern."
L["to invite."] = "um einzuladen."
L["to query information."] = "um Informationen abzufragen."
L["to edit note."] = "um Notiz zu bearbeiten."
L["to edit officer note."] = "um Offiziersnotiz zu bearbeiten."
L["to remove friend."] = "um Freund zu entfernen."
L["to sort main column."] = "um die Hauptspalte zu sortieren."
L["to sort second column."] = "um die zweite Spalte zu sortieren."
L["to sort third column."] = "um die dritte Spalte zu sortieren."
L["to resize tooltip."] = "um Tooltip zu skalieren."
L["Mobile App"] = "Mobile App"
L["Desktop App"] = "Desktop App"
L["OFFLINE FAVORITE"] = "OFFLINE FAVORIT"
L["MOTD"] = "MOTD"
L["No friends online."] = "Keine Freunde online."
L["Broadcast"] = "Broadcast"
L["Invalid scale.\nShould be a number between 70 and 200%"] = "Ungültige Skalierung.\nMuss zwischen 70 und 200% liegen."
L["Set a custom tooltip scale.\nEnter a value between 70 and 200 (%%)."] = "Benutzerdefinierte Tooltip-Skalierung setzen.\nWert zwischen 70 und 200 eingeben (%%)."
L["Guild & Friends"] = "Gilde & Freunde"
L["Show guild name"] = "Gildenname anzeigen"
L["Show 'Guild' tag"] = "'Gilde'-Tag anzeigen"
L["Show total number of guildmates"] = "Gesamtanzahl Gildenmitglieder anzeigen"
L["Show 'Friends' tag"] = "'Freunde'-Tag anzeigen"
L["Show total number of friends"] = "Gesamtanzahl Freunde anzeigen"
L["Show guild XP"] = "Gilden-XP anzeigen"
L["Show guild XP tooltip"] = "Gilden-XP Tooltip anzeigen"
L["Show own broadcast"] = "Eigenes Broadcast anzeigen"
L["Show bnet friends broadcast"] = "Broadcast von bnet-Freunden anzeigen"
L["Show guild notes"] = "Gilden-Notizen anzeigen"
L["Show friend notes"] = "Freundes-Notizen anzeigen"
L["Show class icon when grouped"] = "Klassen-Symbol in Gruppe anzeigen"
L["Highlight sorted column"] = "Sortierte Spalte hervorheben"
L["Simple"] = "Einfach"
L["Gradient"] = "Verlauf"
L["Reverse gradient"] = "Verlauf umkehren"
L["Status as..."] = "Status als..."
L["Class colored text"] = "Klassenfarbiger Text"
L["Custom colored text"] = "Eigene Farbe"
L["Icon"] = "Symbol"
L["Real ID..."] = "Real ID..."
L["Before nickname"] = "Vor dem Spitznamen"
L["Instead of nickname"] = "Statt Spitznamen"
L["After nickname"] = "Nach dem Spitznamen"
L["Don't show"] = "Nicht anzeigen"
L["Column alignments"] = "Spaltenausrichtung"
L["Name"] = "Name"
L["Zone"] = "Zone"
L["Notes"] = "Notizen"
L["Rank"] = "Rang"
L["Tooltip Size"] = "Tooltip-Größe"
L["90%"] = "90%"
L["100%"] = "100%"
L["110%"] = "110%"
L["120%"] = "120%"
L["Custom..."] = "Benutzerdefiniert..."
L["Use TipTac skin (requires TipTac)"] = "TipTac Skin verwenden (benötigt TipTac)"
L["Colors"] = "Farben"
L["Background"] = "Hintergrund"
L["Borders"] = "Ränder"
L["Order highlight"] = "Reihenfolge hervorheben"
L["Headers"] = "Überschriften"
L["MotD / broadcast"] = "MotD / Broadcast"
L["Friendly zone"] = "Freundliche Zone"
L["Contested zone"] = "Umstrittene Zone"
L["Enemy zone"] = "Feindliche Zone"
L["Officer notes"] = "Offiziersnotizen"
L["Status"] = "Status"
L["Ranks"] = "Ränge"
L["Friends broadcast"] = "Freundes-Broadcast"
L["Realms"] = "Server"
L["Restore default colors"] = "Standardfarben wiederherstellen"
L["Show Block Hints"] = "Block-Hinweise anzeigen"
L["Open panel"] = "Panel öffnen"
L["Config menu"] = "Konfigurationsmenü"
L["Toggle notes"] = "Notizen umschalten"
L["Add a friend"] = "Freund hinzufügen"
L["Show Hints"] = "Hinweise anzeigen"
L["Whisper"] = "Flüstern"
L["Invite"] = "Einladen"
L["Query"] = "Abfragen"
L["Edit note"] = "Notiz bearbeiten"
L["Edit officer note"] = "Offiziersnotiz bearbeiten"
L["Sort main column"] = "Hauptspalte sortieren"
L["Sort second column"] = "Zweite Spalte sortieren"
L["Sort third column"] = "Dritte Spalte sortieren"
L["Resize tooltip"] = "Tooltip skalieren"
L["Remove friend"] = "Freund entfernen"
