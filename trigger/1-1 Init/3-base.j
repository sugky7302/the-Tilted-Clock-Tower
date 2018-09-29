<?
    import 'base.lua' [==[
        local Runtime = require 'jass.runtime'
        local Console = require 'jass.console'
        local Debug = require 'jass.debug'
        local string  = string

        Base = {}

        -- 版本號
        Base.VERSION = '0.1.0'

        --打開控制台
        Console.enable = true

        --重載print，自動轉換編碼
        print = Console.write

        --將handle等級設為0(地圖中所有的handle均使用table封裝)
        Runtime.handle_level = 0

        --關閉等待
        Runtime.sleep = false

        function Base.error_handle(msg)
            print("---------------------------------------")
            print(tostring(msg) .. "\n")
            print(Debug.traceback())
            print("---------------------------------------")
        end

        --錯誤匯報
        function Runtime.error_handle(msg)
            Base.error_handle(msg)
        end

        -- 初始化本地腳本
        require 'main'
    ]==]
?>