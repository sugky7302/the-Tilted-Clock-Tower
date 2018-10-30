local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'
local Damage = require 'damage'
local Unit = require 'unit'
local js = require 'jass_tool'

local mt = Skill '暴風雪' {
    orderId = 'A00H',
    disBlp = 'A00X',
    area = 200,
    hotkey = "w",
    damage = {{18, 24}},
    proc = 0.5,
    tip = "冷卻時間: |Cffffcc0010|r|n|n降下|Cffffcc002|r波冰霜，每波造成|Cffffcc00N|r|Cff99ccff[+P]|r" ..
    "點冰寒傷害。如果在技能施放時移動或攻擊，將打斷此技能。",
    proficiencyNeed = {75},
    castChannelTime = 2,
}

function mt:on_cast_channel()
    local g = Group(self.owner.object)
    g:EnumUnitsInRange(self.targetLoc.x, self.targetLoc.y, self.area, Group.IsEnemy)
    g:Loop(function(group, i)
        Damage{
            source = self.owner,
            target = Unit(group.units[i]),
            type = "法術",
            name = "暴風雪",
            elementType = "水",
        }
        self.owner:get "專長":EventDispatch("擊中單位", false, self.owner, Unit(group.units[i]))
        js.Sound("gg_snd_jaina_blizzard_impact01")
    end)
end