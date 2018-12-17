-- 處理quest的工具

-- package
local cj = require 'jass.common'

local Util = {}

function Util:Announce(msg)
    local ANNOUNCE_DUR = 6
    cj.DisplayTimedTextToPlayer(self.receiver_.owner_.object_, 0., 0., ANNOUNCE_DUR, msg)
end

-- package
local Point = require 'point'

function Util:GiveItem(trigger_item, count)
    local trigger_unit = self.receiver_.object_ -- 防止任務被刪除後，搜尋不到單位的問題
    local p = Point.GetUnitLoc(trigger_unit)

    local timer = require 'timer.core'
    local PERIOD = 0.1
    Timer(PERIOD, false, function()
        -- 預設數量
        count = count or 1

        for i = 1, count do
            local item = Item.Create(trigger_item, p)
            cj.UnitAddItem(trigger_unit, item)
        end

        p:Remove()
    end)
end

function Util:Near(x, y)
    local source_point = Point.GetUnitLoc(self.receiver_.object_)
    local target_point = Point(x, y)

    local is_near = Point.Distance(source_point, target_point) < 200

    source_point:Remove()
    target_point:Remove()

    return is_near
end

return Util