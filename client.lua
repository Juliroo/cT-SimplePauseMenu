local isOpened = false
local nuiReady = false

local function generateKeybindName(baseName)
    return string.format('%s-%s-%s', GetCurrentResourceName(), baseName, GetGameTimer())
end

local function addKeybind(params)
    local name, description, defaultKey, onPressed in params
    local keybindName = generateKeybindName(name)
    RegisterCommand(name, onPressed, false)
    RegisterKeyMapping(name, description, 'KEYBOARD', defaultKey)
end

local function sendNui(action, data)
    local messageData = { action = tostring(action) }

    if data then
        for k, v in pairs(data) do
            messageData[k] = v
        end
    end

    SendNUIMessage(messageData)
end

local function startBlockNuiControls()
    CreateThread(function()
        while isOpened do
            DisableControlAction(0, 200, true) -- Pause Menu
            DisableControlAction(0, 199, true) -- Map

            if GetPauseMenuState() > 0 then
                SetFrontendActive(false)
            end
            Wait(0)
        end
    end)
end

local function onPauseMenuKeyPressed()
    if not nuiReady then return end
    if not IsPauseMenuActive() and not IsNuiFocused() then
        isOpened = true
        startBlockNuiControls()
        sendNui('openEsc')
        SetNuiFocus(true, true)
        SetCursorLocation(0.15, 0.75)
    end
end

addKeybind({
    name = 'pausemenu',
    description = 'Pause Menu',
    defaultKey = 'ESCAPE',
    onPressed = onPauseMenuKeyPressed
})

RegisterNUICallback('SendAction', function(data)
    SetNuiFocus(false, false)

    local actionHandlers = {
        exit = function()
            isOpened = false
        end,
        settings = function()
            ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)
        end,
        map = function()
            ActivateFrontendMenu('FE_MENU_VERSION_MP_PAUSE', false, -1)
        end
    }

    local actionHandler = actionHandlers[data.action]
    if actionHandler then
        actionHandler()
    end
end)

CreateThread(function()
    Wait(500)

    sendNui('setup', {
        translatedTbl = Config.Translations[Config.Locale],
        serverIcon = Config.SERVER_ICON
    })

    nuiReady = true
end)
