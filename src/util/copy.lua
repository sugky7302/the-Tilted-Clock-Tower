-- 複製table，連同原table的mt也一起複製
-- 淺複製: 引用子可變對象
-- 深複製: 複製子可變對象

local pairs, setmetatable, getmetatable = pairs, setmetatable, getmetatable

local function Copy(object)
    local duplicate = {}

    for k, v in pairs(object) do
        duplicate[k] = v
    end

    return duplicate
end

local function DeepCopy(object)
    local function Recursiving(child)
        if type(child) ~= 'table' then
            return child
        end

        local duplicate = {}

        for k, v in pairs(child) do
            duplicate[Recursiving(k)] = Recursiving(v)
        end

        return setmetatable(duplicate, getmetatable(child))
    end

    return Recursiving(object)
end

return {
    copy = Copy,
    deepCopy = DeepCopy
}