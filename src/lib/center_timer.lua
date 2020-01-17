local setmetatable = setmetatable


-- NOTE: 設計為弱引用表是因為讓lua在做垃圾收集時，能夠將失效的幀的table完全清除。
local CenterTimer = {__mode = 'kv'}
setmetatable(CenterTimer, CenterTimer)

local StartTimer, NewTimer, CLOCK_CYCLE, INSTRUCTION_COUNT
local current_frame, end_frame, order_queue_index = 0, 0, 0
local ExecuteOrder, ProcessOrder


function CenterTimer.init(start_timer_func, timer_func, clock_cycle, instruction_count)
    StartTimer = start_timer_func
    NewTimer = timer_func
    CLOCK_CYCLE = clock_cycle
    INSTRUCTION_COUNT = instruction_count
end

function CenterTimer.start()
    StartTimer(
        NewTimer(),
        CLOCK_CYCLE * INSTRUCTION_COUNT,
        true,
        function()
            end_frame = end_frame + INSTRUCTION_COUNT
            for i = 1, INSTRUCTION_COUNT do
                -- 每一幀的命令隊列都處理完才做下一幀
                if order_queue_index == 0 then
                    current_frame = current_frame + 1
                end

                ExecuteOrder()
            end
        end
    )
end

ExecuteOrder = function()
    local order_queue = CenterTimer[current_frame]
    if not order_queue then
        return false
    end

    local order
    for i = order_queue_index + 1, #order_queue do
        order = order_queue[i]
        if order then
            ProcessOrder(order)
        end

        -- 記錄當前命令索引，如果沒處理完還能在下一迴圈處理
        order_queue_index = i
        order_queue[i] = nil
    end

    -- 必須所有引用都清除，lua才會釋放記憶體
    CenterTimer[current_frame] = nil
    order_queue = nil
end

ProcessOrder = function(order)
    order:run()

    -- 如果count_是-1，表示無窮迴圈，因此不用遞減
    if order.count_ > 0 then
        order.count_ = order.count_ - 1
    end

    if order.count_ == 0 then
        order:remove()
        return false
    end

    -- 處理指令暫停的情況
    if order.pause_frame_ > 0 then
        return false
    end

    CenterTimer.insert(order, order.frame_)
end

-- NOTE: 不直接使用order.frame_的原因是
--       恢復計時器的動作中，插入的frame是剩餘時間。
function CenterTimer.insert(order, frame)
    if order.count_ == 0 then
        return false
    end

    local end_stamp = current_frame + frame
    order.end_stamp_ = end_stamp

    if not CenterTimer[end_stamp] then
        CenterTimer[end_stamp] = {__mode = 'kv'}
        setmetatable(CenterTimer[end_stamp], CenterTimer[end_stamp])
    end

    -- 使用變數提高插入指令的程式碼的閱讀性
    local order_queue = CenterTimer[end_stamp]
    order_queue[#order_queue + 1] = order
end

function CenterTimer.delete(order)
    local order_queue = CenterTimer[order.end_stamp_]
    if not order_queue then
        return false
    end

    -- NOTE: 使用table.remove才能完整刪除，
    --       只設定為nil反而會讓數組中斷。
    for k, v in ipairs(order_queue) do
        if v == order then
            table.remove(order_queue, k)
            return true
        end
    end
end

function CenterTimer.frame(time)
    local math = math
    return math.max(math.floor(time / CLOCK_CYCLE) or 1, 1)
end

function CenterTimer.now()
    return current_frame
end


return CenterTimer
