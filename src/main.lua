-- 此module會初始化所有package，並替地圖單位註冊遊戲事件

-- 在這邊require可以讓後面的module都直接調用
-- package
local require = require
require 'id'
require 'order_id'

local function Main()
    -- -- 啟動中心計時器
    -- require 'timer.init'.Init()

    -- -- 註冊事件
    -- require 'unit.event'
    -- require 'item.event'
    -- require 'skill.event'

    -- -- 初始化數據
    -- require 'unit.attribute.init'
    -- require 'item.init'
    -- require 'player'.Init()
    -- require 'buff.attribute.init'
    -- require 'buffs.init'
    -- require 'quests.init'

    -- -- 初始化單位事件
    -- require 'buff.unit'
    -- require 'quest.unit'
    -- require 'item.unit'
    -- require 'talent'
    
    -- -- 替所有單位註冊事件，因此一定要放在最後
    -- require 'map'

    -- 呼叫測試碼
    require 'test.core'('knock')
end

Main()
    