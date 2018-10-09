local setmetatable = setmetatable
local max = math.max
local floor = math.floor
local Queue = require 'queue'
local cj = require 'jass.common'
local Object = require 'object'

local Timer = {}
local mt = {}
setmetatable(Timer, Timer)
Timer.__index = mt

-- constants
local PERIOD = 0.001

-- variables
local _currentFrame, _maxFrame, _backFrame = 0, 0, 0
local _recycleQueue, _OnTick, _Wakeup, _SetTimeout, _GetQueue = Queue("timer")
local _Loop, _Wait, _Count

--[[ 建立0.01秒一幀的中心計時器
執行每幀的佇列(最多10個動作)，若因為計時器誤差而導致丟幀，就於下次進行補幀。
此計時器參考moe-master 2.1
]] 
function Timer.Init()
    local centerTimer = cj.CreateTimer()
    cj.TimerStart(centerTimer, PERIOD * 10, true, function()
        local loopTimes = 10
        if _backFrame > 0 then
            _currentFrame = _currentFrame - 1
        end
        _maxFrame = _maxFrame + loopTimes
        while _currentFrame < _maxFrame do 
            _currentFrame = _currentFrame + 1
            _OnTick()
        end
    end)
end

-- 執行佇列內的每個動作，若此幀無動作則跳出。
_OnTick = function()
    local callbackQueue = Timer[_currentFrame]
	if not callbackQueue then
		_backFrame = 0
		return
    end
    local callback
	for i = _backFrame + 1, #callbackQueue do
		callback = callbackQueue[i]
		_backFrame = i
		callbackQueue[i] = nil -- 移除回調
		if callback then
			_Wakeup(callback)
		end
	end
	_backFrame = 0
	Timer[_currentFrame] = nil -- 移除佇列
	_recycleQueue:Push(callbackQueue)
end

-- 判定回調是否失效，並處理執行函數有可能會暫停或停止回調
_Wakeup = function(callback)
    callback:execution() -- 執行函數
    -- 處理上面的執行函數內有停用計時器的情況
    if callback.pauseRemaining then
        return
    elseif callback.invalid then
        callback.timeout = nil
    end
    -- 如果有儲存timeout，代表是週期觸發，因此要重複設定
    if callback.timeout then
        _SetTimeout(callback, callback.timeout)
    else
        callback:Remove()
    end
end

function Timer:__call(timeout, isPeriod, execution)
    local obj = Object{
        timeout = max(floor(timeout / PERIOD) or 1, 1),
        isPeriod = isPeriod,
        execution = execution,
        invalie = false
    }
    setmetatable(obj, self)
    obj.__index = obj
    if isPeriod or (isPeriod == 0) then -- 如果週期設定成true或0，都視為循環觸發
        _Loop(obj)
    elseif not isPeriod then
        _Wait(obj)
    else
        _Count(obj)
    end
    return obj
end

_Loop = function(self)
    _SetTimeout(self, self.timeout)
end

-- 單次計時器，因此不儲存timeout，讓_Wakeup能夠判斷是否循環
_Wait = function(self)
    local timeout = self.timeout
    self.timeout = nil
    _SetTimeout(self, timeout)
end

function mt:Resume()
    if self.pauseRemaining then
        _SetTimeout(self, self.pauseRemaining)
        self.pauseRemaining = nil
    end
end

-- 將循環動作插入新的幀的佇列中
_SetTimeout = function(callback, timeout)
    local newFrame = _currentFrame + timeout
    local callbackQueue = Timer[newFrame]
    -- 讀不到該幀的佇列，就新建一個
    if not callbackQueue then
        callbackQueue = _GetQueue()
        Timer[newFrame] = callbackQueue
    end
    callback.timeoutFrame = newFrame -- 儲存新的時間戳記
    callbackQueue:Insert(callback) -- 儲存回調
end

-- 獲得空白佇列
_GetQueue = function()
    if _recycleQueue:IsEmpty() then
        return Object()
    else
        local queue = _recycleQueue:Front()
        _recycleQueue:Pop()
        return queue
    end
end

_Count = function(self)
    local execution = self.execution
    self.execution = function(self)
        execution(self)
        self.isPeriod = self.isPeriod - 1
        if self.isPeriod < 1 then
            self:Remove()
        end
    end
end

function mt:Pause()
    self.pauseRemaining = self:GetRemaining()
    local queue = Timer[self.timeoutFrame]
    if queue then
        for i = #queue, 1, -1 do
            if queue[i] == self then -- 清除回調
                queue[i] = nil
                return 
            end
        end
    end
end

function mt:GetRemaining()
    if self.pauseRemaining then
        return self.pauseRemaining
    elseif self.timeoutFrame == _currentFrame then
        return self.timeout or 0
    else
        return self.timeoutFrame - _currentFrame
    end
end

function mt:Remove()
    self.timeout = nil
    self.isPeriod = nil
    self.execution = nil
    self.invalie = nil
    self = nil
    collectgarbage("collect")
end

return Timer