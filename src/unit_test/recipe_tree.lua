Class = require 'lib_old.recipe_tree'

a = Class()
a:insert{"a", 3, "b", 2, "c", 1, "d"}
a:insert{"a", 3, "b", 3, "c", 2, "e"}
a:insert{"a", 5, "b", 1, "c", 4, "f"}
a:insert{"a", 2, "b", 2, "c", 1, "g"}
a:insert{"a", 3, "b", 2, "c", 6, "h"}

Class1 = require 'lib_old.consumables'
local b = a:query{
    Class1{
        type = "b",
        count = 3
    },
    Class1{
        type = "a",
        count = 3
    },
    Class1{
        type = "c",
        count = 3
    }
}

local pairs = pairs
for _, v in pairs(b) do
    for _, v1 in pairs(v) do 
        print(v1)
    end
end
