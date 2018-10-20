local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'

local mt = Skill '暴風雪' {
    orderId = 'AHbz',
    area = 600,
}

function mt:on_cast_start(hero, target)
    local g = Group(hero)
    -- g:EnumUnitsInRange(target.x, target.y, self.area, Group.IsEnemy)
    g:EnumUnitsInRange(0, 0, self.area, Group.IsEnemy)
    g:Loop(function(group, i)
    end)
end