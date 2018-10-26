local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'
local Damage = require 'damage'
local Hero = require 'hero'
local js = require 'jass_tool'
local Point = require 'point'
local Timer = require 'timer'

local mt = Skill '霜之環' {
    orderId = 'A00U',
    area = 400,
    hotkey = "E",
    damage = {{20, 30}},
    proc = 0.8,
    tip = "冷卻時間: |Cffffcc0012|n|r|n延遲|Cffffcc001.25|r秒後，在目標地點產生一圈霜之環，" ..
    "造成|Cffffcc00N|r|Cff99ccff[+P]|r點冰寒傷害，並且使敵人定身|Cff99ccff3|r秒。",
    proficiencyNeed = {50},
    castStartTime = 1.25,
}

-- variables
local _area = 300

function mt:on_cast_start()
    js.Sound("gg_snd_jaina_ringoffrost_launch01")
    local count = 25
    Timer(self.castStartTime / count, count, function(callback)
        local offset = Point(_area, 0)
        offset:Rotate(callback.isPeriod * 360 / count)
        local p = self.targetLoc + offset
        js.TimeEffect(cj.AddSpecialEffect("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", p.x, p.y), self.castStartTime * callback.isPeriod / count)
        offset:Remove()
        p:Remove()
    end)
end

function mt:on_cast_channel()
    local count = 15
    for i = 1, count do
        local offset = Point(_area, 0)
        offset:Rotate(i * 360 / count)
        local p = self.targetLoc + offset
        js.TimeEffect(cj.AddSpecialEffect("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", p.x, p.y), 1.2)
        offset:Remove()
        p:Remove()
    end
    js.TimeEffect(cj.AddSpecialEffect("war3mapImported\\186.mdx", self.targetLoc.x, self.targetLoc.y), 1.5)
end 

function mt:on_cast_shot()
    local g = Group(self.owner.object)
    g:EnumUnitsInRange(self.targetLoc.x, self.targetLoc.y, self.area, Group.IsEnemy)
    g:Loop(function(group, i)
        local p = Point:GetUnitLoc(group.units[i])
        if Point.Distance(self.targetLoc, p) > 250 then
            Damage{
                source = self.owner,
                target = Hero(group.units[i]),
                type = "法術",
                name = "霜之環",
                mustHit = true,
                elementType = "水",
            }
            -- Unit(group.units[i]):set("定身", 1.5)
        end
    end)
    g:Remove()
end