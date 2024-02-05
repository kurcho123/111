local Translations = {
    error = {
        not_online = 'Играча не е онлайн',
        wrong_format = 'Грешни данни',
        missing_args = 'Не сте задали всички кординати (x, y, z)',
        missing_args2 = 'Всичко трябва да бъде попълнено!',
        no_access = 'Нямате право на тази команда',
        company_too_poor = 'Твоя работодател е разорен',
        item_not_exist = 'Няма такъв предмет',
        too_heavy = 'Много са ви пълни гащите',
        location_not_exist = 'Няма такава локация',
        duplicate_license = '[BULGAR CORE] - Дубликиран Rockstar лиценз',
        no_valid_license  = '[BULGAR CORE] - Няма Rockstar лиценз',
        not_whitelisted = '[BULGAR CORE] - Нямате whitelist за този сървър',
        server_already_open = 'Сървъра вече е пуснат',
        server_already_closed = 'Сървъра е вече спрян',
        no_permission = 'Нямате право на това..',
        no_waypoint = 'Нямате зададена крайна точка.',
        tp_error = 'Грешка при телепортирането.',
        connecting_database_error = '[BULGAR CORE] - Грешка в датабазата докато се опитвахте да се свържете със сървъра',
        connecting_database_timeout = '[BULGAR CORE] - Времето за изчакване за връзка с датабазата изтече',
    },
    success = {
        server_opened = 'Сървъра беше пуснат',
        server_closed = 'Сървъра беше спрян',
        teleported_waypoint = 'Телепортирахте се до вашата точка.',
    },
    info = {
        received_paycheck = 'Получихте вашия чек от $%{value}',
        job_info = 'Работа: %{value} | Степен: %{value2} | Задължение: %{value3}',
        gang_info = 'Генг: %{value} | Степен: %{value2}',
        on_duty = 'Вие влязохте на смяна!',
        off_duty = 'Вие излязохте от смяна!',
        checking_ban = 'Здравейте, %s. Проверяваме дали сте баннати от сървъра.',
        join_server = '%s, влизате в {Server Name}.',
        checking_whitelisted = 'Здравейте %s. проверяваме вашия достъп до сървъра.',
        exploit_banned = 'Вие бяхте баннати защото хаквате. Проверете си дискорда за повече информация: %{discord}',
        exploit_dropped = 'Бяхте кикнати заради употребата на бъгове',
    },
    command = {
        tp = {
            help = 'TP To Player or Coords (Admin Only)',
            params = {
                x = { name = 'id/x', help = 'ID of player or X position'},
                y = { name = 'y', help = 'Y position'},
                z = { name = 'z', help = 'Z position'},
            },
        },
        tpm = { help = 'TP To Marker (Admin Only)' },
        togglepvp = { help = 'Toggle PVP on the server (Admin Only)' },
        addpermission = {
            help = 'Give Player Permissions (God Only)',
            params = {
                id = { name = 'id', help = 'ID of player' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        removepermission = {
            help = 'Remove Player Permissions (God Only)',
            params = {
                id = { name = 'id', help = 'ID of player' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        openserver = { help = 'Open the server for everyone (Admin Only)' },
        closeserver = {
            help = 'Close the server for people without permissions (Admin Only)',
            params = {
                reason = { name = 'reason', help = 'Reason for closing (optional)' },
            },
        },
        car = {
            help = 'Spawn Vehicle (Admin Only)',
            params = {
                model = { name = 'model', help = 'Model name of the vehicle' },
            },
        },
        dv = { help = 'Delete Vehicle (Admin Only)' },
        givemoney = {
            help = 'Give A Player Money (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                moneytype = { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Amount of money' },
            },
        },
        setmoney = {
            help = 'Set Players Money Amount (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                moneytype = { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Amount of money' },
            },
        },
        job = { help = 'Check Your Job' },
        setjob = {
            help = 'Set A Players Job (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                job = { name = 'job', help = 'Job name' },
                grade = { name = 'grade', help = 'Job grade' },
            },
        },
        gang = { help = 'Check Your Gang' },
        setgang = {
            help = 'Set A Players Gang (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                gang = { name = 'gang', help = 'Gang name' },
                grade = { name = 'grade', help = 'Gang grade' },
            },
        },
        ooc = { help = 'OOC Chat Message' },
        me = {
            help = 'Show local message',
            params = {
                message = { name = 'message', help = 'Message to send' }
            },
        },
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
