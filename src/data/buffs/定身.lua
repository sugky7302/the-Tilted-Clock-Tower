-- 利用 動畫-改變單位的轉向角度 達成此效果，原因不明

local mt = require 'buff.core' "定身"

-- assert
local SetUnitPropWindow = require 'jass.common'.SetUnitPropWindow
local GetUnitDefaultPropWindow = require 'jass.common'.GetUnitDefaultPropWindow

function mt:on_add()
    SetUnitPropWindow(self.target_.object_, 0)
end

function mt:on_remove()
    SetUnitPropWindow(self.target_.object_, GetUnitDefaultPropWindow(self.target_.object_))
end