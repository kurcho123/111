local Translations = {
    error = {
        license_already = 'Играчът вече има лиценз',
        error_license = 'Играчът няма този лиценз',
        no_camera = 'Камерата не съществува',
        blood_not_cleared = 'Кръвта НЕ е почистена',
        bullet_casing_not_removed = 'Гилзите не са почистени',
        none_nearby = 'Няма никого наоколо!',
        canceled = 'Прекъснато..',
        time_higher = 'Времето трябва да бъде по-голямо от 0',
        amount_higher = 'Сумата трябва да бъде по-голяма от 0',
        vehicle_cuff = 'Не можеш да сложиш белезници на някого в превозното средство',
        no_cuff = 'Нямаш белезници в себе си',
        no_impound = 'Няма иззети превозни средства',
        no_spikestripe = 'Не може да се поставят повече лента с шипове',
        error_license_type = 'Невалиден тип лиценз',
        rank_license = 'Не може да издаваш лиценз',
        revoked_license = 'Вашият лиценз беше иззет',
        rank_revoke = 'Нямате право за да отнемете лиценз',
        on_duty_police_only = 'Само за полицаи на смяна',
        vehicle_not_flag = 'Превозното средство не е маркирано',
        not_towdriver = 'Не си шофьор на репатрак',
        not_lawyer = 'Този човек не е адвокат',
        no_anklet = 'Този човек няма устройство за крака.',
        have_evidence_bag = 'Трябва да имаш празен плик за доказателства с теб',
        no_driver_license = 'Липсва шофьорска книжка',
        not_cuffed_dead = 'Гражданинът не с белезници или е мъртъв',
        fine_yourself = 'Не можеш да наложиш глоба на себе си',
        not_online = "Този човек не е онлайн"
    },
    success = {
        uncuffed = 'Бяха ви махнати белезниците',
        granted_license = 'Ти получи лиценз',
        grant_license = 'Ти предостави лиценз',
        revoke_license = 'Ти отне лиценз',
        tow_paid = 'Вие получихте $500',
        blood_clear = 'Кръвта е почистена',
        bullet_casing_removed = 'Гилзите са премахнати...',
        anklet_taken_off = 'Тракера на глезена ви беше свален.',
        took_anklet_from = 'Ти свали на %{firstname} %{lastname} тракера от глезена',
        put_anklet = 'Ти постави тракер на глезен.',
        put_anklet_on = 'Сложихте тракер на глезена на %{firstname} %{lastname}',
        vehicle_flagged = 'Превозното средство %{plate} беше маркирано за %{reason}',
        impound_vehicle_removed = 'Превозното средство беше извадено от наказателния паркинг!',
        impounded = 'Превозното средство беше иззето',
 },
    info = {
        mr = 'Гн.',
        mrs = 'Г-жа',
        impound_price = 'Цена, която играчът плаща, за да извади превозното средство от задържане (може и да е 0)',
        plate_number = 'Номер на регистрация',
        flag_reason = 'Причина за маркиране на превозното средство',
        camera_id = 'Идентификационен номер на камерата',
        callsign_name = 'Името на вашата позивна',
        poobject_object = 'Тип на обекта за създаване или \'delete\' за изтриване',
        player_id = 'Щатско ID на играча',
        citizen_id = 'Щатско ID на играча',
        dna_sample = 'ДНК образец',
        jail_time = 'Време което трябва да са в затвора',
        jail_time_no = 'Времето в затвора трябва да бъде повече от 0',
        license_type = 'Тип лиценз (шофьорски/оръжен)',
        ankle_location = 'Местоположение на глезенния тракер',
        cuff = 'Бяха ви сложени белезници!',
        cuffed_walk = 'С белезниците сте, но може да вървите',
        vehicle_flagged = 'Превозното средство %{vehicle} е маркирано поради: %{reason}',
        unflag_vehicle = 'Превозното средство %{vehicle} вече не е маркирано',
        tow_driver_paid = 'Ти плати на шофьора на репатрака',
        paid_lawyer = 'Ти плати на адвоката',
        vehicle_taken_depot = 'Превозното средство беше закарано в депото за $%{price}',
        vehicle_seized = 'Превозното средство конфискувано',
        stolen_money = 'Ти открадна $%{stolen}',
        cash_robbed = 'Откраднаха ви $%{money}',
        driving_license_confiscated = 'Вашето шофьорска книжка беше конфискувана',
        cash_confiscated = 'Вашите пари бяха конфискувани',
        being_searched = 'Претърсват ви',
        cash_found = 'Намерихте $%{cash} в този гражданин',
        sent_jail_for = 'Изпратихте човека в затвора за %{time} месеца',
        fine_received = 'Получихте фактура за $%{fine}',
        blip_text = 'Полицейско предупреждение - %{value}',
        jail_time_input = 'Време в затвора',
        submit = 'Изпрати',
        time_months = 'Време в месеци',
        bill = 'Сметка',
        amount = 'Сума',
        police_plate = 'LSPD', --Should only be 4 characters long
        vehicle_info = 'Двигател: %{value} % | Гориво: %{value2} %',
        evidence_stash = 'Доказателства | %{value}',
        slot = 'Номер слотове. (1,2,3)',
        current_evidence = '%{value} | Чекмедже %{value2}',
        on_duty = '[E] - Влез на смяна',
        off_duty = '[E] - Излез от смяна',
        onoff_duty = '~g~On~s~/~r~Off~s~ Смяна',
        stash = 'Скривалище %{value}',
        delete_spike = '[~r~E~s~] Махни шиповете',
        close_camera = 'Затвори камерата',
        bullet_casing = '[~g~G~s~] Гилзи %{value}',
        casing = 'Гилзи',
        blood = 'Кръв',
        blood_text = '[~g~G~s~] Кръв %{value}',
        fingerprint_text = '[G] Отпечатъци',
        fingerprint = 'Отпечатъци',
        store_heli = '[E] Прибери хеликоптер',
        take_heli = '[E] Вземи хеликоптер',
        impound_veh = '[E] - Конфискувайте превозното средство',
        store_veh = '[E] - Приберете превозното средство',
        armory = 'Оръжейна стая',
        enter_armory = '[E] Оръжейна',
        finger_scan = 'Сканиране на пръстов отпечатък',
        scan_fingerprint = '[E] за да сканираш пръстов отпечатък',
        trash = 'Боклук',
        trash_enter = '[E] Кош за боклук',
        stash_enter = '[E] Скривалище',
        target_location = 'Местоположението на %{firstname} %{lastname} е маркирано на JPS-a ви',
        anklet_location = 'Местоположение на тракера на глезена',
        new_call = 'Нов разговор',
        officer_down = 'Полицай %{lastname} | %{callsign} е паднал',
        fine_issued = 'Глобата е издадена успешно на нарушителя',
        received_fine = 'Централната агенция за събиране на съдебни задължения автоматично е изтеглила сумата от глобите, които дължите...'
    },
    evidence = {
        red_hands = 'Червени ръце',
        wide_pupils = 'Широки зеници',
        red_eyes = 'Червени очи',
        weed_smell = 'Мирише на трева',
        gunpowder = 'Барут по дрехите',
        chemicals = 'Мирише на химикали',
        heavy_breathing = 'Диша тежко',
        sweat = 'Много се поти',
        handbleed = 'Кръв по ръцете',
        confused = 'Объркан',
        alcohol = 'Мирише на алкохол',
        heavy_alcohol = 'Много силно мирише на алкохол',
        agitated = 'Раздразнен - Признаци на употреба на метамфетамин',
        serial_not_visible = 'Сериен номер не е видим...',
    },
    menu = {
        garage_title = 'Полицейски превозни средства',
        close = '⬅ Затвори менюто',
        impound = 'Конфискувани превозни средства',
        pol_impound = 'Наказателен паркинг на полицията',
        pol_garage = 'Полицейски гараж',
        pol_armory = 'Оръжейна на полицията',
    },
    email = {
        sender = 'Централна съдебна инкасационна агенция',
        subject = 'Изплащане на дълг',
        message = 'Скъпи %{value}. %{value2}, <br /><br />Централната съдебна инкасационна агенция (ЦСИА) е таксувала глобите, които сте получили от полицията.<br />От вашата сметка <strong>$%{value3}</strong> бяха изтеглени.<br /><br />С уважение,<br />Mr. I.K. Graai',
    },
    commands = {
        place_spike = 'Поставете шипове (само за полицията)',
        license_grant = 'Дайте лиценз на някого',
        license_revoke = 'Отнемане на лиценз от някого',
        place_object = 'Поставяне/Премахване на обект (само за полиция)',
        cuff_player = 'Сложете белезници на човек (само за полиция)',
        escort = 'Придружете човек',
        callsign = 'Дайте си звание',
        clear_casign = 'Изчистване на област от обвивки (само за полиция)',
        jail_player = 'Затваряне на човек на топло (само за полиция)',
        unjail_player = 'Освобождаване на човек (само за полиция)',
        clearblood = 'Изчистване на кръвта (само за полиция)',
        seizecash = 'Конфискуване на пари (само за полиция)',
        softcuff = 'Леко слагане на белезниците (само за полиция)',
        camera = 'Преглед на камера за сигурност (само за полиция)',
        flagplate = 'Маркирайте номер на табела (само за полиция)',
        unflagplate = 'Премахнете маркировка от номер на табела (само за полиция)',
        plateinfo = 'Проверка на номер на табела (само за полиция)',
        depot = 'Конфискуване с цена (само за полиция)',
        impound = 'Конфискуване на превозното средство (само за полиция)',
        paytow = 'Плащане на шофьор на репатрак (само за полиция)',
        paylawyer = 'Плащане на адвокат (само за полиция, съдия)',
        anklet = 'Прикрепяне на проследителен глезен (само за полиция)',
        ankletlocation = 'Вземете местоположението на гривната от глезена на лицето',
        removeanklet = 'Премахване на проследителен глезен (само за полиция)',
        drivinglicense = 'Конфискуване на шофьорска книжка (само за полиция)',
        takedna = 'Вземане на ДНК проба от човек (нужен е празен плик за доказателствата) (само за полиция)',
        police_report = 'Доклад на полицията',
        message_sent = 'Съобщение за изпращане',
        civilian_call = 'Обаждане на гражданин',
        emergency_call = 'Нов 911 разговор',
        fine = 'Глоби човек'
    },
    progressbar = {
        blood_clear = 'Изчистване на кръвта...',
        bullet_casing = 'Премахване на гилзи...',
        robbing = 'Ограбвате човек...',
        place_object = 'Поставяне на обект..',
        remove_object = 'Премахване на обект..',
        impound = 'Конфискуване на превозното средство..',
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})