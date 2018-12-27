-- 此module擴展we的item的功能

local setmetatable = setmetatable
local cj = require 'jass.common'

local Item, mt = {}, {}
setmetatable(Item, Item)
Item.__index = mt

-- assert
mt.type = "Item"

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

function Item:__call(item)
    local H2I = require 'jass_tool'.H2I

    local instance = self[H2I(item) .. ""]
    if not instance then
        local modf = math.modf
        local Id2S = Base.Id2String
    
        instance = {
            name_       = cj.GetItemName(item),
            id_         = Id2S(cj.GetItemTypeId(item)),
            handle_     = H2I(item),
            owner_      = nil,
            own_player_ = nil,
            level_      = modf(cj.GetWidgetLife(item)),
            object_     = item,
        }

        -- 記錄使用完會不會消失
        if self.IsSecrets(instance) or self.IsRecipe(instance) then
            instance.perishable_ = true
        else
            instance.perishable_ = false
        end

        self[H2I(item) .. ""] = instance

        setmetatable(instance, self)
        instance.__index = instance
    end

    return instance
end

function mt:Remove()
    -- 要真正刪除物品，必須先設定生命值再刪除才行
    Item.Delete(self.object_)

    local pairs = pairs
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

function mt:add(name, val)
    if not set[name] then
        return 
    end

    set[name](self, get[name](self) + val)
end

function mt:set(name, val)
    if not set[name] then
        return 
    end

    set[name](self, val)
end

function mt:get(name)
    if not get[name] then
        return
    end

    return get[name](self)
end

get['數量'] = function(self)
    return cj.GetItemCharges(self.object_)
end

set['數量'] = function(self, val)
    local max = math.max
    val  = max(val, 0) -- <0 跟 =0 是一樣是刪除的意思

    local charges = cj.GetItemCharges(self.object_)
    if val == 0 then
        return false
    end

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
    self.object_ = mt.Create(self.id_, p)
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
    local S2Id = Base.String2Id
    local item = cj.CreateItem(S2Id(id), loc.x_, loc.y_)
    return item
end

return Item