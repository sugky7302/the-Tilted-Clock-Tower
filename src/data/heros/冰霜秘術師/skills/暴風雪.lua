local mt = require 'skill.core' '暴風雪' {
    order_id_ = 'A00H',
    hotkey_ = "W",
    tip_ = "冷卻時間: |Cffffcc0010|r|n|n降下|Cffffcc002|r波冰霜，每波造成|Cffffcc00N|r|Cff99ccff[+P]|r" ..
           "點冰寒傷害。如果在技能施放時移動或攻擊，將打斷此技能。",
    dis_blp_ = 'A00X',

    area_ = 200,
    range_ = 600,

    damage_ = {18, 24},
    proc_ = 0.5,
    proficiency_need_ = {75},
    
    cast_channel_time_ = 2,
}

function mt:on_cast_channel()
    local Group = require 'group.core'
    local Damage = require 'combat.damage'
    local Unit = require 'unit.core'
    local Sound = require 'jass_tool'.Sound

    local enum_units = Group(self.owner_.object_)
    enum_units:EnumUnitsInRange(self.target_loc_.x_, self.target_loc_.y_, self.area_, "IsEnemy")
    enum_units:Loop(function(group, i)
        Damage{
            source_ = self.owner_,
            target_ = Unit(group.units_[i]),
            
            name_ = "暴風雪",
            type_ = "法術",
            element_type_ = "水",
        }

        self.owner_:get "專長":EventDispatch("技能-擊中單位", false, self.owner_, Unit(group.units_[i]))
        
        Sound("gg_snd_jaina_blizzard_impact01")
    end)

    enum_units:Remove()
    
    self.owner_:TalentDispatch("冬之蕭瑟", "呼叫", self.order_id_, self)
end