local Map = require 'map'

--加載英雄數據
function Map.LoadTalents()
    for _, heroData in ipairs(Map.heroList) do
		local file = heroData[2]
        Base.AddPath(('Maps\\talents\\%s'):format(file))
        local heroData = select(2, xpcall(require, Base.ErrorHandle ,('Maps.talents.%s.init'):format(file)))
	end
end

Map.LoadTalents()
