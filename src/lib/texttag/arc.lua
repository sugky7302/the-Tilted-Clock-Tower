-- 此module讓漂浮文字能夠跟隨單位移動

local cj = require 'jass.common'

-- constants
local PI = math.pi
local DEFAULT_ANGLE, IS_ANGLE_RANDOM = PI / 2, true
local TIME_LIFE = 0.7
local VELOCITY = 5
local SIZE = 0.9

-- assert
local sin, cos = math.sin, math.cos
local Initialize, Update

local function ArcText(str, loc, scale)
    local angle = IS_ANGLE_RANDOM and cj.GetRandomReal(0, 2 * PI) or DEFAULT_ANGLE

    -- 設定漂浮文字比例，初始值=1
    scale = scale or 1

    local Point = require 'point'
    local instance = {
        _msg_ = str,
        _loc_ = loc,
        _timeout_ = TIME_LIFE,
        _offset_ = Point(cos(angle) * VELOCITY, sin(angle) * VELOCITY), 
        _size_ = SIZE * scale,
        
        Initialize = Initialize,
        Update = Update,
    }

    local Texttag = require 'texttag.core'
    return Texttag(instance)
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
local Z_OFFSET_BONUS = 120 -- 55

Update = function(self)
    -- 設定運動軌跡
    local trace = sin(PI * self._timeout_)

    -- 更新漂浮文字的位置
    self._loc_ = self._loc_ + self._offset_

    local z_offset = self._size_ * (Z_OFFSET + Z_OFFSET_BONUS * trace)
    local size = self._size_ * (SIZE_MIN + SIZE_BONUS * trace)

    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, z_offset)    
    cj.SetTextTagText(self._texttag_, self._msg_, size)
end

return ArcText
    