local mt = require 'skill.core' "召喚水元素" {
    order_id_ = 'A00V',
    hotkey_ = "R",
    tip_ = "冷卻時間: |Cffffcc0040|n|r|n在目標位置召喚一個水元素，對目標地點周圍所有敵人造成|Cffffcc00N|r|Cff99ccff[+P]|r" ..
    "點冰寒傷害。水元素的普通攻擊相當於召喚者的|Cffffcc0050%|r。水元素持續|Cffffcc0020|r秒。",
    dis_blp_ = 'A00Z',

    area_ = 300,
    dur_ = 20,

    damage_ = {10, 15},
    proc_ = 0.2,
    proficiency_need_ = {50},
}

function mt:on_cast_shot()
    local Pet       = require 'unit.pet'
    local Unit      = require 'unit.core'
    local Group     = require 'group.core'
    local Damage    = require 'combat.damage'
    local js        = require 'jass_tool'
    local AddEffect = require 'jass.common'.AddSpecialEffect
    
    js.Sound("gg_snd_jaina_water_elemental_birth")

    js.TimeEffect(AddEffect("war3mapImported\\186.mdx", self.target_loc_.x_, self.target_loc_.y_), 0.5)

    -- TODO:記得要註冊被傷害事件
    local dummy = Pet.Create('hwat', self.owner_, self.target_loc_, self.dur_)
    self.owner_.pet_ = dummy
    dummy:set("最大物理攻擊力", self.owner_:get "最大物理攻擊力" * 0.5)
    dummy:set("最小物理攻擊力", self.owner_:get "最小物理攻擊力" * 0.5)

    -- 設定事件
    local Game = require 'game'
    Game:EventDispatch("單位-創建", dummy.object_)

    local enum_units = Group(self.owner_.object_)
    enum_units:EnumUnitsInRange(self.target_loc_.x_, self.target_loc_.y_, self.area_, "IsEnemy")
    enum_units:Loop(function(group, i)
        Damage{
            source_ = dummy,
            target_ = Unit(group.units_[i]),
            
            name_ = "召喚水元素",
            type_ = "法術",
            element_type_ = "水",
        }
        self.owner_:get "專長":EventDispatch("技能-擊中單位", false, self.owner_, Unit(group.units_[i]))
    end)
    
    enum_units:Remove()
end