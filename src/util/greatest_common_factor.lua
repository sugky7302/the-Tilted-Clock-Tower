-- 此函數計算最大公因數
-- 遞歸比起for會慢很多，這裡把較大的數當作迴圈次數，才不會出現迴圈結束卻還沒得到結果的問題
local function GreatestCommonFactor(num1, num2)
    local big_num, small_num
    if num1 > num2 then
        big_num = num1
        small_num = num2
    else
        big_num = num2
        small_num = num1
    end

    for i = 1, big_num do 
        big_num = big_num % small_num
        if big_num == 0 then
            return small_num
        end

        -- 保證big_num > small_num
        big_num, small_num = small_num, big_num
    end
end 

return GreatestCommonFactor
    