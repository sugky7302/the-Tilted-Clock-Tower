-- 此module擴展we的player的功能

local setmetatable = setmetatable
local cj = require 'jass.common'

local Player, mt = {}, {}
setmetatable(Player, Player)
Player.__index = mt

-- assert
mt.type = "Player"

local set, get = {}, {}

function Player.Init()
    -- 設定點擊事件
    local War3 = require 'api'

    local click_trg = War3.CreateTrigger(function()
        Player(cj.GetTriggerPlayer()):EventDispatch("玩家-對話框被點擊", cj.GetClickedButton())
        return true
    end)

    -- 設定玩家
    for i = 0, 15 do 
        if cj.GetPlayerController(cj.Player(i)) == cj.MAP_CONTROL_USER then
            cj.TriggerRegisterDialogEvent(click_trg, Player(cj.Player(i)).dialog_.object_)
        end
    end
    
end

function Player:__call(player)
    local instance = self[cj.GetPlayerId(player) + 1]
    if not instance then
        instance = {
            name_ = cj.GetPlayerName(player),
            index_ = cj.GetPlayerId(player),
            object_ = player,
            dialog_ = nil,
            multiboard_ = nil,
            leaderboard_ = nil,
        }

        local Dialog = require 'dialog'
        instance.dialog_ = Dialog(instance)

        local Multiboard = require 'multiboard'
        instance.multiboard_ = Multiboard(instance)

        local Leaderboard = require 'leaderboard'
        instance.leaderboard_ = Leaderboard(instance)

        self[cj.GetPlayerId(player) + 1] = instance

        setmetatable(instance, self)
    end

    return instance
end

-- assert
local Event = require 'event'

function mt:Event(event_name)
    return Event(self, event_name)
end

function mt:EventDispatch(event_name, ...)
	local res = Event.Dispatch(Player, event_name, self, ...)
	if res ~= nil then
		return res
    end

    -- 如果Player搜尋不到就搜尋全局事件
    local Game = require 'game'
	local res = Event.Dispatch(Game, event_name, self, ...)
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
    cj.SetPlayerState(self.object_, cj.PLAYER_STATE_RESOURCE_GOLD, val)
end

get['黃金'] = function(self)
    return cj.GetPlayerState(self.object_, cj.PLAYER_STATE_RESOURCE_GOLD)
end

set['天賦點'] = function(self, val)
    cj.SetPlayerState(self.object_, cj.PLAYER_STATE_RESOURCE_LUMBER, val)
end

get['天賦點'] = function(self)
    return cj.GetPlayerState(self.object_, cj.PLAYER_STATE_RESOURCE_LUMBER)
end

return Player