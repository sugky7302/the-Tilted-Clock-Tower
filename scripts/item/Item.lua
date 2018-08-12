local cj = require 'jass.common'
local setmetatable = setmetatable

local mt = {}
local Item = {}
Item.__index = mt
setmetatable(Item, Item)

function Item:__call(item)
    local object = {}
    
    object.name = cj.GetItemName(item)
    object.owner = nil
    object.ownPlayer = cj.GetOwningPlayer(object.owner)
    object.prefix = nil 
    object.level = nil
    object.fixedAttributes = nil
    object.holes = nil
    object.holeCount = nil
    object.color = "|cffffffff"
    object.intensifyLevel = 0
    object.stability = nil
    object.intensify = nil
    object.fusion = nil
    object.uniqueness = nill
    
    setmetatable(object, self)
    object.__index = object
    return object
end

function mt:Remove()
end

function mt:Display()
end

function mt:Entry()

function mt:Named()
end

function mt:SetHoleCounts()
end


return Item
