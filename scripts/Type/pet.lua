local setmetatable = setmetatable
local js = require 'jass_tool'
local cj = require 'jass.common'
local Unit = require 'unit'

local Pet = {}
setmetatable(Pet, Pet)
Pet.__index = Unit

-- constants
Pet.type = "Pet"

-- variables
local _SetPetLifePeriod

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
    return obj
end

_SetPetLifePeriod = function(pet, dur)
    if type(dur) == 'number' then
        cj.UnitApplyTimedLife(pet, Base.String2Id('BHwe'), dur)
    end
end

return Pet