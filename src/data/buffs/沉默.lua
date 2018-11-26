local cj = require 'jass.common'

local mt = require 'buff' "沉默"

-- constants
mt.model = [[Abilities\Spells\Other\Silence\SilenceTarget.mdl]]
mt.modelPoint = "overhead"

function mt:on_add()
    for _, skill in ipairs(self.target.eachCasting) do
        skill:Break()
    end
    -- 獲取技能
    for _, skill in pairs(self.target.heroDatas[cj.GetUnitName(self.target.object)].skillDatas) do
        if skill.canUse == true then
            skill.canUse = false
            self.target:AbilityDisable(skill.orderId)
            self.target:AddAbility(skill.disBlp)
        end
    end
end

function mt:on_remove()
    for _, skill in pairs(self.target.heroDatas[cj.GetUnitName(self.target.object)].skillDatas) do
        if skill.canUse == false then
            skill.canUse = true
            self.target:RemoveAbility(skill.disBlp)
            self.target:AbilityEnable(skill.orderId)
        end
    end
end
