local function Print(equip)
    print(equip.prefix_ .. equip.name_)
    for _, tb in ipairs(equip.attribute_) do
        print(tb[3])
    end
    print(" ")
end

function EnchantedTest()
    local Item = require 'item.core'
    local Point = require 'point'
    local p = Point(15009, 9869)
    local test_item = Item.Create('rde4', p)
    
    local Equipment = require 'item.equipment'
    local equip = Equipment(test_item)
    equip.attribute_count_limit_ = equip.attribute_count_limit_ + 1
    Print(equip)

    local test_secrets = Item.Create('sbch', p)
    local Secrets = require 'item.secrets'
    local secret = Secrets(test_secrets)

    local Enchanted = require 'item.enchanted'
    Enchanted.Insert(equip, secret, false)
    Print(equip)
end

return EnchantedTest