-- 此module會生成以《超幾何分配》為原理的隨機數牌組，在一定次數下必生效
-- 解決 ex: rand() < 0.3 有可能都不會生效的問題

local setmetatable = setmetatable

local math = math
math.randomseed(tostring(os.time()):reverse():sub(1, 6))

local RandomNumberGenerator, mt = {}, {}
setmetatable(RandomNumberGenerator, RandomNumberGenerator)
RandomNumberGenerator.__index = mt

-- assert
local _GenerateDeck, _GenerateValidCards

function RandomNumberGenerator:__call(cards_label, probability)
    local instance = self[cards_label]

    if not instance then
        instance = _GenerateDeck(probability)
        _GenerateValidCards(instance)

        self[cards_label] = instance
    end

    return instance
end

_GenerateDeck = function(probability)
    -- 計算牌數
    local gcf = require 'greatest_common_factor'
    local gcd = gcf(probability, 100)
    local valid_card_count, total_card_count = probability / gcd, 100 / gcd

    -- 調整 <10張 的牌組
    if total_card_count < 10 then
        local modf = math.modf
        local change_ratio = modf(10 / total_card_count) + 1

        valid_card_count = valid_card_count * change_ratio
        total_card_count = total_card_count * change_ratio
    end

    local instance = {
        _used_card_count_ = 0,
        _valid_card_count_ = valid_card_count,
        _total_card_count_ = total_card_count
    }
    setmetatable(instance, RandomNumberGenerator)
    return instance
end

-- 抽牌
function mt:draw()
    if self._used_card_count_ >= self._total_card_count_ then
        self:Reset()
    end

    self._used_card_count_ = self._used_card_count_ + 1
    return self[self._used_card_count_]
end

function mt:Reset()
    self._used_card_count_ = 0
    _GenerateValidCards(self)
end

-- 創建有效牌和無效牌
_GenerateValidCards = function(self)
    local rand = require 'math_lib'.Random
    local current_valid_card_count = 0
    for i = 1, self._total_card_count_ do
        --rand()只會生成 0, 1 兩個數，所以可以分別有效、無效
        if (rand() == 1) and (current_valid_card_count < self._valid_card_count_) then
            self[i] = true
            current_valid_card_count = current_valid_card_count + 1
        else
            self[i] = false
        end
    end

    -- 補足有效牌
    local demands = self._valid_card_count_ - current_valid_card_count
    for i = self._total_card_count_, 1, -1 do
        if demands == 0 then
            return true
        end
        
        if self[i] == false then
            self[i] = true
            demands = demands - 1
        end
    end
end

return RandomNumberGenerator