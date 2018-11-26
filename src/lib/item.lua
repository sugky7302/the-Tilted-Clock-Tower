local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Timer = require 'timer'
local Point = require 'point'

local Item, mt = {}, {}
setmetatable(Item, Item)
Item.__index = mt

-- varaibles
local set, add, get = {}, {}, {}
local _AddItem

function Item.Init()
    Timer(300, true, function(callback)
        cj.EnumItemsInRect(cj.GetPlayableMapRect(), null, function()
            Item(cj.GetEnumItem()):Remove()
        end)
    end)
end

function Item:__call(item)
    local obj = self[js.H2I(item) .. ""]
    if not obj then
        local slk = require 'jass.slk'
        obj = {}
        obj.name = cj.GetItemName(item)
        obj.id = Base.Id2String(cj.GetItemTypeId(item))
        obj.owner = nil
        obj.ownPlayer = nil
        obj.level = math.modf(cj.GetWidgetLife(item))
        obj.object = item
        obj.perishable = (slk.item[obj.id].perishable > 0) and true or false
        self[js.H2I(item) .. ""] = obj
        setmetatable(obj, self)
        obj.__index = obj
    end
    return obj
end

function Item:Remove()
    cj.SetWidgetLife(self.object, 1)
    cj.RemoveItem(self.object)
    self = nil
end

function mt.IsEquipment(item)
    return cj.GetItemLevel(item) == 5
end

function mt.IsSecrets(item)
    return cj.GetItemLevel(item) == 1
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
    return cj.GetItemCharges(self.object)
end

set['數量'] = function(self, val)
    val  = math.max(val, 0)
    local charges = cj.GetItemCharges(self.object)
    if val > 0 then
        if charges > 0 then
            cj.SetItemCharges(self.object, val)
        elseif charges == 0 and self.perishable then
            _AddItem(self, val)
        end
    end
end

_AddItem = function(self, val)
    cj.SetWidgetLife(self.object, 1)
    cj.RemoveItem(self.object)
    local p = Point:GetUnitLoc(self.owner.object)
    self.object = mt.Create(self.id, p)
    cj.SetItemCharges(self.object, val)
    if self.owner.object then
        cj.UnitAddItem(self.owner.object, self.object)
    end
    p:Remove()
end

function mt.Create(id, loc)
    return cj.CreateItem(Base.String2Id(id), loc.x, loc.y)
end

return Item