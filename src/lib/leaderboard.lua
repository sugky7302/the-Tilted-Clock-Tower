-- 擴展we的排行榜功能
-- 依賴
--   jass.common


-- package
local require = require
local cj = require 'jass.common'

local Lb = require 'class'("Leaderboard")
Lb._VERSION = "1.0.0"

function Lb:_new(player)
    self._count_ = 0
        
    self.object_ = cj.CreateLeaderboard()
    self.owner_ = player

    cj.PlayerSetLeaderboard(player.object_, self.object_)
    self:Show(false)
end

function Lb:_delete()
    self:Clear()
    cj.DestroyLeaderboard(self.object_)
end


function Lb:Clear()
    cj.LeaderboardClear(self.object_)
end

function Lb:add(player, name, point)
    if cj.LeaderboardHasPlayerItem(player.object_) then
        self:Delete(player)
    end
    
    cj.LeaderboardAddItem(self.object_, name, point or 0, player.object_)
    self._count_ = self._count_ + 1
end

function Lb:Delete(player)
    cj.LeaderboardRemovePlayerItem(self.object_, player.object_)
end

function Lb:SetPlayerValue(player, point)
    cj.LeaderboardSetItemValue(self.object_, cj.LeaderboardGetPlayerIndex(self.object_, player.object_), point)
end

function Lb:SetPlayerName(player, name)
    cj.LeaderboardSetItemLabel(self.object_, cj.LeaderboardGetPlayerIndex(self.object_, player.object_), name)
end

function Lb:Show(is_show)
    cj.LeaderboardDisplay(self.object_, is_show)
end


function Lb:SetTitle(str)
    cj.LeaderboardSetLabel(self.object_, str)
end

function Lb:SetStyle(is_view_title, is_view_text, is_view_point, is_view_icon)
    cj.LeaderboardSetStyle(self.object_, is_view_title, is_view_text, is_view_point, is_view_icon)
end

return Lb