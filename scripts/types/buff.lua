--[[

Effect Over Time System for Lua 0.1.0 2018-04-21

------------------------------------------------------------------------------------------------------------------ 
來源:
  Wietlol's Effect Over Time System 2.3.2 2015-07-17
  Moe-Master 的 buff.lua

------------------------------------------------------------------------------------------------------------------ 
描述:
  此系統的目的是創建或新增隨時間變化的效果。
  此系統可用於增減益效果或隨時間改變的傷害。

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
- https://github.com/jin10086/pystandard/wiki/%E9%A1%B9%E7%9B%AE%E6%9B%B4%E6%96%B0%E6%97%A5%E5%BF%97%EF%BC%88CHANGELOG.md%EF%BC%89
- https://www.hiveworkshop.com/threads/gui-effect-over-time-system-2-3-1.261662/

------------------------------------------------------------------------------------------------------------------
開發日誌:
  Unreleased - 2018-05-27 
    Added:
    - 根據來源搭建初始架構。
    - 根據lua的特性調整架構。
    - 添加註解，完善說明檔。

    Changed:
    - 將此檔案和buff.lua合併，並更名為buff.lua。
  
  0.0.0 - 2018-04-20 - 啟動專案
  
]]
local cj = require 'jass.common'
local js = require 'jass_tool'
local timer = require 'TimerUtils'
local war3 = require 'api'
local unit = require 'unit'
local queue = require 'queue'
local setmetatable = setmetatable

local buff = {}
local mt = {}
setmetatable(buff,buff)
buff.__index = mt 

-- 全域變量

-- 變量預設值
mt.type = 'buff'     -- 類型
mt.name = ''         -- 名字
mt.source = nil      -- 來源
mt.target = nil      -- 所有者
mt.cover_type = 0    -- 共存方式(0 = 獨佔，1 = 共存)
mt.cover_max = 0     -- 最大生效數量(僅用於共存的buff)
mt.time = -1         -- 本次週期的持續時間
mt.life_time = 0     -- 總持續時間
mt.pulse = nil       -- 週期
mt.cycle_timer = nil
mt.pulse_count = 0   -- 已經循環的次數
mt.add_time = 0      -- 添加時間
mt.timer = nil       -- 關聯計時器
mt.tip = ''            -- buff說明
mt.send_tip = false  -- 獲得buff時提示說明
mt.is_finish = false -- 是否是正常到期而移除
mt.disable_count = 0 -- 禁用計數
mt.pause_count = 0   -- 暫停計數
mt.force = false     -- 無視暫停

-- 函數
--  暫停
function mt:pause(flag) -- flag 傳入 true or false or nil
	if self.force then
		return
	end
	if flag == nil then -- 沒參數默認暫停
		flag = true
	end
	if flag then
		self.pause_count = self.pause_count + 1
		if self.pause_count == 1 then
			if self.timer then
				self.timer:pause()
			end
			if self.cycle_timer then
				self.cycle_timer:pause()
			end
		end
	else
		self.pause_count = self.pause_count - 1
		if self.pause_count == 0 then
			if self.timer then
				self.timer:resume()
			end
			if self.cycle_timer then
				self.cycle_timer:resume()
			end
		end
	end
end
--  設置buff時間
--   時間
function mt:set_remaining(time_out)
	if time_out < 0 then
		return
	end
	self.life_time = self.life_time + time_out
end