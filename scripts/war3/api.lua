local jass = require 'jass.common'
local debug = require 'jass.debug'

war3 = {}

function war3.CreateTrigger(call_back)
	local trg = jass.CreateTrigger()
	debug.handle_ref(trg)
	war3[jass.GetHandleId(trg)] = jass.TriggerAddCondition(trg, jass.Condition(call_back))
	return trg
end

function war3.DestroyTrigger(trg)
	jass.TriggerRemoveCondition(war3[jass.GetHandleId(trg)])
	war3[jass.GetHandleId(trg)] = nil
	jass.DestroyTrigger(trg)
	debug.handle_unref(trg)
end

return war3
