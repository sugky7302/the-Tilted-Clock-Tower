-- 追蹤任務是否完成
-- 目前texttag、missile內建回報任務完成機制
-- 可以到skill.cast和寒冰箭看看實際案例

local setmetatable = setmetatable

local TaskTracker = {}
setmetatable(TaskTracker, TaskTracker)

function TaskTracker:__call(key, unfinished_task)
    self[key] = unfinished_task or -1
end

function TaskTracker.Remove(key)
    TaskTracker[key] = nil
end

-- assert
local max = math.max

function TaskTracker.add(key)
    TaskTracker[key] = max(0, TaskTracker[key]) + 1
end

function TaskTracker.finish(key)
    TaskTracker[key] = max(0, TaskTracker[key] - 1)
end

function TaskTracker.IsCompleted(key)
    return TaskTracker[key] == 0
end

return TaskTracker