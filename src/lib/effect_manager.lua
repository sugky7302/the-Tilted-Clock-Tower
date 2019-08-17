-- Effect的外部接口。

local require = require
local Effect = require 'lib.effect'


local EffectManager = require 'util.class'("EffectManager")
local LoadTemplates

function EffectManager:_new()
    return {_effects_ = LoadTemplates()}
end

LoadTemplates = function()
    local concat = table.concat
    local path = 'data.effects.templates.'

    local templates = require(concat{path, 'init'})
    local effects = {}

    -- 使用xpcall捕獲require異常，會知道哪個module沒讀到
    for _, name in ipairs(templates) do
        local success, template = xpcall(require, debug.traceback, concat{path, name}))
        if success then
            effects[template.name] = Effect:new(template, self)
        end
    end

    return effects
end

function EffectManager:getInstance()
    if not self._instance_ then
        self._instance_ = self:new()
    end

    return self._instance_
end

function EffectManager:getEffect(name)
    return self._effects_[name]
end

function EffectManager:add(data)
    local effect = self._effects_[data.name]
    if effect then
        effect:start(data)
    end
end

function EffectManager:delete(data)
    local effect = self._effects_[data.name]
    if effect then
        effect:delete(data)
    end
end


return EffectManager
