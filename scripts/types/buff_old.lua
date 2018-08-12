--[[

Buff System for Lua 0.0.0 2018-05-27

------------------------------------------------------------------------------------------------------------------ 
描述:
  此系統的目的是創建或新增隨時間變化的效果，有共存和獨佔兩種模式。

------------------------------------------------------------------------------------------------------------------
變量解釋:
--------
  全域變量:
  - g_amount              - number
    eot實例總量。從 -1 開始。

  - g_unique_id           - number
    當新增實例時，系統配予的唯一索引。從 -1 開始。

  - g_timer               - timer (timer in JASS)
    效果系統的中央計時器，統一執行所有效果。

--------
  接口:
  - on_execute            - function
    預設技能函數。各實例可實現此函數，讓系統執行各實例設定的效果。

--------
  參數:
  - id                    - number
    內部索引，類似handle。

  - source                - unit
    來源單位。

  - target                - unit
    目標單位。

  - duration              - number
    預設持續時間，為一定值。

  - remaining_duration    - number
    剩餘時間。

  - interval              - number
    預設觸發間隔，為一定值。

  - remaining_interval    - number
    剩餘時間的觸發間隔，通常和觸發間隔同。除非臨時更改，才會與預設不同。

  - stack                 - number
    最大層數。

  - remaining_stack       - number
    當前層數。

  - hidden                - boolean
    效果圖標的顯示開關。true為開，false為關，預設為開。

  - buff                  - buff (integer in JASS)
    增減益效果，原型為技能。

  - buff_holder           - ability (integer in JASS)
    buff所屬的技能。

  - buff_holder_level     - number
    上述的等級。

  - ability               - ability (integer in JASS)
    計時結束或移除時，給予目標的技能。

  - ability_level         - number
    上述的等級。

  - positive              - boolean
    是否為增益效果。

  - negative              - boolean
    是否為減益效果。

  - special_effect        - speical effect (effect in JASS)
    附加到目標上的特殊效果。不要自己製作效果，而是創建模型和附著點。

  - special_effect_model  - string
    上述模型的路徑。

  - special_effect_point  - string
    上述附著點的路徑。

  - type                  - number
    buff的主類型。1=增益，2=減益，3=dot。

  - subtype               - number
    buff的次類型。1=增益，2=減益，3=dot。

  - is_paused             - boolean
    暫停尚未到期或觸發的效果。

  - is_refreshed          - boolean
    新效果是否重置舊效果的持續時間。

  - is_covered            - boolean
    新效果是否覆蓋舊效果。

------------------------------------------------------------------------------------------------------------------
參考:
- http://www.ydwe.net/2015/09/buff-system/

------------------------------------------------------------------------------------------------------------------
開發日誌:
  Unreleased - 2018-05-27 
    Changed:
    - 調整回調函數。
  
  0.0.0 - 2018-04-05 - 啟動專案
  
]]

local cj = require 'jass.common'
local js = require 'jass_tool'
local unit = require 'unit'
local queue = require 'queue'
local timer = require 'timerutils'
local setmetatable = setmetatable

local buff = {}
local mt = {}
setmetatable(buff,buff)
buff.__index = mt 

function mt:add_stack(val) -- 增加層數
  self:set_stack(self:get_stack() + val)
end 

function mt:get_pulse() -- 獲取週期
  return self.pulse
end

function mt:get_remaining() -- 獲取剩餘時間
  return self.time
end 

function mt:get_stack() -- 獲取層數
  return self.stack
end 

function mt:remove() -- 移除狀態
end 

function mt:set_pulse(val) -- 設置週期
  self.pulse = val
end 

function mt:set_remaining(val) -- 設置剩餘時間
  self.time = val
end 

function mt:set_stack(val) -- 設置層數
  self.stack = val or self.stack_max
end 

function mt:on_add() end -- 單位獲取該狀態時觸發此事件
function mt:on_cover() end -- 疊加事件。每當有新的同名狀態添加道單位身上時觸發此事件。
function mt:on_finish() end -- 完成事件。每當狀態因持續時間耗盡而被移除時觸發此事件，會比on_remove事件先觸發
function mt:on_pulse() end -- 週期事件。根據pulse的設置，週期性觸發的事件
function mt:on_remove() end -- 失去事件。每當狀態被移除時觸發此事件。

function buff:__call(o)
  local a = self[o.name]
  local t = timer()
  cj.UnitAddAbility(o.object,base.string2id(a.id))
  a:on_add()
  cj.TimerStart(t, a.pulse, true, function()
    o.time = o.time - a.pulse
    a:on_cover()
    a:on_pulse()
    if o.time <= 0 or a:remove() then
      a:on_finish()
      a:on_remove()
      cj.UnitRemoveAbility(o.object,base.string2id(a.id))
      timer.erase(t)
      o = nil
    end
  end)
end

function unit.__index:add_buff(name,dur)
  buff{
    name = name,
    object = self.object,
    time = dur,
    stack = 1
  }
end

function unit.__index.remove_buff(self,name)
end

function unit.__index.find_buff(self,name)
end

return buff