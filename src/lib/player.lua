-- 擴展we的player的功能

-- package
local require = require 
local cj = require 'jass.common'

local Player = require 'class'("Player")
Player._VERSION = "1.0.0"

-- assert
local set, get = {}, {}

function Player.Init()
    -- 設定點擊事件
    local War3 = require 'api'

    local click_trg = War3.CreateTrigger(function()
        local player = Player:getInstance(cj.GetPlayerId(cj.GetTriggerPlayer()))
        player:EventDispatch("玩家-對話框被點擊", cj.GetClickedButton())

        return true
    end)

    -- 設定玩家
    for i = 0, 15 do 
        if cj.GetPlayerController(cj.Player(i)) == cj.MAP_CONTROL_USER then
            cj.TriggerRegisterDialogEvent(click_trg, Player:getInstance(i).dialog_.object_)
        end
    end
    
end

function Player:_new(player)
    self.object_ = player
    self.name_ = cj.GetPlayerName(player)
    self.index_ = cj.GetPlayerId(player)

    local Dialog = require 'dialog'
    self.dialog_ = Dialog(self)

    local Multiboard = require 'multiboard'
    self.multiboard_ = Multiboard(self)

    local Leaderboard = require 'leaderboard'
    self.leaderboard_ = Leaderboard(self)

    Player:setInstance(self.index_, this)
end

-- assert
local Event = require 'event'

function Player:Event(event_name)
    return Event(self, event_name)
end

function Player:EventDispatch(event_name, ...)
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

function Player:add(name, val)
    if not set[name] then
        return false
    end

    set[name](self, get[name](self) + val)
end

function Player:get(name)
    if not get[name] then
        return false
    end

    return get[name](self)
end

function Player:set(name, val)
    if not set[name] then
        return false
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