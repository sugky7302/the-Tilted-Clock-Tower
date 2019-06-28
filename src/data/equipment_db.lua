local Equipment = require 'util.database':new(4)

-- 欄位: id(主鍵) | 等級 | 自帶環數 | 自帶屬性
Equipment:append('ratf', 2, 1, {["物理攻擊力"] = 1})
Equipment:append('rde4', 1, 0, {["物理護甲"] = 1})
Equipment:append('desc', 1, 0, {["物理攻擊力"] = 1})
Equipment:append('modt', 1, 0, {["耐力"] = 1})
Equipment:append('ckng', 2, 1, {["法術護甲"] = 1})
Equipment:append('tkno', 2, 1, {["法術攻擊力"] = 2})
Equipment:append('pmna', 2, 2, nil)
Equipment:append('kymn', 2, 0, {["物理護甲"] = 1, ["法術護甲"] = 1})
Equipment:append('ofro', 3, 0, {["物理護甲"] = 2, ["法術護甲"] = 1})
Equipment:append('rej5', 1, 0, {["耐力"] = 1})
Equipment:append('rej6', 2, 0, {["命中"] = 1, ["耐力"] = 1})

return Equipment