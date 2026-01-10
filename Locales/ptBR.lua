local _, SDT = ...
local L = SDT.L

if GetLocale() ~= "ptBR" then
    return
end

-- ----------------------------
-- SimpleDatatexts.lua
-- ----------------------------
-- Used in: Settings.lua, SimpleDatatexts.lua
L["(empty)"] = "(vazio)"
L["Simple Datatexts loaded. Total modules:"] = "Simple Datatexts carregado. Módulos totais:"
L["Options"] = "Opções"
L["Lock/Unlock"] = "Bloquear/Desbloquear"
L["Width"] = "Largura"
L["Height"] = "Altura"
L["Scale"] = "Escala"
L["Settings"] = "Configurações"
L["Version"] = "Versão"
L["Usage"] = "Uso"
L["barName"] = "Nome da barra"
L["value"] = "valor"
L["Invalid panel name supplied. Valid panel names are:"] = "Nome de painel inválido. Nomes válidos são:"
L["A valid numeric value for the adjustment must be specified."] = "Um valor numérico válido deve ser especificado para o ajuste."
L["Invalid panel width specified."] = "Largura do painel inválida."
L["Invalid panel height specified."] = "Altura do painel inválida."
L["Invalid panel scale specified."] = "Escala do painel inválida."
L["Invalid adjustment type specified."] = "Tipo de ajuste inválido."
L["SDT panels are now"] = "Os painéis SDT agora estão"
L["LOCKED"] = "BLOQUEADOS"
L["UNLOCKED"] = "DESBLOQUEADOS"
L["Simple Datatexts Version"] = "Versão do Simple Datatexts"

-- ----------------------------
-- Settings.lua
-- ----------------------------
L["Simple DataTexts"] = "Simple DataTexts"
L["Global"] = "Global"
L["Simple DataTexts - Global Settings"] = "Simple DataTexts - Configurações Globais"
L["Panels"] = "Painéis"
L["Simple DataTexts - Panel Settings"] = "Simple DataTexts - Configurações de Painéis"
L["Experience Module"] = "Módulo de Experiência"
L["Simple DataTexts - Experience Settings"] = "Simple DataTexts - Configurações de Experiência"
L["Profiles"] = "Perfis"
L["Simple DataTexts - Profile Settings"] = "Simple DataTexts - Configurações de Perfis"
L["Lock Panels (disable movement)"] = "Bloquear painéis (desabilitar movimento)"
L["Show login message"] = "Mostrar mensagem de login"
L["Use Class Color"] = "Usar cor da classe"
L["Use 24Hr Clock"] = "Usar relógio 24h"
L["Use Custom Color"] = "Usar cor personalizada"
L["Display Font:"] = "Fonte de exibição:"
L["Font Size"] = "Tamanho da fonte"
L["Create New Panel"] = "Criar novo painel"
L["Select Panel:"] = "Selecionar painel:"
L["Rename Panel:"] = "Renomear painel:"
L["Remove Selected Panel"] = "Remover painel selecionado"
L["Slot %d:"] = "Slot %d:"
L["Scale"] = "Escala"
L["Background Opacity"] = "Opacidade do fundo"
L["Slots"] = "Slots"
L["Width"] = "Largura"
L["Height"] = "Altura"
L["Select Border:"] = "Selecionar borda:"
L["Border Size"] = "Tamanho da borda"
L["Are you sure you want to delete this bar?\nThis action cannot be undone."] = "Tem certeza de que deseja excluir esta barra?\nEsta ação não pode ser desfeita."
L["Yes"] = "Sim"
L["No"] = "Não"
L["(none)"] = "(nenhum)"
L["Display Format:"] = "Formato de Exibição:"
L["Show Bar"] = "Mostrar Barra"
L["Hide Blizzard XP Bar"] = "Ocultar barra de XP da Blizzard"
L["Bar Height (%)"] = "Altura da Barra (%)"
L["Bar Font Size"] = "Tamanho da Fonte da Barra"
L["Bar Color:"] = "Cor da Barra:"
L["Bar Text Color:"] = "Cor do Texto da Barra:"
L["Create New Profile:"] = "Criar novo perfil:"
L["Current Profile:"] = "Perfil atual:"
L["Enable Per-Spec Profiles"] = "Ativar perfis por especialização"
L["Copy Profile:"] = "Copiar perfil:"
L["Delete Profile:"] = "Excluir perfil:"
L["NYI:"] = "Ainda não disponível:"
L["The profile name you have entered already exists. Please enter a new name."] = "O nome do perfil já existe. Insira um novo nome."
L["Ok"] = "OK"
L["Saved font not found. Resetting font to Friz Quadrata TT."] = "Fonte salva não encontrada. Restaurando para Friz Quadrata TT."

-- ----------------------------
-- Utilities.lua
-- ----------------------------
L["Are you sure you want to overwrite your\n'%s' profile?\nThis action cannot be undone."] = "Tem certeza de que deseja sobrescrever o perfil\n'%s'?\nEsta ação não pode ser desfeita."
L["You cannot copy the active profile onto itself. Please change your active profile first."] = "Você não pode copiar o perfil ativo sobre ele mesmo. Altere o perfil ativo primeiro."
L["Invalid source profile specified."] = "Perfil de origem inválido."
L["You cannot delete the active profile. Please change your active profile first."] = "Você não pode excluir o perfil ativo. Altere o perfil ativo primeiro."
L["Are you sure you want to delete this profile?\nThis action cannot be undone."] = "Tem certeza de que deseja excluir este perfil?\nEsta ação não pode ser desfeita."

-- ----------------------------
-- modules/Armor.lua
-- ----------------------------
L["Mitigation By Level:"] = "Mitigação por nível:"
L["Level %d"] = "Nível %d"
L["Target Mitigation"] = "Mitigação do alvo"

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
L["CURRENCIES"] = "MOEDAS"
-- Used in: modules/Currency.lua, modules/Gold.lua
L["GOLD"] = "OURO"

-- ----------------------------
-- modules/Durability.lua
-- ----------------------------
L["Durability:"] = "Durabilidade:"

-------------------------------
-- modules/Experience.lua
-------------------------------
L["Max Level"] = "Nível Máximo"
L["N/A"] = "N/D"
L["Experience"] = "Experiência"
L["Configure in settings"] = "Configurar nas definições"

-- ----------------------------
-- modules/Friends.lua
-- ----------------------------
L["Ara Friends LDB object not found! SDT Friends datatext disabled."] = "Objeto LDB Ara Friends não encontrado! Datatext Amigos SDT desativado."

-- ----------------------------
-- modules/Gold.lua
-- ----------------------------
L["Session:"] = "Sessão:"
L["Earned:"] = "Ganho:"
L["Spent:"] = "Gasto:"
L["Profit:"] = "Lucro:"
L["Deficit:"] = "Déficit:"
L["Character:"] = "Personagem:"
L["Server:"] = "Servidor:"
L["Alliance:"] = "Aliança:"
L["Horde:"] = "Horda:"
L["Total:"] = "Total:"
L["Warband:"] = "Grupo de guerra:"
L["WoW Token:"] = "Token WoW:"
L["Reset Session Data: Hold Ctrl + Right Click"] = "Redefinir dados da sessão: Segure Ctrl + clique direito"

-- ----------------------------
-- modules/Guild.lua
-- ----------------------------
L["Ara Guild LDB object not found! SDT Guild datatext disabled."] = "Objeto LDB Ara Guild não encontrado! Datatext Guilda SDT desativado."

-- ----------------------------
-- modules/Haste.lua
-- ----------------------------
L["Haste:"] = "Aceleração:"

-- ----------------------------
-- modules/LDBObjects.lua
-- ----------------------------
L["NO TEXT"] = "SEM TEXTO"

-- ----------------------------
-- modules/Mail.lua
-- ----------------------------
L["New Mail"] = "Nova mensagem"
L["No Mail"] = "Sem mensagens"

-- ----------------------------
-- modules/Mastery.lua
-- ----------------------------
L["Mastery:"] = "Maestria:"

-- ----------------------------
-- modules/SpecSwitch.lua
-- ----------------------------
L["Active"] = "Ativo"
L["Inactive"] = "Inativo"
L["Loadouts"] = "Configurações"
L["Failed to load Blizzard_PlayerSpells: %s"] = "Falha ao carregar Blizzard_PlayerSpells: %s"
L["Starter Build"] = "Build inicial"
L["Spec"] = "Spec"
L["Left Click: Change Talent Specialization"] = "Clique esquerdo: alterar especialização de talentos"
L["Control + Left Click: Change Loadout"] = "Ctrl + clique esquerdo: alterar configuração"
L["Shift + Left Click: Show Talent Specialization UI"] = "Shift + clique esquerdo: mostrar interface de especialização"
L["Shift + Right Click: Change Loot Specialization"] = "Shift + clique direito: alterar especialização de saque"

-- ----------------------------
-- modules/System.lua
-- ----------------------------
L["MB_SUFFIX"] = "MB"
L["KB_SUFFIX"] = "KB"
L["SYSTEM"] = "SISTEMA"
L["FPS:"] = "FPS:"
L["Home Latency:"] = "Latência local:"
L["World Latency:"] = "Latência global:"
L["Total Memory:"] = "Memória total:"
L["(Shift Click) Collect Garbage"] = "(Shift + Clique) Limpar memória"
L["FPS"] = "FPS"
L["MS"] = "MS"

-- ----------------------------
-- modules/Time.lua
-- ----------------------------
L["TIME"] = "TEMPO"
L["Saved Raid(s)"] = "Raids salvos"
L["Saved Dungeon(s)"] = "Masmorras salvas"

-- ----------------------------
-- modules/Versatility.lua
-- ----------------------------
L["Vers:"] = "Vers:"

-- ----------------------------
-- modules/Volume.lua
-- ----------------------------
L["Select Volume Stream"] = "Selecionar stream de volume"
L["Toggle Volume Stream"] = "Ativar/desativar stream de volume"
L["Output Audio Device"] = "Dispositivo de áudio de saída"
L["Active Output Audio Device"] = "Dispositivo de áudio de saída ativo"
L["Volume Streams"] = "Streams de volume"
L["Left Click: Select Volume Stream"] = "Clique esquerdo: selecionar stream de volume"
L["Middle Click: Toggle Mute Master Stream"] = "Clique do meio: silenciar stream principal"
L["Shift + Middle Click: Toggle Volume Stream"] = "Shift + clique do meio: ativar/desativar stream de volume"
L["Shift + Left Click: Open System Audio Panel"] = "Shift + clique esquerdo: abrir painel de áudio do sistema"
L["Shift + Right Click: Select Output Audio Device"] = "Shift + clique direito: selecionar dispositivo de saída de áudio"

-- ----------------------------
-- Ara_Broker_Guild_Friends.lua
-- ----------------------------
L["Guild"] = "Guilda"
L["No Guild"] = "Sem guilda"
L["Friends"] = "Amigos"
L["<Mobile>"] = "<Mobile>"
L["Hints"] = "Dicas"
L["Block"] = "Bloquear"
L["Click"] = "Clique"
L["RightClick"] = "Clique direito"
L["MiddleClick"] = "Clique do meio"
L["Modifier+Click"] = "Modificador+Clique"
L["Shift+Click"] = "Shift+Clique"
L["Shift+RightClick"] = "Shift+Clique direito"
L["Ctrl+Click"] = "Ctrl+Clique"
L["Ctrl+RightClick"] = "Ctrl+Clique direito"
L["Alt+RightClick"] = "Alt+Clique direito"
L["Ctrl+MouseWheel"] = "Ctrl+Roda do mouse"
L["Button4"] = "Botão4"
L["to open panel."] = "para abrir o painel."
L["to display config menu."] = "para exibir o menu de configuração."
L["to add a friend."] = "para adicionar um amigo."
L["to toggle notes."] = "para mostrar/ocultar notas."
L["to whisper."] = "para sussurrar."
L["to invite."] = "para convidar."
L["to query information."] = "para consultar informações."
L["to edit note."] = "para editar nota."
L["to edit officer note."] = "para editar nota de oficial."
L["to remove friend."] = "para remover amigo."
L["to sort main column."] = "para ordenar coluna principal."
L["to sort second column."] = "para ordenar segunda coluna."
L["to sort third column."] = "para ordenar terceira coluna."
L["to resize tooltip."] = "para redimensionar tooltip."
L["Mobile App"] = "App móvel"
L["Desktop App"] = "App desktop"
L["OFFLINE FAVORITE"] = "FAVORITO OFFLINE"
L["MOTD"] = "MdD"
L["No friends online."] = "Nenhum amigo online."
L["Broadcast"] = "Broadcast"
L["Invalid scale.\nShould be a number between 70 and 200%"] = "Escala inválida.\nDeve ser um número entre 70 e 200%"
L["Set a custom tooltip scale.\nEnter a value between 70 and 200 (%%)."] = "Defina uma escala de tooltip personalizada.\nInsira um valor entre 70 e 200 (%%)."
L["Guild & Friends"] = "Guilda e amigos"
L["Show guild name"] = "Mostrar nome da guilda"
L["Show 'Guild' tag"] = "Mostrar etiqueta 'Guilda'"
L["Show total number of guildmates"] = "Mostrar número total de membros da guilda"
L["Show 'Friends' tag"] = "Mostrar etiqueta 'Amigos'"
L["Show total number of friends"] = "Mostrar número total de amigos"
L["Show guild XP"] = "Mostrar XP da guilda"
L["Show guild XP tooltip"] = "Mostrar tooltip de XP da guilda"
L["Show own broadcast"] = "Mostrar seu broadcast"
L["Show bnet friends broadcast"] = "Mostrar broadcast de amigos Battle.net"
L["Show guild notes"] = "Mostrar notas da guilda"
L["Show friend notes"] = "Mostrar notas de amigos"
L["Show class icon when grouped"] = "Mostrar ícone da classe em grupo"
L["Highlight sorted column"] = "Destacar coluna ordenada"
L["Simple"] = "Simples"
L["Gradient"] = "Gradiente"
L["Reverse gradient"] = "Gradiente invertido"
L["Status as..."] = "Status como..."
L["Class colored text"] = "Texto colorido por classe"
L["Custom colored text"] = "Texto com cor personalizada"
L["Icon"] = "Ícone"
L["Real ID..."] = "ID real..."
L["Before nickname"] = "Antes do apelido"
L["Instead of nickname"] = "No lugar do apelido"
L["After nickname"] = "Depois do apelido"
L["Don't show"] = "Não mostrar"
L["Column alignments"] = "Alinhamento das colunas"
L["Name"] = "Nome"
L["Zone"] = "Zona"
L["Notes"] = "Notas"
L["Rank"] = "Rank"
L["Tooltip Size"] = "Tamanho do tooltip"
L["90%"] = "90%"
L["100%"] = "100%"
L["110%"] = "110%"
L["120%"] = "120%"
L["Custom..."] = "Personalizado..."
L["Use TipTac skin (requires TipTac)"] = "Usar skin TipTac (requer TipTac)"
L["Colors"] = "Cores"
L["Background"] = "Fundo"
L["Borders"] = "Bordas"
L["Order highlight"] = "Destacar ordenação"
L["Headers"] = "Cabeçalhos"
L["MotD / broadcast"] = "MdD / broadcast"
L["Friendly zone"] = "Zona amiga"
L["Contested zone"] = "Zona contestada"
L["Enemy zone"] = "Zona inimiga"
L["Officer notes"] = "Notas de oficial"
L["Status"] = "Status"
L["Ranks"] = "Ranks"
L["Friends broadcast"] = "Broadcast de amigos"
L["Realms"] = "Reinos"
L["Restore default colors"] = "Restaurar cores padrão"
L["Show Block Hints"] = "Mostrar dicas do bloco"
L["Open panel"] = "Abrir painel"
L["Config menu"] = "Menu de configuração"
L["Toggle notes"] = "Mostrar/ocultar notas"
L["Add a friend"] = "Adicionar amigo"
L["Show Hints"] = "Mostrar dicas"
L["Whisper"] = "Sussurrar"
L["Invite"] = "Convidar"
L["Query"] = "Consultar"
L["Edit note"] = "Editar nota"
L["Edit officer note"] = "Editar nota de oficial"
L["Sort main column"] = "Ordenar coluna principal"
L["Sort second column"] = "Ordenar segunda coluna"
L["Sort third column"] = "Ordenar terceira coluna"
L["Resize tooltip"] = "Redimensionar tooltip"
L["Remove friend"] = "Remover amigo"
