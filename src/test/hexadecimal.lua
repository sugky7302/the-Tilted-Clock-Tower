local Hex = require 'Hexadecimal'

function HexTest()
    print(Hex.I2S(240))
    print(Hex.S2I("fa"))
end

return HexTest