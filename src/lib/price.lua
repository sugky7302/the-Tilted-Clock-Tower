local Price = require 'util.class'("Price")
local math = math
local table = table


local RATIO = 10^3
local DealNegativeValue, DealDecimal, DealCarrying

function Price:_new(...)
    local money = {...}
    money = DealNegativeValue(money)
    money = DealDecimal(money)
    money = DealCarrying(money)
    money._units_ = {"金", "銀", "銅"}

    return money
end

DealNegativeValue = function(money)
    local need 

    for i = #money, 2, -1 do
        if money[i] < 0 then
            for j = i-1, 1, -1 do
                need = math.floor(math.abs(money[i] / RATIO^(i-j))) + 1
                if money[j] >= need then
                    money[j] = money[j] - need
                    money[i] = money[i] + RATIO^(i-j) * need
                end
            end
        end
    end

    return money
end

DealDecimal = function(money)
    local decimal = 0
    for i = 1, #money do
        money[i], decimal = math.modf(money[i] + decimal * RATIO)
    end

    return money
end

local Mod

DealCarrying = function(money)
    local carry = 0
    for i = #money, 1, -1 do
        carry, money[i] = Mod(money[i] + carry, RATIO)
    end

    return money
end

Mod = function(number, mod_value)
    local carry = math.modf(number / mod_value)
    local remain = number - carry * mod_value
    return carry, remain
end

function Price:__tostring()
    local print_str = {}
    for i = 1, #self do
        print_str[#print_str+1] = math.modf(self[i])
        print_str[#print_str+1] = self._units_[i] or " "
    end
    
    return table.concat(print_str)
end

local CalculateTable

function Price:__add(price)
    return Price(CalculateTable(self, price, 1))
end

function Price:__sub(price)
    return Price(CalculateTable(self, price, -1))
end

CalculateTable = function(price1, price2, sign)
    local price_new = {}
    local length = math.max(#price1, #price2)
    
    for i = 1, length do
        price_new[#price_new+1] = (price1[i] or 0) + sign * (price2[i] or 0)
    end

    return table.unpack(price_new)
end

local CalculateScalar

function Price:__mul(ratio)
    return Price(CalculateScalar(self, ratio, 1))
end

function Price:__div(ratio)
    return Price(CalculateScalar(self, ratio, -1))
end

CalculateScalar = function(price, scalar, sign)
    local price_new = {}
    for i = 1, #price do
        price_new[#price_new+1] = price[i] * scalar^sign
    end

    return table.unpack(price_new)
end

function Price:setUnits(unit_table)
    self._units_ = unit_table
end

return Price