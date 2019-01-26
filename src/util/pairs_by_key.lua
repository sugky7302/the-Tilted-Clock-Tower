-- 解決pairs無序的問題
-- O(#tb)的方法
local function pairsByKey(tb)
    local pairs = pairs
    local tb_key, size = {}, 0
    for n in pairs(tb) do 
        size = size + 1
        tb_key[size] = n 
    end
    
    local Comparator = require 'comparator'.Default
    table.sort(tb_key, Comparator)
    
    local i = 0
    return function()
        i = i + 1
        return tb_key[i], tb[tb_key[i]]
    end
end

return pairsByKey
    