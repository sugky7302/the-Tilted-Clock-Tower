function TexttagTest()
    local Texttag = require 'texttag.core'
    local Point = require 'point'

    local texttag = Texttag("測試", Point(15009, 9869), 1, true)
    local texttag1 = Texttag("測試", Point(15029, 9849), 5, false)
end

return TexttagTest