<?
    import 'main.lua' [==[
        local cj = require 'jass.common'
        local js = require 'jass_tool'
        local gbs = require 'general_bonus_system'
        local Color = require 'color'

        require 'id'
        local function main()
            print('歡迎進入 奧蘭多') -- 測試lua check訊息
            js.Debug("1") -- 測試遊戲訊息
            gbs.Init()
            Color:Init()
        end

        main()
    ]==]
?>