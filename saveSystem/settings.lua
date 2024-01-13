settings = {
    join = {
        money = 2000, -- Dinheiro ao entrar no servidor.
        bank = {
            data = 'bank', -- elementData do banco
            value = 100 -- Dinheiro no banco ao entrar no servidor
        },
    },
    setId = {
        command = 'setid',
        permission = {'Console', 'Admin'}
    }
}

notify = function (player, msg, tipo)
    assert(player and isElement(player) and tostring(msg) and tostring(tipo))

    print(msg)

end
-- ElementData do ID : ID || Exemplo Normal : getElementData(element, 'ID') || OOP : element:getData('ID') 