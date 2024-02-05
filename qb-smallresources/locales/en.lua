local Translations = {
    command = {
        name = "topmoney",
        help = "Get money of top players",
    },
    message = {
        top_without_license = "%{name} (%{citizenid}) | %{money} | TOTAL MONEY: $%{totalMoney}`\n", --DO NOT REMOVE "`" AT THE END OF THIS STRING
        top_with_license = "%{name} (%{citizenid}) | %{license} | %{money} | TOTAL MONEY: $%{totalMoney}`\n", --DO NOT REMOVE "`" AT THE END OF THIS STRING
        short_top_message = "%{name} (%{citizenid}) | TOTAL MONEY: $%{totalMoney}`\n", --DO NOT REMOVE "`" AT THE END OF THIS STRING
    },
    afk = {
        will_kick = 'Вие сте афк и ще бъдете кикнат след ',
        time_seconds = ' секунди!',
        time_minutes = ' минута/минути!',
        kick_message = 'Бяхте кикнати за седене на едно място'
    },
    wash = {
        in_progress = "Превозното средство се измива...",
        wash_vehicle = "[E] за да измиеш превозното средство",
        wash_vehicle_target = "Измийте превозното средство",
        dirty = "Това превозно средство не е мръсно",
        cancel = "Измиването беше прекъснато..."
    },
    consumables = {
        eat_progress = "Ядеш...",
        drink_progress = "Пиеш...",
        liqour_progress = "Пиеш ликьор..",
        coke_progress = "Бърза линия...",
        crack_progress = "Пушиш яко...",
        ecstasy_progress = "Друсате се",
        healing_progress = "Превързвате се",
        meth_progress = "Взимате кристали",
        joint_progress = "Палите джойнката...",
        use_parachute_progress = "Слагате парашут...",
        pack_parachute_progress = "Опаковате парашута...",
        no_parachute = "Нямате парашут!",
        armor_full = "Вече имате достатъчно броня!",
        armor_empty = "Не носите бронежилетка...",
        armor_progress = "Слагате вашата броня...",
        heavy_armor_progress = "Слагате бронежилетка...",
        remove_armor_progress = "Премахвате бронежилетката...",
        canceled = "Прекъснато..."
    },
    cruise = {
        unavailable = "Круиз контрол не съществува",
        activated = "Круиз контрол активиран",
        deactivated = "Круиз контрол деактивиран"
    },
    editor = {
        started = "Започвахте да записвате!",
        save = "Запазено видео!",
        delete = "Изтрито видео!",
        editor = "Довиждане!"
    },
    firework = {
        place_progress = "Поставяте фойерверката...",
        canceled = "Прекъсната...",
        time_left = "Фойерверката се изтрелва след ~r~"
    },
    seatbelt = {
        use_harness_progress = "Слагате състезателния колан",
        remove_harness_progress = "Премахвате състезателния колан",
        no_car = "Не сте в колата."
    },
    teleport = {
        teleport_default = 'Използвай асансьора'
    },
    pushcar = {
        stop_push = "[E] за да спреш да буташ"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})