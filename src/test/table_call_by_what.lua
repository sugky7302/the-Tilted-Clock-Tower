local function TableCallByWhat()
    local x = {foo = "123"}

    -- x是call by value
    -- 但.foo會引用原本的table
    local function modt_1(x)
        x.foo = "bar"
    end

    -- 因為x是call by value，所以重設不影響原table
    -- 但是如果傳參不是命名為x，寫x = {}就會重設，因為lua會發現上面有一個x
    local function modt_2(x)
        x = {}
    end

    print(x.foo)
    modt_1(x)
    print(x.foo)
    modt_2(x)
    print(x.foo)
end

return TableCallByWhat