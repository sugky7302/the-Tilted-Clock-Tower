local require = require
local cj, japi = require 'jass.common', require 'jass.japi'

require 'unit.operator'.Register("生命上限", {
    set = function(self, max_life)
        japi.SetUnitState(self.object_, cj.UNIT_STATE_MAX_LIFE, max_life)
    end,

    get = function(self)
        return cj.GetUnitState(self.object_, cj.UNIT_STATE_MAX_LIFE)
    end, 
    
    on_set = function(self)
        local rate = self:get '生命' / self:get '生命上限'
        return function()
            self:set('生命', self:get '生命上限' * rate)
        end
    end
})