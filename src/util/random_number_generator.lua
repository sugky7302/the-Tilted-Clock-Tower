-- 生成以《超幾何分配》為原理的隨機數牌組，在一定次數下必生效。
-- 解決 ex: rand() < 0.3 有可能都不會生效的問題。
-- 一開始創建要給name_、probability_(小於等於100的整數)。

local math = math
local require = require
math.randomseed(tostring(os.time()):reverse():sub(1, 6))

local RNG = require 'util.class'("RNG")

-- assert
local GenerateDeck, GenerateValidCards

function RNG:_new(probability, cards_label)
    local instance = {
        _used_card_count_  = 0,
        _valid_card_count_ = 0,
        _total_card_count_ = 0
    }

    GenerateDeck(instance, probability)
    GenerateValidCards(instance)

    if cards_label then
        RNG:setInstance(cards_label, instance)
    end

    return instance
end

GenerateDeck = function(self, probability)
    local gcf = require 'util.greatest_common_factor'
    
    -- 計算牌數
    local gcd = gcf(probability, 100)
    local valid_card_count, total_card_count = probability / gcd, 100 / gcd

    -- 調整 <10張 的牌組
    if total_card_count < 10 then
        local change_ratio = math.modf(10 / total_card_count) + 1

        valid_card_count = valid_card_count * change_ratio
        total_card_count = total_card_count * change_ratio
    end

    self._used_card_count_  = 0
    self._valid_card_count_ = valid_card_count
    self._total_card_count_ = total_card_count
end

-- 抽牌
function RNG:draw()
    if self._used_card_count_ >= self._total_card_count_ then
        self:reset()
    end

    self._used_card_count_ = self._used_card_count_ + 1
    return self[self._used_card_count_]
end

function RNG:reset()
    self._used_card_count_ = 0
    GenerateValidCards(self)
end

-- 創建有效牌和無效牌
GenerateValidCards = function(self)
    local rand = require 'util.math_lib'.rand

    local current_valid_card_count = 0
    for i = 1, self._total_card_count_ do
        if (rand() > 0.5) and (current_valid_card_count < self._valid_card_count_) then
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

function RNG:count()
    return self._total_card_count_
end

return RNG