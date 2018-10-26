local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'
local Damage = require 'damage'
local Hero = require 'hero'
local Missile = require 'missile'
local Point = require 'point'
local js = require 'jass_tool'

local mt = Skill '寒冰箭' {
    orderId = 'A000',
    area = 100,
    range = 800,
    damage = {{10, 15}, {20, 25}},
    proc = 1,
    hotkey = "Q",
    proficiencyNeed = {100, 150},
    tip = "冷卻時間: |Cffffcc004|r|n|n對目標造成|Cffffcc00N|r|Cff99ccff[+P]|r點冰寒傷害。" .. 
    "寒冰箭對被冰凍的目標造成|Cffffcc002.25|r倍傷害。",
    castStartTime = 2,
}

function mt:on_cast_start()
    js.Sound("gg_snd_jaina_ringoffrost_loop01")
end

function mt:on_cast_channel()
    js.Sound("gg_snd_jaina_frostbolt_activate01")
end

function mt:on_cast_shot()
    js.Sound("gg_snd_jaina_frostbolt_launch01")
    Missile{
        owner = self.owner,
        modelName = 'A00T',
        startingPoint = Point:GetUnitLoc(self.owner.object),
        targetPoint = self.targetLoc,
        maxDistance = self.range,
        traceMode = "StraightLine",
        hitMode = 1,
        execution = function(group, i)
            Damage{
                source = self.owner,
                target = Hero(group.units[i]),
                type = "法術",
                name = "寒冰箭",
                mustHit = true,
                elementType = "水",
            }
            group:Ignore(group.units[i])
            js.Sound("gg_snd_jaina_blizzard_impact01")
        end,
    }
end