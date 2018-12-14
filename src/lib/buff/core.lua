-- 可以設置多樣化的buff

local setmetatable = setmetatable

-- package
local cj = require 'jass.common'

local Buff, mt = {}, require 'buff.init'
setmetatable(Buff, Buff)
Buff.__index = mt 

-- assert
local InitValue, CallSetFn
local set, get = {}, {}

-- on_cover根據buff的cover type做不同處理
-- 如果要做多層數的buff，可以在on_cover內，將新buff的數據複製給舊buff，並要不要更新時間，最後回傳false即可
-- cover type = 0 -> (true, false) = (當前狀態被移除，新的狀態被添加)
-- cover type = 1 -> (true, false) = (新的狀態排序到當前狀態之前，新的狀態排序到當前狀態之後)
function Buff:__call(name)
    local instance = self[name]
    if not instance then
        instance = {}
        
        instance.name_ = name

        self[name] = instance
        setmetatable(instance, self)
        instance.__index = instance
    end

    return instance
end

local Operator = require 'buff.operator'

function mt:Obtain()
    return Operator.Obtain(self)
end

function mt:Delete()
    Operator.Delete(self)
end

function Buff.Register(name, reg_fn)
    set[name] = reg_fn.set or nil
    get[name] = reg_fn.get or nil

    reg_fn = nil
end

function mt:add(name, val)
    InitValue(self, name)
    
    self[name] = self[name] + val
    
    CallSetFn(self, name)
end

function mt:set(name, val)
    InitValue(self, name)
    
    self[name] = val
    
    CallSetFn(self, name)
end

CallSetFn = function(self, name)
    if set[name] then
        set[name](self, self[name])
    end
end

function mt:get(name)
    InitValue(self, name)

    if get[name] then
        return get[name]
    end

    return self[name]
end

InitValue = function(self, name)
    if not self[name] then
        self[name] = get[name] and get[name](self) or 0
    end
end

function mt:Pause()
    -- 暫停功能被禁用
    if self.is_force_ then
        return false
    end

    if not self.is_pause_ then
        self.is_pause_ = true

        if self.timer_ then
            self.timer_:Pause()
        end

        self:EventDispatch "狀態-刪除"
    end
end

function mt:Resume()
    if self.is_pause_ then
        self.is_pause_ = false

        self.timer_:Resume()

        self:EventDispatch "狀態-獲得"
    end
end

function mt:EventDispatch(name, default, ...)
    default = default or false

    if self.invalid_ then
        return default
    end

    local EVENT_NAME = {
        ["狀態-獲得"] = "on_add",
        ["狀態-覆蓋"] = "on_cover",
        ["狀態-結束"] = "on_finish",
        ["狀態-週期"] = "on_pulse",
        ["狀態-刪除"] = "on_remove",
    }

    name = EVENT_NAME[name]

    if not self[name] then
        return default
    end

    local result = self[name](self, ...)
    return result or default
end

return Buff