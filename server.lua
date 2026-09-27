local ESX = exports['es_extended']:getSharedObject()

-- Function to play the radio
local function playRadio(source, youtubeLink, volume)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return
    end
    
    -- Save the radio settings to the database
    MySQL.Async.execute('INSERT INTO autoradio (player_id, youtube_link, volume, is_playing) VALUES (@player_id, @youtube_link, @volume, @is_playing)', {
        ['@player_id'] = xPlayer.identifier,
        ['@youtube_link'] = youtubeLink,
        ['@volume'] = volume,
        ['@is_playing'] = true
    }, function(rowsChanged)
        if rowsChanged > 0 then
            -- Broadcast the radio playback to nearby players
            TriggerClientEvent('esx_autoradio:playRadioClient', -1, youtubeLink, volume)
        end
    end)
end

-- Function to stop the radio
local function stopRadio(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return
    end
    
    -- Update the radio settings in the database
    MySQL.Async.execute('UPDATE autoradio SET is_playing = FALSE WHERE player_id = @player_id', {
        ['@player_id'] = xPlayer.identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            -- Broadcast the radio stop to nearby players
            TriggerClientEvent('esx_autoradio:stopRadioClient', -1)
        end
    end)
end

-- Register server event to play the radio
RegisterServerEvent('esx_autoradio:playRadio')
AddEventHandler('esx_autoradio:playRadio', function(youtubeLink, volume)
    playRadio(source, youtubeLink, volume)
end)

-- Register server event to stop the radio
RegisterServerEvent('esx_autoradio:stopRadio')
AddEventHandler('esx_autoradio:stopRadio', function()
    stopRadio(source)
end)