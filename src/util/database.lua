-- 生成一個新的資料庫
-- append(col1, col2, ...): 插入新的資料
-- query(key): 查詢某筆資料

local setmetatable = setmetatable


local Database = {}
setmetatable(Database, Database)

local Associate, GetData

function Database:__call(column_count)
    local instance = {
        association = {}
    }

    for i = 1, column_count do
        instance[#instance + 1] = {}
    end

    setmetatable(instance, instance)
    instance.__index = self
    return instance
end

function Database:append(...)
    local args = {...}
    local index = #self[1] + 1
    local column

    -- 如果args超過欄位，則不填入
    -- 如果args不足，則設定false(用nil會造成'#'無法正確返回表長度)
    for i = 1, #self do
        column = self[i]
        column[index] = args[i] or false
    end

    Associate(self.association, args[1], index)
end

Associate = function(tb, arg, id)
    local key = table.concat{arg, ""}
    tb[key] = id
end

function Database:query(key)
    local type = type

    if type(key) == "number" then
        return GetData(self, key)
    end

    if type(key) == "string" then
        return GetData(self, self.association[key])
    end
end

GetData = function(self, key)
    local column
    local data = {key}

    for i = 1, #self do
        column = self[i]
        data[#data + 1] = column[key]
    end

    if #data < 2 then
        return nil
    end
    
    return data
end

return Database