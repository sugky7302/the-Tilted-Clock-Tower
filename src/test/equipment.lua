function EquipmentTest()
    local Item = require 'item.core'
    local Point = require 'point'

    local test_item = Item.Create('rde4', Point(15009, 9869))

    local Equipment = require 'item.equipment'
    Equipment.Init()

    local equip = Equipment(test_item)

    equip:Update()

    equip:Rand(5, 3)

    print(equip:GetGearScore())
    print(equip.level_, "/",equip.layer_)

    if equip:IsAttributeFull() then
        print "1"
    else
        print "0"
    end

    if equip:IsRingFull() then
        print "3"
    else
        print "2"
    end
end

return EquipmentTest