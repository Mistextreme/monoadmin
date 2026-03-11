Config = {}

Config.Framework = nil           -- Do not touch. Automated configured by the cloud.

Config.ReportCommand = 'report'  -- To disable make it false
Config.OpenGameAdminPanelCommand =
'madmin'                         -- To disable make it false. If this is disabled, register keybind is also disabled
Config.OpenGameAdminKeyBind = '' --Leave blank to let the user decide what keybind via ESC > ....

Config.CommunityService = {
    spawnCoords = {
        vec4(159.309891, -997.345032, 29.347290, 144.566910)
    },
    centerPoint = {
        coords = vec4(159.309891, -997.345032, 29.347290, 144.566910),
        radius = 100.0
    },
    trashPickup = {
        vec4(169.951645, -992.703308, 30.088623, 150.236221),
        vec4(150.039566, -993.560425, 29.347290, 249.448822)
    },
    trashModels = {
        'prop_rub_binbag_01',
        'prop_rub_binbag_01b',
        'prop_rub_binbag_03',
        'prop_rub_binbag_03b',
        'prop_rub_binbag_04',
        'prop_rub_binbag_05',
        'prop_rub_binbag_06',
        'prop_rub_binbag_08',
        'prop_cs_rub_binbag_01',
    },
    releaseCoords = {
        vec4(159.309891, -997.345032, 29.347290, 144.566910)
    },
    workflows = {
        --Client Sided Workflows. Not Server sided
        onCommunityService = {
            function()
                print('Community service workflow') -- change clothes something..
            end
        },
        onCommunityServiceRelease = {
            function()
                print('Community service release workflow') -- change clothes something..
            end
        }
    }
}
