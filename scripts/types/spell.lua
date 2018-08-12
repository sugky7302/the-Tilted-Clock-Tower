local cj = require 'jass.common'
local js = require 'jass_tool'
local jgb = require 'jass.globals'
local slk = require 'jass.slk'
local war3 = require 'api'
local point = require 'point'
local timer = require 'timerutils'
local unit = require 'unit'
local math = math

local spell = {}
local mt = {} -- 功能區
setmetatable(spell,spell)
spell.__index = mt

--技能類型
-- 施法時間
mt.cast_time = nil
-- 施法者
mt.caster = nil
-- 目標(單位或點)
mt.target = nil
-- 目標類型(單位或點)
mt.target_type = nil
-- 技能係數加成
mt['技能係數加成'] = 0

function mt:on_cooldown() -- 只有第一次會冷卻成功，之後秒數會被拆成2部分，一開始先讀11，後面讀sec-11
  local sec = math.max(10,10*self.cooldown) -- 設定時間，最小不能低於1秒(0.1精度)
  cj.SetPlayerAbilityAvailable(cj.GetOwningPlayer(self.caster), self.id, false) -- 禁用原技能，改成冷卻圖標
  cj.AddItemToStock(self.caster,base.string2id(self['冷卻圖示']), sec, sec)
  local t = timer()
  cj.TimerStart(t, 0.1, true, function()
    sec = sec - 1
    cj.RemoveItemFromStock(self.caster,base.string2id(self['冷卻圖示'])) -- 重建冷卻圖標
    if sec <= 0 then
      cj.SetPlayerAbilityAvailable(cj.GetOwningPlayer(self.caster), self.id, true)
      timer.erase(t)
      return 
    end
    cj.AddItemToStock(self.caster,base.string2id(self['冷卻圖示']), sec, sec)
  end)
end

function mt:random()
  return cj.GetRandomReal(self['最小技能係數'],self['最大技能係數']) + unit(self.caster)['技能係數加成'] + self['技能係數加成']
end

function mt:cp()
  if self.cast_time > 0 then
    --self.cp_tag()
  else
    --self:on_cast_channel()
  end
end

function spell.init()
  local trg = war3.CreateTrigger(function()
    local self = spell(cj.GetSpellAbilityId())
    self.caster = cj.GetTriggerUnit()
    self.target = (js.H2I(cj.GetSpellTargetUnit()) > 0) and cj.GetSpellTargetUnit() or point{
      x = cj.GetLocationX(cj.GetSpellTargetLoc()),
      y = cj.GetLocationY(cj.GetSpellTargetLoc())
    }
    -- 用lua的判斷法會一直判斷成unit，因此利用handle值來獲取有無單位
    self.target_type = (js.H2I(cj.GetSpellTargetUnit()) > 0) and 'unit' or 'point'
    --print(self.target_type) -- 測試英雄施法是否進入此觸發
    self:on_cast_channel() -- 施法前搖
    self:on_cooldown() -- 冷卻
  end)
  cj.TriggerRegisterUnitEvent(trg, jgb.gg_unit_Hamg_0009, cj.EVENT_UNIT_SPELL_EFFECT)
  --print(cj.GetUnitName(jgb.gg_unit_Hamg_0009)) -- 獲得地圖上的單位名字
end

function spell:erase()
  spell[self.id] = nil
  spell[self.name] = nil -- 清除索引
  self = nil
end

function spell:__call(i)
  local id = (type(i) == 'string') and base.string2id(i) or i
  o = spell[id] or {id = id,name = slk.ability[base.id2string(id)].name}
  setmetatable(o,self)
  o.__index = o
  spell[id] = o
  spell[o.name] = o
  return o
end

return spell
