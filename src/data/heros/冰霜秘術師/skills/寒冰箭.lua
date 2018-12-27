local mt = require 'skill.core' '寒冰箭' {
    order_id_ = 'A000',
    hotkey_ = "Q",
    tip_ = "冷卻時間: |Cffffcc004|r|n|n對目標造成|Cffffcc00N|r|Cff99ccff[+P]|r點冰寒傷害。",
    dis_blp_ = 'A00W',
    
    area_ = 100,
    range_ = 800,
    velocity_ = 1000,
    
    damage_ = {10, 15, 20, 25},
    proc_ = 1,
    proficiency_need_ = {100, 150},
    
    cast_start_time_ = 2,
}

-- package
local Sound = require 'jass_tool'.Sound

function mt:on_cast_start()
    Sound("gg_snd_jaina_ringoffrost_loop01")
end

function mt:on_cast_channel()
    Sound("gg_snd_jaina_frostbolt_activate01")
end

function mt:on_cast_shot()
    local Missile = require 'missile.core'
    local Point = require 'point'
    local Damage = require 'combat.damage'
    local Unit = require 'unit.core'
    
    Sound("gg_snd_jaina_frostbolt_launch01")

    local missile = Missile{
        owner_ = self.owner_,
        model_name_ = 'A00T',
        hit_mode_ = self.owner_:TalentDispatch("冰晶裂片", "呼叫") or 1,
        
        starting_point_ = Point.GetUnitLoc(self.owner_.object_),
        target_point_ = self.target_loc_,
        
        velocity_ = self.velocity_,
        max_distance_ = self.range_,
        
        TraceMode = "StraightLine",

        Execute = function(group, i)
            Damage{
                source_ = self.owner_,
                target_ = Unit(group.units_[i]),

                name_ = "寒冰箭",
                type_ = "法術",
                element_type_ = "水",
            }

            -- 觸發專長效果
            self.owner_:get "專長":EventDispatch("技能-擊中單位", false, self.owner_, Unit(group.units_[i]))

            self.owner_:TalentDispatch("冰霜長矛", "呼叫", Unit(group.units_[i]))

            group:Ignore(group.units_[i])

            Sound("gg_snd_jaina_blizzard_impact01")
        end,
    }
    -- 新增追蹤任務-投射物
    -- 這樣才能解決finish函數在投射物刪除前就觸發的問題
    if self.handle_ then
        missile.handle_ = self.handle_
        local TaskTracker = require 'task_tracker'
        TaskTracker.add(self.handle_)
    end

    self.owner_:TalentDispatch("冰晶", "呼叫", self.target_loc_, self.range_)
    self.owner_:TalentDispatch("冬之蕭瑟", "呼叫", self.order_id_, missile)
end

function mt:on_cast_finish()
    self.owner_:TalentDispatch("冰霜長矛", "添加")
end