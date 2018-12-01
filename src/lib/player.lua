local setmetatable = setmetatable
local cj = require 'jass.common'
local Dialog = require 'dialog'
local Event = require 'event'
local Game = require 'game'

local Player, mt = {}, {}
setmetatable(Player, Player)
Player.__index = mt

-- constants
mt.type = "Player"

-- vairables
local set, get = {}, {}

function Player.Init()
    -- 設定點擊事件
    local War3 = require 'api'

    local _clickTrg = War3.CreateTrigger(function()
        Player(cj.GetTriggerPlayer()):EventDispatch("玩家-對話框被點擊", cj.GetClickedButton())
        return true
    end) 
    -- 設定玩家
    for i = 0, 15 do 
        if cj.GetPlayerController(cj.Player(i)) == cj.MAP_CONTROL_USER then
            cj.TriggerRegisterDialogEvent(_clickTrg, Player(cj.Player(i)).dialog.object)
        end
    end
    
end

function Player:__call(player)
    local obj = self[cj.GetPlayerId(player) + 1]
    if not obj then
        obj = {}
        obj.name = cj.GetPlayerName(player)
        obj.index = cj.GetPlayerId(player)
        obj.object = player
        obj.dialog = Dialog(obj)
        self[cj.GetPlayerId(player) + 1] = obj
        setmetatable(obj, self)
        obj.__index = obj
    end
    return obj
end

function mt:Event(eventName)
    return Event(self, eventName)
end

function mt:EventDispatch(eventName, ...)
	local res = Event.Dispatch(Player, eventName, self, ...)
	if res ~= nil then
		return res
    end
	local res = Event.Dispatch(Game, eventName, self, ...)
	if res ~= nil then
		return res
	end
	return nil
end

function mt:add(name, val)
    if not set[name] then
        return 
    end
    set[name](self, get[name](self) + val)
end

function mt:get(name)
    if not get[name] then
        return
    end
    return get[name](self)
end

function mt:set(name, val)
    if not set[name] then
        return 
    end
    set[name](self, val)
end


set['黃金'] = function(self, val)
    cj.SetPlayerState(self.object, cj.PLAYER_STATE_RESOURCE_GOLD, val)
end

get['黃金'] = function(self)
    return cj.GetPlayerState(self.object, cj.PLAYER_STATE_RESOURCE_GOLD)
end

set['天賦點'] = function(self, val)
    cj.SetPlayerState(self.object, cj.PLAYER_STATE_RESOURCE_LUMBER, val)
end

get['天賦點'] = function(self)
    return cj.GetPlayerState(self.object, cj.PLAYER_STATE_RESOURCE_LUMBER)
end

return Player