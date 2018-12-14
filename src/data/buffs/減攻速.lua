local mt = require 'buff.core' "減攻速"

-- constants
mt.model_ = [[Abilities\Spells\Human\slow\slowtarget.mdl]]

function mt:on_add()
	self.target_:add('攻擊速度', - self.val_)
end

function mt:on_remove()
	self.target_:add('攻擊速度', self.val_)
end

function mt:on_cover(new)
	return new.val_ > self.val_
end
