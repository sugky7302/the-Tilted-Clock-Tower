-- 處理quest的工具

-- package
local cj = require 'jass.common'

local Util = {
    is_unique_  = true,  -- 任務是否唯一
    can_accept_ = true,  -- 可否接取任務
}

function Util:Announce(msg)
    local type = type
    if type(msg) == 'table' then
        local table_concat = table.concat
        msg = table_concat(msg)
    end

    cj.DisplayTimedTextToPlayer(self.receiver_.owner_.object_, 0., 0., 9, msg)
end

-- package
local Point = require 'point'

function Util:GiveItem(trigger_item, count)
    local trigger_unit = self.receiver_.object_ -- 防止任務被刪除後，搜尋不到單位的問題
    local p = Point.GetUnitLoc(trigger_unit)

    local Timer = require 'timer.core'
    local Item_Create = require 'item.core'.Create
    Timer(0.1, false, function()
        -- 預設數量
        count = count or 1

        for i = 1, count do
            local item = Item_Create(trigger_item, p)
            cj.UnitAddItem(trigger_unit, item)
        end

        p:Remove()
    end)
end

function Util:Near(x, y)
    local target_point = type(x) == 'table' and x or Point(x, y)
    local source_point = Point.GetUnitLoc(self.receiver_.object_)

    local is_near = Point.Distance(source_point, target_point) < 200

    source_point:Remove()
    
    if type(x) ~= 'table' then
        target_point:Remove()
    end

    return is_near
end

-- TODO: 用mover重寫
-- assert
local UpdateRecevierPoint

function Util:ActivePathIndicator(x, y)
    local Point = require 'point'
    local type = type

    local receiver_point, target_point = Point.GetUnitLoc(self.receiver_.object_), type(x) == 'table' and x or Point(x,y)
    local angle = Point.Deg(receiver_point, target_point)

    UpdateRecevierPoint(receiver_point, angle)

    local indicator = require('unit.core').Create(self.receiver_.owner_.object_, 'u008', receiver_point, angle)

    receiver_point:Remove()

    -- 讓指示器平穩地移動，如果用on_timer會卡卡地，因為它是1秒執行一次
    local Timer = require 'timer.core'
    Timer(0.03125, true, function(this)
        local receiver_point = Point.GetUnitLoc(self.receiver_.object_)
        local angle = Point.Deg(receiver_point, target_point)

        UpdateRecevierPoint(receiver_point, angle)

        cj.SetUnitPosition(indicator, receiver_point.x_, receiver_point.y_)
        cj.SetUnitFacing(indicator, angle)

        receiver_point:Remove()

        -- 如果玩家死亡或是抵達目的地就終止計時器
        if (not self.receiver_:IsAlive()) or self:Near(target_point) then
            this:Break()
            require 'jass_tool'.RemoveUnit(indicator)

            -- 只刪除此函式創建的target_point，如果是引用的話，在這刪除外面也會刪除
            if type(x) ~= 'table' then
                target_point:Remove()
            end
        end
    end)
end

UpdateRecevierPoint = function(p, angle)
    local math = math
    local offset = 150

    -- 位置要在英雄前面才看的到
    p.x_ = p.x_ + offset * math.cos(math.rad(angle))
    p.y_ = p.y_ + offset * math.sin(math.rad(angle))
end

return Util