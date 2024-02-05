Config          = Config or {}
Config.KeyBinds = {
    Open = {
        Bind = "M",
        Description = "Отворяне на телефон"
    },
    FlipPhone = {
        Bind = "SLASH", -- RIGHT / - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Обръщане на телефона (Затваряне/Отваряне)"
    },
    Focus = {
        Bind = 19, -- Left alt - https://docs.fivem.net/docs/game-references/controls/#controls -- use control index
        Description = "Фокус на курсора"
    },
    AnswerCall = {
        Bind = "RETURN", -- Enter - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Отговоряне на повикване"
    },
    CancelCall = {
        Bind = "BACK", -- Backspace - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Отмяна на повикване"
    },

    TakePhoto = {
        Bind = "RETURN",        -- Enter - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Enter", -- Used in the camera app info popup
        Description = "Снимай"
    },
    RotateCamera = {
        Bind = "UP",               -- ArrowUp - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Arrow Up", -- Used in the camera app info popup
        Description = "Завъртане камера"
    },
    MoveCamera = {
        Bind = "LMENU",            -- Left alt - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Left Alt", -- Used in the camera app info popup
        Description = "Фокус на камера"
    },
    CloseCamera = {
        Bind = "BACK",              -- Backspace - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Backspace", -- Used in the camera app info popup
        Description = "Затворяне на камера"
    },

    UnlockPhone = { -- https://www.toptal.com/developers/keycode -- get `event.code`
        Bind = "Space",
        Description = "Отключване на телефона",
    }
}
