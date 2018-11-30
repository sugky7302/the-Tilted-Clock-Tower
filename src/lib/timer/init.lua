-- 建立0.01秒一幀的中心計時器
-- 執行每幀的列表(最多10個動作)，若因為計時器誤差而導致丟幀，就於下次進行補幀。
-- 參考moe-master 2.1

local CenterTimer = {}

-- constants
CenterTimer.PERIOD = 0.001

-- assert
local current_frame, _max_frame, _back_frame = 0, 0, 0

--- 中心計時器動作
local _ExecuteFrameAction, _Wakeup

function CenterTimer.Init()
    local cj = require 'jass.common'

    local center_timer = cj.CreateTimer()
    local period = CenterTimer.PERIOD * 10
    cj.TimerStart(center_timer, period, true, function()
        local loop_count = 10

        -- 補幀
        if _back_frame > 0 then
            current_frame = current_frame - 1
        end

        -- 執行每幀動作
        _max_frame = _max_frame + loop_count
        for i = current_frame, _max_frame do
            current_frame = current_frame + 1
            _ExecuteFrameAction()
        end
    end)
end

-- 若此幀無動作則跳出
_ExecuteFrameAction = function()
    local frame_queue = CenterTimer[current_frame]
    if not frame_queue then
		_back_frame = 0 -- 不需要補幀
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
    
    -- 執行到這一步，表示Loop結束了，所以重置補幀幀數
    _back_frame = 0
    
    CenterTimer[current_frame] = nil -- 移除佇列
	frame_queue = nil
end

-- 判定回調是否失效，並處理執行函數(有可能會暫停或移除動作)
_Wakeup = function(callback)
    if callback.invalid_ then
        callback:Remove()
        return 
    end

    callback:execution_() -- 執行函數

    -- 處理調用執行函數後，停用計時器的情況
    if callback.pause_remaining_ then
        return false
    end

    -- 處理調用執行函數後，移除計時器的情況
    if callback.invalid_ then
        callback.timeout_ = nil
    end

    -- 如果有儲存秒數，表示是週期觸發，因此要重複設定
    if callback.timeout_ then
        CenterTimer.SetTimeout(callback, callback.timeout_)
    else
        callback:Remove()
    end
end

-- 將計時器插入新的幀的集合中
function CenterTimer.SetTimeout(callback, timeout)
    local new_frame = current_frame + timeout

    local frame_list = CenterTimer[new_frame]
    
    -- 讀不到該幀的列表，就新建一個
    if not frame_list then
        frame_list = {}
        CenterTimer[new_frame] = frame_list
    end

    -- 儲存時間結束點
    callback.end_frame_ = new_frame

    -- 儲存回調
    frame_list[#frame_list + 1] = callback
end

-- 提供當前時間(秒)
function CenterTimer.clock()
    return current_frame * CenterTimer.PERIOD
end

-- 提供當前時間(幀)
function CenterTimer.frame()
    return current_frame
end

return CenterTimer