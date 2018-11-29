-- 建立0.01秒一幀的中心計時器
-- 執行每幀的佇列(最多10個動作)，若因為計時器誤差而導致丟幀，就於下次進行補幀。
-- 此計時器參考moe-master 2.1

local Queue = require 'stl.queue'

local CenterTimer = {}

-- constants
local CenterTimer.PERIOD = 0.001
local _recycle_queue = Queue()

-- assert
CenterTimer.current_frame = 0
local _max_frame, _back_frame = 0, 0

--- 中心計時器動作
local _ExecuteFrameAction, _Wakeup

--- 設定幀
local _AddCndToExecution, _GetSet

function CenterTimer.Init()
    local cj = require 'jass.common'

    local center_timer = cj.CreateTimer()
    cj.TimerStart(center_timer, CenterTimer.PERIOD * 10, true, function()
        local loop_count = 10

        -- 補幀
        if _back_frame > 0 then
            CenterTimer.current_frame = CenterTimer.current_frame - 1
        end

        -- 執行每幀動作
        _max_frame = _max_frame + loop_count
        for i = CenterTimer.current_frame, _max_frame do
            CenterTimer.current_frame = CenterTimer.current_frame + 1
            _ExecuteFrameAction()
        end
    end)
end

-- 若此幀無動作則跳出。
_ExecuteFrameAction = function()
    local frame_queue = CenterTimer[CenterTimer.current_frame]
    
    if not frame_queue then
		_back_frame = 0
		return
    end

    local callback
	for i = _back_frame + 1, #frame_queue do
        -- 記錄當前幀數，怕循環突然停止，當前動作無法執行
        _back_frame = i

        callback = frame_queue[i]
		if callback then
			_Wakeup(callback)
        end

        frame_queue[i] = nil 
    end
    
    _back_frame = 0
    
    CenterTimer[CenterTimer.current_frame] = nil -- 移除佇列
    
	_recycle_queue:PushBack(frame_queue)
end

-- 判定回調是否失效，並處理執行函數有可能會暫停或停止回調
_Wakeup = function(callback)
    callback:execution() -- 執行函數

    -- 處理上面的執行函數內有停用計時器的情況
    if callback.pause_remaining then
        return false
    end

    if callback.invalid then
        callback.timeout = nil
    end

    -- 如果有儲存timeout，表示週期觸發，因此要重複設定
    if callback.timeout then
        CenterTimer.SetTimeout(callback, callback.timeout)
    else
        callback:Remove()
    end
end

-- 將動作插入新的幀的集合中
function CenterTimer.SetTimeout(callback, timeout)
    _AddCndToExecution(callback)

    local new_frame = CenterTimer.current_frame + timeout

    local frame_set = CenterTimer[new_frame]
    
    -- 讀不到該幀的集合，就新建一個
    if not frame_set then
        frame_set = _GetSet()
        CenterTimer[new_frame] = frame_set
    end

    -- 儲存時間結束點
    callback.end_frame = new_frame

    -- 儲存回調
    frame_set[#frame_set + 1] = callback
end

-- 為了外部停用計時器動作，而設定停用條件
_AddCndToExecution = function(self)
    local execution = self.execution

    if self.is_exec_registered then
        return
    end

    -- 防止恢復計時器動作後又重新註冊一次，導致執行函數越來越笨重
    self.is_exec_registered = true

    self.execution = function(self)
        if (self.pause_remaining == false) and (self.invalid == false) then
            execution(self)
        end
    end
end

-- 獲得空白幀集合
_GetSet = function()
    if _recycle_queue:IsEmpty() then
        return {}
    end

    local queue = _recycle_queue:front()
    _recycle_queue:PopFront()
    return queue
end

-- 提供計時器當前時間點(秒)
function CenterTimer.Clock()
    return CenterTimer.current_frame * CenterTimer.PERIOD
end

-- 提供計時器當前時間點(幀)
function CenterTimer.Frame()
    return enterTimer.current_frame
end

return CenterTimer