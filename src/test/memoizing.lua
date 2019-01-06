local function Memoizing()
    local start = os.clock()
    for i = 1, 1000000 do
        local a = {true, true, true}
        a[1] = 1
        a[2] = 2
        a[3] = 3
    end

    print(os.clock() - start)
    start = os.clock()

    for i = 1, 1000000 do
        local a = {}
        a[1] = 1
        a[2] = 2
        a[3] = 3
    end
    print(os.clock() - start)
end

return Memoizing