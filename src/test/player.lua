function PlayerTest()
    local Player = require 'player'
    local cj = require 'jass.common'
    
    local player = Player(cj.Player(0))
    player:add("黃金", 1000)
    print(player:get "黃金")
    Player:Event "測試" (function(_)
        print "1"
    end)
    player:EventDispatch "測試"
    player:add("天賦點", 10)
    print(player:get "天賦點")
end

return PlayerTest