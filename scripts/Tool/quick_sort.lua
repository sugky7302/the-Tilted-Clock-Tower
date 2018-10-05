local setmetatable = setmetatable

local QuickSort = {}
setmetatable(QuickSort, QuickSort)

-- variables
local quicksort, partition

function QuickSort:__call(array)
    quicksort(array, 1, #array)
end

quicksort = function(array, left, right)
    if right > left then
        local pivotNewIndex = partition(array, left, right, left)
        quicksort(array, left, pivotNewIndex - 1)
        quicksort(array, pivotNewIndex + 1, right)
    end
end

partition = function(array, left, right, pivotIndex)
    local pivotValue = array[pivotIndex]
    array[pivotIndex], array[right] = array[right], array[pivotIndex]
    local storeIndex = left
    for i = left, right-1 do
        if array[i] <= pivotValue then
            array[i], array[storeIndex] = array[storeIndex], array[i]
            storeIndex = storeIndex + 1
        end
        array[storeIndex], array[right] = array[right], array[storeIndex]
    end
    return storeIndex
end

return QuickSort