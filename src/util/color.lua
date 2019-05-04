-- 此module提供we的字串顏色符

local Color = {
    -- constants
    red          = "|cffff0000",
    green        = "|cff00ff00",
    blue         = "|cff0000ff",
    orange       = "|cffff8c00",
    yellow       = "|cffffff00",
    indigo       = "|cff333399",
    purple       = "|cff8000ff",
    black        = "|cff000000",
    white        = "|cffffffff",
    golden       = "|cffffcc00",
    lightblue    = "|cff99ccff",
    mediumblue   = "|cff3366ff",
    mediumpurple = "|cff8080c0",
    mediumorange = "|cffffcc99",
    lightpurple  = "|cffcc99ff",
    superpurple  = "|cff9393ff",
    brown        = "|cff804000",
    skin         = "|cffffd8ae",
    grey         = "|cff999999"
}
setmetatable(Color, Color)

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
        local Hex = require 'util.hexadecimal'
        self[color_nums] = table.concat({'|cff', Hex.I2S(r), Hex.I2S(g), Hex.I2S(b)})
    end

    return self[color_nums]
end

return Color