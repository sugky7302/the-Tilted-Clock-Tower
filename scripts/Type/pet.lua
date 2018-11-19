local setmetatable = setmetatable
local js = require 'jass_tool'
local cj = require 'jass.common'
local Unit = require 'unit'
local Game = require 'game'

local Pet = {}
setmetatable(Pet, Pet)
Pet.__index = Unit

-- constants
Pet.type = "Pet"

-- variables
local _SetPetLifePeriod

Unit:Event "寵物-清除" (function(trigger, pet)
    pet.owner.pet = nil
    pet:Remove()
end)

function Pet:__call(pet)
    return self[js.H2I(pet) .. ""]
end

function Pet:New(id, owner, loc, dur)
    local pet = Unit.Create(owner.owner.object, id, loc, cj.GetUnitFacing(owner.object))
    cj.SetUnitAnimation(pet, "birth") -- 播放出生動畫
    local obj = Unit(pet)
    _SetPetLifePeriod(pet, dur)
    obj.object = pet
    obj.owner = owner
    obj.revivePoint:Remove()
    obj.revivePoint = nil
    setmetatable(obj, obj)
    obj.__index = self
    self[js.H2I(pet) .. ""] = obj
    Game:EventDispatch("單位-創建", pet)
    return obj
end

_SetPetLifePeriod = function(pet, dur)
    if type(dur) == 'number' then
        cj.UnitApplyTimedLife(pet, Base.String2Id('BHwe'), dur)
    end
end

function Pet:Remove()
    Unit[js.H2I(self.object) .. ""] = nil -- 清除實例
    Pet[js.H2I(self.object) .. ""] = nil -- 清除實例
    self = nil
end 

return Pet