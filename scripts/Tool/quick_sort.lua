local setmetatable = setmetatable

local QuickSort = {}
setmetatable(QuickSort, QuickSort)

-- variables
local _quicksort, _partition

function QuickSort:__call(array)
    _quicksort(array, 1, #array)
end

_quicksort = function(array, left, right)
    if right > left then
        local pivotNewIndex = _partition(array, left, right, left)
        _quicksort(array, left, pivotNewIndex - 1)
        _quicksort(array, pivotNewIndex + 1, right)
    end
end

_partition = function(array, left, right, pivotIndex)
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