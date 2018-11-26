local cj = require 'jass.common'
local Missile = require 'missile'
local Point = require 'point'
local Unit = require 'unit'
local Damage = require 'damage'
local Group = require 'group'

local mt = require 'talent' "冬之蕭瑟"
{
    cost = 5,
    tip = "水元素現在會模仿英雄施放寒冰箭、暴風雪。",
    skill = "召喚水元素",
}

function mt:on_call(target, id, skill)
    if target.pet then
        if id == 'A000' then
            Missile{
                owner = target,
                modelName = 'A00T',
                startingPoint = Point:GetUnitLoc(target.pet.object),
                targetPoint = skill.targetPoint,
                maxDistance = skill.maxDistance,
                traceMode = "StraightLine",
                hitMode = 1,
                execution = function(group, i)
                    Damage{
                        source = target,
                        target = Unit(group.units[i]),
                        type = "法術",
                        name = "寒冰箭",
                        elementType = "水",
                    }
                    group:Ignore(group.units[i])
                end,
            }
        elseif id == 'A00H' then
            local g = Group(target.object)
            g:EnumUnitsInRange(skill.targetLoc.x, skill.targetLoc.y, skill.area, Group.IsEnemy)
            g:Loop(function(group, i)
                Damage{
                    source = target,
                    target = Unit(group.units[i]),
                    type = "法術",
                    name = "暴風雪",
                    elementType = "水",
                }
            end)
        end
    end
end