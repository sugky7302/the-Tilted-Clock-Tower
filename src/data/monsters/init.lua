-- 加載怪物數據

local monster_list = {
    "物品測試員",
    "豺狼守望者",
}

local general_node_list = {
    "wait",
    "period",
}

local function Load()
    local ipairs = ipairs
    local select, xpcall, ErrorHandle = select, xpcall, Base.ErrorHandle
    local table_concat = table.concat
    
    for _, name in ipairs(monster_list) do
        select(2, xpcall(require, ErrorHandle ,table_concat({"monsters.", name, ".skill"})))
    end
    
    for _, name in ipairs(general_node_list) do
        select(2, xpcall(require, ErrorHandle ,table_concat({"monsters.general_node.", name})))
	end
end

Load()
