local Skill = require 'skill'
local Buff = require 'buff'

local mt = Skill '霜寒刺骨' {
    orderId = 'A00F',
    tip = "所有技能都會對目標造成冰冷效果，移動速度降低|cffffcc0025%|r，並且使你的技能傷害提高" ..
    "|cffffcc0035%|r，持續|cffffcc004|r秒。施放技能將重置持續時間。",
}

function mt:on_hit(source, target)
    source:AddBuff "霜寒刺骨buff"
    {
        dur = 4,
        skill = self,
    }
    target:AddBuff "霜寒刺骨debuff"
    {
        dur = 4,
        moveSpeed = 25,
        skill = self,
    }
end

local mt = Buff "霜寒刺骨buff"

function mt:on_add()
    self.target:set("霜寒刺骨", 0.35)
end

function mt:on_remove()
    self.target:set("霜寒刺骨", 0)
end

local mt = Buff "霜寒刺骨debuff"
mt.tipSkill = 'A00S'
mt.model = [[Abilities\Spells\Other\FrostDamage\FrostDamage.mdl]]
mt.modelPoint = 'chest'

function mt:on_add()
    self.target:add("移動速度%", - self.moveSpeed)
end

function mt:on_remove()
    self.target:add("移動速度%", self.moveSpeed)
end