local StackableBehavior = {}

function StackableBehavior.Item(self, count)
    if count < 1 then
        跳出
    endif

    增加堆疊數量
end

return StackableBehavior