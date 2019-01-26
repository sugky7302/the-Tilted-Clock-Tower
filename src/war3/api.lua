-- 此module重載we內部的trigger，使其符合lua的調用格式
-- 也打破了原先triiger無法傳參、只能是無參數函數等侷限性

-- package
local require = require
local cj = require 'jass.common'
local js = require 'jass_tool'
local Debug = require 'jass.debug'

local Api = {}

function Api.CreateTrigger(callback)
    local trg = cj.CreateTrigger()

    -- 增加handle的引用
    Debug.handle_ref(trg) 

    Api[js.H2I(trg)] = cj.TriggerAddCondition(trg, cj.Condition(callback))
    
    return trg
end

function Api.DestroyTrigger(trg)
    cj.TriggerRemoveCondition(Api[js.H2I(trg)])
    
    Api[js.H2I(trg)] = nil
    
    cj.DestroyTrigger(trg)

    -- 減少handle的引用
    Debug.handle_unref(trg)
end

return Api
    