local setmetatable = setmetatable


local RecipeTree = {}
setmetatable(RecipeTree, RecipeTree)
local Sort, Search, GetMatchProduct

function RecipeTree:__call()
    local instance = {}

    setmetatable(instance, instance)
    instance.__index = self
    return instance
end

-- NOTE: 資料量要為奇數，{data1, count1, data2, count2, ..., product}
function RecipeTree:insert(recipe)
    local size = #recipe

    if size < 3 then
        return false
    end

    if size % 2 == 0 then
        return false
    end

    local node, demands = self, {}
    for i = 1, size, 2 do
        -- 配方的最後一個元素是產品
        if i == size then
            if not node.products then
                node.products = {}
            end

            -- 材料數量的索引是從1開始，用不到0，所以我用0當作產品索引
            -- {0:產品id, 1:材料1數量, 2:材料2數量, 3:材料3數量, ...}
            demands[0] = recipe[i]

            -- 儲存產品及材料數量，檢測用的到
            node.products[#node.products + 1] = demands
            break
        end

        local material_id = recipe[i]

        -- 儲存需求量
        demands[#demands + 1] = recipe[i + 1]

        -- 以鏈表的方式儲存材料
        -- root -> 材料1id -> 材料2id -> ... -> products
        if not node[material_id] then
            node[material_id] = {}
        end
        
        node = node[material_id]
    end
end

function RecipeTree:query(materials)
    Sort(materials)
    local products = Search(self, materials)

    if not products then
        return nil
    end

    local matching = GetMatchProduct(products, materials)
    if #matching > 0 then
        return matching
    else
        return nil
    end
end

Sort = function(materials)
    table.sort(materials, function(a, b)
        return a:getType() < b:getType()
    end)
end

Search = function(self, materials)
    local node = self

    for i = 1, #materials do
        if not node[materials[i]:getType()] then
            break
        end

        -- 跳到下一個節點
        node = node[materials[i]:getType()]
    end
    
    return node.products
end

GetMatchProduct = function(products, materials)
    local matching, size = {}

    for i = 1, #products do
        size = #products[i]
        for j = 1, size do
            if materials[j]:getCount() < products[i][j] then
                break
            end

            if j == size then
                matching[#matching + 1] = products[i]
            end
        end
    end

    return matching
end

return RecipeTree