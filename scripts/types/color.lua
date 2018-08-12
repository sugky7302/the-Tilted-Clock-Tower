local setmetatable = setmetatable
local math = math
local color = {}
setmetatable(color,color)
local m = {'a', 'b', 'c', 'd', 'e', 'f'}

function color:hex(v) return (math.modf(v/16) > 9) and m[math.modf(v/16)-9] or v/16 .. (v%16 > 9) and m[v%16-9] or v%16 end
function color:str(v)
  if v == 'red' then return '|cffff0000'
  elseif v == "orange" then return "|cffff8c00"
  elseif v == "yellow" then return "|cffffff00"
  elseif v == "green" then return "|cff00ff00"
  elseif v == "blue" then return "|cff0000ff"
  elseif v == "indigo" then return "|cff333399"
  elseif v == "purple" then return "|cff8000ff"
  elseif v == "black" then return "|cff000000"
  elseif v == "white" then return "|cffffffff"
  elseif v == "golden" then return "|cffffcc00"
  elseif v == "lightblue" then return "|cff99ccff"
  elseif v == "mediumblue" then return "|cff3366ff"
  elseif v == "mediumpurple" then return "|cff8080c0"
  elseif v == "mediumorange" then return "|cffffcc99"
  elseif v == "lightpurple" then return "|cffcc99ff"
  elseif v == "superpurple" then return "|cff9393ff"
  elseif v == "brown" then return "|cff804000"
  elseif v == "skin" then return "|cffffd8ae" end
end

function color:__call(...)
  local r, g, b = ...
  if type(r) == 'string' then return self:str(r)
  else return '|cff' .. self:hex(r) .. self:hex(g) .. self:hex(b) end
end

return color