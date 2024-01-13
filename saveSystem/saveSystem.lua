function saveSystem (player) 
    assert(player and isElement(player), string.format("Expecting element, argument 1 'saveSystem' (not : '%s')", type(player)))

    local value = {
        money = player:getMoney(),
        bank =  player:getData(settings.join.bank.data) or 0,
        pos = {getElementPosition(player)},
        vida = player:getHealth(),
        colete = player:getArmor(),
        skin = player:getModel()
    }
    return value
end


function setPlayerDatasSave (player, data)
    assert(player and isElement(player), string.format("Expecting element, argument 1 'setPlayerDatasSave' (not : '%s')", type(player)))
    if not data and #data == 0 then 
        return  
    end
 

    player:setMoney(data.money)
    player:setData(settings.join.bank.data, data.bank)
    player:setPosition(data.pos[1], data.pos[2] , data.pos[3])
    player:setHealth(data.vida)
    player:setArmor(data.colete)
    player:setModel(data.skin)
end