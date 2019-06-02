local require = require
local Item = require 'util.class'("Item")
local Price = require 'lib.price'


function Item:_new(tb)
    if tb then
        tb._id_ = tb.id or GenerateNewId()
        tb._name_ = tb.name or ""
        tb._kind_ = tb.kind or ""
        tb._type_ = tb.type or ""
        tb._owner_ = tb.owner or nil
        tb._price_ = tb.price or Price()
        tb._object_ = tb.object or nil
        tb._description_ = tb.description or ""

        return tb
    end
end

function Item:isSameType(object)
    if type(object) == "string" then
        return self._type_ == object
    end

    return self._type_ == object._type_
end

function Item:isSameKind(object)
    if type(object) == "string" then
        return self._kind_ == object
    end

    return self._kind_ == object._kind_
end

function Item:getOwnPlayer()
    if self._owner_ then
        return self._owner_.getOwner()
    end

    return nil
end

function Item:getPrice()
    return self._price_.get()
end


local Event = require 'lib.event'

function Item:registerPickUpEvent(trigger)
    return Event(self, "物品-拾取")(trigger)
end

function Item:registerDropEvent(trigger)
    return Event(self, "物品-丟棄")(trigger)
end

function Item:registerUseEvent(trigger)
    return Event(self, "物品-使用")(trigger)
end

function Item:registerSellEvent(trigger)
    return Event(self, "物品-販售")(trigger)
end