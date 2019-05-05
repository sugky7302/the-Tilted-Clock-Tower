-- 追蹤任務是否完成
-- 目前texttag、missile內建回報任務完成機制
-- 可以到skill.cast和寒冰箭看看實際案例

local TaskTracker = {}
setmetatable(TaskTracker, TaskTracker)

function TaskTracker:__call(key, unfinished_task)
    -- -1表示還沒加入任務，這樣使用IsCompleted也不會出問題。
    -- 不會出現明明才剛創建追蹤器且還沒加入任務，追蹤器卻認為你已經完成任務而結束的問題。
    self[key] = unfinished_task or -1
end

function TaskTracker:remove(key)
    self[key] = nil
end

-- assert
local max = math.max

function TaskTracker:add(key, count)
    self[key] = max(0, self[key]) + (count or 1)
end

function TaskTracker:finish(key, count)
    self[key] = max(0, self[key] - (count or 1))
end

function TaskTracker:IsCompleted(key)
    return self[key] == 0
end

return TaskTracker