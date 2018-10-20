local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'

local Item, mt = {}, {}
setmetatable(Item, Item)
Item.__index = mt

function Item:__call(item)
    local obj = self[js.H2I(item) .. ""]
    if not obj then
        obj = {}
        obj.name = cj.GetItemName(item)
        obj.id = Base.Id2String(cj.GetItemTypeId(item))
        obj.owner = nil
        obj.ownPlayer = cj.GetOwningPlayer(obj.owner) or nil
        obj.level = cj.GetWidgetLife(item)
        obj.object = item
        self[js.H2I(item) .. ""] = obj
        setmetatable(obj, self)
        obj.__index = obj
    end
    return obj
end

function Item:Remove()
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

return Item