-- 16進位制轉換

local Hexadecimal = {}

-- constants
local HEXADECIMAL_SIGN = {'a', 'b', 'c', 'd', 'e', 'f'}

-- assert
local FindLetter

function Hexadecimal.I2S(num_hex)
    local modf = math.modf

    local first_sign
    local hex_first = num_hex / 16
    if modf(hex_first) > 9 then
        first_sign = HEXADECIMAL_SIGN[modf(hex_first) - 9]
    else
        first_sign = modf(hex_first)
    end

    local hex_second = num_hex % 16
    local second_sign = (hex_second > 9) and HEXADECIMAL_SIGN[hex_second - 9] or hex_second

    return table.concat({first_sign, second_sign})
end

function Hexadecimal.S2I(sign)
    local string_sub, tonumber = string.sub, tonumber

    local first_sign, second_sign = string_sub(sign, 1, 1), string_sub(sign, 2, 2)
    
    local first_num  = FindLetter(first_sign) or tonumber(first_sign)
    local second_num = FindLetter(second_sign) or tonumber(second_sign)
    
    local num_hex = first_num * 16 + second_num
    
    return num_hex
end

-- O(HEXADECIMAL_SIGN)的方法
FindLetter = function(sign)
    for index, letter in ipairs(HEXADECIMAL_SIGN) do 
        if sign == letter then
            return 9 + index
        end
    end

    return false
end

return Hexadecimal