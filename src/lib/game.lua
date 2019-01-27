-- 儲存全局事件

-- package
local Event = require 'event'

local Game = {type = "Game"}
setmetatable(Game, Game)

-- 格式為Game:Event(event_name)(callback)
-- callback第一個參數是trigger的實例，後面的參數才是自己加的
function Game:Event(event_name)
    return Event(self, event_name)
end

function Game:EventDispatch(event_name, ...)
    return Event.Dispatch(self, event_name, ...)
end

-- NOTE: 預留不用
function Game:EventNotify(event_name, ...)
    return Event.Notify(self, event_name, ...)
end

return Game