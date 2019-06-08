-- 加載英雄數據

local hero_list = {
	"冰霜秘術師",
}

-- assert
local select, xpcall, ErrorHandle = select, xpcall, Base.ErrorHandle
local table_concat = table.concat
local RegisterDatas

local function LoadHeros()
    local ipairs = ipairs
    for _, name in ipairs(hero_list) do
        local hero_data = select(2, xpcall(require, ErrorHandle ,table_concat({"heros.", name, ".init"})))
        
        -- 初始化技能、天賦
        RegisterDatas(name, hero_data.skill_names, "skills")
        RegisterDatas(name, hero_data.talent_names, "talents")

        -- 初始化英雄模板
        require 'unit.hero'.Create(name)(hero_data)

        -- 初始化專長
        if hero_data.specialty_name then
            require(table_concat({"heros.", name, ".skills.", hero_data.specialty_name}))
        end
	end
end

RegisterDatas = function(name, datas, folder_name)
    for i = 1, #datas do
        select(2, xpcall(require, ErrorHandle ,table_concat({"heros.", name, ".", folder_name, ".", datas[i]})))
    end
end

LoadHeros()
