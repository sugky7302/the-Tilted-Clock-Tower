-- 此module會初始化所有package，並替地圖單位註冊遊戲事件

local cj = require 'jass.common'
local js = require 'jass_tool'

-- 在這邊require可以讓後面的module都直接調用
require 'id'
require 'order_id'

local function _Main()
    print('Welcome to Orlando') -- 測試lua check訊息
    js.Debug("Welcome to Orlando") -- 測試遊戲訊息

    -- require 'Type.init'
    -- require 'Tool.init'
    -- require 'Item.init'
    require 'test.core'()
    
    -- -- 替所有單位註冊事件，因此一定要放在最後
    -- Map.Init() 
end

_Main()
    