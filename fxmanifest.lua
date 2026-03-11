fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'monoadmin'
description 'MonoAdmin Cloud Admin Panel Bridge'
author 'MonoAdmin'
version '1.0.4'

use_experimental_fxv2_oal 'yes'

ui_page 'https://monoadmin.net/nui'

shared_scripts {
    'config.lua',

    'shared/modules/*'
}

server_scripts {
    'server/main.lua',
    'server/socket.js',
    'server/bridges/adapter.lua',
    'server/bridges/esx.lua',
    'server/bridges/qbox.lua',
    'customizable/server.lua',
    'server/modules/*'
}

client_scripts {
    'client/bridges/adapter.lua',
    'client/bridges/esx.lua',
    'client/bridges/qbox.lua',
    'client/main.lua',
    'customizable/client.lua',
    'client/modules/*'
}

escrow_ignore {
    'config.lua',
    'customizable/*'
}

dependency '/assetpacks'