local mt = require 'skill.core' '霜之環' {
    order_id_ = 'A00U',
    hotkey_ = "E",
    tip_ = "冷卻時間: |Cffffcc0012|n|r|n延遲|Cffffcc001.25|r秒後，在目標地點產生一圈霜之環，" ..
           "造成|Cffffcc00N|r|Cff99ccff[+P]|r點冰寒傷害，並且使敵人定身|Cff99ccff3|r秒。",
    dis_blp_ = 'A00Y',
    
    area_ = 400,
    
    damage_ = {20, 30},
    proc_ = 0.8,
    proficiency_need_ = {50},

    cast_start_time_ = 1.25,
}

-- package
local js = require 'jass_tool'
local Point = require 'point'
local AddEffect = require 'jass.common'.AddSpecialEffect

-- constants
local AREA = 300

-- 顯示霜之環的最大影響範圍
function mt:on_cast_start()
    js.Sound("gg_snd_jaina_ringoffrost_launch01")

    local Timer = require 'timer.core'
    local COUNT = 25
    Timer(self.cast_start_time_ / COUNT, COUNT, function(callback)
        local offset = Point(AREA, 0)
        offset:Rotate(callback.is_period_ * 360 / COUNT)

        local p = self.target_loc_ + offset
        js.TimeEffect(AddEffect("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", p.x_, p.y_),
                      self.cast_start_time_ * callback.is_period_ / COUNT)
        
        offset:Remove()
        p:Remove()

        -- 回報當前計時器動作完成，讓階段計時器能夠轉階段
        if callback.is_period_ == 0 then
            self.end_cast_start_ = true
        end
    end)
end

-- 顯示霜之環特效
function mt:on_cast_channel()
    local COUNT = 15
    for i = 1, COUNT do
        local offset = Point(AREA, 0)
        offset:Rotate(i * 360 / COUNT)
        local p = self.target_loc_ + offset

        js.TimeEffect(AddEffect("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", p.x_, p.y_), 1.2)
        
        offset:Remove()
        p:Remove()
    end
end 

function mt:on_cast_shot()
    local Unit   = require 'unit.core'
    local Group  = require 'group.core'
    local Damage = require 'combat.damage'

    local enum_units = Group(self.owner_.object_)
    enum_units:EnumUnitsInRange(self.target_loc_.x_, self.target_loc_.y_, self.area_, "IsEnemy")
    enum_units:Loop(function(group, i)
        local p = Point.GetUnitLoc(group.units_[i])

        -- 只選取[250, 400]範圍的敵人
        if Point.Distance(self.target_loc_, p) > 250 then
            Damage{
                source_ = self.owner_,
                target_ = Unit(group.units_[i]),
                
                name_ = "霜之環",
                type_ = "法術",
                element_type_ = "水",
            }

            Unit(group.units_[i]):AddBuff "定身"
            {
                dur_ = 3,
                skill_ = self,
            }

            self.owner_:get "專長":EventDispatch("技能-擊中單位", false, self.owner_, Unit(group.units_[i]))
        end
    end)

    enum_units:Remove()
end