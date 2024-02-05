Config = Config or {}

----------------------------------------------------------------------------------------------------
-- # BACKGROUND SECTION # --
----------------------------------------------------------------------------------------------------
-- Allows you to set the preferred background Color from a list of available options.
Config.Background = "background_blue"

-- Available Options --
-- background_blue
-- background_darkblue
-- background_darkerblue
-- background_darkgreen
-- background_green
-- background_other
-- background_pink
-- background_projectsloth
-- background_red
-- background_yellow

-- Allows you to change the opactiy of the Background
Config.Opacity = 100

----------------------------------------------------------------------------------------------------
-- # HEADER and OPTIONS SECTION # --
----------------------------------------------------------------------------------------------------

Config.Header = {
    -- LEFT MENU CONFIG
    ["TITLE"] = "Bulgar OG",
    ["SUBTITLE"] = "",

    ["MAP"] = "Карта",
    ["GAME"] = "Изход",
    ["LEAVE"] = "Изход към сървър лист",
    ["QUIT"] = "Изход към десктоп",
    ["INFO"] = "Информация",
    ["STATS"] = "Статистика",
    ["SETTINGS"] = "Настройки",
    ["GALLERY"] = "Галерия",
    ["KEYBIND"] = "Основни Бутони",
    ["EDITOR"] = "Rockstar Editor",

    -- RIGHT MENU CONFIG
    ["SERVER_NAME"] = "Bulgar OG",
    ["SERVER_TEXT"] = "ЩО ЧЕТЕШ ТУК?",
    ["SERVER_DISCORD"] = "https://discord.gg/bulgarog"
}

Config.Quotes = {
    "Когато човек силно желае нещо, цялата Вселена му съдейства.",
    "Който не умее да мълчи, той не е способен и да говори.",
    "Приятелят трябва да е специалист по досещане и запазване на спокойствие.",
    "Някои хора градят своето бъдеще, докато повечето хора само го чакат да дойде.",
    "Любовта не се изразява в това да се взираме един в друг, а да гледаме в една и съща посока.",
    "Бурята, която разклаща гнездото ти, те научава как да летиш.",
    "Любовта не доминира, тя култивира.",
    "На най-важните житейски кръстопътища няма никакви пътни знаци.",
    "Бъдещето зависи от това, какво правим в момента.",
    "За величието на великите хора се съди по отношението им към по-малките."
}

--Allows you to Change the Colour ( Use this Website: https://rgbacolorpicker.com/ )
Config.RGBA = {
    LINE = { -- Line over the Options
        ["RED"] = 31,
        ["GREEN"] = 90,
        ["BLUE"] = 128,
        ["ALPHA"] = 255,
    },
    STYLE = { -- Pause Menu Options
        ["RED"] = 0,
        ["GREEN"] = 0,
        ["BLUE"] = 0,
        ["ALPHA"] = 186,
    },
    WAYPOINT = { -- Waypoint
        ["RED"] = 56,
        ["GREEN"] = 162,
        ["BLUE"] = 229,
        ["ALPHA"] = 255,
    },
}
