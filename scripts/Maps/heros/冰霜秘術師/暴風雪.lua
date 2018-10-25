local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'
local Damage = require 'damage'
local Hero = require 'hero'
local js = require 'jass_tool'

local mt = Skill '暴風雪' {
    orderId = 'A00H',
    area = 200,
    hotkey = "w",
    castChannelTime = 2,
}

function mt:on_cast_channel()
    local g = Group(self.owner.object)
    g:EnumUnitsInRange(self.targetLoc.x, self.targetLoc.y, self.area, Group.IsEnemy)
    g:Loop(function(group, i)
        Damage{
            source = self.owner,
            target = Hero(group.units[i]),
            type = "法術",
            name = "暴風雪",
            mustHit = true,
            elementType = "水",
            basicDamage = {18, 24},
            proc = 0.5,
        }
        js.Sound("gg_snd_jaina_blizzard_impact01")
    end)
end