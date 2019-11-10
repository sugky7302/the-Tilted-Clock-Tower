local Status = require 'lib_old.status'

a = Status()

a:enable("昏迷")
print(a:isEnable("昏迷"))
a:disable("昏迷")
print(a:isEnable("昏迷"))

a:compose("沉默", {"不能使用技能", "打斷定點引導", "打斷移動引導"})
print(a:isEnable("沉默"))
a:enable("沉默")
print(a:isEnable("沉默"))
