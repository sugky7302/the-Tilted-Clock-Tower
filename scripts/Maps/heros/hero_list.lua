local Map = require 'map'

Map.heroList = {
	{'冰霜秘術師','冰霜秘術師'}
}

--加載英雄數據
function Map.LoadHeros()
    for _, heroData in ipairs(Map.heroList) do
		local name, file = heroData[1], heroData[2]
		Map.heroList[name] = heroData
		local heroData = select(2, xpcall(require, Base.ErrorHandle ,('Maps.heros.%s.init'):format(file)))
		Map.heroList[name].data = heroData
	end
	--英雄總數
	Map.heroCount = #Map.heroList
end

Map.LoadHeros()
