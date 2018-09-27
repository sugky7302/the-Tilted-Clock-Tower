        local cj = require 'jass.common'
        local Debug = require 'jass.debug'
        Api = {}
        function Api.CreateTrigger(call_back)
            local trg = cj.CreateTrigger()
            Debug.handle_ref(trg)
            Api[cj.GetHandleId(trg)] = cj.TriggerAddCondition(trg, cj.Condition(call_back))
            return trg
        end
        function Api.DestroyTrigger(trg)
            cj.TriggerRemoveCondition(Api[cj.GetHandleId(trg)])
            Api[cj.GetHandleId(trg)] = nil
            cj.DestroyTrigger(trg)
            Debug.handle_unref(trg)
        end
        return Api
    