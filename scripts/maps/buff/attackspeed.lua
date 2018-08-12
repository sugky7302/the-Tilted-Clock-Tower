local buff = require 'buff'
buff['減速'] = {}
local mt = buff['減速']
local setmetatable = setmetatable
setmetatable(mt,buff)

mt.id = 'A00S'
mt.pulse = 1
mt.cover_global = 1
mt.stack_max = 1
--[[
  同名狀態
  0:必須名字和來源都相同才視為同名狀態，觸發覆蓋，這是默認值。
  1:只要名字相同就會視為同名狀態，觸發覆蓋。
--]]
mt.cover_max =  0 -- 當單位身上有多個同名狀態時，最多可以同時生效的狀態數量。這個值默認為0，表示無限制。只有當cover_type為共存模式時才有意義。
mt.cover_type = 1
--[[
  共存模式
  0:獨佔模式，單位只能同時保留一個同名狀態。on_cover可以決定哪個狀態保留下來。
  1:共存模式，單位可以同時保留多個同名狀態。on_cover可以決定這些狀態的排序，以便通過cover_max來只讓部分狀態生效。
--]]
mt.keep = false
--[[
  死亡後保留:決定了單位死亡後，狀態是否繼續保留；以及單位死亡時是否能添加該狀態。
  true:單位死亡時保留狀態，狀態也可以添加給死亡的單位。
  false:單位死亡時移除狀態，狀態無法添加給死亡的單位。
--]]