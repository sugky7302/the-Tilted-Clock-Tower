local setmetatable = setmetatable
local GreatestCommonFactor = require "GreatestCommonFactor"
local math = math

local RandomNumberGenerator = {_VERSION = "0.1.1"}
local mt = {}
setmetatable(RandomNumberGenerator, RandomNumberGenerator)
RandomNumberGenerator.__index = mt

-- 函數聲明
mt.GetCard = nil
mt.ResetCards = nil
mt.GenerateValidCards = nil
local GenerateNewCards = nil


-- 功能：生成以《超幾何分配》為原理的隨機數牌組
function RandomNumberGenerator:__call(cardsLabel, probability)
    local object = GenerateNewCards(probability)

    self[cardsLabel] = object
    object:GenerateValidCards()

    return object
end

-[[
    功能：生成新牌組
    描述：計算最大公因數，生成新牌組，並調整牌數，使其牌數超過10張
-]]
local function GenerateNewCards(probability)
    local gcd = GreatestCommonFactor(probability, 100)
    local validCardCount = probability / gcd
    local totalCardCount = 100 / gcd

    if totalCardCount < 10 then
        local fixedMultiple = math.modf(10 / totalCardCount) + 1
        validCardCount *= fixedMultiple
        totalCardCount *= fixedMultiple
    end

    local object = {usedCardNumber = 0, validCardCount = validCardCount, totalCardCount = totalCardCount}
    setmetatable(object, RandomNumberGenerator)
    object.__index = object

    return object
end

-- 功能：獲取牌組的牌是否有效
function mt:GetCard()
    if self.usedCardNumber < self.totalCardCount then
        self.usedCardNumber += 1
        return self[self.usedCardNumber]
    else
        self:ResetCards()
        return self:GetCard()
    end
end

-- 功能：重置牌組
function mt:ResetCards()
    self.usedCardNumber = 0
    self:GenerateValidCards()
end

-- 功能：創建有效牌和無效牌
function mt:GenerateValidCards()
    local currentValidCard = 0
    
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    for i = 1, self.totalCardCount do
        if currentValidCard < self.validCardCount then
            if math.random() < 0.5 then
                self[i] = true
                currentValidCard += 1
            else
                self[i] = false
            end
        end
    end

    local i = self.totalCardCount
    while currentValidCard < self.validCardCount do
        if self[i] == false then
            self[i] = true
            currentValidCard += 1
        end
        i -= 1
    end
end

return RandomNumberGenerator