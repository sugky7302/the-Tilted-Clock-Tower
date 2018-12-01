function GameTest()
    local Game = require 'game'
    Game:Event "測試" (function()
        print "1"
        return 2
    end)

    print(Game:EventDispatch "測試")
end

return GameTest