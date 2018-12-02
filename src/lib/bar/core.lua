-- 此module會在英雄身上創建狀態條

local Point = require 'point'

-- assert
local motivation = Point(-40, 0)

local GetBarModel
local Initialize, Update

function Bar(unit, timeout, color, is_reverse)
    local SIZE = 0.015

    local unit_loc = Point.GetUnitLoc(unit)
    local instance = {
        _msg_ = GetBarModel(0, timeout, color, is_reverse),
        _loc_ = unit_loc + motivation,
        _timeout_ = timeout,
        _life_time_ = timeout, -- 記錄總時間，要計算條的變色比例
        _size_ = SIZE,
        _is_reverse_ = is_reverse,
        _color_ = color,
        _owner_ = unit,

        Initialize = Initialize,
        Update = Update,
    }

    unit_loc:Remove()

    local Texttag = require 'texttag.core'
    return Texttag(instance)
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
    local unit_loc = Point.GetUnitLoc(self._owner_)
    self._loc_:Remove()
    self._loc_ = unit_loc + motivation
    unit_loc:Remove()

    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, Z_OFFSET)

    local bar_model = GetBarModel(self._life_time_ - self._timeout_, self._life_time_, self._color_, self._is_reverse_)
    cj.SetTextTagText(self._texttag_, bar_model, self._size_)
end

GetBarModel = function(current, total, color, isReverse)
    -- 設定條是向右充能，或是向左
    current = is_reverse and (total - current) or current
    
    -- 計算染色比例
    local modf = math.modf
    local BAR_SIZE = 25
    local coloring_rate = modf(BAR_SIZE * current / total)

    -- 以漂浮文字輸出條的視覺效果
    local Color = require 'color'
    local string_rep, table_concat = string.rep, table.concat
    local BAR_MODEL = "l"
    local string_concat = {Color(color), string_rep(BAR_MODEL, coloring_rate),
                           "|r|cffc0c0c0", string_rep(BAR_MODEL, BAR_SIZE - coloring_rate)}
    return table_concat(string_concat)
end

return Bar