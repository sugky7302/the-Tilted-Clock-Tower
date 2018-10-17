local setmetatable = setmetatable
local Test = {}

setmetatable(Test, Test)

function Test:__call()
    -- self:Texttag()
    -- self:TextToAttachUnit()
    -- self:AddRecipe()
    -- self:Group()
    self.Missile()
end
        
function Test:Texttag()
    local Texttag = require 'texttag'
    local Point = require 'point'
    local obj = Texttag("test", Point(15009, 9869), 1)
end
        
function Test:TextToAttachUnit()
    local TextToAttachUnit = require 'text_to_attach_unit'
    local Point = require 'point'
    local obj = TextToAttachUnit("test", Point(15009, 9869), 1)
end

function Test:AddRecipe()
    local AddRecipe = require 'add_recipe'
    local obj = AddRecipe{1, 2, 3, 4, 5, 6}
    ob = {12, 4564, 897321, 987564, 1231}
    print("1")
end

function Test:Group()
    local Group = require 'group'
    local obj = {}
    for i = 1, 2 do 
        obj[i] = Group()
    end 
    obj[1]:Remove()
    obj[1] = Group()
    print("2")
end

function Test:Missile()
    local Missile = require 'missile'
    local Point = require 'point'
    local p  = Point(15009, 9869)
    local obj = Missile{
        owner = nil,
        modelName = 'A00T',
        startingPoint = p,
        targetPoint = p + Point(600, 0),
        maxDistance = 1000,
        traceMode = "StraightLine",
        hitMode = "Pass",
        execution = function() end,
    }
end

function Test:Buff()
    local Buff = require 'buff'
    local obj = Buff{
        name = ,
        type = ,
        owner = ,
        remaining = ,
        icon = nil,
        coverMode = 1,
        pulse = 1,
        callback = function() end,
        execute = function() end
    }
end

return Test
    