local Database = require 'util.database'
local Status_db = Database(2)

-- 狀態名字 | 子狀態
Status_db:append("不能移動")
Status_db:append("不能使用技能")
Status_db:append("打斷定點引導")
Status_db:append("打斷移動引導")
Status_db:append("普通攻擊無效")
Status_db:append("無視普通攻擊")
Status_db:append("不能普通攻擊")
Status_db:append("被位移")
Status_db:append("不能使用產生位移的技能")
Status_db:append("不會被選中")
Status_db:append("昏迷", {"不能移動", "不能使用技能", "不能普通攻擊", "打斷定點引導", "打斷移動引導"})
Status_db:append("暈眩", {"不能移動", "不能使用技能", "不能普通攻擊", "打斷定點引導"})

return Status_db