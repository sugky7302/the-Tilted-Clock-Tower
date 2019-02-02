-- we單位組的擴展，開放許多自定義功能
-- 依賴
--   jass.common
--   queue
--   array
--   jass_tool
--   group.condition
-- API
--   Clear : 清空單位組
--   Loop(action, ...) : 對單位組所有單位做動作
--   In(unit) : 確認單位有沒有在單位組裡，返回值為bool
--   getNum : 獲取單位組內的單位總數
--   IsEmpty : 回報單位組是否為空
--   Ignore(unit) : 使單位組不會對該單位執行動作
--   EnumUnitsInRange(x, y, r, cnd) : 選取範圍內的單位
--   AddUnit(unit) : 添加單位給單位組
--   RemoveUnit(unit) : 刪除單位組中的某單位

-- package
local require = require
local Queue = require 'stl.queue'
local cj = require 'jass.common'


local Group = require 'class'("Group")
Group._VERION = "1.0.0"

-- constants
local QUANTITY = 128

-- assert
-- 使用queue是因為要重複利用we的單位組，減少ram的開銷
local recycle_group = Queue()

local GetEmptyGroup, RecycleGroup

-- 建構函式
function Group:_new(filter)
    local Array = require 'stl.array'
    
    self._ignore_label_ = {}

    self.object_ = GetEmptyGroup()
    self.units_  = Array()

    -- 如果filter沒有傳參，要設定成0才不會出問題
    self.filter_ = filter or 0 
end

function Group:_delete()
    RecycleGroup(self.object_)

    self:Clear()

    self.units_:Remove()
end

function Group:Clear()
    self:Loop(function(self, i)
        -- x self[i]
        -- v self.units_[i]
        self:RemoveUnit(self.units_[i])
    end)

    cj.GroupClear(self.object_)
    self.units_:Clear()
end

-- action的格式要是
-- function(self, i, ...)
--     body
-- end
-- 順序循環在執行改變array長度的動作時，由於最後一個元素會補到空位，而導致順序不正確
-- 只有2個元素的array，如果delete array[1]刪掉，會讀不到array[2]
-- 使用倒序循環就不會出現這樣的問題
function Group:Loop(action, ...)
    for i = self.units_:getLength(), 1, -1 do -- BUG: 寒冰箭投射物結束後，有時會獲取不到self.units_而報錯
        action(self, i, ...)
    end
end

function Group:In(unit)
    return self.units_:Exist(unit)
end

function Group:getNum()
    return self.units_:getLength()
end

function Group:IsEmpty()
    return self.units_:IsEmpty()
end

-- assert
local H2I = require 'jass_tool'.H2I

function Group:Ignore(unit)
    self._ignore_label_[H2I(unit) .. ""] = true
end 

-- cnd_name 有 IsEnemy、IsAlly、IsHero、IsNonHero、Nil
function Group:EnumUnitsInRange(x, y, r, cnd_name)
    local GroupCnd = require 'group.condition'

    local enum_range_units = GetEmptyGroup()

    -- 選取比原先範圍大一些的區域，好讓有些處在範圍邊緣的單位能夠被正確選取
    cj.GroupEnumUnitsInRange(enum_range_units, x, y, r + 10, nil)

    local enum_unit = cj.FirstOfGroup(enum_range_units)
    while H2I(enum_unit) ~= 0 do
        if GroupCnd[cnd_name](enum_unit, self.filter_) and 
        (not self._ignore_label_[H2I(enum_unit) .. ""]) and 
        H2I(enum_unit) ~= H2I(self.filter_) then
            self:AddUnit(enum_unit)
        end

        cj.GroupRemoveUnit(enum_range_units, enum_unit)
        
        enum_unit = cj.FirstOfGroup(enum_range_units)
    end

    RecycleGroup(enum_range_units)
end

GetEmptyGroup = function()
    -- 超過上限報錯
    -- 用 ">" 是因為這個函式會減少recycle_group的數量
    if recycle_group:getLength() > QUANTITY then
        local ErrorHandle = Base.ErrorHandle
        ErrorHandle("單位組超過上限。")
        return false
    end

    if recycle_group:IsEmpty() then
        return cj.CreateGroup()
    end
    
    local empty_group = recycle_group:front()
    recycle_group:PopFront()
    
    return empty_group
end

RecycleGroup = function(group)
    -- 用 ">=" 是因為這個函式會增加recycle_group的數量
    if recycle_group:getLength() >= QUANTITY then
        cj.DestroyGroup(group)
    else
        recycle_group:PushBack(group)
    end
end

function Group:AddUnit(unit)
    cj.GroupAddUnit(self.object_, unit)
    self.units_:PushBack(unit)
end

function Group:RemoveUnit(unit)
    cj.GroupRemoveUnit(self.object_, unit)
    self.units_:Delete(unit)
end

return Group