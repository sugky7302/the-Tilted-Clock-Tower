function PrefixTest()
    local Item = require 'item.core'
    local Point = require 'point'

    local test_item = Item.Create('rde4', Point(15009, 9869))

    local Equipment = require 'item.equipment'
    local equip = Equipment(test_item)
    equip.attribute_count_limit_ = equip.attribute_count_limit_ + 2
    equip.attribute_[#equip.attribute_ + 1] = {"精通", 2, "", false}
    equip.attribute_[#equip.attribute_ + 1] = {"精神", 3, "", false}
    equip.attribute_count_ = equip.attribute_count_ + 2
    
    local Prefix = require 'item.prefix'
    Prefix(equip)
    print(equip.prefix_)
end

return PrefixTest