local Init = {}

Init.cover_global_ = 0       -- (0, 1) = (名字和來源都相同才視為同名狀態, 只要名字相同就是為同名狀態)
Init.cover_max_ = 0          -- 當單位身上有多個同名狀態，最多可以同時生效的狀態數量。0為無限制。只有當coverType為共存模式才有意義
Init.cover_type_ = 0         -- (0, 1) = (只能同時保留一個同名狀態, 可以同時保留多個同名狀態)
Init.keep_ = false           -- (true, false) = (死亡時保留狀態或可以添加給死亡單位，死亡時移除狀態或無法添加給死亡單位)
Init.pulse_ = nil            -- 觸發週期事件(on_pulse)的頻率，單位為秒
Init.dur_ = 0                -- 持續時間，單位為秒
Init.timeout_ = 0            -- 剩餘時間，單位為秒
Init.val_ = 0                -- 效果數值，用於某些要添加數值的效果
Init.tip_ = ''               -- buff說明
Init.tip_skill_ = nil        -- buff說明的相關技能
Init.is_force_ = false       -- 是否無視暫停
Init.is_pause_ = false       -- 是否為暫停狀態
Init.target_ = nil           -- 獲得buff的單位
Init.invalid_ = false        -- 是否失效
Init.timer_ = nil            -- 關聯計時器
Init.effect_ = nil           -- 特效
Init.model_ = nil            -- 特效模型
Init.model_point_ = "origin" -- 特效綁定點，預設為地面
Init.begin_timestep_ = nil   -- 新增buff的時間點

Init.on_add = nil           -- 添加事件
Init.on_remove = nil        -- 刪除事件
Init.on_cover = nil         -- 覆蓋事件
Init.on_finish = nil        -- 結束事件
Init.on_stop = nil          -- 中止事件

return Init