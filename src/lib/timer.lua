local require = require

local Timer = require 'util.class'('Timer', require 'lib.center_timer')

function Timer:_new(timeout, count, action)
    return {
        frame_ = self.frame(timeout),
        count_ = count, -- 循環次數必須>0，-1定義為永久，0定義為結束
        end_stamp_ = 0, -- 提前結束會用到結束點
        pause_frame_ = 0, -- 恢復時會需要剩餘時間
        run = action
    }
end

function Timer:start()
    self:insert(self.frame_)
end

function Timer:stop()
    -- 外部停止需要把計時器從隊列中刪除
    self:delete()
    self:remove()
end

function Timer:pause()
    self.pause_frame_ = self.end_stamp_ - self.now()

    -- 外部暫停需要把計時器從隊列中刪除
    self:delete()
end

function Timer:resume()
    self:insert(self.pause_frame_)
end

return Timer
