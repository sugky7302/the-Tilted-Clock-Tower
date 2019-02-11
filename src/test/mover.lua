local function MoverTest(self)
    self.InitTimer()


    local require = require
    local Mover = require 'mover.core'
    local Hero = require 'unit.hero'
    local Point = require 'point'

    local test_unit = Hero(self.EnumUnit())
    -- 第一種是設定最大距離，碰到障礙物停止
    -- TODO: mover要提供標籤
    Mover{
        mover_ = test_unit,
        max_dist_ = 600,
        angle_ = 90,

        flag_collision = true,

        TraceMode = "StraightLine",
        Execute = function()
            print "one"
        end
    }

    -- 第二種是設定時間，一直執行到時間結束
    -- TODO: 要調整Surround的參數
    Mover{
        mover_ = test_unit,
        timeout_ = 10,
        radius_ = 100,
        velocity_ = 45,

        TraceMode = "Surround",
        Execute = function()
            print "two"
        end
    }

    -- 第三種是設定地點，直到抵達地點為止
    Mover{
        mover_ = test_unit,
        target_loc_ = Point(14836, 6554),

        -- TraceMode = "Parabola"
        TraceMode = "StraightLine",
        Execute = function()
            print "three"
        end
    }
end

return MoverTest