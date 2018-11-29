local mt = require 'buff' "沉默"

-- constants
mt.model = [[Abilities\Spells\Other\Silence\SilenceTarget.mdl]]
mt.model_point = "overhead"

-- assert
local pairs, ipairs = pairs, ipairs
local cj_GetUnitName = require 'jass.common'.GetUnitName

function mt:on_add()
    for _, skill in ipairs(self.target.each_casting) do
        skill:Break()
    end

    -- 換成暗圖標
    for _, skill in pairs(self.target.hero_datas[cj_GetUnitName(self.target.object)].skill_datas) do
        if skill.can_use == true then
            skill.can_use = false
            self.target:AbilityDisable(skill.order_id)
            self.target:AddAbility(skill.dis_blp)
        end
    end
end

function mt:on_remove()
    for _, skill in pairs(self.target.heroDatas[cj_GetUnitName(self.target.object)].skillDatas) do
        if skill.canUse == false then
            skill.canUse = true
            self.target:RemoveAbility(skill.disBlp)
            self.target:AbilityEnable(skill.orderId)
        end
    end
end
