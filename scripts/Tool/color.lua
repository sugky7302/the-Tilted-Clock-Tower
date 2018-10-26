local setmetatable = setmetatable
local math = math

local Color = {}
setmetatable(Color,Color)

-- constants
local _HEXADECIMAL_SIGN = {'a', 'b', 'c', 'd', 'e', 'f'}
local _D2H

function Color:Init()
    self["red"] = "|cffff0000"
    self["green"] = "|cff00ff00"
    self["blue"] = "|cff0000ff"
    self["orange"] = "|cffff8c00"
    self["yellow"] = "|cffffff00"
    self["indigo"] = "|cff333399"
    self["purple"] = "|cff8000ff"
    self["black"] = "|cff000000"
    self["white"] = "|cffffffff"
    self["golden"] = "|cffffcc00"
    self["lightblue"] = "|cff99ccff"
    self["mediumblue"] = "|cff3366ff"
    self["mediumpurple"] = "|cff8080c0"
    self["mediumorange"] = "|cffffcc99"
    self["lightpurple"] = "|cffcc99ff"
    self["superpurple"] = "|cff9393ff"
    self["brown"] = "|cff804000"
    self["skin"] = "|cffffd8ae"
    self["white"] = "|cffffffff"
end

function Color:__call(...) -- 可能會給 顏色的英文名字 或 RGB數字
    local r, g, b = ...
    if type(r) == 'string' then
        return Color[r]
    else
        return '|cff' .. _D2H(r) .. _D2H(g) .. _D2H(b)
    end
end

_D2H = function(num)
    local firstSign = (math.modf(num/16) > 9) and _HEXADECIMAL_SIGN[math.modf(num/16)-9] or math.modf(num/16) .. ""
    local secondSign = (num%16 > 9) and _HEXADECIMAL_SIGN[num%16-9] or num%16 .. ""
    return firstSign .. secondSign
end

return Color