local map = require 'map'
local runtime = require 'jass.runtime'
local string = string

map.hero_list = {
	{'珍娜','珍娜'}
}

--加載英雄數據
function map.load_heroes()
  for _, hero_data in ipairs(map.hero_list) do
		local name, file = hero_data[1], hero_data[2]
		map.hero_list[name] = hero_data
		local hero_data = select(2, xpcall(require, runtime.error_handle ,('maps.hero.%s.init'):format(file)))
		map.hero_list[name].data = hero_data
	end

	--英雄总数
	map.hero_count = #map.hero_list
end

map.load_heroes()
