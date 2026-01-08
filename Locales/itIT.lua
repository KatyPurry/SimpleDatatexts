local _, SDT = ...
local L = SDT.L

if GetLocale() ~= "itIT" then
    return
end

-- ----------------------------
-- SimpleDatatexts.lua
-- ----------------------------
-- Used in: Settings.lua, SimpleDatatexts.lua
L["(empty)"] = "(vuoto)"
L["Loaded. Total modules: %d"] = "Caricato. Totale moduli: %d"
L["Options"] = "Opzioni"
L["Lock/Unlock"] = "Blocca/Sblocca"
L["Width"] = "Larghezza"
L["Height"] = "Altezza"
L["Scale"] = "Scala"
L["Settings"] = "Impostazioni"
L["Version"] = "Versione"
L["Usage"] = "Utilizzo"
L["barName"] = "Nome barra"
L["value"] = "valore"
L["Invalid panel name supplied. Valid panel names are:"] = "Nome pannello non valido. I nomi validi sono:"
L["A valid numeric value for the adjustment must be specified."] = "Deve essere specificato un valore numerico valido per la regolazione."
L["Invalid panel width specified."] = "Larghezza pannello non valida."
L["Invalid panel height specified."] = "Altezza pannello non valida."
L["Invalid panel scale specified."] = "Scala pannello non valida."
L["Invalid adjustment type specified."] = "Tipo di regolazione non valido."
L["SDT panels are now"] = "I pannelli SDT sono ora"
L["LOCKED"] = "BLOCCATI"
L["UNLOCKED"] = "SBLOCCATI"
L["Simple Datatexts Version"] = "Versione di Simple Datatexts"

-- ----------------------------
-- Settings.lua
-- ----------------------------
L["Simple DataTexts"] = "Simple DataTexts"
L["Global"] = "Globale"
L["Simple DataTexts - Global Settings"] = "Simple DataTexts - Impostazioni globali"
L["Panels"] = "Pannelli"
L["Simple DataTexts - Panel Settings"] = "Simple DataTexts - Impostazioni pannelli"
L["Profiles"] = "Profili"
L["Simple DataTexts - Profile Settings"] = "Simple DataTexts - Impostazioni profili"
L["Lock Panels (disable movement)"] = "Blocca pannelli (disabilita movimento)"
L["Show login message"] = "Mostra messaggio di accesso"
L["Use Class Color"] = "Usa colore classe"
L["Use 24Hr Clock"] = "Usa orologio 24h"
L["Use Custom Color"] = "Usa colore personalizzato"
L["Display Font:"] = "Font visualizzazione:"
L["Font Size"] = "Dimensione font"
L["Create New Panel"] = "Crea nuovo pannello"
L["Select Panel:"] = "Seleziona pannello:"
L["Rename Panel:"] = "Rinomina pannello:"
L["Remove Selected Panel"] = "Rimuovi pannello selezionato"
L["Slot %d:"] = "Slot %d:"
L["Scale"] = "Scala"
L["Background Opacity"] = "Opacità sfondo"
L["Slots"] = "Slot"
L["Width"] = "Larghezza"
L["Height"] = "Altezza"
L["Select Border:"] = "Seleziona bordo:"
L["Border Size"] = "Dimensione bordo"
L["Are you sure you want to delete this bar?\nThis action cannot be undone."] = "Sei sicuro di voler eliminare questa barra?\nQuesta azione non può essere annullata."
-- Used in: Settings.lua, Utilities.lua
L["Yes"] = "Sì"
-- Used in: Settings.lua, Utilities.lua
L["No"] = "No"
L["(none)"] = "(nessuno)"
L["Create New Profile:"] = "Crea nuovo profilo:"
L["Current Profile:"] = "Profilo corrente:"
L["Enable Per-Spec Profiles"] = "Abilita profili per specializzazione"
L["Copy Profile:"] = "Copia profilo:"
L["Delete Profile:"] = "Elimina profilo:"
L["NYI:"] = "Non ancora disponibile:"
L["The profile name you have entered already exists. Please enter a new name."] = "Il nome del profilo inserito esiste già. Inserisci un nuovo nome."
-- Used in: Settings.lua, Utilities.lua
L["Ok"] = "OK"
L["Saved font not found. Resetting font to Friz Quadrata TT."] = "Font salvato non trovato. Ripristino a Friz Quadrata TT."

-- ----------------------------
-- Utilities.lua
-- ----------------------------
L["Are you sure you want to overwrite your\n'%s' profile?\nThis action cannot be undone."] = "Sei sicuro di voler sovrascrivere il profilo\n'%s'?\nQuesta azione non può essere annullata."
L["You cannot copy the active profile onto itself. Please change your active profile first."] = "Non puoi copiare il profilo attivo su se stesso. Cambia prima il profilo attivo."
L["Invalid source profile specified."] = "Profilo sorgente non valido."
L["You cannot delete the active profile. Please change your active profile first."] = "Non puoi eliminare il profilo attivo. Cambia prima il profilo attivo."
L["Are you sure you want to delete this profile?\nThis action cannot be undone."] = "Sei sicuro di voler eliminare questo profilo?\nQuesta azione non può essere annullata."

-- ----------------------------
-- modules/Armor.lua
-- ----------------------------
L["Mitigation By Level:"] = "Mitigazione per livello:"
L["Level %d"] = "Livello %d"
L["Target Mitigation"] = "Mitigazione bersaglio"

-- ----------------------------
-- modules/Bags.lua
-- ----------------------------
L["Bags"] = "Borse"

-- ----------------------------
-- modules/Crit.lua
-- ----------------------------
L["Crit"] = "Critico"

-- ----------------------------
-- modules/Currency.lua
-- ----------------------------
L["CURRENCIES"] = "VALUTE"
-- Used in: modules/Currency.lua, modules/Gold.lua
L["GOLD"] = "ORO"

-- ----------------------------
-- modules/Durability.lua
-- ----------------------------
L["Durability:"] = "Durabilità:"

-- ----------------------------
-- modules/Friends.lua
-- ----------------------------
L["Ara Friends LDB object not found! SDT Friends datatext disabled."] = "Oggetto LDB Ara Friends non trovato! Datatext Amici SDT disabilitato."

-- ----------------------------
-- modules/Gold.lua
-- ----------------------------
L["Session:"] = "Sessione:"
L["Earned:"] = "Guadagnato:"
L["Spent:"] = "Speso:"
L["Profit:"] = "Profitto:"
L["Deficit:"] = "Deficit:"
L["Character:"] = "Personaggio:"
L["Server:"] = "Server:"
L["Alliance:"] = "Alleanza:"
L["Horde:"] = "Orda:"
L["Total:"] = "Totale:"
L["Warband:"] = "Branco di guerra:"
L["WoW Token:"] = "WoW Token:"
L["Reset Session Data: Hold Ctrl + Right Click"] = "Reimposta dati sessione: tieni Ctrl + clic destro"

-- ----------------------------
-- modules/Guild.lua
-- ----------------------------
L["Ara Guild LDB object not found! SDT Guild datatext disabled."] = "Oggetto LDB Ara Guild non trovato! Datatext Gilda SDT disabilitato."

-- ----------------------------
-- modules/Haste.lua
-- ----------------------------
L["Haste:"] = "Celerità:"

-- ----------------------------
-- modules/LDBObjects.lua
-- ----------------------------
L["NO TEXT"] = "NESSUN TESTO"

-- ----------------------------
-- modules/Mail.lua
-- ----------------------------
L["New Mail"] = "Nuova posta"
L["No Mail"] = "Nessuna posta"

-- ----------------------------
-- modules/Mastery.lua
-- ----------------------------
L["Mastery:"] = "Maestria:"

-- ----------------------------
-- modules/SpecSwitch.lua
-- ----------------------------
L["Active"] = "Attivo"
L["Inactive"] = "Inattivo"
L["Loadouts"] = "Configurazioni"
L["Failed to load Blizzard_PlayerSpells: %s"] = "Impossibile caricare Blizzard_PlayerSpells: %s"
L["Starter Build"] = "Build iniziale"
L["Spec"] = "Spec"
L["Left Click: Change Talent Specialization"] = "Click sinistro: cambia specializzazione talenti"
L["Control + Left Click: Change Loadout"] = "Ctrl + click sinistro: cambia configurazione"
L["Shift + Left Click: Show Talent Specialization UI"] = "Shift + click sinistro: mostra interfaccia specializzazione talenti"
L["Shift + Right Click: Change Loot Specialization"] = "Shift + click destro: cambia specializzazione bottino"

-- ----------------------------
-- modules/System.lua
-- ----------------------------
L["MB_SUFFIX"] = "MB"
L["KB_SUFFIX"] = "KB"
L["SYSTEM"] = "SISTEMA"
L["FPS:"] = "FPS:"
L["Home Latency:"] = "Latenza locale:"
L["World Latency:"] = "Latenza mondo:"
L["Total Memory:"] = "Memoria totale:"
L["(Shift Click) Collect Garbage"] = "(Shift + Click) Pulisci memoria"
L["FPS"] = "FPS"
L["MS"] = "MS"

-- ----------------------------
-- modules/Time.lua
-- ----------------------------
L["TIME"] = "TEMPO"
L["Saved Raid(s)"] = "Raid salvati"
L["Saved Dungeon(s)"] = "Dungeon salvati"

-- ----------------------------
-- modules/Versatility.lua
-- ----------------------------
L["Vers:"] = "Vers:"

-- ----------------------------
-- modules/Volume.lua
-- ----------------------------
L["Select Volume Stream"] = "Seleziona stream volume"
L["Toggle Volume Stream"] = "Attiva/disattiva stream volume"
L["Output Audio Device"] = "Dispositivo audio in uscita"
L["Active Output Audio Device"] = "Dispositivo audio in uscita attivo"
L["Volume Streams"] = "Stream volume"
L["Left Click: Select Volume Stream"] = "Click sinistro: seleziona stream volume"
L["Middle Click: Toggle Mute Master Stream"] = "Click centrale: silenzia stream principale"
L["Shift + Middle Click: Toggle Volume Stream"] = "Shift + click centrale: attiva/disattiva stream volume"
L["Shift + Left Click: Open System Audio Panel"] = "Shift + click sinistro: apri pannello audio"
L["Shift + Right Click: Select Output Audio Device"] = "Shift + click destro: seleziona dispositivo audio uscita"

-- ----------------------------
-- Ara_Broker_Guild_Friends.lua
-- ----------------------------
L["Guild"] = "Gilda"
L["No Guild"] = "Nessuna gilda"
L["Friends"] = "Amici"
L["<Mobile>"] = "<Mobile>"
L["Hints"] = "Suggerimenti"
L["Block"] = "Blocca"
L["Click"] = "Click"
L["RightClick"] = "Click destro"
L["MiddleClick"] = "Click centrale"
L["Modifier+Click"] = "Modificatore+Click"
L["Shift+Click"] = "Shift+Click"
L["Shift+RightClick"] = "Shift+Click destro"
L["Ctrl+Click"] = "Ctrl+Click"
L["Ctrl+RightClick"] = "Ctrl+Click destro"
L["Alt+RightClick"] = "Alt+Click destro"
L["Ctrl+MouseWheel"] = "Ctrl+Rotellina"
L["Button4"] = "Pulsante4"
L["to open panel."] = "per aprire il pannello."
L["to display config menu."] = "per mostrare il menu di configurazione."
L["to add a friend."] = "per aggiungere un amico."
L["to toggle notes."] = "per mostrare/nascondere note."
L["to whisper."] = "per sussurrare."
L["to invite."] = "per invitare."
L["to query information."] = "per richiedere informazioni."
L["to edit note."] = "per modificare la nota."
L["to edit officer note."] = "per modificare nota ufficiale."
L["to remove friend."] = "per rimuovere un amico."
L["to sort main column."] = "per ordinare colonna principale."
L["to sort second column."] = "per ordinare seconda colonna."
L["to sort third column."] = "per ordinare terza colonna."
L["to resize tooltip."] = "per ridimensionare tooltip."
L["Mobile App"] = "App mobile"
L["Desktop App"] = "App desktop"
L["OFFLINE FAVORITE"] = "FAVORITO OFFLINE"
L["MOTD"] = "MdG"
L["No friends online."] = "Nessun amico online."
L["Broadcast"] = "Broadcast"
L["Invalid scale.\nShould be a number between 70 and 200%"] = "Scala non valida.\nDeve essere un numero tra 70 e 200%"
L["Set a custom tooltip scale.\nEnter a value between 70 and 200 (%%)."] = "Imposta scala tooltip personalizzata.\nInserisci un valore tra 70 e 200 (%%)."
L["Guild & Friends"] = "Gilda e amici"
L["Show guild name"] = "Mostra nome gilda"
L["Show 'Guild' tag"] = "Mostra etichetta 'Gilda'"
L["Show total number of guildmates"] = "Mostra numero totale membri gilda"
L["Show 'Friends' tag"] = "Mostra etichetta 'Amici'"
L["Show total number of friends"] = "Mostra numero totale amici"
L["Show guild XP"] = "Mostra XP gilda"
L["Show guild XP tooltip"] = "Mostra tooltip XP gilda"
L["Show own broadcast"] = "Mostra il tuo broadcast"
L["Show bnet friends broadcast"] = "Mostra broadcast amici Battle.net"
L["Show guild notes"] = "Mostra note gilda"
L["Show friend notes"] = "Mostra note amici"
L["Show class icon when grouped"] = "Mostra icona classe in gruppo"
L["Highlight sorted column"] = "Evidenzia colonna ordinata"
L["Simple"] = "Semplice"
L["Gradient"] = "Gradiente"
L["Reverse gradient"] = "Gradiente inverso"
L["Status as..."] = "Stato come..."
L["Class colored text"] = "Testo colorato per classe"
L["Custom colored text"] = "Testo colore personalizzato"
L["Icon"] = "Icona"
L["Real ID..."] = "Real ID..."
L["Before nickname"] = "Prima del soprannome"
L["Instead of nickname"] = "Al posto del soprannome"
L["After nickname"] = "Dopo il soprannome"
L["Don't show"] = "Non mostrare"
L["Column alignments"] = "Allineamento colonne"
L["Name"] = "Nome"
L["Zone"] = "Zona"
L["Notes"] = "Note"
L["Rank"] = "Rango"
L["Tooltip Size"] = "Dimensione tooltip"
L["90%"] = "90%"
L["100%"] = "100%"
L["110%"] = "110%"
L["120%"] = "120%"
L["Custom..."] = "Personalizzato..."
L["Use TipTac skin (requires TipTac)"] = "Usa skin TipTac (richiede TipTac)"
L["Colors"] = "Colori"
L["Background"] = "Sfondo"
L["Borders"] = "Bordi"
L["Order highlight"] = "Evidenzia ordine"
L["Headers"] = "Intestazioni"
L["MotD / broadcast"] = "MdG / broadcast"
L["Friendly zone"] = "Zona amica"
L["Contested zone"] = "Zona contesa"
L["Enemy zone"] = "Zona nemica"
L["Officer notes"] = "Note ufficiali"
L["Status"] = "Stato"
L["Ranks"] = "Ranghi"
L["Friends broadcast"] = "Broadcast amici"
L["Realms"] = "Reami"
L["Restore default colors"] = "Ripristina colori predefiniti"
L["Show Block Hints"] = "Mostra suggerimenti blocco"
L["Open panel"] = "Apri pannello"
L["Config menu"] = "Menu configurazione"
L["Toggle notes"] = "Mostra/nascondi note"
L["Add a friend"] = "Aggiungi amico"
L["Show Hints"] = "Mostra suggerimenti"
L["Whisper"] = "Sussurra"
L["Invite"] = "Invita"
L["Query"] = "Richiedi"
L["Edit note"] = "Modifica nota"
L["Edit officer note"] = "Modifica nota ufficiale"
L["Sort main column"] = "Ordina colonna principale"
L["Sort second column"] = "Ordina seconda colonna"
L["Sort third column"] = "Ordina terza colonna"
L["Resize tooltip"] = "Ridimensiona tooltip"
L["Remove friend"] = "Rimuovi amico"
