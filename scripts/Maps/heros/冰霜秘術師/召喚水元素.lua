local Skill = require 'skill'
local cj = require 'jass.common'
local Group = require 'group'
local Damage = require 'damage'
local Unit = require 'unit'
local js = require 'jass_tool'
local Pet = require 'pet'

local mt = Skill '召喚水元素' {
    orderId = 'A00V',
    disBlp = 'A00Z',
    area = 300,
    hotkey = "R",
    dur = 20,
    damage = {{10, 15}},
    proc = 0.2,
    tip = "冷卻時間: |Cffffcc0040|n|r|n在目標位置召喚一個水元素，對目標地點周圍所有敵人造成|Cffffcc00N|r|Cff99ccff[+P]|r" ..
    "點冰寒傷害。水元素的普通攻擊相當於召喚者的|Cffffcc0050%|r。水元素持續|Cffffcc0020|r秒。",
    proficiencyNeed = {50},
}

function mt:on_cast_shot()
    js.Sound("gg_snd_jaina_water_elemental_birth")
    js.TimeEffect(cj.AddSpecialEffect("war3mapImported\\188.mdx", self.targetLoc.x, self.targetLoc.y), 0.5)
    local dummy = Pet:New('hwat', self.owner, self.targetLoc, self.dur)
    dummy:set("最大物理攻擊力", self.owner:get "最大物理攻擊力" * 0.5)
    dummy:set("最小物理攻擊力", self.owner:get "最小物理攻擊力" * 0.5)
    local g = Group(self.owner.object)
    g:EnumUnitsInRange(self.targetLoc.x, self.targetLoc.y, self.area, Group.IsEnemy)
    g:Loop(function(group, i)
        Damage{
            source = dummy,
            target = Unit(group.units[i]),
            type = "法術",
            name = "召喚水元素",
            mustHit = true,
            elementType = "水",
        }
        self.owner:get "專長":EventDispatch("擊中單位", false, self.owner, Unit(group.units[i]))
    end)
    g:Remove()
end