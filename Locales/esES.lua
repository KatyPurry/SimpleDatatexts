local _, SDT = ...
local L = SDT.L

if GetLocale() ~= "esES" then
    return
end

-- ----------------------------
-- SimpleDatatexts.lua
-- ----------------------------
L["(empty)"] = "(vacío)"
L["Simple Datatexts loaded. Total modules:"] = "Simple Datatexts cargado. Total de módulos:"
L["Options"] = "Opciones"
L["Lock/Unlock"] = "Bloquear/Desbloquear"
L["Width"] = "Ancho"
L["Height"] = "Alto"
L["Scale"] = "Escala"
L["Settings"] = "Configuración"
L["Version"] = "Versión"
L["Usage"] = "Uso"
L["barName"] = "nombreBarra"
L["value"] = "valor"
L["Invalid panel name supplied. Valid panel names are:"] = "Nombre de panel inválido. Los nombres válidos son:"
L["A valid numeric value for the adjustment must be specified."] = "Debe especificarse un valor numérico válido."
L["Invalid panel width specified."] = "Ancho de panel inválido."
L["Invalid panel height specified."] = "Alto de panel inválido."
L["Invalid panel scale specified."] = "Escala de panel inválida."
L["Invalid adjustment type specified."] = "Tipo de ajuste inválido."
L["SDT panels are now"] = "Los paneles SDT ahora están"
L["LOCKED"] = "BLOQUEADO"
L["UNLOCKED"] = "DESBLOQUEADO"
L["Simple Datatexts Version"] = "Versión de Simple Datatexts"

-- ----------------------------
-- Settings.lua
-- ----------------------------
L["Simple DataTexts"] = "Simple Datatexts"
L["Global"] = "Global"
L["Simple DataTexts - Global Settings"] = "Simple Datatexts - Configuración Global"
L["Panels"] = "Paneles"
L["Simple DataTexts - Panel Settings"] = "Simple Datatexts - Configuración de Panel"
L["Module Settings"] = "Configuración del módulo"
L["Configure settings for the "] = "Configurar ajustes para el "
L["module."] = "módulo."
L["Configuration"] = "Configuración"
L["Experience Module"] = "Módulo de Experiencia"
L["Simple DataTexts - Experience Settings"] = "Simple DataTexts - Configuración de Experiencia"
L["Profiles"] = "Perfiles"
L["Simple DataTexts - Profile Settings"] = "Simple Datatexts - Configuración de Perfil"
L["Lock Panels (disable movement)"] = "Bloquear paneles (desactivar movimiento)"
L["Show login message"] = "Mostrar mensaje de inicio de sesión"
L["Use Class Color"] = "Usar color de clase"
L["Use 24Hr Clock"] = "Usar reloj 24h"
L["Use Custom Color"] = "Usar color personalizado"
L["Display Font:"] = "Fuente mostrada:"
L["Font Size"] = "Tamaño de fuente"
L["Create New Panel"] = "Crear nuevo panel"
L["Select Panel:"] = "Seleccionar panel:"
L["Rename Panel:"] = "Renombrar panel:"
L["Remove Selected Panel"] = "Eliminar panel seleccionado"
L["Slot %d:"] = "Ranura %d:"
L["Scale"] = "Escala"
L["Background Opacity"] = "Opacidad del fondo"
L["Slots"] = "Ranuras"
L["Width"] = "Ancho"
L["Height"] = "Alto"
L["Select Border:"] = "Seleccionar borde:"
L["Border Size"] = "Tamaño del borde"
L["Are you sure you want to delete this bar?\nThis action cannot be undone."] = "¿Estás seguro de que deseas eliminar esta barra?\nEsta acción no se puede deshacer."
L["Yes"] = "Sí"
L["No"] = "No"
L["(none)"] = "(ninguno)"
L["Display Format:"] = "Formato de Pantalla:"
L["Show Bar"] = "Mostrar Barra"
L["Hide Blizzard XP Bar"] = "Ocultar barra de XP de Blizzard"
L["Bar Height (%)"] = "Altura de Barra (%)"
L["Bar Font Size"] = "Tamaño de Fuente de Barra"
L["Bar Color:"] = "Color de Barra:"
L["Bar Text Color:"] = "Color de Texto de Barra:"
L["Create New Profile:"] = "Crear nuevo perfil:"
L["Current Profile:"] = "Perfil actual:"
L["Enable Per-Spec Profiles"] = "Habilitar perfiles por especialización"
L["Copy Profile:"] = "Copiar perfil:"
L["Delete Profile:"] = "Eliminar perfil:"
L["NYI:"] = "NYI:"
L["The profile name you have entered already exists. Please enter a new name."] = "El nombre del perfil ya existe. Por favor, ingresa un nuevo nombre."
L["Ok"] = "Ok"
L["Saved font not found. Resetting font to Friz Quadrata TT."] = "Fuente guardada no encontrada. Restableciendo a Friz Quadrata TT."

-- ----------------------------
-- Utilities.lua
-- ----------------------------
L["Are you sure you want to overwrite your\n'%s' profile?\nThis action cannot be undone."] = "¿Estás seguro de que deseas sobrescribir tu perfil\n'%s'?\nEsta acción no se puede deshacer."
L["You cannot copy the active profile onto itself. Please change your active profile first."] = "No se puede copiar el perfil activo sobre sí mismo. Cambia primero tu perfil activo."
L["Invalid source profile specified."] = "Perfil fuente inválido."
L["You cannot delete the active profile. Please change your active profile first."] = "No se puede eliminar el perfil activo. Cambia primero tu perfil activo."
L["Are you sure you want to delete this profile?\nThis action cannot be undone."] = "¿Estás seguro de que deseas eliminar este perfil?\nEsta acción no se puede deshacer."

-- ----------------------------
-- modules/Agility.lua
-- ----------------------------
L["Agi"] = "Agi"

-- ----------------------------
-- modules/Armor.lua
-- ----------------------------
L["Mitigation By Level:"] = "Mitigación por nivel:"
L["Level %d"] = "Nivel %d"
L["Target Mitigation"] = "Mitigación del objetivo"

-- ----------------------------
-- modules/AttackPower.lua
-- ----------------------------
L["AP"] = "AP"

-- ----------------------------
-- modules/Bags.lua
-- ----------------------------
L["Bags"] = "Bolsas"

-- ----------------------------
-- modules/Crit.lua
-- ----------------------------
L["Crit"] = "Crítico"

-- ----------------------------
-- modules/Currency.lua
-- ----------------------------
L["CURRENCIES"] = "MONEDAS"
L["GOLD"] = "ORO"

-- ----------------------------
-- modules/Durability.lua
-- ----------------------------
L["Durability:"] = "Durabilidad:"

-------------------------------
-- modules/Experience.lua
-------------------------------
L["Max Level"] = "Nivel Máximo"
L["N/A"] = "N/D"
L["Experience"] = "Experiencia"
L["Configure in settings"] = "Configurar en ajustes"

-- ----------------------------
-- modules/Friends.lua
-- ----------------------------
L["Ara Friends LDB object not found! SDT Friends datatext disabled."] = "Objeto Ara Friends LDB no encontrado! Datatext SDT Friends deshabilitado."

-- ----------------------------
-- modules/Gold.lua
-- ----------------------------
L["Session:"] = "Sesión:"
L["Earned:"] = "Ganado:"
L["Spent:"] = "Gastado:"
L["Profit:"] = "Beneficio:"
L["Deficit:"] = "Déficit:"
L["Character:"] = "Personaje:"
L["Server:"] = "Servidor:"
L["Alliance:"] = "Alianza:"
L["Horde:"] = "Horda:"
L["Total:"] = "Total:"
L["Warband:"] = "Banda de Guerra:"
L["WoW Token:"] = "Token WoW:"
L["Reset Session Data: Hold Ctrl + Right Click"] = "Restablecer datos de sesión: Mantén Ctrl + clic derecho"

-- ----------------------------
-- modules/Guild.lua
-- ----------------------------
L["Ara Guild LDB object not found! SDT Guild datatext disabled."] = "Objeto Ara Guild LDB no encontrado! Datatext SDT Guild deshabilitado."

-- ----------------------------
-- modules/Haste.lua
-- ----------------------------
L["Haste:"] = "Celeridad:"

-- ----------------------------
-- modules/Intellect.lua
-- ----------------------------
L["Int"] = "Int"

-- ----------------------------
-- modules/LDBObjects.lua
-- ----------------------------
L["NO TEXT"] = "SIN TEXTO"

-- ----------------------------
-- modules/Mail.lua
-- ----------------------------
L["New Mail"] = "Correo nuevo"
L["No Mail"] = "Sin correo"

-- ----------------------------
-- modules/Mastery.lua
-- ----------------------------
L["Mastery:"] = "Maestría:"

-- ----------------------------
-- modules/SpecSwitch.lua
-- ----------------------------
L["Active"] = "Activo"
L["Inactive"] = "Inactivo"
L["Loadouts"] = "Loadouts"
L["Failed to load Blizzard_PlayerSpells: %s"] = "Error al cargar Blizzard_PlayerSpells: %s"
L["Starter Build"] = "Build inicial"
L["Spec"] = "Espec."
L["Left Click: Change Talent Specialization"] = "Clic izquierdo: Cambiar especialización"
L["Control + Left Click: Change Loadout"] = "Ctrl + clic izquierdo: Cambiar Loadout"
L["Shift + Left Click: Show Talent Specialization UI"] = "Shift + clic izquierdo: Mostrar UI de especialización"
L["Shift + Right Click: Change Loot Specialization"] = "Shift + clic derecho: Cambiar especialización de botín"

-- ----------------------------
-- modules/Strength.lua
-- ----------------------------
L["Str"] = "Str"

-- ----------------------------
-- modules/System.lua
-- ----------------------------
L["MB_SUFFIX"] = "mb"
L["KB_SUFFIX"] = "kb"
L["SYSTEM"] = "SISTEMA"
L["FPS:"] = "FPS:"
L["Home Latency:"] = "Latencia local:"
L["World Latency:"] = "Latencia mundial:"
L["Total Memory:"] = "Memoria total:"
L["(Shift Click) Collect Garbage"] = "(Shift + clic) Liberar memoria"
L["FPS"] = "FPS"
L["MS"] = "MS"

-- ----------------------------
-- modules/Time.lua
-- ----------------------------
L["TIME"] = "TIEMPO"
L["Saved Raid(s)"] = "Banda(s) guardada(s)"
L["Saved Dungeon(s)"] = "Mazmorra(s) guardada(s)"

-- ----------------------------
-- modules/Versatility.lua
-- ----------------------------
L["Vers:"] = "Vers:"

-- ----------------------------
-- modules/Volume.lua
-- ----------------------------
L["Select Volume Stream"] = "Seleccionar flujo de audio"
L["Toggle Volume Stream"] = "Alternar flujo de audio"
L["Output Audio Device"] = "Dispositivo de salida"
L["Active Output Audio Device"] = "Dispositivo de salida activo"
L["Volume Streams"] = "Flujos de audio"
L["Left Click: Select Volume Stream"] = "Clic izquierdo: Seleccionar flujo"
L["Middle Click: Toggle Mute Master Stream"] = "Clic central: Silenciar flujo principal"
L["Shift + Middle Click: Toggle Volume Stream"] = "Shift + clic central: Alternar flujo"
L["Shift + Left Click: Open System Audio Panel"] = "Shift + clic izquierdo: Abrir panel de audio del sistema"
L["Shift + Right Click: Select Output Audio Device"] = "Shift + clic derecho: Seleccionar dispositivo de salida"

-- ----------------------------
-- Ara_Broker_Guild_Friends.lua
-- ----------------------------
L["Guild"] = "Hermandad"
L["No Guild"] = "Sin hermandad"
L["Friends"] = "Amigos"
L["<Mobile>"] = "<Móvil>"
L["Hints"] = "Sugerencias"
L["Block"] = "Bloquear"
L["Click"] = "Clic"
L["RightClick"] = "Clic derecho"
L["MiddleClick"] = "Clic central"
L["Modifier+Click"] = "Modificador+clic"
L["Shift+Click"] = "Shift+clic"
L["Shift+RightClick"] = "Shift+clic derecho"
L["Ctrl+Click"] = "Ctrl+clic"
L["Ctrl+RightClick"] = "Ctrl+clic derecho"
L["Alt+RightClick"] = "Alt+clic derecho"
L["Ctrl+MouseWheel"] = "Ctrl+rueda del ratón"
L["Button4"] = "Botón4"
L["to open panel."] = "para abrir el panel."
L["to display config menu."] = "para mostrar el menú de configuración."
L["to add a friend."] = "para agregar un amigo."
L["to toggle notes."] = "para alternar notas."
L["to whisper."] = "para susurrar."
L["to invite."] = "para invitar."
L["to query information."] = "para consultar información."
L["to edit note."] = "para editar nota."
L["to edit officer note."] = "para editar nota de oficial."
L["to remove friend."] = "para eliminar amigo."
L["to sort main column."] = "para ordenar columna principal."
L["to sort second column."] = "para ordenar segunda columna."
L["to sort third column."] = "para ordenar tercera columna."
L["to resize tooltip."] = "para redimensionar tooltip."
L["Mobile App"] = "App móvil"
L["Desktop App"] = "App de escritorio"
L["OFFLINE FAVORITE"] = "FAVORITO DESCONECTADO"
L["MOTD"] = "MOTD"
L["No friends online."] = "No hay amigos en línea."
L["Broadcast"] = "Transmisión"
L["Invalid scale.\nShould be a number between 70 and 200%"] = "Escala inválida.\nDebe estar entre 70 y 200%"
L["Set a custom tooltip scale.\nEnter a value between 70 and 200 (%%)."] = "Configurar escala personalizada del tooltip.\nIngresa un valor entre 70 y 200 (%%)."
L["Guild & Friends"] = "Hermandad y amigos"
L["Show guild name"] = "Mostrar nombre de hermandad"
L["Show 'Guild' tag"] = "Mostrar etiqueta 'Hermandad'"
L["Show total number of guildmates"] = "Mostrar número total de miembros"
L["Show 'Friends' tag"] = "Mostrar etiqueta 'Amigos'"
L["Show total number of friends"] = "Mostrar número total de amigos"
L["Show guild XP"] = "Mostrar XP de hermandad"
L["Show guild XP tooltip"] = "Mostrar tooltip de XP de hermandad"
L["Show own broadcast"] = "Mostrar transmisión propia"
L["Show bnet friends broadcast"] = "Mostrar transmisión de amigos de bnet"
L["Show guild notes"] = "Mostrar notas de hermandad"
L["Show friend notes"] = "Mostrar notas de amigos"
L["Show class icon when grouped"] = "Mostrar icono de clase en grupo"
L["Highlight sorted column"] = "Resaltar columna ordenada"
L["Simple"] = "Simple"
L["Gradient"] = "Degradado"
L["Reverse gradient"] = "Invertir degradado"
L["Status as..."] = "Estado como..."
L["Class colored text"] = "Texto con color de clase"
L["Custom colored text"] = "Texto con color personalizado"
L["Icon"] = "Icono"
L["Real ID..."] = "Real ID..."
L["Before nickname"] = "Antes del apodo"
L["Instead of nickname"] = "En lugar del apodo"
L["After nickname"] = "Después del apodo"
L["Don't show"] = "No mostrar"
L["Column alignments"] = "Alineación de columnas"
L["Name"] = "Nombre"
L["Zone"] = "Zona"
L["Notes"] = "Notas"
L["Rank"] = "Rango"
L["Tooltip Size"] = "Tamaño del tooltip"
L["90%"] = "90%"
L["100%"] = "100%"
L["110%"] = "110%"
L["120%"] = "120%"
L["Custom..."] = "Personalizado..."
L["Use TipTac skin (requires TipTac)"] = "Usar skin TipTac (requiere TipTac)"
L["Colors"] = "Colores"
L["Background"] = "Fondo"
L["Borders"] = "Bordes"
L["Order highlight"] = "Resaltar orden"
L["Headers"] = "Encabezados"
L["MotD / broadcast"] = "MotD / transmisión"
L["Friendly zone"] = "Zona amistosa"
L["Contested zone"] = "Zona disputada"
L["Enemy zone"] = "Zona enemiga"
L["Officer notes"] = "Notas de oficiales"
L["Status"] = "Estado"
L["Ranks"] = "Rangos"
L["Friends broadcast"] = "Transmisión de amigos"
L["Realms"] = "Reinos"
L["Restore default colors"] = "Restaurar colores por defecto"
L["Show Block Hints"] = "Mostrar sugerencias de bloque"
L["Open panel"] = "Abrir panel"
L["Config menu"] = "Menú de configuración"
L["Toggle notes"] = "Alternar notas"
L["Add a friend"] = "Agregar amigo"
L["Show Hints"] = "Mostrar sugerencias"
L["Whisper"] = "Susurrar"
L["Invite"] = "Invitar"
L["Query"] = "Consultar"
L["Edit note"] = "Editar nota"
L["Edit officer note"] = "Editar nota de oficial"
L["Sort main column"] = "Ordenar columna principal"
L["Sort second column"] = "Ordenar segunda columna"
L["Sort third column"] = "Ordenar tercera columna"
L["Resize tooltip"] = "Redimensionar tooltip"
L["Remove friend"] = "Eliminar amigo"
