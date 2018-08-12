local cj = require 'jass.common'
local js = require 'jass_tool'
local timer = require 'timerutils'
local point = require 'point'
local slk = require 'jass.slk'
local group = require 'grouputils'
local gbs = require 'general_bonus_system'
local war3 = require 'api'
local setmetatable = setmetatable

local race = {'龍族', '元素', '靈魂', '動物', '人形', '人造', '惡魔'}
local unit = {}
local mt = {} -- 功能區
setmetatable(unit,unit)
unit.__index = mt

function mt:is_alive() return self['生命'] > 0 end
function mt.kill(u) cj.RemoveUnit(u) end

-- 初始化單位狀態
function mt:init_state()
  local p = slk.unit[base.id2string(cj.GetUnitTypeId(self.object))]
  self.type = cj.IsUnitType(self.object,cj.UNIT_TYPE_HERO) and 'hero' or 'unit'
  self['最大生命'] = cj.GetUnitState(self.object,cj.UNITX_STATE_MAX_LIFE)
  self['生命'] = cj.GetUnitState(self.object,cj.UNITX_STATE_LIFE)
  self['最大魔力'] = cj.GetUnitState(self.object,cj.UNITX_STATE_MAX_MANA)
  self['魔力'] = cj.GetUnitState(self.object,cj.UNITX_STATE_MANA)
  self['護甲'] = p.def
  self['最小傷害'] = p.dmgplus1 + p.dice1
  self['最小傷害'] = p.dmgplus1 + p.dice1 * p.sides1
  self['攻擊間隔'] = p.cool1
  self['攻擊範圍'] = p.rangeN1
  self['移動速度'] = p.spd
  self['轉身速度'] = p.turnRate
  self['魔力恢復'] = p.regenMana
  self['生命恢復'] = p.regenHP
  self['物理傷害增幅'] = 0
  self['物理傷害減幅'] = 0
  self['物理傷害加深'] = 0
  self['物理傷害降低'] = 0
  self['物理暴擊'] = 0
  self['法術傷害增幅'] = 0
  self['法術傷害減幅'] = 0
  self['法術傷害加深'] = 0
  self['法術傷害降低'] = 0
  self['法術暴擊'] = 0
  if self.type == 'hero' then
    self['法術能量'] = cj.GetHeroStr(self.object,false) or 0
    self['暴擊'] = cj.GetHeroAgi(self.object,false) or 0
    self['急速'] = cj.GetHeroInt(self.object,false) or 0
    self['耐力'] = 0
    self['精神'] = 0
    self['韌性'] = 0
    self['閃避'] = 0
    self['抵擋'] = 0
    self['精通'] = 0
    self['穿透'] = 0
    self['吸血'] = 0
    self['暴擊倍率'] = 1
    self['機率回魔'] = 0
    self['額外法術傷害'] = 0
    self['額外物理傷害'] = 0
    self['最後法術傷害'] = 0
    self['最後物理傷害'] = 0
    self['定身'] = 0
    self['暈眩'] = 0
    self['凍結'] = 0
    self['沉默'] = 0
    self['攻擊速度'] = 0
    self['技能係數加成'] = 0
    self['持續傷害'] = 0
    self['濺射'] = 0   
    self['擊殺回魔'] = 0
    self['減耗'] = 0
    self['冷卻縮減'] = 0
    self['龍族'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['元素'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['靈魂'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['動物'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['人形'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['人造'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['惡魔'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['物理'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['火焰'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['冰霜'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['閃電'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['毒素'] = {0,0,0} -- 1:定值增傷 2:百分比增傷 3:抗性
    self['物品觸發技能'] = {
      ['閃電鏈'] = 0,
      ['火焰呼吸'] = 0,
      ['霜凍閃電'] = 0,
      ['暗影突襲'] = 0
    }
    self['反彈'] = 0

    local trg = war3.CreateTrigger(function() -- 英雄復活
      local t = timer()
      cj.TimerStart(t, 20, false, function()
        cj.ReviveHero(self.object,self.revive.x,self.revive.y,true)
        timer.erase(t)
      end)
    end)
    cj.TriggerRegisterUnitEvent(trg, self.object, cj.EVENT_UNIT_DEATH)
  end
  if self.type == 'unit' then
    self['種族'] = race[p.goldcost]
    self['刷新時間'] = p.stockRegen
    local trg = war3.CreateTrigger(function()
      local id = js.U2Id(self.object) -- 移除單位前先存單位id才不會讀不到
      local t = timer()
      self.kill(self.object)
      self:erase() -- 移除實例
      cj.TimerStart(t, self['刷新時間'], false, function()
        local u = cj.CreateUnit(cj.Player(cj.PLAYER_NEUTRAL_AGGRESSIVE), id, self.revive.x, self.revive.y, cj.GetRandomReal(0,180))
        unit(u) -- 新單位註冊實例
        timer.erase(t)
        war3.DestroyTrigger(trg)
      end)
    end)
    cj.TriggerRegisterUnitEvent(trg, self.object, cj.EVENT_UNIT_DEATH)
  end
end 

-- 更新單位狀態
function mt:refresh_state()
end

-- 獲得定值加成
function mt:constant_bonus(a)
  return self[a['屬性']][1]
end

-- 獲得百分比型加成
function mt:percent_bonus(e,r)
  return (1 + self[e][2]) * (1 + self[r][1])
end

-- 獲得精通加成
function mt:pfc_bonus()
  return 1 + self['精通'] / (250 + (cj.GetUnitLevel(self.object) - 1) * 150)
end

-- 獲得基礎加成
function mt:basic_bonus(target,name)
  local a = unit(target)
  return (1 + self[name .. '傷害增幅'] - self[name .. '傷害減幅']) * (1 + a[name .. '傷害加深'] - a[name .. '傷害降低'])
end

-- 獲得韌性
function mt:spd()
  return self['韌性'] / (75 + (cj.GetUnitLevel(self.object) - 1) * 150)
end

-- 獲得急速
function mt:spd()
  return self['急速'] / (165 + (cj.GetUnitLevel(self.object) - 1) * 152)
end

-- 獲得護甲
function mt:amr()
  return self['護甲']
end

-- 獲得抵擋
function mt:blk()
  return 1 - self['抵擋'] / (150 + (cj.GetUnitLevel(self.object) - 1) * 150)
end

-- 獲得元素抗性
function mt:rst(type)
  return 1 - self[type][3] / (50 + (cj.GetUnitLevel(self.object) - 1) * 150)
end

-- 獲得種族抗性
function mt:race_rst(type)
  return (self.type == 'hero') and 1 - self[type][3] or 1
end

-- 獲得穿透機率
function mt:pnt()
  return self['穿透'] / (130 + (cj.GetUnitLevel(self.object) - 1) * 15)
end

function mt:pnt_rate()
  return cj.GetRandomReal(0.01,100) <= self:pnt()
end

-- 獲得閃避機率
function mt:dge()
  return self['閃避'] / (50 + (cj.GetUnitLevel(self.object) - 1) * 150)
end

function mt:dge_rate()
  return cj.GetRandomReal(0.01,100) <= self:dge()
end

-- 獲得暴擊機率
function mt:crt(name)
  return (self['暴擊'] + self[name .. '暴擊']) / (300 + (cj.GetUnitLevel(self.object) - 1) * 150)
end

function mt:crt_rate()
  if cj.GetRandomReal(0.01,100) <= self:crt('法術') then
    return self['暴擊倍率']
  else
    return 1
  end
end

-- 設定單位狀態
function mt:set(name,val)
  self[name] = val
  self:refresh_state()
end

--獲得單位狀態
function mt:get(name)
  return self[name]
end 

function mt:erase()
  unit[js.H2I(self.object)] = nil -- 清除實例
  self = nil
end 

function unit:__call(u)
  local o = unit[js.H2I(u)]
  if not o then
    o = {object = u, revive = point{x = cj.GetUnitX(u),y = cj.GetUnitY(u)}}
    unit[js.H2I(u)] = o -- 利用單位呼叫實例
    setmetatable(o,self)
    o.__index = o
    o:init_state() -- 初始化單位狀態
    gbs(u) -- 註冊屬性系統
  end
  return o
end

function unit.init()
  js.Debug('初始化單位(|cff00ff000%|r)')
  local g = group()
  g:EnumUnitsInRange(0,0,99999,g.null)
  g:loop(function(i,self)
    unit(self[i])
    js.Debug('初始化單位-' .. cj.GetUnitName(self[i]) .. '(|cff00ff00' .. 100*i/self:size() .. '%|r)')
  end)
  js.Debug('初始化完畢...')
end

return unit