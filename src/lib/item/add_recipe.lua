-- 此module儲存材料配方。奇數索引存材料id，偶數存數量，最後一個索引存產品id
-- 可以設計同個產品卻不同材料的配方

local setmetatable = setmetatable

local AddRecipe = {}
setmetatable(AddRecipe, AddRecipe)

-- assert
AddRecipe.root = {}

local RegisterRecipe

function AddRecipe:__call(recipe)
    if not self.IsRecipeOverLimit(recipe) then
        -- 配方排序:Ab > Ba > ab > ba
        RegisterRecipe(self, recipe)
    end
end

function AddRecipe.IsRecipeOverLimit(recipe)
    local recipe_amount = (#recipe - 1) / 2
    return recipe_amount < 1 or recipe_amount > 6
end

RegisterRecipe = function(self, recipe)
    local node, demands = self.root, {}
    for i = 1, #recipe, 2 do
        -- 配方的最後一個元素是產品
        if i == #recipe then
            if not node.products then
                node.products = {}
            end

            -- 材料數量的索引是從1開始，用不到0，所以我用0當作產品索引
            -- {0:產品id, 1:材料1數量, 2:材料2數量, 3:材料3數量, ...}
            demands[0] = recipe[i]

            -- 儲存產品及材料數量，檢測用的到
            node.products[#node.products + 1] = demands

            return true
        end

        if i % 2 == 1 then
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
end

return AddRecipe