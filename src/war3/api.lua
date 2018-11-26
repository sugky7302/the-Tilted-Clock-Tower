-- 此module重載we內部的trigger，使其符合lua的調用格式
-- 也打破了原先triiger無法傳參、只能是無參數函數等侷限性

local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Debug = require 'jass.debug'

local Api = {}
setmetatable(Api, Api)

function Api.CreateTrigger(callBack)
    local trg = cj.CreateTrigger()
    Debug.handle_ref(trg) -- 增加handle的引用
    Api[js.H2I(trg)] = cj.TriggerAddCondition(trg, cj.Condition(callBack))
    return trg
end

function Api.DestroyTrigger(trg)
    cj.TriggerRemoveCondition(Api[js.H2I(trg)])
    Api[js.H2I(trg)] = nil
    cj.DestroyTrigger(trg)
    Debug.handle_unref(trg) -- 減少handle的引用
end

return Api
    