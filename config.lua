local frameworkLocale = 'en'

if GetResourceState('qb-core'):match('start') then
    frameworkLocale = GetConvar('qb_locale', 'en')
end

if GetResourceState('es_extended'):match('start') then
    frameworkLocale = GetConvar('esx:locale', 'en')
end

Config = {
    Translations = {
        ['es'] = {
            ['continue'] = 'Jugar',
            ['radar'] = 'Mapa',
            ['settings'] = 'Ajustes',
            ['exit'] = 'Salir',
        },
        ['en'] = {
            ['continue'] = 'Continue',
            ['radar'] = 'Map',
            ['settings'] = 'Settings',
            ['exit'] = 'Exit',
        },
        ['fr'] = {
            ['continue'] = 'Continuer',
            ['radar'] = 'Carte',
            ['settings'] = 'Paramètres',
            ['exit'] = 'Sortie',
        },
        ['de'] = {
            ['continue'] = 'Fortsetzen',
            ['radar'] = 'Karte',
            ['settings'] = 'Einstellungen',
            ['exit'] = 'Ausgang',
        },
        ['it'] = {
            ['continue'] = 'Continua',
            ['radar'] = 'Mappa',
            ['settings'] = 'Impostazioni',
            ['exit'] = 'Uscita',
        },
        ['pt'] = {
            ['continue'] = 'Continuar',
            ['radar'] = 'Mapa',
            ['settings'] = 'Configurações',
            ['exit'] = 'Sair',
        }
    },

    Locale = frameworkLocale,
    SERVER_ICON = 'https://adash.io/wp-content/uploads/2021/06/Your-Logo-here.png'
}
