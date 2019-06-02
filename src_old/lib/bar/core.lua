-- 此module會在英雄身上創建狀態條
-- 依賴
--   point
--   texttag.core
--   jass.common
--   color

-- package
local require = require
local Point = require 'point'
local Texttag = require 'texttag.core'

local Bar = require 'class'("Bar", Texttag)

-- assert
local motivation = Point(-40, 0)

local Initialize, Update

-- unit是Unit實例，不是單位
function Bar:_new(unit, value, timeout, color, is_reverse, initialize, update)
    local SIZE = 0.015

    local unit_loc = Point.GetUnitLoc(unit.object_)
    
    self._msg_ = Bar.GetBarModel(0, value or timeout, color, is_reverse)
    self._loc_ = unit_loc + motivation
    self._timeout_ = timeout
    self._value_ = 0 -- 記錄當前值，計算條的變色比例
    self._max_value_ = value or timeout -- 記錄最大值，計算條的變色比例
    self._size_ = SIZE
    self._is_reverse_ = is_reverse
    self._color_ = color
    self._owner_ = unit

    self.Initialize = initialize or Initialize
    self.Update = update or Update

    unit_loc:Remove()

    Texttag._new(self)
end

-- assert
local cj = require 'jass.common'
local Z_OFFSET = 150

Initialize = function(self)
    cj.SetTextTagPermanent(self._texttag_, false)
    cj.SetTextTagLifespan(self._texttag_, self._timeout_)

    cj.SetTextTagText(self._texttag_, self._msg_, self._size_)
    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, Z_OFFSET)
end

Update = function(self)
    -- bar要跟隨單位
    local unit_loc = Point.GetUnitLoc(self._owner_.object_)
    self._loc_:Remove()
    self._loc_ = unit_loc + motivation
    unit_loc:Remove()

    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, Z_OFFSET)

    self._value_ = self._timeout_
    local bar_model = Bar.GetBarModel(self._max_value_ - self._value_, self._max_value_,
                                      self._color_, self._is_reverse_)
    cj.SetTextTagText(self._texttag_, bar_model, self._size_)
end

function Bar:_delete()
    Texttag._delete(self)
end

function Bar.GetBarModel(current, total, color, is_reverse)
    -- 設定bar是向右充能，或是向左
    current = is_reverse and (total - current) or current
    
    -- 計算染色比例
    local modf = math.modf
    local BAR_SIZE = 25
    local coloring_rate = modf(BAR_SIZE * current / total)

    -- 以漂浮文字輸出條的視覺效果
    local Color = require 'color'
    local string_rep = string.rep
    local BAR_MODEL = "l"
    local string_concat = {Color(color), string_rep(BAR_MODEL, coloring_rate),
                           "|r", Color("grey"), string_rep(BAR_MODEL, BAR_SIZE - coloring_rate)}
    return table.concat(string_concat)
end

return Bar