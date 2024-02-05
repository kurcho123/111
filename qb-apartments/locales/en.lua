local Translations = {
    error = {
        to_far_from_door = 'Прекалено сте далече от звънеца!',
        nobody_home = 'Няма никого у дома',
        nobody_at_door = 'Няма никой на вратата...'
    },
    success = {
        receive_apart = 'Честито! Вие получихте апартамент',
        changed_apart = 'Вие преместихте вашият апартамент!',
    },
    info = {
        at_the_door = 'Има някой на вратата!',
    },
    text = {
        options = '[E] за опции  на апартамента',
        enter = 'Влез в апартамента',
        ring_doorbell = 'Позвънете на звънеца',
        logout = 'Заспи',
        change_outfit = 'Преоблечете се',
        open_stash = 'Отвори хранилище',
        move_here = 'Премести тук',
        open_door = 'Отвори вратата',
        leave = 'Напуснете апартамента',
        close_menu = '⬅ Затвори менюто',
        tennants = 'Наематели',
    },
}
Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})