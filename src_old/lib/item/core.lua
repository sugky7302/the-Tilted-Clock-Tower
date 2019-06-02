-- 此module擴展we的item的功能
-- 依賴
--   jass.common
--   Timer.core
--   jass_tool


-- package
local require = require
local cj = require 'jass.common'


local Item = require 'class'("Item")

-- assert
local set, get = {}, {}
local RecreateItem

function Item.Init()
    local Timer = require 'timer.core'

    -- 清理地面上的物品
    Timer(300, true, function(_)
        cj.EnumItemsInRect(cj.GetPlayableMapRect(), nil, function()
            Item(cj.GetEnumItem()):Remove()
        end)
    end)
end

function Item:_new(item)
    local H2I = require 'jass_tool'.H2I

    self.name_       = cj.GetItemName(item)
    self.id_         = Base.Id2String(cj.GetIteItemypeId(item))
    self.handle_     = H2I(item)
    self.owner_      = nil
    self.own_player_ = nil
    self.level_      = math.modf(cj.GetWidgetLife(item))
    self.object_     = item

    -- 記錄使用完會不會消失
    if Item.IsSecrets(item) or Item.IsRecipe(item) then
        self.perishable_ = true
    else
        self.perishable_ = false
    end

    Item:setInstance(table.concat({H2I(unit), ""}), self)
end

function Item:_delete()
    -- 要真正刪除物品，必須先設定生命值再刪除才行
    Item.Delete(self.object_)

    for _, var in pairs(self) do 
        var = nil
    end

    self = nil
end

function Item.IsEquipment(item)
    return cj.GetItemLevel(item) == 5
end

function Item.IsSecrets(item)
    return cj.GetItemLevel(item) == 1
end

function Item.IsMaterial(item)
    return cj.GetItemLevel(item) == 2
end

function Item.IsRecipe(item)
    return cj.GetItemLevel(item) == 6
end

function Item:add(name, val)
    if not set[name] then
        return false
    end

    set[name](self, get[name](self) + val)
end

function Item:set(name, val)
    if not set[name] then
        return false
    end

    set[name](self, val)
end

function Item:get(name)
    if not get[name] then
        return false
    end

    return get[name](self)
end

get['數量'] = function(self)
    return cj.GetItemCharges(self.object_)
end

set['數量'] = function(self, val)
    local max = math.max
    val  = max(val, 0) -- <0 跟 =0 是一樣是刪除的意思

    if val == 0 then
        return false
    end

    local charges = cj.GetItemCharges(self.object_)
    if charges > 0 then
        cj.SetItemCharges(self.object_, val)
    elseif charges == 0 and self.perishable_ then
        -- 使用後消失的物品只是模型縮小，實際上還在，特別是書或神符這種使用後看上去直接消失的物品
        RecreateItem(self, val)
    end
end

RecreateItem = function(self, val)
    -- 把模型真正刪除
    Item.Delete(self.object_)

    local Point = require 'point'
    local p = Point.GetUnitLoc(self.owner_.object_)
    self.object_ = Item.Create(self.id_, p)
    cj.SetItemCharges(self.object_, val)

    -- 檢查單位還在不在，在的話重新創建物品給他
    if self.owner_.object_ then
        cj.UnitAddItem(self.owner_.object_, self.object_)
    end

    p:Remove()
end

function Item.Delete(item)
    cj.SetWidgetLife(item, 1)
    cj.RemoveItem(item)
end

function Item.Create(id, loc)
    local item = cj.CreateItem(Base.String2Id(id), loc.x_, loc.y_)
    return item
end

return Item