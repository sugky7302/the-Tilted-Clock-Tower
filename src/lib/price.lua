local Price = require 'util.class'("Price")
local math = math

local DealNegativeValue, DealDecimal, DealCarrying
local RATIO = 10^3

function Price:_new(gold, silver, copper)
    gold, silver, copper = gold or 0, silver or 0, copper or 0
    gold, silver, copper = DealNegativeValue(gold, silver, copper)
    gold, silver, copper = DealDecimal(gold, silver, copper)
    gold, silver, copper = DealCarrying(gold, silver, copper)
    
    return {
        gold_ = gold,
        silver_ = silver,
        copper_ = copper
    }
end

local 
DealNegativeValue = function(gold, silver, copper)
    if gold < 0 then
        return 0, 0, 0
    end

    if silver < 0 then
        local need = math.floor(math.abs(silver / RATIO)) + 1
        if gold < need then
            return 0, 0, 0
        end

        gold = gold - need
        silver = need * RATIO + silver
    end
    silver = math.max(0, silver or 0)
    copper = math.max(0, copper or 0)

    return gold, silver, copper
end

DealDecimal = function(gold, silver, copper)
    local gold_integer, gold_decimal = math.modf(gold)
    local silver_integer, silver_decimal = math.modf(silver + gold_decimal * RATIO)
    copper = math.modf(copper + silver_decimal * RATIO)

    return gold_integer, silver_integer, copper
end

local mod

DealCarrying = function(gold, silver, copper)
    local copper_carry, copper_remain = mod(copper, RATIO)
    local silver_carry, silver_remain = mod(silver + copper_carry, RATIO)
    local gold_remain = gold + silver_carry

    return gold_remain, silver_remain, copper_remain
end

mod = function(number, mod_value)
    local carry = math.modf(number / mod_value)
    local remain = number - carry * mod_value
    return carry, remain
end

function Price:__tostring()
    return table.concat({math.modf(self.gold_), "金", math.modf(self.silver_), "銀", math.modf(self.copper_), "銅"})
end

function Price:__add(price)
    return Price(self.gold_ + price.gold_, self.silver_ + price.silver_, self.copper_ + price.copper_)
end

function Price:__sub(price)
    return Price(self.gold_ - price.gold_, self.silver_ - price.silver_, self.copper_ - price.copper_)
end

function Price:__mul(ratio)
    return Price(self.gold_ * ratio, self.silver_ * ratio, self.copper_ * ratio)
end

function Price:__div(ratio)
    return Price(self.gold_ / ratio, self.silver_ / ratio, self.copper_ / ratio)
end

return Price