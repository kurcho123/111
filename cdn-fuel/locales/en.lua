local Translations = {
    -- Fuel
    set_fuel_debug = "Set fuel to:",
    cancelled = "Прекъснато.",
    not_enough_money = "Нямате достатъчно пари!",
    not_enough_money_in_bank = "Нямате достатъчно пари в банката!",
    not_enough_money_in_cash = "Нямате достатъчно пари в себе си!",
    more_than_zero = "Трябва да заредите повече!",
    emergency_shutoff_active = "В момента помпите за изключени заради аварийните системи.",
    nozzle_cannot_reach = "Дюзата не може да стигне до там!",
    station_no_fuel = "В бензиностанцията няма гориво!",
    station_not_enough_fuel = "Бензиностанцията няма толкова гориво!",
    show_input_key_special = "Натиснете [G] за да заредите гориво!",
    tank_cannot_fit = "Вашия резервоар не може да поеме толкова много!",
    tank_already_full = "Вашето МПС е вече пълно до горе!",
    need_electric_charger = "Имате нужда да отидете до електрическото зарядно!",
    cannot_refuel_inside = "Не можете да зареждате докато сте в колата!",
    
    -- 2.1.2 -- Reserves Pickup ---
    fuel_order_ready = "Вашата поръчка за говиро е готова за получаване!Проверете GPS за да намерите локацията!",
    draw_text_fuel_dropoff = "[E] за да доставите камиона",
    fuel_pickup_success = "Вашия резервоар беше напълнен с: %sL",
    fuel_pickup_failed = "Ron Oil току що достави горивото за вашата бензиностанция!",
    trailer_too_far = "Ремаркето не е закачено за камиона или е трърде далеч!",

    -- 2.1.0
    no_nozzle = "Нямате пистолет за зареждане!",
    vehicle_is_damaged = "Превозното средство е прекалено счупено, за да се зареди!",
    vehicle_too_far = "Прекалено сте далече, за да заредите превозното средство!",
    inside_vehicle = "Не може да заредите докато сте в превозното средство!",
    you_are_discount_eligible = "Ако влезете на смяна може да вземете отстъпка на "..Config.EmergencyServicesDiscount['discount'].."%!",
    no_fuel = "Няма гориво..",

    -- Electric
    electric_more_than_zero = "Трябва да заредите повече!",
    electric_vehicle_not_electric = "Вашето МПС не е електрическо!",
    electric_no_nozzle = "Вашето МПС не е електрическо!",

    -- Phone --
    electric_phone_header = "Електрическо зарядно",
    electric_phone_notification = "Обща цена за електричеството: $",
    fuel_phone_header = "Бензиностанция",
    phone_notification = "Крайна цена: $",
    phone_refund_payment_label = "Възстановяване @ бензиностанцията!",

    -- Stations
    station_per_liter = " / Литър!",
    station_already_owned = "Тази локация е вече купена!",
    station_cannot_sell = "Не може да продадете тази локация!",
    station_sold_success = "Вие успешно продадохте тази локация!",
    station_not_owner = "Тази локация не е ваша!",
    station_amount_invalid = "Невалидно количество!",
    station_more_than_one = "Трябва да купите повече от това!",
    station_price_too_high = "Цената е твърда висока!",
    station_price_too_low = "Цената е твърде ниска!",
    station_name_invalid = "Името е неправилно!",
    station_name_too_long = "Вашето име не може да бъде по-дълго "..Config.NameChangeMaxChar.." символа.",
    station_name_too_short = "Вашето име трябва да бъде по-дълго "..Config.NameChangeMinChar.." символа.",
    station_withdraw_too_much = "Не може да изтеглите повече от колкото бензиностанцията има!", 
    station_withdraw_too_little = "не може да изтеглите по-малко от $1!",
    station_success_withdrew_1 = "Успешно изтеглени $",
    station_success_withdrew_2 = " от баланса на тази бензиностанция!", -- Leave the space @ the front!
    station_deposit_too_much = "Не може да депозирате повече от това което имате!", 
    station_deposit_too_little = "Не може да депозирате по-малко от $1!",
    station_success_deposit_1 = "Успешно депозирахте $",
    station_success_deposit_2 = " във баланса на тази бензиностанция!", -- Leave the space @ the front!
    station_cannot_afford_deposit = "Не може да си позволите да депозирате $",
    station_shutoff_success = "Успешно е променено състоянието на спирателния вентил за това местоположение!",
    station_fuel_price_success = "Цената на горивото успешно е променена на $",
    station_reserve_cannot_fit = "Резервите на бензиностанцията не могат да поберат това!",
    station_reserves_over_max =  "Не може да купите такова количество понеже ще е повече от "..Config.MaxFuelReserves.." литра",
    station_name_change_success = "Успешно променихте името на: ", -- Leave the space @ the end!
    station_purchased_location_payment_label = "Закупихте тази бензиностанция: ",
    station_sold_location_payment_label = "Продадохте тази бензиностанция: ",
    station_withdraw_payment_label = "Изтеглите пари от тази бензиностанция: ",
    station_deposit_payment_label = "Депозирахте пари от тази бензиностанция: ",
    -- All Progress Bars
    prog_refueling_vehicle = "Зареждате МПС-то..",
    prog_electric_charging = "Зареждате..",
    prog_jerry_can_refuel = "Пълните тубата..",
    prog_syphoning = "Сифониране на гориво..",

    -- Menus
    
    menu_header_cash = "Кеш",
    menu_header_bank = "Банка",
    menu_header_close = "Прекъсни",
    menu_pay_with_cash = "Плати в брой.  \nНаличност: $",
    menu_pay_with_bank = "Плати с карта.", 
    menu_refuel_header = "Бензиностанция",
    menu_refuel_accept = "Бих желал да закупя гориво.",
    menu_refuel_cancel = "Всъщност вече не искам гориво.",
    menu_pay_label_1 = "Газолин @ ",
    menu_pay_label_2 = " / L",
    menu_header_jerry_can = "Туба",
    menu_header_refuel_jerry_can = "Напълни тубата",
    menu_header_refuel_vehicle = "Зарадете превозното средство",

    menu_electric_cancel = "Всъщност не искам вече да си зареждам превозното средство.",
    menu_electric_header = "Електрическо зарядно",
    menu_electric_accept = "Бих искал да платя за електричеството.",
    menu_electric_payment_label_1 = "Електричество @ ",
    menu_electric_payment_label_2 = " / KW",


    -- Station Menus

    menu_ped_manage_location_header = "Управление на местоположението",
    menu_ped_manage_location_footer = "Ако сте собственик може да управлявате.",

    menu_ped_purchase_location_header = "Купете тази локация",
    menu_ped_purchase_location_footer = "Ако никой не притежава тази локация Вие може да я закупите.",

    menu_ped_emergency_shutoff_header = "Включи/Изключи аварийното копче",
    menu_ped_emergency_shutoff_footer = "Изключете горивото в случай на авария.   \n Помпите са в момента ",
    
    menu_ped_close_header = "Прекъсни разговора",
    menu_ped_close_footer = "Не искам да обсъждам нищо повече.",

    menu_station_reserves_header = "Купи резерви за ",
    menu_station_reserves_purchase_header = "Купи резерви за: $",
    menu_station_reserves_purchase_footer = "Да, искам да купя резерви за $",
    menu_station_reserves_cancel_footer = "Всъщност не искам да купя повече резерви!",
    
    menu_purchase_station_header_1 = "Крайната цена ще бъде: $",
    menu_purchase_station_header_2 = " с включени такси.",
    menu_purchase_station_confirm_header = "Потвърди",
    menu_purchase_station_confirm_footer = "Искам да купя тази локация за $",
    menu_purchase_station_cancel_footer = "Всъщност вече не искам да купувам това местоположение. Тази цена е откачена!",

    menu_sell_station_header = "Продай ",
    menu_sell_station_header_accept = "Продай бензиностанцията",
    menu_sell_station_footer_accept = "Да, искам да продам тази локация за $",
    menu_sell_station_footer_close = "Нямам какво повече да обсъждам.",

    menu_manage_header = "Управление на ",
    menu_manage_reserves_header = "Гориво резерви  \n",
    menu_manage_reserves_footer_1 =  " Литри извън ",
    menu_manage_reserves_footer_2 =  " Литри  \nможе да закупите от резерви!",
    
    menu_manage_purchase_reserves_header = "Купете повече гориво за резерви",
    menu_manage_purchase_reserves_footer = "Искам да купя повече горива за резерви на цена от $",
    menu_manage_purchase_reserves_footer_2 = " / L!",

    menu_alter_fuel_price_header = "Промяна на цената на горивата",
    menu_alter_fuel_price_footer_1 = "Искам да променя цената на горивото в моята бензиностанция!  \nВ момента е $",
    
    menu_manage_company_funds_header = "Управлявай средствата на компанията",
    menu_manage_company_funds_footer = "Аз искам да управлявам средствата на компанията.",
    menu_manage_company_funds_header_2 = "Управление на средствата на ",
    menu_manage_company_funds_withdraw_header = "Изтегли средства",
    menu_manage_company_funds_withdraw_footer = "Изтегли средства от баланса на бензиностанцията.",
    menu_manage_company_funds_deposit_header = "Депозирай средства",
    menu_manage_company_funds_deposit_footer = "Депозирай средства в баланса на бензиностанцията.",
    menu_manage_company_funds_return_header = "Върни",
    menu_manage_company_funds_return_footer = "Искам да обсъдим нещо друго!",

    menu_manage_change_name_header = "Смени името на локацията",
    menu_manage_change_name_footer = "Искам да променя името на локацията.",

    menu_manage_sell_station_footer = "Продай своята бензиностанция за $",

    menu_manage_close = "Нямам какво повече да обсъждам!", 

    -- Jerry Can Menus 
    menu_jerry_can_purchase_header = "Купете туба за $",
    menu_jerry_can_footer_full_gas = "Вашата туба е пълна!",
    menu_jerry_can_footer_refuel_gas = "Напълнете своята туба!",
    menu_jerry_can_footer_use_gas = "Използвайте говировото и заредете превозното средство!",
    menu_jerry_can_footer_no_gas = "Нямате гориво в тубата!",
    menu_jerry_can_footer_close = "Всъщност вече не искам тубата.",
    menu_jerry_can_close = "Всъщност вече не искам да използвам това.",

    -- Syphon Kit Menus
    menu_syphon_kit_full = "Вашия сифон е пълен. Събира само " .. Config.SyphonKitCap .. "L!",
    menu_syphon_vehicle_empty = "Резервоара на МПС-то е празен.",
    menu_syphon_allowed = "Откраднете говиро от неподозиращ човек!",
    menu_syphon_refuel = "Използвайте откраднатото си гориво и заредете автомобила!",
    menu_syphon_empty = "Използвайте откраднатото си гориво и заредете автомобила!",
    menu_syphon_cancel = "Не искам да използвам повече това. Промених нещата!",
    menu_syphon_header = "Сифонирай",
    menu_syphon_refuel_header = "Напълни",


    -- Input --
    input_select_refuel_header = "Изберете колко гориво да се зареди.",
    input_refuel_submit = "Напълни превозното средство",
    input_refuel_jerrycan_submit = "Напълни тубата",
    input_max_fuel_footer_1 = "До горе ",
    input_max_fuel_footer_2 = "L гориво.",
    input_insert_nozzle = "Поставете пистолета", -- Used for Target as well!

    input_purchase_reserves_header_1 = "Купете запаси  \nСегашна цена: $",
    input_purchase_reserves_header_2 = Config.FuelReservesPrice .. " / Liter  \nСегашни запаси: ",
    input_purchase_reserves_header_3 = " Литри  \nКрайна цена: $",
    input_purchase_reserves_submit_text = "Купете запаси",
    input_purchase_reserves_text = 'Купете запаси за гориво.',

    input_alter_fuel_price_header_1 = "Промяна на цената на горивото   \nСегашна цена: $",
    input_alter_fuel_price_header_2 = " / Литра",
    input_alter_fuel_price_submit_text = "Смяна на цената на горивото",

    input_change_name_header_1 = "Смени ",
    input_change_name_header_2 = "'s Име.",
    input_change_name_submit_text = "Потвърди промяната на името",
    input_change_name_text = "Ново име..",

    input_withdraw_funds_header = "Изтегли средства  \nТекущ баланс: $",
    input_withdraw_submit_text = "Изтегли",
    input_withdraw_text = "Изтегли средства",

    input_deposit_funds_header = "Депозирай средства  \nТекущ баланс: $",
    input_deposit_submit_text = "Депозирай",
    input_deposit_text = "Депозирай средства",

    -- Target
    grab_electric_nozzle = "Хвани електрическия пистолет",
    insert_electric_nozzle = "Постави електрическия пистолет",
    grab_nozzle = "Вземи пистолета",
    return_nozzle = "Върнете пистолета",
    grab_special_nozzle = "Вземи специалният пистолет",
    return_special_nozzle = "Върни специалният пистолет",
    buy_jerrycan = "Купете туба",
    station_talk_to_ped = "Обсъдете бензиностанцията",

    -- Jerry Can
    jerry_can_full = "Вашта туба е пълан!",
    jerry_can_refuel = "Напълни тубата!",
    jerry_can_not_enough_fuel = "В тубата няма толкова гориво!",
    jerry_can_not_fit_fuel = "Тубата не може да се напълни повече!",
    jerry_can_success = "Успешно напълнихте тубата!",
    jerry_can_success_vehicle = "Успешно напълнихте превозното средство с тубата!",
    jerry_can_payment_label = "Закупена туба.",

    -- Syphoning
    syphon_success = "Успешно източено от МПС-то!",
    syphon_success_vehicle = "Успешно заредено превозно средство като използвахте сифона!",
    syphon_electric_vehicle = "Вашето МПС е електрическо!",
    syphon_no_syphon_kit = "Имаш нужда от нещо за да точиш газ.",
    syphon_inside_vehicle = "Не може да точите докато сте вътре в автомобила!",
    syphon_more_than_zero = "Трябва да откраднете повече!",
    syphon_kit_cannot_fit_1 = "Не може да крадете толкова! Можете да откраднете: ",
    syphon_kit_cannot_fit_2 = " Литри.",
    syphon_not_enough_gas = "Нямате толкова газ, за да напълните!",
    syphon_dispatch_string = "(10-90) - кражба на гориво",
}

Lang = Locale:new({phrases = Translations, warnOnMissing = true})