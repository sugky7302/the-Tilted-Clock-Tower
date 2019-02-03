-- 技能的基本功能
-- 依賴
--   jass.slk
--   skill.init
--   skill.cast
--   jass.japi


-- package
local require = require
local Class = require 'class'

local Skill = Class("Skill", require 'skill.init')

-- 實際技能為Skill的子類別
function Skill:_new(data)
    self = Class(data.name_, Skill)
    
    self:_copy(data)
    data = nil

    if self.order_id_ then
        local slk_ability = require 'jass.slk'.ability

        -- 獲取指令，如果是通魔技能就去獲取基礎id
        self.order_ = slk_ability[self.order_id_].Order
        self.order_ = (self.order_ == "channel") and slk_ability[self.order_id_].DataF

        self.cool_  = slk_ability[self.order_id_].Cool
        self.blp_   = slk_ability[self.order_id_].Art
    end

    Skill:setSubclass(self.name_, self)

    self._new = function(self, hero, target_unit, target_loc)
        self.owner_ = hero
        self.target_unit_ = target_unit
        self.target_loc_ = target_loc
    end

    self._delete = function(self)
        Skill._delete(self)
    end
end

function Skill:_delete()
    -- 從玩家施法隊列中清除當前技能副本
    local table_remove = table.remove
    for i, skill in pairs(self.owner_.each_casting_) do 
        if v == self then
            table_remove(self.owner_.each_casting_, i)
            break
        end
    end
end

-- 調用施法動作
function Skill:Cast()
    local Cast = require 'skill.cast'
    Cast(self)
end

-- 不打斷直接施放的階段，只打斷需要時間的階段
-- castbar是把動作從計時器break掉，讓計時器自動刪除漂浮文字
function Skill:Break()
    -- "開始" 階段可以被打斷才打斷
    if (self.break_cast_start_ == 1) and self.cast_start_timer_ then
        self.castbar_:Break()
        self.cast_start_timer_:Break()
        self:Remove()
    end

    -- "引導" 階段可以被打斷才打斷
    if (self.break_cast_channel_ == 1) and self.cast_channel_timer_ then
        self.castbar_:Break()
        self.cast_channel_timer_:Break()
        self:Remove()
    end

    -- "出手" 階段可以被打斷才打斷
    if (self.break_cast_shot_ == 1) and self.cast_shot_timer_ then
        self.castbar_:Break()
        self.cast_shot_timer_:Break()
        self:Remove()
    end
end

-- 沒有返回值用notify，有返回值才用dispatch
function Skill:EventDispatch(name, force, ...)
    force = force or false

    -- force是檢測要不要強制執行
    if not force then
        if self.invalid_ then
            return false
        end
    end

    -- 事件名轉換成實際動作函數名
    local EVENT_NAME = {
        ['技能-施法開始'] = 'on_cast_start',
        ['技能-施法引導'] = 'on_cast_channel',
        ['技能-施法出手'] = 'on_cast_shot',
        ['技能-施法完成'] = 'on_cast_finish',
        ['技能-擊中單位'] = 'on_hit',
        ['技能-造成傷害'] = 'on_deal_damage',
    }

    -- 調用該技能的階段事件
    name = EVENT_NAME[name]
    if self[name] then
        return self[name](self, ...)
    end
    
    return false
end

local S2Id = Base.String2Id
local table_concat = table.concat
local japi = require 'jass.japi'

function Skill:UpdateName()
    local print_tb = {self.name_, "(|cffffcc00", self.hotkey_, "|r) - [等級 |cffffcc00", self.level_, "|r"}

    -- 達最大等級就不顯示熟練度
    if self.level_ == self.max_level_ then
        print_tb[#print_tb + 1] = "]"
    else
        print_tb[#print_tb + 1] = " - |cffffcc00"
        print_tb[#print_tb + 1] = self.proficiency_
        print_tb[#print_tb + 1] = "|r/|cffffcc00"
        print_tb[#print_tb + 1] = self.proficiency_need_[self.level_]
        print_tb[#print_tb + 1] = "|r]"
    end

    -- 更新技能名稱
    japi.EXSetAbilityDataString(japi.EXGetUnitAbility(self.owner_.object_, S2Id(self.order_id_)), 1, 215,
                                table_concat(print_tb))
end

function Skill:UpdateTip()
    local string_gsub = string.gsub
    local print_tb = {}

    -- 有技能傷害表示更新技能說明需要替換值，不然不用更動
    if self.damage_ then
        -- 替換傷害值
        local state = string_gsub(self.tip_, "N", table_concat({self.damage_[2 * self.level_ - 1], "-",
                                                                self.damage_[2 * self.level_]}))

        -- 替換技能係數
        state = string_gsub(state, "P", self.proc_ .. "")

        print_tb[#print_tb + 1] = state
    else
        print_tb[#print_tb + 1] = self.tip_
    end

    -- 更新天賦到技能說明
    -- 利用短路檢測有沒有天賦
    if self.owner_.talents_ and self.owner_.talents_[self.hotkey_] then
        -- 空一行把技能說明跟天賦敘述分開
        print_tb[#print_tb + 1] = "|n"

        local ipairs = ipairs
        for _, talent in ipairs(self.owner_.talents_[self.hotkey_]) do
            print_tb[#print_tb + 1] = "|n|Cffffff00["
            print_tb[#print_tb + 1] = talent.name_
            print_tb[#print_tb + 1] = "]|r"
            print_tb[#print_tb + 1] = talent.tip_
        end
    end

    -- 更新技能說明
    japi.EXSetAbilityDataString(japi.EXGetUnitAbility(self.owner_.object_, S2Id(self.order_id_)), 1, 218,
                                table_concat(print_tb))
end

return Skill
