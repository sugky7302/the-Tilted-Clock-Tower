local BuffLibrary = {}

local function Insert(buffName, duration, effectName, coverMode)
    newObject = {
        duration = duration,
        effectName = effectName,
        coverMode = coverMode -- 1 = 獨佔模式(重置時間) 2 = 獨佔模式(提高層數) 3 = 獨佔模式(新效果失去作用) 4 = 共存模式(各獨立作用)
    }
    BuffLibrary[buffName] = newObject
end

return BuffLibrary