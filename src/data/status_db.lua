local Status = require 'util.database':new(2)

-- 狀態名字 | 子狀態
Status:append("不能移動")
Status:append("不能使用技能")
Status:append("打斷定點引導")
Status:append("打斷移動引導")
Status:append("普通攻擊無效")
Status:append("無視普通攻擊")
Status:append("不能普通攻擊")
Status:append("被位移")
Status:append("不能使用產生位移的技能")
Status:append("不會被選中")
Status:append("昏迷", {"不能移動", "不能使用技能", "不能普通攻擊", "打斷定點引導", "打斷移動引導"})
Status:append("暈眩", {"不能移動", "不能使用技能", "不能普通攻擊", "打斷定點引導"})

return Status