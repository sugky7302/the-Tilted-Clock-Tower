-- 創建護盾條

local Bar = require 'bar.core'

-- assert
local Initialize, Update

-- unit是Unit實例，不是單位
local function Shield(unit, value, timeout)
    -- 單位要設定護盾值，damage要用
    -- unit:set("護盾", value)
    
    return Bar(unit, value, timeout, "white", false, Initialize, Update)
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
    -- 如果護盾歸零就自動移除，不用再手動移除
    if self._owner_:get "護盾" < 1 then
        self:Break()
        return false
    end

    local Point = require 'point'
    local motivation = Point(-40, 0)
    local unit_loc = Point.GetUnitLoc(self._owner_.object_)
    self._loc_ = unit_loc + motivation
    unit_loc:Remove()

    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, Z_OFFSET)

    local bar_model = Bar.GetBarModel(self._max_value_ - self._owner_:get "護盾", self._max_value_, self._color_)
    cj.SetTextTagText(self._texttag_, bar_model, self._size_)
end

return Shield