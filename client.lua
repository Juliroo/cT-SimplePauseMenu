CreateThread(function()
    while true do
        DisableControlAction(0, 200) -- ESC
        Wait(5)
    end
end)

lib.addKeybind({
    name = 'pausemenu',
    description = 'Pause Menu',
    defaultKey = 'ESCAPE',
    onPressed = function()
        if not IsPauseMenuActive() and not IsNuiFocused() then
            SendNUIMessage({action = 'openEsc'})
            SetNuiFocus(true, true)
            SetCursorLocation(.15, .75)
        end
    end
})

RegisterNUICallback('SendAction', function(data)
    SetNuiFocus(false, false)
    if data.action == 'exit' then
        SendNUIMessage({action = 'closeEsc'})
    elseif data.action == 'settings' then
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)
    elseif data.action == 'map' then
        ActivateFrontendMenu('FE_MENU_VERSION_MP_PAUSE', false, -1)
    end
end)