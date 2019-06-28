local Secrets = require 'util.database':new(3)

-- 按照秘物編號排序
-- 欄位: id(主鍵) | 屬性名 | 屬性值
Secrets:append('sbch', "物理攻擊力", 1)
Secrets:append('crys', "物理護甲", 1)
Secrets:append('bspd', "法術攻擊力", 1)
Secrets:append('ankh', "精通", 5)
Secrets:append('afac', "精神", 4)

return Secrets