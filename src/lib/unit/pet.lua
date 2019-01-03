-- 此module專門處理寵物、隨從、召喚物，為單位的子集

local setmetatable = setmetatable

local Pet, Unit = {}, require 'unit.core'
setmetatable(Pet, Pet)
Pet.__index = Unit

-- constants
Pet.type = "Pet"

-- assert
local SetPetLifePeriod

function Pet:__call(pet, owner)
    local H2I = require 'jass_tool'.H2I

    if H2I(pet) == 0 then
        return false
    end

    local instance = Unit[H2I(pet) .. ""]
    if not instance then
        instance = Unit(pet)

        -- 設定擁有者
        if owner then
            instance.owner_ = owner
            instance.owner_.pet_ = instance
        end
        
        -- 寵物都不需要復活
        instance.revive_point_:Remove()
        instance.revive_point_ = nil

        setmetatable(instance, instance)
        instance.__index = self
    
        Unit[H2I(pet) .. ""] = instance
    end

    return instance
end

-- package
local cj = require 'jass.common'

-- dur不填 = 無限
function Pet.Create(id, owner, loc, dur)
    local pet = Unit.Create(cj.GetOwningPlayer(owner.object_), id, loc, cj.GetUnitFacing(owner.object_))
    
    local obj = Pet(pet, owner)
    SetPetLifePeriod(pet, dur)

    -- 播放出生動畫
    cj.SetUnitAnimation(pet, "birth")
    
    return obj
end

SetPetLifePeriod = function(pet, dur)
    if type(dur) == 'number' then
        cj.UnitApplyTimedLife(pet, Base.String2Id('BHwe'), dur)
    end
end

return Pet