function EventTest()
    local Event = require 'event'

    local tb = {}
    local trigger = Event(tb, "測試")(function()
        print "1"
        return 2
    end)

    print(Event.Dispatch(tb, "測試"))
end

return EventTest