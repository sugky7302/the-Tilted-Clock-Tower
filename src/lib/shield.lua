-- shield系統是buff系統的適配器，內部核心就是buff系統，只是給使用者的接口比較簡單

-- request{
-- target: unit
-- shield_type: int
-- value: float
-- time: float
-- model: string
-- }
local function Shield(req)
    -- 獲得目標的護盾表
    -- 生成新的護盾對象
    -- {type, value, model}
    -- 加入至護盾表
    -- 如果有模型就創建
    -- 設定持續時間
        -- 時間到就將護盾對象從護盾表中刪除
end

return Shield
