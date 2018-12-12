-- 異常處理，同python的try-exception功能
-- 用法為傳參一個table，第一個元素為try函數，第二個元素為catch函數(可選)

-- assert
local Trackback

-- 參考Bushimichi's blog
local function try_catch(what)
    -- 判斷try函數有無異常
    assert(what[1])

    -- 正常是ok有值，異常是error有值
    local xpcall = xpcall
    local status, error_info = xpcall(what[1], Trackback)

    -- catch函數存在才會執行
    if (status == false) and what[2] then
        what[2](error_info)
    end

    return status and error_info or nil
end

-- 參考CSDN的「使用lua实现try-catch异常捕获」
Trackback = function(errors)
    local getinfo, format = debug.getinfo, string.format

    -- make results
    -- Level=2：指出哪個調用error函數的函數
    -- Level=1[默認]：為調用error位置(文件+行號)
    -- Level=0:不添加錯誤位置訊息
    local level = 2    
    while true do    

        -- get debug info
        local info = getinfo(level, "Sln")

        -- end?
        if not info or (info.name and info.name == "xpcall") then
            break
        end

        -- function?
        if info.what == "C" then
            results = results .. format("    [C]: in function '%s'\n", info.name)
        elseif info.name then 
            results = results .. format("    [%s:%d]: in function '%s'\n", info.short_src, info.currentline, info.name)    
        elseif info.what == "main" then
            results = results .. format("    [%s:%d]: in main chunk\n", info.short_src, info.currentline)    
            break
        else
            results = results .. format("    [%s:%d]:\n", info.short_src, info.currentline)    
        end

        -- next
        level = level + 1    
    end    

    -- ok?
    return results
end

return try_catch