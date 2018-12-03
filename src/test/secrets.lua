function SecretsTest()
    local Item = require 'item.core'
    local Point = require 'point'

    local test_item = Item.Create('sbch', Point(15009, 9869))
    
    local Secrets = require 'item.secrets'
    local secrets = Secrets(test_item)
    print(secrets:get "數量")

    local item = Item(test_item)

    item:set("數量", 10)

    secrets = Secrets(test_item)
    print(secrets:get "數量")
end

return SecretsTest