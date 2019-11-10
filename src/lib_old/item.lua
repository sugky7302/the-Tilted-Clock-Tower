local require = require
local Item = require 'util.class'("Item")


local ID = 0
local GenerateNewId

function Item:_new(tb)
    return {
        _id_ = GenerateNewId(),
        _name_ = tb.name or "",
        _kind_ = tb.kind or "",
        _type_ = tb.type or "",
        _owner_ = tb.owner or nil,
        _price_ = tb.price or require 'lib.price':new(0, 0, 0),
        _object_ = tb.object or nil,
        _description_ = tb.description or ""
    }
end

GenerateNewId = function()
    ID = ID + 1
    return ID
end


local type = type

function Item:isSameType(object)
    if type(object) == "string" then
        return self._type_ == object
    end

    return self._type_ == object:getType()
end

function Item:getType()
    return self._type_
end

function Item:isSameKind(object)
    if type(object) == "string" then
        return self._kind_ == object
    end

    return self._kind_ == object:getKind()
end

function Item:getKind()
    return self._kind_
end

function Item:getOwnPlayer()
    if self._owner_ then
        return self._owner_.getOwner()
    end

    return nil
end

function Item:getPrice()
    return self._price_
end


local Event = require 'lib.event'
local PICK_UP = "物品-拾取"
local DROP = "物品-丟棄"
local USE = "物品-使用"
local SELL = "物品-販售"

function Item:registerPickUpEvent(trigger)
    return Event(self, PICK_UP)(trigger)
end

-- eventDispatch是event幫忙註冊的
function Item:dispatchPickUpEvent(...)
    return self:eventDispatch(PICK_UP, ...)
end

function Item:registerDropEvent(trigger)
    return Event(self, DROP)(trigger)
end

function Item:dispatchDropEvent(...)
    return self:eventDispatch(DROP, ...)
end

function Item:registerUseEvent(trigger)
    return Event(self, USE)(trigger)
end

function Item:dispatchUseEvent(...)
    return self:eventDispatch(USE, ...)
end

function Item:registerSellEvent(trigger)
    return Event(self, SELL)(trigger)
end

function Item:dispatchSellEvent(...)
    return self:eventDispatch(SELL, ...)
end

return Item