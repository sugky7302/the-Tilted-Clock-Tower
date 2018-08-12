--[[

texttag 0.2.0 2018-04-28

------------------------------------------------------------------------------------------------------------------ 
描述:
  此系統能產生曲線型的漂浮文字。

------------------------------------------------------------------------------------------------------------------
變量解釋:
--------
  全域變量:
  - g_recycle               - queue
    收集閒置空間的編號。

  - g_matrix                - table
    texttag執行區。

  - g_size_min              - number
    初始大小。

  - g_size_bonus            - number
    增加大小。

  - g_time_life             - number
    維持秒數。

  - g_time_fade             - number
    淡出秒數。

  - g_z_offset              - number
    高度。

  - g_z_offset_bonus        - number
    增加的高度。

  - g_velocity              - number
    平面的速度。

  - g_angle                 - number
    移動角度。angle=true才會生效。

  - g_angle_rnd             - number
    移動角度為固定或隨機。

  - g_timer                 - timer (timer in JASS)
    計時器。

--------
  函數:
  - texttag:__call          - function
    調用函數。

  - mt:combat_word          - funciton
    接口函數。
    
--------
  參數:
  - msg                     - string
    文字訊息。

  - x                       - number
    漂浮文字的x座標。

  - y                       - number
    漂浮文字的y座標。

  - t                       - number
    維持秒數。

  - as                      - number
    y座標的位移量。

  - ac                      - number
    x座標的位移量。

  - ah                      - number
    z座標的位移量。

  - size                    - number
    字體大小。

------------------------------------------------------------------------------------------------------------------
開發日誌:
  0.2.0 - 2018-04-28
    Added:
    - 添加註解，完善說明檔。
    - 修改變量名稱。

    Question:
    - 計時器在執行多工時，161行的v會出現nil值的情況。

  0.1.0 - 2018-04-01 - 啟動專案
    Added:
    - 根據lua的特性重寫JASS架構。

]]
local cj = require 'jass.common'
local js = require 'jass_tool'
local math = math
local setmetatable = setmetatable
local timer = require 'timerutils'
local queue = require 'queue'
local table = table
local custom_tool = require 'custom_tool'

local texttag = {}
local mt = {}
setmetatable(texttag,texttag)
texttag.__index = mt

-- 本地變量
texttag.g_recycle = queue()
texttag.g_matrix = {}
texttag.g_size_min = 0.018
texttag.g_size_bonus = 0.012
texttag.g_time_life = 0.7
texttag.g_time_fade = 0.3
texttag.g_z_offset = 20
texttag.g_z_offset_bonus = 55
texttag.g_velocity = 5
texttag.g_angle = math.pi / 2
texttag.g_angle_rnd = true
texttag.g_timer = timer()

-- 函數
function texttag:__call(s, u, size)
  local a
  if self.g_angle_rnd then a = cj.GetRandomReal(0,2*math.pi)
  else a = self.g_angle end
  local o = {
    msg = s,
    x = cj.GetUnitX(u),
    y = cj.GetUnitY(u),
    t = self.g_time_life,
    as = math.sin(a) * self.g_velocity,
    ac = math.cos(a) * self.g_velocity,
    ah = 0,
    size = size
  }
  if self.g_recycle:size() == 0 then table.insert(self.g_matrix,o) -- 把實例放入texttag的數字區，統一執行
  else -- 如果回收區有收錄texttag的閒置空間，則使用閒置空間
    -- table.insert(self.g_matrix, self.g_recycle:front(), o)
    self.g_matrix[self.g_recycle:front()] = o
    self.g_recycle:pop()
  end
  setmetatable(o,self)
  o.__index = o
  if cj.IsUnitVisible(u,cj.GetLocalPlayer()) then -- 如果玩家能看見單位，則顯示漂浮文字
    o.tt = cj.CreateTextTag()
    cj.SetTextTagPermanent(o.tt,false)
    cj.SetTextTagLifespan(o.tt,o.t)
    cj.SetTextTagFadepoint(o.tt,self.g_time_fade)
    cj.SetTextTagText(o.tt, s, size * self.g_size_min)
    cj.SetTextTagPos(o.tt, o.x, o.y, size * self.g_z_offset)
  end
  if self.g_recycle:size() == 0 then --啟動計時器
    cj.TimerStart(self.g_timer, 0.03125, true, function()
      local p
      local leng = 0
      for i,v in pairs_by_keys(self.g_matrix) do
        p = math.sin(math.pi * o.t) -- 文字的運動軌跡
        -- print(i .. " - " .. v.t .. " - " .. v.size * (self.g_z_offset + self.g_z_offset_bonus * p) .. " - " .. v.size * (self.g_size_min + self.g_size_bonus * p))
        v.t = v.t - 0.03125
        v.x = v.x + v.ac
        v.y = v.y + v.as
        cj.SetTextTagPos(v.tt, v.x, v.y, v.size * (self.g_z_offset + self.g_z_offset_bonus * p))
        cj.SetTextTagText(v.tt, v.msg, v.size * (self.g_size_min + self.g_size_bonus * p))
        if v.t <= 0 then
          cj.DestroyTextTag(v.tt)
          v.tt = nil
          self.g_recycle:push(i)
          --v = nil
          table.remove(self.g_matrix,i)
          leng = leng - 1 -- 先扣掉數量，底下計算數量時才不會算進去。
        end
        leng = leng + 1 -- 計算尚在運作的漂浮文字的數量
      end
      print(" ")
      if leng == 0 then cj.PauseTimer(self.g_timer) end -- 如果沒有漂浮文字運作，就關閉計時器
    end)
  end
  return o
end

function mt:combat_word(u, val, size, texttype)
  if texttype == '治療' then self.msg = '|cff00ff00' .. math.modf(val)
  elseif texttype == '回魔' then self.msg = '|cff3366ff' .. math.modf(val)
  elseif texttype == '法術' then
    if val > 0 then
      self.msg = '|cffffff00' .. math.modf(val)
    elseif val == 0 then
      self.msg = '|cffff0000' .. '抵抗!'
    else self.msg = '|cffff0000' .. "忽視!" end
  else
    if val > 0 then self.msg = math.modf(val)
    elseif val == 0 then self.msg = '|cffff0000' .. "閃躲!"
    else self.msg = '|cffff0000' .. "忽視!" end
  end
  texttag(self.msg, u, size)
end

return texttag