
addEventHandler('onResourceStart', resourceRoot, function()
    if not data.connection then 
       cancelEvent(true, 'SQL CONNECTION NOT DEFINE') 
    end
    data.connection:exec('CREATE TABLE IF NOT EXISTS SaveSystem (Account Text, ID Int, Data Text)')
end)


addEventHandler('onPlayerLogin', root ,function ()


    data.functions['setPlayerID'](source)

end)


addEventHandler('onPlayerQuit', root, function ()

    data.functions['savePlayerData'](source)

end)


addCommandHandler(settings.setId.command, function(player, _, id, newid)
    if data.functions['isPermision'](player) then
        if tonumber(id) and (newid) then 
            local targt = data.functions['getPlayerByID'](id)
            if targt then 
                data.functions['PlayerNewID'](targt, newid)
                notify(player, 'success command', 'success')
            end
        end
    end
end)