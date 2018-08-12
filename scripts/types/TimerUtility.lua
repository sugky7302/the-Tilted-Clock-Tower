local setmetatable = setmetatable

local TimerUtility = {}
local mt = {}

setmetatable(TimerUtility, TimerUtility)
TimerUtility.__index = mt

TimerUtility.time = nil 
TimerUtility.isRepeat = nil
TimerUtility.executeFunction = nil

local function TimerUtility:createNewObject()
    newObject = {}
    setmetatable(newObject, self)
    newObject.__index = newObject
    return newObject
end

function TimerUtility:__call(time, executeFunction)
    newObject = self:createNewObject()
    newObject.time = time
    newObject.executeFunction = executeFunction
    return newObject
end

function TimerUtility:loop()
    self.isRepeat = true
    centerTimer:insert(self)
end

function TimerUtility:wait()
    self.isRepeat = false
    centerTimer:insert(self)
end

function TimerUtility:remove()
    self.time = nil
    self.isRepeat = nil
    self.executeFunction = nil
    self = nil
end