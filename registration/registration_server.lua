RegisterServerEvent("showPlayerId")
RegisterServerEvent("registerNewPlayer")

-- AddEventHandler("playerConnecting", function()
--     local player = source
--     --Wait(20000)
--     print('source = ' .. player)
--     TriggerClientEvent('register', player)
-- end)

function GetIdentifiers()
    local player = source
    local player_id = GetPlayerIdentifiers(player)

    local identifiers = {
        steam_id = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for key,value in pairs(player_id)do
        if string.sub(value, 1, string.len("steam:")) == "steam:" then
            identifiers.steam_id = value
        elseif string.sub(value, 1, string.len("license:")) == "license:" then
            identifiers.license = value
        elseif string.sub(value, 1, string.len("xbl:")) == "xbl:" then
            identifiers.xbl  = value
        elseif string.sub(value, 1, string.len("ip:")) == "ip:" then
            identifiers.ip = value
        elseif string.sub(value, 1, string.len("discord:")) == "discord:" then
            identifiers.discord = value
        elseif string.sub(value, 1, string.len("live:")) == "live:" then
            identifiers.liveid = value
        end
    end

    return identifiers
end

AddEventHandler("showPlayerId", function()
    local player = source
    MySQL.Async.fetchAll("SELECT * FROM main WHERE steam_id = @steam_id",
    {
        ['@steam_id'] = GetPlayerIdentifiers(player)[1]
    },
    function(result)
        if result[1] == nil then
            TriggerClientEvent('register', player)
        else
            TriggerClientEvent('chat:addMessage', player, { args = { "^0Welcome to the ^1BMK^0 server. Your^1ID^0 is ^2" .. result[1]["first_name"] .. " " .. result[1]["last_name"] }, color = 255,255,255 })
        end
    end)
end)

AddEventHandler("registerNewPlayer", function(data)
    local identifier = GetIdentifiers.steam_id
    local player = source
    
    if (identifier == "") then
        TriggerClientEvent('chat:addMessage', player, { args = { "Error finding your Steam_id. Please Login into your Steam account " }, color = 255,0,0 })
    else
        MySQL.Async.fetchAll("INSERT INTO main (steam_id, first_name, last_name) VALUES(@steam_id, @first_name, @last_name)",
        {
        ['@steam_id']   = identifier,
        ['@first_name'] = data.firstname,
        ['@last_name']  = data.lastname,
        })
    end
end)