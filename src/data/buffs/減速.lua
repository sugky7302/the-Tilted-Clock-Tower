local mt = require 'buff' "減速"

-- constants
mt.coverType = 1
mt.coverMax = 1
mt.model = [[Abilities\Spells\Human\slow\slowtarget.mdl]]

function mt:on_add()
	self.target:add('移動速度%', - self.val)
end

function mt:on_remove()
	self.target:add('移動速度%', self.val)
end

function mt:on_cover(new)
	return new.val > self.val
end
