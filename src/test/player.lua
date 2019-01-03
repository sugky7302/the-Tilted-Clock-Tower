function PlayerTest()
    local Player = require 'player'
    local cj = require 'jass.common'
    
    local player = Player(cj.Player(0))
    player:add("黃金", 1000)
    print("黃金" .. player:get "黃金")
    Player:Event "測試" (function(_)
        print "test"
    end)
    player:EventDispatch "測試"
    player:add("天賦點", 10)
    print("天賦點" .. player:get "天賦點")
end

return PlayerTest