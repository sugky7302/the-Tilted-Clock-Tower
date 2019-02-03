local require = require
local cj = require 'jass.common'

require 'unit.operator'.Register("生命", {
    set = function(self, life)
        if life > 1 then
            cj.SetWidgetLife(self.object_, life)
        else
            -- 用觸發設定成0，會導致單位無法死亡
            cj.SetWidgetLife(self.object_, 1)
        end
    end,

    get = function(self)
        return cj.GetWidgetLife(self.object_)
    end, 
    
    on_get = function(self, life)
        if life < 0 then
            return 0
        end
        
        local max_life = self:get "生命上限"
        if life > max_life then
            return max_life
        end

        return life
    end
})