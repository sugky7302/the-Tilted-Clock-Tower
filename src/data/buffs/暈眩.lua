local Buff = require 'buff.core'
local SkillUtil = require 'skill.util'

local mt = Buff "暈眩"

-- constants
mt.model_ = [[Abilities\Spells\Human\Thunderclap\ThunderclapTarget.mdl]]
mt.model_point_ = "overhead"

function mt:on_add()
    SkillUtil.ChangeTurnRate(self.target_, 0x01, 0)
    Buff["沉默"].on_add(self)
    Buff['繳械'].on_add(self)
end

function mt:on_remove()
    SkillUtil.ChangeTurnRate(self.target_, 0x02)
    Buff["沉默"].on_remove(self)
    Buff['繳械'].on_remove(self)
end