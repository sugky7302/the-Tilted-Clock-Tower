-- 專門處理寵物、隨從、召喚物，為單位的subclass
-- 依賴
--   unit.core
--   jass_tool
--   jass.common


-- package
local require = require 
local Unit = require 'unit.core'


local Pet = require 'class'("Pet", Unit)

-- assert
local SetPetLifePeriod

function Pet:_new(pet, owner)
    local H2I = require 'jass_tool'.H2I

    if H2I(pet) == 0 then
        return false
    end

    Unit._new(self, pet)

    -- 設定擁有者
    if owner then
        self.owner_ = owner
        self.owner_.pet_ = self
    end
        
    -- 寵物都不需要復活
    self.revive_point_:Remove()
    self.revive_point_ = nil
end

function Pet:_delete()
    self.owner_.pet_ = nil
    Unit._delete(self)
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