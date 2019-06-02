function ArcTextTest()
    require 'timer.init'.Init()
    local ArcTexttag = require 'texttag.arc'
    local Point = require 'point'

    local texttag = ArcTexttag("測試", Point(15009, 9869))
end

return ArcTextTest