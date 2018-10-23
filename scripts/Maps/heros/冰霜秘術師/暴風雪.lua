local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'
local Damage = require 'damage'
local Hero = require 'hero'


local mt = Skill '暴風雪' {
    orderId = 'A00H',
    area = 600,
    castStartTime = 2,
}

function mt:on_cast_start(hero, _, loc)
    local g = Group(hero.object)
    g:EnumUnitsInRange(loc.x, loc.y, self.area, Group.IsEnemy)
    g:Loop(function(group, i)
        Damage{
            source = hero,
            target = Hero(group.units[i]),
            type = "法術",
            name = "暴風雪",
            mustHit = true,
            elementType = "水",
            basicDamage = {12, 20},
            proc = 0.5,
        }
    end)
end