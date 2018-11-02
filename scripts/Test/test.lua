local setmetatable = setmetatable

local Test = {}
setmetatable(Test, Test)

-- variables 
local _Add

function Test:__call()
    -- self.Add()
    -- self.Texttag()
    -- self.TextToAttachUnit()
    -- self.AddRecipe()
    -- self.Group()
    -- self.Missile()
    -- self.Buff()
    -- self.Damage()
    -- self.Enchanted()
    -- self.Combine()
    self.Player()
    self.Quest()
end

function Test.Add()
    local a = 0
    for i = 1, 10 do
        _Add(a)
    end
end
-- 不改變原a，應是複製a的值
_Add = function(a)
    a = a + 1
end
        
function Test.Texttag()
    local Texttag = require 'texttag'
    local Point = require 'point'
    local obj = Texttag("test", Point(15009, 9869), 1)
end
        
function Test.TextToAttachUnit()
    local TextToAttachUnit = require 'text_to_attach_unit'
    local Point = require 'point'
    local obj = TextToAttachUnit("test", Point(15009, 9869), 1)
end

function Test.AddRecipe()
    local AddRecipe = require 'add_recipe'
    local obj = AddRecipe{1, 2, 3, 4, 5, 6}
    ob = {12, 4564, 897321, 987564, 1231}
end

function Test.Group()
    local Group = require 'group'
    local obj = {}
    for i = 1, 2 do 
        obj[i] = Group()
    end 
    obj[1]:Remove()
    obj[1] = Group()
end

function Test.Missile()
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

function Test.Buff()
    local Buff = require 'buff'
    local obj = Buff{
        name = "測試",
        type = "test",
        owner = nil,
        remaining = 10,
        icon = nil,
        coverMode = 3,
        pulse = 1,
        on_add = function() end,
        on_remove = function() end,
        on_cover = function() end,
        on_finish = function() end,
        on_cast = function() end
    }
    local obj = Buff{
        name = "測試",
        type = "test",
        owner = nil,
        remaining = 10,
        icon = nil,
        coverMode = 3,
        pulse = 1,
        on_add = function() end,
        on_remove = function() end,
        on_cover = function() end,
        on_finish = function() end,
        on_cast = function() end
    }
end

function Test.Damage()
    local Damage = require 'damage'
    Damage{
        type = "法術", 
        name = "test",
        source = "",
        target = "",
        elementType = "無",
        basicDamage = {},
        proc = 1,
        ratio = {},
    }
end

function Test.Enchanted()
    local Enchanted = require 'enchanted'
    local Item = require 'item'
    local Equipment = require 'equipment'
    local Secrets = require 'secrets'
    local Point = require 'point'
    local p = Point(15009, 9869)
    local item, rune = Equipment(Item.Create('asbl', p)), Secrets(Item.Create('afac', p))
    item:Rand(1, 1)
end

function Test.Combine()
    local Item = require 'item'
    local Point = require 'point'
    local p = Point(15009, 9869)
    for i = 1, 3 do
        Item.Create('afac', p)
    end
    for i = 1, 5 do
        Item.Create('asbl', p)
    end
end

function Test.Player()
    local Player = require 'player'
    local cj = require 'jass.common'
    Player(cj.Player(0)):set("天賦點", 100)
end

function Test.Quest()
    local Item = require 'item'
    local cj = require 'jass.common'
    local Unit = require 'unit'
    local Point = require 'point'
    local MathLib = require 'math_lib'
    local p = Point(15009, 9869)
    local item = Item.Create('tstr', p)
    for i = 1, 6 do 
        local u = Unit.Create(cj.Player(cj.PLAYER_NEUTRAL_AGGRESSIVE), 'nbrg', p + Point(MathLib.Random(500), MathLib.Random(500)), 0)
    end
end

return Test
    