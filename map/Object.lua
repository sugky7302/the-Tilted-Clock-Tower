        local setmetatable = setmetatable
        local Object = {}
        setmetatable(Object, Object)
        Object.CountOfEIN = 0
        function Object:__call(obj)
            obj = obj or {}
            self.CountOfEIN = self.CountOfEIN + 1
            obj.EIN = self.CountOfEIN
            return obj
        end
        return Object
    