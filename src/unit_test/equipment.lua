Class = require 'lib.equipment'

a = Class{
    name = "test",
    kind = "a",
    type = "pmna",
}

print(a._attributes_.limit_)

a:registerPickUpEvent(function(_, self, secrets)
    print(self:enchanting(secrets))
    print(self:extendHole())
end)

a:registerUseEvent(function(_, self)
    print(self:intensify())
    print(self._attributes_)
end)

Class1 = require 'lib.secrets'
b = Class1{
    name = "test1",
    kind = "d",
    type = "sbch"
}

c = Class1{
    name = "test2",
    kind = "d",
    type = "crys"
}

d = Class1{
    name = "test3", 
    kind = "d",
    type = 'bspd'
}

e = Class1{
    name = "test3", 
    kind = "d",
    type = 'ankh'
}

a:dispatchPickUpEvent(e)
a:dispatchPickUpEvent(c)
a:dispatchPickUpEvent(d)
a:dispatchPickUpEvent(b)

a:update()
print(a:print(true))
print(a._attributes_)
print(a._attributes_.limit_)

for i = 1, 5 do 
    a:dispatchUseEvent()
end