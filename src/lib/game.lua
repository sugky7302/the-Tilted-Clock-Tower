-- 此module專門儲存全局事件

local setmetatable = setmetatable
local Event = require 'event'

local Game = {}
setmetatable(Game, Game)

-- constatns
Game.type = "Game"

-- 格式為Game:Event(event_name)(callback)
-- callback第一個參數是trigger的實例，後面的參數才是自己加的
function Game:Event(event_name)
    return Event(self, event_name)
end

function Game:EventDispatch(event_name, ...)
    return Event.Dispatch(self, event_name, ...)
end

-- TODO: 預留不用
function Game:EventNotify(event_name, ...)
    return Event.Notify(self, event_name, ...)
end

return Game