local cj = require 'jass.common'
local js = require 'jass_tool'
local slk = require 'jass.slk'
local timer = require 'timerutils'
local group = require 'grouputils'
local spell = require 'spell'
local damage = require 'damage'
local unit = require 'unit'
local gbs = require 'general_bonus_system'
local buff = require 'buff'
local math = math

local mt = spell('A00H')

-- 技能屬性
mt['屬性'] = '冰霜'
-- 消耗
mt.cost = math.modf(slk.ability.A00H.Cost1)
-- 施法範圍
mt.range = math.modf(slk.ability.A00H.Area1)
-- 冷卻時間
mt.cooldown = math.modf(slk.ability.A00H.Cool1)
-- 效果技能
mt['效果技能'] = 'A00R'
-- 冷卻圖示
mt['冷卻圖示'] = 'I000'
-- 技能係數
mt['最小技能係數'] = 0.9
mt['最大技能係數'] = 1.4

function mt:on_cast_channel()
  local t = timer()
  local g = group(self.caster)
  local n = 2
  --馬甲技能
  local u = cj.CreateUnit(cj.GetOwningPlayer(self.caster), base.string2id('u007'), self.target.x, self.target.y, 0.)
  cj.UnitAddAbility(u,base.string2id(self['效果技能']))
  cj.IssuePointOrder(u, "blizzard", self.target.x, self.target.y)

  g:EnumUnitsInRange(self.target.x, self.target.y, mt.range, g.is_enemy) -- 選取單位
  cj.TimerStart(t, 1, true, function()
    n = n - 1
    local u = unit(self.caster)
    for i = 1,g:size() do
      unit(g[i]):add_buff('減速',3) -- 添加減速效果
      damage{
        type = '法術',
        source = self.caster,
        target = g[i],
        element_type = self['屬性'],
        damage = u['法術能量'] * self:random(),
        bonus_a = u:crt_rate('法術') * u:basic_bonus(g[i],'法術') * u:pfc_bonus() * u:percent_bonus(self['屬性'],unit(g[i])['種族']),
        bonus_b = u:constant_bonus(self) + u['額外法術傷害']
      }
    end
    if n <= 0 then
      timer.erase(t)
      g:erase()
      cj.RemoveUnit(u)
    end
  end)
end
