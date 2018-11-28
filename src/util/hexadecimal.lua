-- 此module為16進位制轉換

local Hexadecimal = {}

-- constants
local _HEXADECIMAL_SIGN = {'a', 'b', 'c', 'd', 'e', 'f'}

-- assert
local _FindLetter

function Hexadecimal.I2S(num_hex)
    local math, first_sign = math
    local hex_first = num_hex / 16
    if math.modf(hex_first) > 9 then
        first_sign = _HEXADECIMAL_SIGN[math.modf(hex_first) - 9]
    else
        first_sign = math.modf(hex_first) .. ""
    end

    local hex_second = num_hex % 16
    local second_sign = (hex_second > 9) and _HEXADECIMAL_SIGN[hex_second - 9] or hex_second .. ""

    return first_sign .. second_sign
end

function Hexadecimal.S2I(sign)
    local string_sub, tonumber = string.sub, tonumber

    local first_sign, second_sign = string_sub(sign, 1, 1), string_sub(sign, 2, 2)
    local first_num  = _FindLetter(first_sign) or tonumber(first_sign)
    local second_num = _FindLetter(second_sign) or tonumber(second_sign)
    local num_hex = first_num * 16 + second_num
    return num_hex
end

-- O(_HEXADECIMAL_SIGN)的方法
_FindLetter = function(sign)
    for index, letter in ipairs(_HEXADECIMAL_SIGN) do 
        if sign == letter then
            return 9 + index
        end
    end

    return false
end

return Hexadecimal