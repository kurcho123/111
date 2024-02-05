Locale = {
    ui = {
        ["go_back"] = "Върнете се",
        ["call_sign"] = "Баджов номер",
        ["call_sign_placeholder"] = "eg.: 333",
        ["name_input"] = "Име",
        ["name_input_placeholder"] = "eg.: Newbie",
        ["button_save"] = "Запази",
        ["lock_button"] = "Заключи",
        ["unlock_button"] = "Отключи",
        ["locked_status"] = "Заключен канал",
        ["unlocked_status"] = "Отключен канал",
        ["channel_is"] = "Канала е",
        ["invite_user"] = "Поканете (Щатско ID)",
        ["invite_button"] = "Поканете",
        ["channel"] = "Канал",
        ["show_list"] = "Покажи листа",
        ["change_signs"] = "Смени номера",
        ["lock_channel"] = "Заключете канала",
        ["settings"] = "Натройки",
        ["change_button"] = "Промени",
        ["disconnect"] = "Напусни",
        ["toggle_frame_movement"] = "Местене на радиото",
        ["color"] = "Цвят",
        ["size"] = "Размер",
        ["volume"] = "Звук",
        ["press_enter_to_connect"] = "Натиснете Enter, за да се свържете",
        ["turn_on_off"] = "Включете/Изключете",
        ["volume_up"] = "Увеличи",
        ["volume_down"] = "Намали",
        ["unknown"] = "Непознат",
        ["color_black"] = "Черен",
        ["color_white"] = "Бял",
        ["color_blue"] = "Син",
        ["color_green"] = "Зелен",
        ["color_red"] = "Червен",
        ["color_yellow"] = "Жълт",
        ["radio_list"] = "В момента в радио",
        ["enable_external_list"] = "Покажи допълнителния лист",
        ["disable_external_list"] = "Скрий допълнителния лист"
    },
    to_close_to_other_jammer = "Прекалено сте близо до друг заглушител.",
    press_to_destroy = "Натиснете [E], за да унищожите заглушителя",
    press_to_pickup = "Натиснете [E], за да вземете заглушителя",
    destroy_jammer = "Унищожи заглушителя",
    pick_up_jammer = "Вземи заглушителя",
    joined_to_radio = 'Свързан сте към: %sMhz.',
    invalid_radio = 'Тази честота е невалидна.',
    you_on_radio = 'Вече сте свързан към тази честота!',
    restricted_channel_error = 'Не може да се свържете към тази честота!',
    you_leave = 'Излязохте от канала.',
    open_radio = 'Изкарай радиото',
    open_radio_list = 'Отворете бързо присъединяване',
    radio_cannot_be_unlocked = "Радиото не може да се включи.",
    radio_unlocked = "Радиото се включи",
    radio_cannot_be_locked = "Радиото не може да се заключи.",
    radio_locked = "Радиото се заключи.",
    radio_cannot_invite = "Не може да поканите към тази честота.",
    radio_invited = "Поканен към честотата.",
    increase_radio_volume = 'Радиото вече е на най-ниската настройка за звук',
    volume_radio = 'Звука на новото радио е %s.',
    decrease_radio_volume = 'Радиото вече е на най-шумната си настройка',
    size_updated = "Размера е променен!",
    frame_updated = "Цвета е променен!",
    position_updated = "Позицията на радиото е променена!",
    signs_updated = "Променихте честотата!"
}

setmetatable(Locale, {
    __index = function(self, key)
        if rawget(self, key) == nil then
            return ('Unknown key: %s'):format(key)
        end

        return rawget(self, key)
    end
})
