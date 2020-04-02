-- 實現EffectTable。

local require = require

local Effect = require 'util.class'('Effect')
local AddModel, DeleteModel, AddTask, DeleteTask, StartTimer
local IsValid, InitArgs

function Effect:_new(template, manager)
    return {
        _name_ = template.name,
        _value_ = template.value,
        _level_ = 1,
        _period_ = template.period,
        _time_ = template.time,
        _priority_ = template.priority,
        _mode_ = template.mode,
        _model_ = template.model,
        _model_point_ = template.model_point,
        _global_ = template.global,
        _max_ = template.max,
        _keep_after_death_ = template.keep_after_death,
        _manager_ = manager,
        _tasks_ = require 'util.stl.list':new(),
        on_add = template.on_add,
        on_delete = template.on_delete,
        on_finish = template.on_finish,
        on_cover = template.on_cover,
        on_pulse = template.on_pulse
    }
end

function Effect:start(new_task)
    InitArgs(new_task)
    AddTask(self, new_task)

    if new_task.valid then
        self:on_add(new_task)
        AddModel(self, new_task)
        StartTimer(self, new_task)
    end
end

function Effect:clear()
    for i = #self, 1, -1 do
        self:delete(self[i])
    end
end

function Effect:delete(task)
    task.timer:stop()
    self:on_delete(task)
    DeleteModel(self, task)
    DeleteTask(self, task)
end

function Effect:finish(task)
    self:on_finish(task)
    self:on_delete(task)
    DeleteModel(self, task)
    DeleteTask(self, task)
end

function Effect:pause(task)
    task.valid = false
    task.timer:pause()
    self:on_delete(task)
    DeleteModel(self, task)
end

function Effect:resume(task)
    task.valid = true
    self:on_add(task)
    AddModel(self, task)
    task.timer:resume()
end

InitArgs = function(new_task)
    new_task.valid = true
end

AddModel = function(self, task)
    if not task.target:hasModel(self._model_) then
        task.target:addModel(self._model_)
    end
end

DeleteModel = function(self, task)
    if not task.target:hasModel(self._model_) then
        task.target:deleteModel(self._model_)
    end
end

AddTask = function(self, new_task)
    if self._tasks_:isEmpty() then
        self._tasks_:push_back(new_task)
        return
    end

    if self._mode_ == 0 then  -- 獨佔模式
        -- effect無法覆蓋
        if not self.on_cover then
            new_task.valid = false
            return
        end

        if not self.on_cover(self._tasks_:front(), new_task) then
            new_task.valid = false
            return
        end

        -- 終止舊的效果
        self:delete(self._tasks_:front())

        -- 替換成新的效果
        self._tasks_:pop_front()
        self._tasks_:push_back(new_task)
    else  -- 共存模式
        self._tasks_:push_back(new_task)

        -- size可以當作新的任務的索引
        if not IsValid(self._tasks_:size(), self._max_) then
            self:pause(new_task)
        end
    end
end

StartTimer = function(self, task)
    task.remained_time = task.time or self._time_

    if self.on_pulse then
        task.timer =
            Timer(
            task.period or self._period_,
            true,
            function(this)
                self.on_pulse(task)

                self.remained_time = self.remained_time - this.period_

                if this.is_shutdown() then
                    self.finish(task)
                end
            end
        )
    else
        task.timer =
            Timer(
            task.period or self._period_,
            false,
            function()
                self.finish(task)
            end
        )
    end
end

DeleteTask = function(self, task)
    local task_node, index = self._tasks_:find(task)

    -- 如果是共存模式，要把暫停的任務恢復
    if self._mode_ == 1 and task_node.next_ and IsValid(index, self._max_) then
        self:resume(task_node.next_:getData())
    end

    -- delete會把node刪掉，這樣的話會抓不到next
    self._tasks_:delete(task_node)
end

IsValid = function(index, max)
    if max < 1 then
        return true
    end

    if index > max then
        return false
    end

    return true
end


return Effect
