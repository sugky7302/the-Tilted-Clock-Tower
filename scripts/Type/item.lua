local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Game = require 'game'
local MathLib = require 'math_lib'
local Point = require 'point'

local Item, mt = {}, {}
setmetatable(Item, Item)
Item.__index = mt

-- varaibles
local set, add, get = {}, {}, {}

function Item.Init()
    Game:Event "單位-掉落物品" (function(self, unit)
        if not unit.dropList then
            return
        end
        local p = Point:GetUnitLoc(unit.object)
        for _, data in ipairs(unit.dropList) do 
            if MathLib.Random(100) < data[2] then
                Item.Create(data[1], p)
            end
        end
        p:Remove()
    end)
end

function Item:__call(item)
    local obj = self[js.H2I(item) .. ""]
    if not obj then
        obj = {}
        obj.name = cj.GetItemName(item)
        obj.id = Base.Id2String(cj.GetItemTypeId(item))
        obj.owner = nil
        obj.ownPlayer = nil
        obj.level = math.modf(cj.GetWidgetLife(item))
        obj.object = item
        self[js.H2I(item) .. ""] = obj
        setmetatable(obj, self)
        obj.__index = obj
    end
    return obj
end

function Item:Remove()
    cj.RemoveItem(self.object)
    self = nil
end

function mt.Create(id, loc)
    return cj.CreateItem(Base.String2Id(id), loc.x, loc.y)
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

add['數量'] = function(self, val)
    cj.SetItemCharges(self.object, cj.GetItemCharges(self.object) + val)
end

get['數量'] = function(self)
    return cj.GetItemCharges(self.object)
end

set['數量'] = function(self, val)
    cj.SetItemCharges(self.object, val)
end

return Item