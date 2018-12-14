local mt = require 'buff.core' "減速"

-- constants
mt.cover_type_ = 1
mt.cover_max_ = 1
mt.model_ = [[Abilities\Spells\Human\slow\slowtarget.mdl]]

function mt:on_add()
	self.target_:add('移動速度%', - self.val_)
end

function mt:on_remove()
	self.target_:add('移動速度%', self.val_)
end

function mt:on_cover(new)
	return new.val_ > self.val_
end
