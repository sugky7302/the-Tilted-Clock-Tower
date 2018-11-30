-- 此module是we單位組的擴展，開放許多自定義功能

local setmetatable = setmetatable

local Queue = require 'stl.queue'
local cj = require 'jass.common'

local Group, mt = {}, require 'group.condition'
setmetatable(Group, Group)
Group.__index = mt

-- constants
local _QUANTITY = 128

-- assert
-- 使用queue是因為要重複利用we的單位組，盡量減少ram的開銷
local _recycle_group = Queue()

local _GetEmptyGroup

-- 建構函式
function Group:__call(filter)
    local Array = require 'stl.array'

    local instance = {
        _ignore_label_ = {},

        object_ = _GetEmptyGroup(),
        units_  = Array(),
        filter_ = filter or 0, -- 用於條件判定，如果filter沒有傳參，要設定成0才不會出問題
    }
    
    setmetatable(instance, self)

    return instance
end

_GetEmptyGroup = function()
    -- 超過上限報錯
    -- 用 ">" 是因為這個函式會減少_recycle_group的數量
    if _recycle_group:getLength() > _QUANTITY then
        local ErrorHandle = Base.ErrorHandle
        ErrorHandle("單位組超過上限。")
        return false
    end

    if _recycle_group:IsEmpty() then
        return cj.CreateGroup()
    end
    
    local empty_group = _recycle_group:front()
    _recycle_group:PopFront()
    return empty_group
end

function mt:Remove()
    -- 用 ">=" 是因為這個函式會增加_recycle_group的數量
    if _recycle_group:getLength() >= _QUANTITY then
        cj.DestroyGroup(self.object_)
    else
        _recycle_group:PushBack(self.object_)
    end

    self:Clear()

    self.units_:Remove()
    self.units_ = nil
    self._ignore_label_ = nil
    self.object_ = nil
    self = nil
end

function mt:Clear()
    self:Loop(function(self, i)
        self:RemoveUnit(self[i])
    end)

    cj.GroupClear(self.object_)
    self.units_:Clear()
end

-- action的格式要是
-- function(self, i)
--     script
-- end
-- 順序循環在執行改變array長度的動作時，由於最後一個元素會補到空位，而導致順序不正確
-- 只有2個元素的array，如果delete array[1]刪掉，會讀不到array[2]
-- 使用倒序循環就不會出現這樣的問題
function mt:Loop(action)
    for i = self.units_:getLength(), 1, -1 do
        action(self, i)
    end
end

function mt:In(unit)
    return self.units_:Exist(unit)
end

function mt:getNum()
    return self.units_:getLength()
end

function mt:IsEmpty()
    return self.units_:IsEmpty()
end

-- assert
local H2I = require 'jass_tool'.H2I

function mt:Ignore(unit)
    self._ignore_label_[H2I(unit) .. ""] = true
end 

function mt:EnumUnitsInRange(x, y, r, cnd_name)
    local enum_range_units = cj.CreateGroup()

    -- 選取比原先範圍大一些的區域，好讓有些處在範圍邊緣的單位能夠被正確選取
    cj.GroupEnumUnitsInRange(enum_range_units, x, y, r + 10, nil)

    local enum_unit = cj.FirstOfGroup(enum_range_units)
    while H2I(enum_unit) ~= 0 do
        if mt[cnd_name](enum_unit, self.filter_) and 
        (not self._ignore_label_[H2I(enum_unit) .. ""]) then
            self:AddUnit(enum_unit)
        end

        cj.GroupRemoveUnit(enum_range_units, enum_unit)
        
        enum_unit = cj.FirstOfGroup(enum_range_units)
    end

    cj.DestroyGroup(enum_range_units)
end

function mt:AddUnit(unit)
    cj.GroupAddUnit(self.object_, unit)
    self.units_:PushBack(unit)
end

function mt:RemoveUnit(unit)
    cj.GroupRemoveUnit(self.object_, unit)
    self.units_:Delete(unit)
end

return Group