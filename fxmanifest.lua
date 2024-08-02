fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'Juliroo'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'client.lua',
}

ui_page {
    'web/index.html',
}

files {
    'web/**',
}

dependency 'ox_lib'