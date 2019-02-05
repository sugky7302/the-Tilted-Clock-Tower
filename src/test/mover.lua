local function MoverTest(self)
    self.InitTimer()


    local require = require
    local Mover = require 'mover.core'
    local Hero = require 'unit.hero'
    local Point = require 'point'

    -- 第一種是設定最大距離，碰到障礙物停止
    -- TODO: mover要提供標籤
    Mover{
        mover_ = Hero(self.EnumUnit()),
        max_dist_ = 600,
        angle_ = 90,

        flag_collision = true,

        TraceMode = "StraightLine"
    }

    -- 第二種是設定時間，一直執行到時間結束
    Mover{
        mover_ = Hero(self.EnumUnit()),
        timeout_ = 10,
        angle_ = 180,

        TraceMode = "Surround"
    }

    -- 第三種是設定地點，直到抵達地點為止
    Mover{
        mover_ = Hero(self.EnumUnit()),
        target_loc_ = Point(14836, -2554)

        TraceMode = "Parabola"
    }
end

return MoverTest