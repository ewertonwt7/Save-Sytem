data = {
	functions = {},
	connection = dbConnect('sqlite', 'assets/database/database.sqlite')
}


data.functions['setPlayerID'] = function (player)
	assert(player and isElement(player), string.format("Expecting element, argument 1 'setPlayerData' (not : '%s')", type(player)))
	local account = player:getAccount()
    local db = dbPoll( data.connection:query( 'SELECT * FROM SaveSystem WHERE Account = ?', account:getName() ), -1)
    if #db ~= 0 then 
       
        player:setData('ID', db[1]['ID'])
        setPlayerDatasSave(player, fromJSON(db[1]['Data']))
  
    else
        local id = data.functions['getFreeID']()
        player:setData('ID', id)
        player:setMoney(settings.join.money)
        player:setData(settings.join.bank.data, settings.join.bank.value)
        data.connection:exec( 'INSERT INTO SaveSystem VALUES (?, ?, ?)', account:getName(), id, toJSON({}))
    end

    return true
end

data.functions['savePlayerData'] = function (player)
    assert(player and isElement(player), string.format("Expecting element, argument 1 'setPlayerData' (not : '%s')", type(player)))
    local account = player:getAccount()
    if not account:isGuest() then 
        local db = dbPoll( data.connection:query( 'SELECT * FROM SaveSystem WHERE Account = ?', account:getName() ), -1)
        if #db == 0 then
            return 
        end
        local datap = saveSystem(player)
        data.connection:exec( ' UPDATE SaveSystem SET Data = ? WHERE Account = ?', toJSON(datap), account:getName() )

    end
end

data.functions['PlayerNewID'] = function (player, newid)
    assert(player and isElement(player), string.format("Expecting element, argument 1 'PlayerNewID' (not : '%s')", type(player)))
    newid = newid
    local db = dbPoll( data.connection:query( 'SELECT ID FROM SaveSystem' ), -1)
    for i, v in ipairs(db[1]) do 
        if v.ID == newid then 
            return false
        end
    end
    local account = player:getAccount()
    data.connection:exec( ' UPDATE SaveSystem SET ID = ? WHERE Account = ?', newid, account:getName() )
    player:setData('ID', newid)
    return true
end

data.functions['getFreeID'] = function ()
    local db = dbPoll( data.connection:query( 'SELECT ID FROM SaveSystem' ), -1)
    if #db == 0 then 
        return 1 
    end
    
    for i = 1, (#db + 1) do
        local slotUsed = false

        for _, v in pairs(db) do
            
            if v.ID == i then
                slotUsed = true
                break
            end
        end

        if not slotUsed then
            return i
        end
    end
    return nil
end

data.functions['getPlayerByID'] = function (id)
    assert(id and tonumber(id), string.format("Expecting number, argument 1 'getPlayerByID' (not : '%s')", type(id)))
    id = tonumber(id)
    for _, player in ipairs(getElementsByType('player')) do
        if player:getData('ID') == id then 
            return player
        end
    end
    return false
end


data.functions['isPermision'] = function (player)
    assert(player and isElement(player) , string.format("Expecting element type player, argument 1 'isPermision' (not : '%s')", type(player)) )

    for i , v in ipairs(settings.setId.permission) do 

        local account = player:getAccount ()
        if isObjectInACLGroup ("user."..account:getName(), aclGetGroup ( v ) ) then -- Does he have access to Admin functions?

            return true

        end
    end
    notify(player, 'Not permison', 'error')
    return false
end