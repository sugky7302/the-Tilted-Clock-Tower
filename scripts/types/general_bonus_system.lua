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

function mt:clear(name)
	self[name] = 0
	-- 技能等級全部調到1
	for i = 1,#gbs[name] do
		cj.SetUnitAbilityLevel(self.object, gbs[name][i], 1)
	end
end

function mt:get(name)
	return self[name]
end

function mt:set(name,val)
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

function gbs:__call(u)
	local o = self[js.H2I(u)]
	if o then return o end --呼叫已有實例
	o = {object = u}
  self[js.H2I(u)] = o -- 利用單位呼叫實例
	setmetatable(o,self)
	o.__index = o
	-- 添加模板技能
	for i = 1,10 do
		cj.UnitAddAbility(u,gbs['攻擊'][i])
		cj.UnitAddAbility(u,gbs['護甲'][i])
		cj.UnitAddAbility(u,gbs['力量'][i])
		cj.UnitAddAbility(u,gbs['敏捷'][i])
		cj.UnitAddAbility(u,gbs['智慧'][i])
		cj.UnitAddAbility(u,gbs['生命'][i])
		cj.UnitAddAbility(u,gbs['魔力'][i])
	end
	for i = 11,16 do
		cj.UnitAddAbility(u,gbs['生命'][i])
		cj.UnitAddAbility(u,gbs['魔力'][i])
	end
	return o
end

function gbs.init()
  for i = 1,10 do -- 獲取屬性模板技能
		gbs['攻擊'][i] = base.string2id('GJ00') + i - 1 
		gbs['護甲'][i] = base.string2id('HJ00') + i - 1
		gbs['力量'][i] = base.string2id('LL00') + i - 1
		gbs['敏捷'][i] = base.string2id('MJ00') + i - 1
		gbs['智慧'][i] = base.string2id('JL00') + i - 1
		gbs['生命'][i] = base.string2id('SM00') + i - 1
		gbs['魔力'][i] = base.string2id('ML00') + i - 1
	end
  for i = 11,16 do
    gbs['生命'][i] = base.string2id('SM00') + i - 1
		gbs['魔力'][i] = base.string2id('ML00') + i - 1
  end
end

return gbs