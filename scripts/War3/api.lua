local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Debug = require 'jass.debug'

local Api = {}
setmetatable(Api, Api)

function Api.CreateTrigger(callBack)
    local trg = cj.CreateTrigger()
    Debug.handle_ref(trg)
    Api[js.H2I(trg)] = cj.TriggerAddCondition(trg, cj.Condition(callBack))
    return trg
end

function Api.DestroyTrigger(trg)
    cj.TriggerRemoveCondition(Api[js.H2I(trg)])
    Api[js.H2I(trg)] = nil
    cj.DestroyTrigger(trg)
    Debug.handle_unref(trg)
end

return Api
    