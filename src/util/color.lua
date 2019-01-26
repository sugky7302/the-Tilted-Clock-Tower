-- 此module提供we的字串顏色符

local Color = {}
setmetatable(Color, Color)

-- constants
Color.red          = "|cffff0000"
Color.green        = "|cff00ff00"
Color.blue         = "|cff0000ff"
Color.orange       = "|cffff8c00"
Color.yellow       = "|cffffff00"
Color.indigo       = "|cff333399"
Color.purple       = "|cff8000ff"
Color.black        = "|cff000000"
Color.white        = "|cffffffff"
Color.golden       = "|cffffcc00"
Color.lightblue    = "|cff99ccff"
Color.mediumblue   = "|cff3366ff"
Color.mediumpurple = "|cff8080c0"
Color.mediumorange = "|cffffcc99"
Color.lightpurple  = "|cffcc99ff"
Color.superpurple  = "|cff9393ff"
Color.brown        = "|cff804000"
Color.skin         = "|cffffd8ae"

-- 參數可能會給"顏色的英文名字"或"RGB數字"
function Color:__call(...) 
    local r, g, b = ...

    local type = type
    if type(r) == 'string' then
        return Color[r]
    end

    local color_nums = string.format("%03d-%03d-%03d", r, g, b)

    -- 儲存下來，下次調用就不用再計算
    if not self[color_nums] then
        local Hex = require 'hexadecimal'
        self[color_nums] = '|cff' .. Hex.I2S(r) .. Hex.I2S(g) .. Hex.I2S(b)
    end

    return self[color_nums]
end

return Color