local SetLife, GetLife = require 'jass.common'.SetWidgetLife, require 'jass.common'.GetWidgetLife

require 'unit.operator'.Register("生命", {
    set = function(self, life)
        if life > 1 then
            SetLife(self.object_, life)
        else
            SetLife(self.object_, 1)
        end
    end,

    get = function(self)
        return GetLife(self.object_)
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