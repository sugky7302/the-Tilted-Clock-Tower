local Skill = require 'skill.core'
local cj = require 'jass.common'
local Group = require 'group.core'
local Damage = require 'combat.damage'
local Unit = require 'unit.core'
-- local Missile = require 'missile'
local Point = require 'point'
local Sound = require 'jass_tool'.Sound
-- local Talent = require 'talent'

local mt = Skill '寒冰箭' {
    order_id_ = 'A000',
    dis_blp_ = 'A00W',
    area_ = 100,
    range_ = 800,
    damage_ = {{10, 15}, {20, 25}},
    proc_ = 1,
    hotkey_ = "Q",
    proficiency_need_ = {100, 150},
    tip_ = "冷卻時間: |Cffffcc004|r|n|n對目標造成|Cffffcc00N|r|Cff99ccff[+P]|r點冰寒傷害。" .. 
    "寒冰箭對被冰凍的目標造成|Cffffcc002.25|r倍傷害。",
    cast_start_time_ = 2,
}

function mt:on_cast_start()
    Sound("gg_snd_jaina_ringoffrost_loop01")
end

function mt:on_cast_channel()
    Sound("gg_snd_jaina_frostbolt_activate01")
end

-- function mt:on_cast_shot()
--     Sound("gg_snd_jaina_frostbolt_launch01")
--     local missile = Missile{
--         owner = self.owner,
--         modelName = 'A00T',
--         startingPoint = Point.GetUnitLoc(self.owner.object),
--         targetPoint = self.targetLoc,
--         maxDistance = self.range,
--         traceMode = "StraightLine",
--         hitMode = self.owner:TalentDispatch("冰晶裂片", "呼叫") or 1,
--         execution = function(group, i)
--             Damage{
--                 source = self.owner,
--                 target = Unit(group.units[i]),
--                 type = "法術",
--                 name = "寒冰箭",
--                 elementType = "水",
--             }
--             self.owner:get "專長":EventDispatch("擊中單位", false, self.owner, Unit(group.units[i]))
--             self.owner:TalentDispatch("冰霜長矛", "呼叫", Unit(group.units[i]))
--             group:Ignore(group.units[i])
--             js.Sound("gg_snd_jaina_blizzard_impact01")
--         end,
--     }
--     self.owner:TalentDispatch("冰晶", "呼叫", self.targetLoc, self.range)
--     self.owner:TalentDispatch("冬之蕭瑟", "呼叫", self.orderId, missile)
-- end

-- function mt:on_cast_finish()
--     self.owner:TalentDispatch("冰霜長矛", "添加")
-- end