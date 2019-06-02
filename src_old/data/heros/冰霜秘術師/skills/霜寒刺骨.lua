local mt = require 'skill.core' '霜寒刺骨' {
    order_id_ = 'A00F',
    tip_ = "所有技能都會對目標造成冰冷效果，移動速度降低|cffffcc0025%|r，並且使你的技能傷害提高" ..
           "|cffffcc0035%|r，持續|cffffcc004|r秒。施放技能將重置持續時間。",
}

function mt:on_hit(source, target)
    source:AddBuff "霜寒刺骨buff"
    {
        dur_ = 4,
        skill_ = self,
    }

    target:AddBuff "減速"
    {
        name_ = "霜寒刺骨debuff",
        dur_ = 4,
        val_ = 25,
        skill_ = self,

        tip_skill_ = 'A00S',
        model_ = [[Abilities\Spells\Other\FrostDamage\FrostDamage.mdl]],
        model_point_ = 'chest',
    }
end

local mt = require 'buff.core' "霜寒刺骨buff"

function mt:on_add()
    self.target_:set("霜寒刺骨加成", 0.35)
end

function mt:on_remove()
    self.target_:set("霜寒刺骨加成", 0)
end