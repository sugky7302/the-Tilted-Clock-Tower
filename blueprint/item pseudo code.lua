創建Item類別

------
創建Price類別


function 建構函數()
    self.gold = 0
    self.silver = 0
    self.copper = 0
endfunction

function print()
    return self.gold + "金" + self.silver + "銀" + self.copper + "銅"
endfunction

function get()
    return self.gold * 10^6 + self.silver * 10^3 + self.copper
endfunction

function set(money)
    self.gold = money / 10^6
    self.silver = (money - self.gold * 10^6) / 10^3
    self.copper = money - self.gold * 10^6 - self.silver * 10^3
endfunction
------

function 建構函數(tb)
    if tb存在 then
        tb._id_ = tb.id or GenerateNewId()
        tb._name_ = tb.name or ""
        tb._kind_ = tb.kind or ""
        tb._type_ = tb.type or ""
        tb._owner_ = tb.owner or nil
        tb._price_ = tb.price or Price()
        tb._object_ = tb.object or nil
        tb._description_ = tb.description or ""

        return tb
    endif
endfunction

function isSameType(另一件物品或類型名稱)
    if 是類型名稱 then
        return self.type == 類型名稱
    endif

    return self.type == 另一件物品.type
endfunction

function isSameKind(另一件物品或種類名稱)
    if 是種類名稱 then
        return self.kind == 種類名稱
    endif

    return self.kind == 另一件物品.kind
endfunction

function getOwnPlayer()
    return self.owner.own_player
endfunction

function getPrice()
endfunction

function registerPickUpEvent(trigger)
    return Event(self, "物品-拾取")(trigger)
endfunction

function registerDropEvent(trigger)
    return Event(self, "物品-丟棄")(trigger)
endfunction

function registerUseEvent(trigger)
    return Event(self, "物品-使用")(trigger)
endfunction

function registerSellEvent(trigger)
    return Event(self, "物品-販售")(trigger)
endfunction