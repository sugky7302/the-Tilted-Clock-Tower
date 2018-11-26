local setmetatable = setmetatable
local Event = require 'event'

local Game = {}
setmetatable(Game, Game)

-- constatns
Game.type = "Game"

function Game:Event(eventName)
    return Event(self, eventName)
end

function Game:EventDispatch(eventName, ...)
    return Event.Dispatch(self, eventName, ...)
end

-- TODO: 預留不用
function Game:EventNotify(eventName, ...)
    return Event.Notify(self, eventName, ...)
end

return Game