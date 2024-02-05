Config          = Config or {}
Config.KeyBinds = {
    Open = {
        Bind = "F1",
        Description = "Open your phone"
    },
    FlipPhone = {
        Bind = "SLASH", -- RIGHT / - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Toggle flip(close/open) phone"
    },
    Focus = {
        Bind = 19, -- Left alt - https://docs.fivem.net/docs/game-references/controls/#controls -- use control index
        Description = "Toggle cursor focus"
    },
    AnswerCall = {
        Bind = "RETURN", -- Enter - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Answer call"
    },
    CancelCall = {
        Bind = "BACK", -- Backspace - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        Description = "Cancel call"
    },

    TakePhoto = {
        Bind = "RETURN",        -- Enter - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Enter", -- Used in the camera app info popup
        Description = "Take a photo"
    },
    RotateCamera = {
        Bind = "UP",               -- ArrowUp - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Arrow Up", -- Used in the camera app info popup
        Description = "Rotate camera"
    },
    MoveCamera = {
        Bind = "LMENU",            -- Left alt - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Left Alt", -- Used in the camera app info popup
        Description = "Toggle camera focus"
    },
    CloseCamera = {
        Bind = "BACK",              -- Backspace - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        DisplayValue = "Backspace", -- Used in the camera app info popup
        Description = "Close camera"
    },

    UnlockPhone = { -- https://www.toptal.com/developers/keycode -- get `event.code`
        Bind = "Space",
        Description = "Unlock phone",
    }
}
