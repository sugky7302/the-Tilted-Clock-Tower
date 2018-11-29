-- 此module用於加載英雄數據

-- assert 
local select, xpcall, ipairs = select, xpcall, ipairs
local ErrorHandle = Base.ErrorHandle
local format = string.format
local _RegisterDatas

local hero_list = {
	"冰霜秘術師",
}

local function _LoadHeros()
    for _, name in ipairs(hero_list) do
        local hero_data = select(2, xpcall(require, ErrorHandle ,format('heros.%s.init', name)))
        
        _RegisterDatas(name, hero_data.skill_datas, "skills")
        _RegisterDatas(name, hero_data.talent_datas, "talents")
	end
end

_RegisterDatas = function(name, datas, folder_name)
    for i, #datas do
        select(2, xpcall(require, ErrorHandle ,format('heros.%s.' .. folder_name .. '.%s', name, datas[i])))
    end
end

_LoadHeros()
