        local CustomTool = {}
        local table = table
        function CustomTool.PairsByKeys(tb)
            local obj = {}
            for n in pairs(tb) do 
                obj[#obj+1] = n 
            end 
            table.sort(obj)
            local i = 0
            return function()
                i = i + 1
                return obj[i], tb[obj[i]]
            end
        end
        return CustomTool
    