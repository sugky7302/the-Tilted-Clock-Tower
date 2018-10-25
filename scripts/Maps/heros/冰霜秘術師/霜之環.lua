local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'
local Damage = require 'damage'
local Hero = require 'hero'
local js = require 'jass_tool'
local Point = require 'point'

local mt = Skill '霜之環' {
    orderId = 'A00U',
    area = 400,
    hotkey = "E",
    castStartTime = 1,
}

function mt:on_cast_start()
    js.Sound("gg_snd_jaina_ringoffrost_launch01")
end

function mt:on_cast_channel()
    local Timer, area = require 'timer', 300
    for i = 1, 20 do
        local offset = Point(area, 0)
        offset:Rotate(i * 18)
        local p = self.targetLoc + offset
        local effect = cj.AddSpecialEffect("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", p.x, p.y)
        Timer(1.2, false, function()
            cj.DestroyEffect(effect)
        end)
        offset:Remove()
        p:Remove()
    end
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
                basicDamage = {20, 30},
                proc = 0.8,
            }
        end
    end)
    local effect = cj.AddSpecialEffect("war3mapImported\\186.mdx", self.targetLoc.x, self.targetLoc.y)
    Timer(1.5, false, function()
        cj.DestroyEffect(effect)
    end)
end