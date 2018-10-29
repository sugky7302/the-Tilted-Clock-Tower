local mt = require 'buff' "減攻速"

-- constants
mt.model = [[Abilities\Spells\Human\slow\slowtarget.mdl]]

function mt:on_add()
	self.target:add('攻擊速度', - self.val)
end

function mt:on_remove()
	self.target:add('攻擊速度', self.val)
end

function mt:on_cover(new)
	return new.val > self.val
end
