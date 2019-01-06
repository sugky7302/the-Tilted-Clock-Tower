-- 擴展we的排行榜功能

local setmetatable = setmetatable

local mod, mt = {}, {type = "Leaderboard"}
setmetatable(mod, mod)
mod.__index = mt

-- package
local cj = require 'jass.common'

function mod:__call(player)
    local instance = {
        _count_ = 0,
        
        object_ = cj.CreateLeaderboard(),
        owner_ = player,
    }

    cj.PlayerSetLeaderboard(player.object_, instance.object_)

    setmetatable(instance, self)

    return instance
end

function mt:Remove()
    self:Clear()
    cj.DestroyLeaderboard(self.object_)

    self.object_ = nil
    self.owner_ = nil
    self = nil
end


function mt:Clear()
    cj.LeaderboardClear(self.object_)
end

function mt:add(player, name, point)
    if cj.LeaderboardHasPlayerItem(player.object_) then
        self:Delete(player)
    end
    
    cj.LeaderboardAddItem(self.object_, name, point or 0, player.object_)
    _count_ = _count_ + 1
end

function mt:Delete(player)
    cj.LeaderboardRemovePlayerItem(self.object_, player.object_)
end

function mt:SetPlayerValue(player, point)
    cj.LeaderboardSetItemValue(self.object_, cj.LeaderboardGetPlayerIndex(self.object_, player.object_), point)
end

function mt:SetPlayerName(player, name)
    cj.LeaderboardSetItemLabel(self.object_, cj.LeaderboardGetPlayerIndex(self.object_, player.object_), name)
end

function mt:Show(is_show)
    cj.LeaderboardDisplay(self.object_, is_show)
end


function mt:SetTitle(str)
    cj.LeaderboardSetLabel(self.object_, str)
end

function mt:SetStyle(is_view_title, is_view_text, is_view_point, is_view_icon)
    cj.LeaderboardSetStyle(self.object_, is_view_title, is_view_text, is_view_point, is_view_icon)
end

return mod