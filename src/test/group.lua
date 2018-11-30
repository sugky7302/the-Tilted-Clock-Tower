local Group = require 'group.core'

function GroupTest()
    local group = Group()
    group:EnumUnitsInRange(15009, 9869, 500, "Nil")
    print(group:getNum())
    
    if group:IsEmpty() then
        print "1"
    else
        print "0"
    end

    local H2I = require 'jass_tool'.H2I
    group:Loop(function(self, i)
        print(H2I(self.units_[i]))
        if self:In(self.units_[i]) then
            print "2"
        end

        self:Ignore(self.units_[i])
        self:RemoveUnit(self.units_[i])
    end)

    print(group:getNum())
    group:Remove()
end

return GroupTest