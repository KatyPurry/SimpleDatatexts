local _, SDT = ...
local L = SDT.L

if GetLocale() ~= "ruRU" then
    return
end

-- ----------------------------
-- SimpleDatatexts.lua
-- ----------------------------
-- Used in: Settings.lua, SimpleDatatexts.lua
L["(empty)"] = "(пусто)"
L["Simple Datatexts loaded. Total modules:"] = "Simple Datatexts загружен. Всего модулей:"
L["Options"] = "Настройки"
L["Lock/Unlock"] = "Заблокировать/Разблокировать"
L["Width"] = "Ширина"
L["Height"] = "Высота"
L["Scale"] = "Масштаб"
L["Settings"] = "Настройки"
L["Version"] = "Версия"
L["Usage"] = "Использование"
L["barName"] = "Имя панели"
L["value"] = "значение"
L["Invalid panel name supplied. Valid panel names are:"] = "Указано недопустимое имя панели. Допустимые имена:"
L["A valid numeric value for the adjustment must be specified."] = "Необходимо указать допустимое числовое значение для настройки."
L["Invalid panel width specified."] = "Указана недопустимая ширина панели."
L["Invalid panel height specified."] = "Указана недопустимая высота панели."
L["Invalid panel scale specified."] = "Указан недопустимый масштаб панели."
L["Invalid adjustment type specified."] = "Указан недопустимый тип настройки."
L["SDT panels are now"] = "Панели SDT теперь"
L["LOCKED"] = "ЗАБЛОКИРОВАНЫ"
L["UNLOCKED"] = "РАЗБЛОКИРОВАНЫ"
L["Simple Datatexts Version"] = "Версия Simple Datatexts"

-- ----------------------------
-- Settings.lua
-- ----------------------------
L["Simple DataTexts"] = "Simple DataTexts"
L["Global"] = "Глобальные"
L["Simple DataTexts - Global Settings"] = "Simple DataTexts - Глобальные настройки"
L["Panels"] = "Панели"
L["Simple DataTexts - Panel Settings"] = "Simple DataTexts - Настройки панелей"
L["Experience Module"] = "Модуль Опыта"
L["Simple DataTexts - Experience Settings"] = "Simple DataTexts - Настройки Опыта"
L["Profiles"] = "Профили"
L["Simple DataTexts - Profile Settings"] = "Simple DataTexts - Настройки профилей"
L["Lock Panels (disable movement)"] = "Блокировать панели (отключить перемещение)"
L["Show login message"] = "Показывать сообщение при входе"
L["Use Class Color"] = "Использовать цвет класса"
L["Use 24Hr Clock"] = "Использовать 24-часовой формат"
L["Use Custom Color"] = "Использовать пользовательский цвет"
L["Display Font:"] = "Шрифт:"
L["Font Size"] = "Размер шрифта"
L["Create New Panel"] = "Создать новую панель"
L["Select Panel:"] = "Выбрать панель:"
L["Rename Panel:"] = "Переименовать панель:"
L["Remove Selected Panel"] = "Удалить выбранную панель"
L["Slot %d:"] = "Слот %d:"
L["Scale"] = "Масштаб"
L["Background Opacity"] = "Прозрачность фона"
L["Slots"] = "Слоты"
L["Width"] = "Ширина"
L["Height"] = "Высота"
L["Select Border:"] = "Выбрать рамку:"
L["Border Size"] = "Размер рамки"
L["Are you sure you want to delete this bar?\nThis action cannot be undone."] = "Вы уверены, что хотите удалить эту панель?\nЭто действие нельзя отменить."
L["Yes"] = "Да"
L["No"] = "Нет"
L["(none)"] = "(нет)"
L["Display Format:"] = "Формат Отображения:"
L["Show Bar"] = "Показать Полосу"
L["Hide Blizzard XP Bar"] = "Скрыть полосу опыта Blizzard"
L["Bar Height (%)"] = "Высота Полосы (%)"
L["Bar Font Size"] = "Размер Шрифта Полосы"
L["Bar Color:"] = "Цвет Полосы:"
L["Bar Text Color:"] = "Цвет Текста Полосы:"
L["Create New Profile:"] = "Создать новый профиль:"
L["Current Profile:"] = "Текущий профиль:"
L["Enable Per-Spec Profiles"] = "Включить профили по специализации"
L["Copy Profile:"] = "Скопировать профиль:"
L["Delete Profile:"] = "Удалить профиль:"
L["NYI:"] = "Будет добавлено:"
L["The profile name you have entered already exists. Please enter a new name."] = "Имя профиля уже существует. Введите новое имя."
L["Ok"] = "OK"
L["Saved font not found. Resetting font to Friz Quadrata TT."] = "Сохранённый шрифт не найден. Сброс на Friz Quadrata TT."

-- ----------------------------
-- Utilities.lua
-- ----------------------------
L["Are you sure you want to overwrite your\n'%s' profile?\nThis action cannot be undone."] = "Вы уверены, что хотите перезаписать профиль\n'%s'?\nЭто действие нельзя отменить."
L["You cannot copy the active profile onto itself. Please change your active profile first."] = "Нельзя копировать активный профиль на самого себя. Сначала измените активный профиль."
L["Invalid source profile specified."] = "Указан недопустимый исходный профиль."
L["You cannot delete the active profile. Please change your active profile first."] = "Нельзя удалить активный профиль. Сначала измените активный профиль."
L["Are you sure you want to delete this profile?\nThis action cannot be undone."] = "Вы уверены, что хотите удалить этот профиль?\nЭто действие нельзя отменить."

-- ----------------------------
-- modules/Armor.lua
-- ----------------------------
L["Mitigation By Level:"] = "Снижение урона по уровням:"
L["Level %d"] = "Уровень %d"
L["Target Mitigation"] = "Снижение урона цели"

-- ----------------------------
-- modules/Bags.lua
-- ----------------------------
L["Bags"] = "Сумки"

-- ----------------------------
-- modules/Crit.lua
-- ----------------------------
L["Crit"] = "Крит"

-- ----------------------------
-- modules/Currency.lua
-- ----------------------------
L["CURRENCIES"] = "ВАЛЮТЫ"
-- Used in: modules/Currency.lua, modules/Gold.lua
L["GOLD"] = "ЗОЛОТО"

-- ----------------------------
-- modules/Durability.lua
-- ----------------------------
L["Durability:"] = "Прочность:"

-------------------------------
-- modules/Experience.lua
-------------------------------
L["Max Level"] = "Максимальный Уровень"
L["N/A"] = "Н/Д"
L["Experience"] = "Опыт"
L["Configure in settings"] = "Настроить в параметрах"

-- ----------------------------
-- modules/Friends.lua
-- ----------------------------
L["Ara Friends LDB object not found! SDT Friends datatext disabled."] = "Объект LDB Ara Friends не найден! Datatext Друзья SDT отключён."

-- ----------------------------
-- modules/Gold.lua
-- ----------------------------
L["Session:"] = "Сессия:"
L["Earned:"] = "Заработано:"
L["Spent:"] = "Потрачено:"
L["Profit:"] = "Прибыль:"
L["Deficit:"] = "Дефицит:"
L["Character:"] = "Персонаж:"
L["Server:"] = "Сервер:"
L["Alliance:"] = "Альянс:"
L["Horde:"] = "Орда:"
L["Total:"] = "Итого:"
L["Warband:"] = "Боевой отряд:"
L["WoW Token:"] = "Токен WoW:"
L["Reset Session Data: Hold Ctrl + Right Click"] = "Сбросить данные сессии: удерживайте Ctrl + правая кнопка мыши"

-- ----------------------------
-- modules/Guild.lua
-- ----------------------------
L["Ara Guild LDB object not found! SDT Guild datatext disabled."] = "Объект LDB Ara Guild не найден! Datatext Гильдия SDT отключён."

-- ----------------------------
-- modules/Haste.lua
-- ----------------------------
L["Haste:"] = "Скорость:"

-- ----------------------------
-- modules/LDBObjects.lua
-- ----------------------------
L["NO TEXT"] = "НЕТ ТЕКСТА"

-- ----------------------------
-- modules/Mail.lua
-- ----------------------------
L["New Mail"] = "Новая почта"
L["No Mail"] = "Нет писем"

-- ----------------------------
-- modules/Mastery.lua
-- ----------------------------
L["Mastery:"] = "Мастерство:"

-- ----------------------------
-- modules/SpecSwitch.lua
-- ----------------------------
L["Active"] = "Активен"
L["Inactive"] = "Неактивен"
L["Loadouts"] = "Сборки"
L["Failed to load Blizzard_PlayerSpells: %s"] = "Не удалось загрузить Blizzard_PlayerSpells: %s"
L["Starter Build"] = "Начальная сборка"
L["Spec"] = "Спек"
L["Left Click: Change Talent Specialization"] = "Левый клик: изменить специализацию талантов"
L["Control + Left Click: Change Loadout"] = "Ctrl + левый клик: изменить сборку"
L["Shift + Left Click: Show Talent Specialization UI"] = "Shift + левый клик: открыть интерфейс специализации"
L["Shift + Right Click: Change Loot Specialization"] = "Shift + правый клик: изменить специализацию добычи"

-- ----------------------------
-- modules/System.lua
-- ----------------------------
L["MB_SUFFIX"] = "МБ"
L["KB_SUFFIX"] = "КБ"
L["SYSTEM"] = "СИСТЕМА"
L["FPS:"] = "FPS:"
L["Home Latency:"] = "Локальная задержка:"
L["World Latency:"] = "Глобальная задержка:"
L["Total Memory:"] = "Всего памяти:"
L["(Shift Click) Collect Garbage"] = "(Shift + клик) Очистить память"
L["FPS"] = "FPS"
L["MS"] = "мс"

-- ----------------------------
-- modules/Time.lua
-- ----------------------------
L["TIME"] = "ВРЕМЯ"
L["Saved Raid(s)"] = "Сохранённые рейды"
L["Saved Dungeon(s)"] = "Сохранённые подземелья"

-- ----------------------------
-- modules/Versatility.lua
-- ----------------------------
L["Vers:"] = "Универс:"

-- ----------------------------
-- modules/Volume.lua
-- ----------------------------
L["Select Volume Stream"] = "Выбрать поток громкости"
L["Toggle Volume Stream"] = "Включить/выключить поток громкости"
L["Output Audio Device"] = "Устройство вывода звука"
L["Active Output Audio Device"] = "Активное устройство вывода"
L["Volume Streams"] = "Потоки громкости"
L["Left Click: Select Volume Stream"] = "Левый клик: выбрать поток громкости"
L["Middle Click: Toggle Mute Master Stream"] = "Средний клик: включить/выключить основной поток"
L["Shift + Middle Click: Toggle Volume Stream"] = "Shift + средний клик: включить/выключить поток громкости"
L["Shift + Left Click: Open System Audio Panel"] = "Shift + левый клик: открыть аудиопанель системы"
L["Shift + Right Click: Select Output Audio Device"] = "Shift + правый клик: выбрать устройство вывода"

-- ----------------------------
-- Ara_Broker_Guild_Friends.lua
-- ----------------------------
L["Guild"] = "Гильдия"
L["No Guild"] = "Нет гильдии"
L["Friends"] = "Друзья"
L["<Mobile>"] = "<Мобильный>"
L["Hints"] = "Подсказки"
L["Block"] = "Блокировать"
L["Click"] = "Клик"
L["RightClick"] = "Правый клик"
L["MiddleClick"] = "Средний клик"
L["Modifier+Click"] = "Модификатор+клик"
L["Shift+Click"] = "Shift+клик"
L["Shift+RightClick"] = "Shift+правый клик"
L["Ctrl+Click"] = "Ctrl+клик"
L["Ctrl+RightClick"] = "Ctrl+правый клик"
L["Alt+RightClick"] = "Alt+правый клик"
L["Ctrl+MouseWheel"] = "Ctrl+колёсико мыши"
L["Button4"] = "Кнопка4"
L["to open panel."] = "для открытия панели."
L["to display config menu."] = "для отображения меню настроек."
L["to add a friend."] = "для добавления друга."
L["to toggle notes."] = "для отображения/скрытия заметок."
L["to whisper."] = "для шёпота."
L["to invite."] = "для приглашения."
L["to query information."] = "для запроса информации."
L["to edit note."] = "для редактирования заметки."
L["to edit officer note."] = "для редактирования заметки офицера."
L["to remove friend."] = "для удаления друга."
L["to sort main column."] = "для сортировки основной колонки."
L["to sort second column."] = "для сортировки второй колонки."
L["to sort third column."] = "для сортировки третьей колонки."
L["to resize tooltip."] = "для изменения размера подсказки."
L["Mobile App"] = "Мобильное приложение"
L["Desktop App"] = "Десктоп приложение"
L["OFFLINE FAVORITE"] = "ИЗБРАННОЕ ОФФЛАЙН"
L["MOTD"] = "СД" -- Short for "Сообщение дня".
L["No friends online."] = "Друзей онлайн нет."
L["Broadcast"] = "Трансляция"
L["Invalid scale.\nShould be a number between 70 and 200%"] = "Недопустимый масштаб.\nДолжно быть число от 70 до 200%"
L["Set a custom tooltip scale.\nEnter a value between 70 and 200 (%%)."] = "Установите пользовательский масштаб подсказки.\nВведите значение от 70 до 200 (%%)."
L["Guild & Friends"] = "Гильдия и друзья"
L["Show guild name"] = "Показать имя гильдии"
L["Show 'Guild' tag"] = "Показать метку 'Гильдия'"
L["Show total number of guildmates"] = "Показать общее количество членов гильдии"
L["Show 'Friends' tag"] = "Показать метку 'Друзья'"
L["Show total number of friends"] = "Показать общее количество друзей"
L["Show guild XP"] = "Показать опыт гильдии"
L["Show guild XP tooltip"] = "Показать подсказку опыта гильдии"
L["Show own broadcast"] = "Показать свои трансляции"
L["Show bnet friends broadcast"] = "Показать трансляции друзей Battle.net"
L["Show guild notes"] = "Показать заметки гильдии"
L["Show friend notes"] = "Показать заметки друзей"
L["Show class icon when grouped"] = "Показывать иконку класса в группе"
L["Highlight sorted column"] = "Выделять отсортированную колонку"
L["Simple"] = "Просто"
L["Gradient"] = "Градиент"
L["Reverse gradient"] = "Обратный градиент"
L["Status as..."] = "Статус как..."
L["Class colored text"] = "Текст цветом класса"
L["Custom colored text"] = "Текст пользовательского цвета"
L["Icon"] = "Иконка"
L["Real ID..."] = "Real ID..."
L["Before nickname"] = "Перед ником"
L["Instead of nickname"] = "Вместо ника"
L["After nickname"] = "После ника"
L["Don't show"] = "Не показывать"
L["Column alignments"] = "Выравнивание колонок"
L["Name"] = "Имя"
L["Zone"] = "Зона"
L["Notes"] = "Заметки"
L["Rank"] = "Ранг"
L["Tooltip Size"] = "Размер подсказки"
L["90%"] = "90%"
L["100%"] = "100%"
L["110%"] = "110%"
L["120%"] = "120%"
L["Custom..."] = "Пользовательский..."
L["Use TipTac skin (requires TipTac)"] = "Использовать тему TipTac (требуется TipTac)"
L["Colors"] = "Цвета"
L["Background"] = "Фон"
L["Borders"] = "Границы"
L["Order highlight"] = "Выделение порядка"
L["Headers"] = "Заголовки"
L["MotD / broadcast"] = "Сообщение дня / трансляция"
L["Friendly zone"] = "Дружественная зона"
L["Contested zone"] = "Оспариваемая зона"
L["Enemy zone"] = "Вражеская зона"
L["Officer notes"] = "Заметки офицера"
L["Status"] = "Статус"
L["Ranks"] = "Ранги"
L["Friends broadcast"] = "Трансляции друзей"
L["Realms"] = "Серверы"
L["Restore default colors"] = "Восстановить стандартные цвета"
L["Show Block Hints"] = "Показать подсказки блока"
L["Open panel"] = "Открыть панель"
L["Config menu"] = "Меню настроек"
L["Toggle notes"] = "Показать/скрыть заметки"
L["Add a friend"] = "Добавить друга"
L["Show Hints"] = "Показать подсказки"
L["Whisper"] = "Шёпот"
L["Invite"] = "Пригласить"
L["Query"] = "Запрос"
L["Edit note"] = "Редактировать заметку"
L["Edit officer note"] = "Редактировать заметку офицера"
L["Sort main column"] = "Сортировать основную колонку"
L["Sort second column"] = "Сортировать вторую колонку"
L["Sort third column"] = "Сортировать третью колонку"
L["Resize tooltip"] = "Изменить размер подсказки"
L["Remove friend"] = "Удалить друга"
