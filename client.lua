local ESX = exports['es_extended']:getSharedObject()

local radioUI = {
    visible = false,
    youtubeLink = '',
    volume = Config.MaxVolume
}

-- Function to toggle the radio UI
local function toggleRadioUI()
    radioUI.visible = not radioUI.visible
    SetNuiFocus(radioUI.visible, radioUI.visible)
    SendNUIMessage({
        type = 'toggleUI',
        visible = radioUI.visible
    })
end

-- Function to play the radio
local function playRadio(youtubeLink, volume)
    if not youtubeLink or youtubeLink == '' then
        ESX.ShowNotification('Please enter a valid YouTube link')
        return
    end
    
    radioUI.youtubeLink = youtubeLink
    radioUI.volume = volume
    
    TriggerServerEvent('esx_autoradio:playRadio', youtubeLink, volume)
end

-- Register NUI callback
RegisterNUICallback('playRadio', function(data, cb)
    playRadio(data.youtubeLink, data.volume)
    cb({})
end)

-- Register NUI callback for closing the UI
RegisterNUICallback('closeUI', function(data, cb)
    toggleRadioUI()
    cb({})
end)

-- Register command to toggle the radio UI
RegisterCommand('radio', function()
    toggleRadioUI()
end, false)

-- Event to handle radio playback
RegisterNetEvent('esx_autoradio:playRadioClient')
AddEventHandler('esx_autoradio:playRadioClient', function(youtubeLink, volume)
    if not youtubeLink or youtubeLink == '' then
        return
    end
    
    -- Play the radio using the YouTube link and volume
    -- This is a placeholder for the actual radio playback implementation
    print('Playing radio with link: ' .. youtubeLink .. ' and volume: ' .. volume)
end)

-- Event to handle radio stop
RegisterNetEvent('esx_autoradio:stopRadioClient')
AddEventHandler('esx_autoradio:stopRadioClient', function()
    -- Stop the radio playback
    -- This is a placeholder for the actual radio stop implementation
    print('Stopping radio')
end)