-- package
local try_catch = require 'try_catch'

local mt = require 'buff.core' "沉默"

-- constants
mt.model_ = [[Abilities\Spells\Other\Silence\SilenceTarget.mdl]]
mt.model_point_ = "overhead"

-- assert
local pairs, ipairs = pairs, ipairs
local cj_GetUnitName = require 'jass.common'.GetUnitName

function mt:on_add()
    -- 終止施法序列
    try_catch{
        function(self)
            for _, skill in ipairs(self.target_.each_casting_) do
                    skill:Break()
            end
        end
    }

    -- 禁用技能
    try_catch{
        function(self)
            for _, skill in pairs(self.target_.hero_datas[cj_GetUnitName(self.target_.object_)].skill_datas) do
                if skill.can_use_ == true then
                    skill.can_use_ = false

                    -- 換成暗圖標
                    self.target_:AbilityDisable(skill.order_id_)
                    self.target_:AddAbility(skill.dis_blp_)
                end
            end
        end
    }
end

function mt:on_remove()
    -- 啟用技能
    try_catch{
        function(self)
            for _, skill in pairs(self.target_.hero_datas[cj_GetUnitName(self.target_.object_)].skill_datas) do
                if skill.can_use_ == false then
                    skill.can_use_ = true

                    -- 換回明圖標
                    self.target_:RemoveAbility(skill.dis_blp_)
                    self.target_:AbilityEnable(skill.order_id_)
                end
            end
        end
    }
end
