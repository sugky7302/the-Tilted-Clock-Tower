function AddRecipeTest()
    local AddRecipe = require 'item.add_recipe'

    local test_recipe = {'a', 5, 'b', 3, 'c', 7, 'd', 1, 'e'}
    AddRecipe(test_recipe)

    if AddRecipe.IsRecipeOverLimit(test_recipe) then 
        print "1"
    else
        print "0"
    end
end

return AddRecipeTest