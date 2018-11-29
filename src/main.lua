-- 此module會初始化所有package，並替地圖單位註冊遊戲事件

-- 在這邊require可以讓後面的module都直接調用
-- assert
require 'id'
require 'order_id'

local function _Main()
    local js = require 'jass_tool'
    -- print('Welcome to Orlando') -- 測試lua check訊息
    -- js.Debug("Welcome to Orlando") -- 測試遊戲訊息

    -- require 'Type.init'
    -- require 'Tool.init'
    -- require 'Item.init'
    require 'test.core'("timer")
    
    -- -- 替所有單位註冊事件，因此一定要放在最後
    -- Map.Init() 
end

_Main()
    