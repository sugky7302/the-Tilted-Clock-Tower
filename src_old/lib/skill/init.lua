-- 設置skill實例的成員變量的初始值

local Init = {}

-- 初始化成員變量
Init.name_ = ''              -- 技能名
Init.hotkey_ = ""            -- 快捷鍵
Init.cool_ = 0               -- 冷卻時間
Init.level_ = 1              -- 等級
Init.max_level_ = 5          -- 最高等級
Init.proficiency_ = 0        -- 當前熟練度
Init.proficiency_need_ = 0   -- 所需熟練度
Init.tip_ = ""               -- 技能說明
Init.dis_blp_ = nil          -- 暗圖標
Init.can_use_ = true         -- 判斷能否使用
Init.cast_pulse_ = 1         -- 施法計時器間隔
Init.cast_start_time_ = 0    -- 施法開始
Init.cast_channel_time_ = 0  -- 施法引導
Init.cast_shot_time_ = 0     -- 施法出手
Init.cast_finish_time_ = 0   -- 施法完成
Init.break_move_ = 1         -- 打斷移動
Init.break_order_ = 0        -- 不恢復指令
Init.castbar_ = nil          -- 施法時間條
Init.can_multi_cast_ = false -- 是否能多重施法
Init.multi_cast_chance_ = 0  -- 多重施法機率，每次接獨立計算
Init.multi_cast_count_ = 0   -- 多重施法次數
Init.is_multi_cast_ = false  -- 是否在多重施法
Init.multi_cast_text_ = nil  -- 多重施法漂浮文字

-- 初始化事件
Init.on_cast_start   = nil
Init.on_cast_channel = nil
Init.on_cast_shot    = nil
Init.on_cast_finish  = nil

-- 某個階段是否可以被打斷
Init.break_cast_start_   = 0
Init.break_cast_channel_ = 0
Init.break_cast_shot_    = 0
Init.break_cast_finish_  = 1

return Init