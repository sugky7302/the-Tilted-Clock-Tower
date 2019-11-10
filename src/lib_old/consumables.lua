local require = require
local Consumables = require 'util.class'("Consumables", require 'lib.item')

function Consumables:_new(tb)
    local instance = self:super():_new(tb)
    instance._count_ = tb.count or 0
    return instance
end

function Consumables:setCount(count)
    self._count_ = count
end

function Consumables:getCount()
    return self._count_
end

function Consumables:addCount(count)
    self._count_ = self._count_ + count
end

return Consumables