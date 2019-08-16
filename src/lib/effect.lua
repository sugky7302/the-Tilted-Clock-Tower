-- 實現EffectTable。

local Effect = require 'util.class'('Effect')
local AddModel, RemoveModel, SetMode, StartTimer


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
        on_add = template.on_add,
        on_remove = template.on_remove,
        on_finish = template.on_finish,
        on_cover = template.on_cover,
        on_pulse = template.on_pulse
    }
end


function Effect:start(new_task)
    SetMode(self, new_task)
    self:on_add(new_task)
    AddModel(self, new_task)

    if new_task.valid then
        StartTimer(self, new_task)
    end
end

function Effect:clear()
    for i = #self, 1, -1 do
        self:delete(self[i])
    end
end

function Effect:delete(new_task)
    -- CloseTimer
    self:on_remove(new_task)
    RemoveModel(self, new_task)
end

function Effect:finish(new_task)
    self:on_finish(new_task)
    RemoveModel(self, new_task)
end

function Effect:pause(new_task)
    -- PauseTimer
    self:on_remove(new_task)
    RemoveModel(self, new_task)
end

function Effect:resume(new_task)
    self:on_add(new_task)
    AddModel(self, new_task)
    -- RestartTimer
end

AddModel = function(self, new_task)
    if new_task.target身上沒有self._model_ then
        new_task.target:addModel(self._model_)
    end
end

RemoveModel = function(self, new_task)
    if new_task.target身上沒有self._model_ then
        new_task.target:removeModel(self._model_)
    end
end

SetMode = function(self, new_task)
    if not self[1] then
        self[1] = new_task
        return
    end

    if self._mode_ == 0 then  -- 獨佔模式
        -- effect無法覆蓋
        if not self.on_cover then
            return
        end

        if not self.on_cover(self[1], new_task) then
            return
        end

        self[1] = new_task
    else  -- 共存模式
        -- 如果前面都滿了，就新增空間儲存
        for i = 1, #self+1 do
            if not self[i] then
                self[i] = new_task
            
                if self._max_ > 0 and i > self._max_ then
                    self:pause(new_task)
                end

                break
            end
        end
    end
end

StartTimer = function(self, new_task)
    new_task.remained_time = new_task.time or self._time_

    if self.on_pulse then
        Timer(new_task.period or self._period_, true, function(this)
            self.on_pulse(new_task)

            self.remained_time = self.remained_time - this.period_

            if this.is_shutdown() then
                self.finish(new_task)
            end
        end)
    else
        Timer(new_task.period or self._period_, false, function()
            self.finish(new_task)
        end)
    end
end


return Effect
