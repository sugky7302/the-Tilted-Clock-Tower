local cj = require 'jass.common'
local js = require 'jass_tool'
local setmetatable = setmetatable
local math = math

local gbs = {
    ['攻擊'] = {},
    ['護甲'] = {},
    ['力量'] = {},
    ['敏捷'] = {},
    ['智慧'] = {},
    ['生命'] = {},
    ['魔力'] = {}
}
local mt = {}
setmetatable(gbs,gbs)
gbs.__index = mt

function gbs.Init()
    for i = 1, 10 do -- 獲取屬性模板技能
        gbs['攻擊'][i] = Base.String2Id('GJ00') + i - 1 
        gbs['護甲'][i] = Base.String2Id('HJ00') + i - 1
        gbs['力量'][i] = Base.String2Id('LL00') + i - 1
        gbs['敏捷'][i] = Base.String2Id('MJ00') + i - 1
        gbs['智慧'][i] = Base.String2Id('JL00') + i - 1
        gbs['生命'][i] = Base.String2Id('SM00') + i - 1
        gbs['魔力'][i] = Base.String2Id('ML00') + i - 1
    end
    for i = 11, 16 do
        gbs['生命'][i] = Base.String2Id('SM00') + i - 1
        gbs['魔力'][i] = Base.String2Id('ML00') + i - 1
    end
end

function gbs:__call(u)
    local obj = self[js.H2I(u)]
    if obj then return obj end --呼叫已有實例
    obj = {object = u}
    self[js.H2I(u)] = obj -- 利用單位呼叫實例
    setmetatable(obj,self)
    obj.__index = obj
    -- 添加模板技能
    for i = 1, 10 do
        cj.UnitAddAbility(u,gbs['攻擊'][i])
        cj.UnitAddAbility(u,gbs['護甲'][i])
        cj.UnitAddAbility(u,gbs['力量'][i])
        cj.UnitAddAbility(u,gbs['敏捷'][i])
        cj.UnitAddAbility(u,gbs['智慧'][i])
        cj.UnitAddAbility(u,gbs['生命'][i])
        cj.UnitAddAbility(u,gbs['魔力'][i])
    end
    for i = 11, 16 do
        cj.UnitAddAbility(u,gbs['生命'][i])
        cj.UnitAddAbility(u,gbs['魔力'][i])
    end
    return obj
end

function mt:Clear(name)
    self[name] = 0
    -- 技能等級全部調到1
    for i = 1, #gbs[name] do
        cj.SetUnitAbilityLevel(self.object, gbs[name][i], 1)
    end
end

function mt:Get(name)
    return self[name]
end

function mt:Set(name, val)
    local i = 1
    while val > 0 do
        if val%2 > 0 then
            cj.SetUnitAbilityLevel(self.object, gbs[name][i], 2)
        else
            cj.SetUnitAbilityLevel(self.object, gbs[name][i], 1)
        end
        val = math.modf(val / 2)
        i = i + 1 
    end
    self[name] = val
end

function mt:erase()
    gbs[js.H2I(self.object)] = nil
    self = nil
end

return gbs