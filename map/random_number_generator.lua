        local setmetatable = setmetatable
        local gcf = require 'greatest_common_factor'
        local math = math
        local RandomNumberGenerator = {}
        local mt = {}
        setmetatable(RandomNumberGenerator, RandomNumberGenerator)
        RandomNumberGenerator.__index = mt
        -- 本地函數聲明
        local GenerateNewCards = nil
        -- 功能：生成以《超幾何分配》為原理的隨機數牌組
        function RandomNumberGenerator:__call(cardsLabel, probability)
            local obj = GenerateNewCards(probability)
            self[cardsLabel] = obj
            obj:GenerateValidCards()
            return obj
        end
        -- 功能：生成新牌組
        -- 描述：計算最大公因數，生成新牌組，並調整牌數，使其牌數超過10張
        GenerateNewCards = function(probability)
            local gcd = gcf(probability, 100)
            local validCardCount = probability / gcd
            local totalCardCount = 100 / gcd
            if totalCardCount < 10 then
                local fixedMultiple = math.modf(10 / totalCardCount) + 1
                validCardCount = validCardCount * fixedMultiple
                totalCardCount = totalCardCount * fixedMultiple
            end
            local obj = {usedCardNumber = 0, validCardCount = validCardCount, totalCardCount = totalCardCount}
            setmetatable(obj, RandomNumberGenerator)
            obj.__index = obj
            return obj
        end
        -- 功能：獲取牌組的牌是否有效
        function mt:GetCard()
            if self.usedCardNumber < self.totalCardCount then
                self.usedCardNumber = self.usedCardNumber + 1
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
                        currentValidCard = currentValidCard + 1
                    else
                        self[i] = false
                    end
                end
            end
            local i = self.totalCardCount
            while currentValidCard < self.validCardCount do
                if self[i] == false then
                    self[i] = true
                    currentValidCard = currentValidCard + 1
                end
                i = i - 1
            end
        end
        return RandomNumberGenerator
    