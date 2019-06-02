-- 讓漂浮文字能夠跟隨單位移動
-- 依賴
--   jass.common
--   point
--   texttag.core


-- package
local math = math
local require = require
local cj = require 'jass.common'

-- constants
local DEFAULT_ANGLE, IS_ANGLE_RANDOM = math.pi / 2, true
local TIME_LIFE = 0.7
local VELOCITY = 5
local SIZE = 0.9

-- assert
local Initialize, Update

local function ArcText(str, loc, scale)
    local angle = IS_ANGLE_RANDOM and cj.GetRandomReal(0, 2 * math.pi) or DEFAULT_ANGLE

    -- 設定漂浮文字比例，初始值=1
    scale = scale or 1

    local Point = require 'point'
    local Texttag = require 'texttag.core'
    local texttag = Texttag{
        _msg_ = str,
        _loc_ = loc,
        _timeout_ = TIME_LIFE,
        _offset_ = Point(math.cos(angle) * VELOCITY, math.sin(angle) * VELOCITY), 
        _size_ = SIZE * scale,
        
        Initialize = Initialize,
        Update = Update,
    }

    return texttag
end

-- assert
local TIME_FADE = 0.3
local SIZE_MIN = 0.018
local Z_OFFSET = 20

Initialize = function(self)
    cj.SetTextTagPermanent(self._texttag_, false)
    cj.SetTextTagLifespan(self._texttag_, self._timeout_)
    cj.SetTextTagFadepoint(self._texttag_, TIME_FADE)

    cj.SetTextTagText(self._texttag_, self._msg_, self._size_ * SIZE_MIN)
    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, self._size_ * Z_OFFSET)
end

-- assert
local SIZE_BONUS = 0.012
local Z_OFFSET_BONUS = 120

Update = function(self)
    -- 設定運動軌跡
    local trace = math.sin(math.pi * self._timeout_)

    -- 更新漂浮文字的位置
    local old_loc = self._loc_
    self._loc_ = self._loc_ + self._offset_
    old_loc :Remove()

    local z_offset = self._size_ * (Z_OFFSET + Z_OFFSET_BONUS * trace)
    local size = self._size_ * (SIZE_MIN + SIZE_BONUS * trace)

    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, z_offset)    
    cj.SetTextTagText(self._texttag_, self._msg_, size)
end

return ArcText
    