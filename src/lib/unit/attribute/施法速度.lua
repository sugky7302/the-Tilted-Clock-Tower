require 'unit.operator'.Register("施法速度", {
    get = function(self)
        return 2 * self:get "急速" / (self:get "急速" + 100 + 50 * self.level_)
    end
})