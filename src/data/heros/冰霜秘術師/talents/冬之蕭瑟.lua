-- package
local Damage = require 'combat.damage'

local mt = require 'talent' "冬之蕭瑟"
{
    cost_ = 5,
    tip_ = "水元素現在會模仿英雄施放寒冰箭、暴風雪。",
    skill_ = "召喚水元素",
}

function mt:on_call(target, id, skill)
    if not target.pet_ then
        return false
    end

    local Unit = require 'unit.core'

    -- 這裡skill是傳寒冰箭的投射物
    if id == 'A000' then
        local Missile = require 'missile.core'
        local Point = require 'point'

        local missile = Missile{
            owner_ = target.pet_,
            model_name_ = 'A00T',
            hit_mode_ = 1,

            starting_point_ = Point.GetUnitLoc(target.pet_.object_),
            target_point_ = skill.target_point_ + Point(0, 0), -- 利用加法生成新目標點，讓這個投射物在刪除時，不會刪掉原目標點

            velocity_ = skill.velocity_,
            max_distance_ = skill.max_distance_,
                
            TraceMode = "StraightLine",
            Execute = function(group, i)
                Damage{
                    source_ = target,
                    target_ = Unit(group.units_[i]),
                        
                    name_ = "寒冰箭",
                    type_ = "法術",
                    element_type_ = "水",
                }

                group:Ignore(group.units_[i])
            end,
        }
    elseif id == 'A00H' then
        local Group = require 'group.core'

        local enum_units = Group(target.object_)
        enum_units:EnumUnitsInRange(skill.target_loc_.x_, skill.target_loc_.y_, skill.area_, "IsEnemy")
        enum_units:Loop(function(group, i)
            Damage{
                source_ = target,
                target_ = Unit(group.units_[i]),
                    
                name_ = "暴風雪",
                type_ = "法術",
                element_type_ = "水",
            }
        end)

        enum_units:Remove()
    end
end