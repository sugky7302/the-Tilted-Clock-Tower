# EffectSystem
- 需求:
    - 易擴展=接口+配置+需求表，各模組獨立設定
    - 經過特殊的適配器，buff、debuff、shield、dot、damage等所有遊戲創生體、動作體、法術場、子彈場都能夠使用
    - 簡單維護
    - 可使用裝飾者模式修改出新的效果
    - 低耦合
    - 各模組都可做單元測試
    - 高度結構化，希望整個先用pseudocode編寫出來
    - 可獨立維護的類型定義表、特殊規則表(比如只能對誰施放之類)    
- 單一職責: 處理技能需要的效果

## EffectTable
- 需求:
    - 純文字。
    - 容易維護。
- 單一職責: 純文字的效果文本。
- 成員:
    - name: 名稱
    - value: 數值
    - level: 等級
    - period: 觸發週期事件的頻率，單位為秒
    - source: 施法者
    - target: 目標
    - time: 持續時間
    - priority: 優先級
    - remained_time: 剩餘時間
    - mode: 布林值。0表示獨佔模式，1表示共存模式
    - model: 視覺特效
    - model_point: 視覺特效點
    - global: 布林值。0表示name相同即視為同名狀態，1表示name和source都相同才視為同名狀態
    - max: 共存模式下，同名狀態生效的最大數量
    - keep_after_death: 死亡後是否保持
    - on_add: 添加時觸發的事件
    - on_remove: 刪除時觸發的事件
    - on_finish: 結束時觸發的事件
    - on_cover: 覆蓋時觸發的事件
    - on_pulse: 週期觸發事件

## Effect
- 需求:
    - 實現EffectTable，將文本轉成對象
    - 提供實作方法
    - 可操作EffectManager儲存的模板
    - 外部無法生成，只能由EffectManager生成。
- 單一職責: 實現EffectTable。

## EffectManager
- 需求:
    - 讀取模板
    - 生成Effect
    - 唯一實例
- 單一職責: Effect的外部接口。
- 成員:
    - templates: 儲存模板
- 接口:
    - constructor
        - 輸入: X
        - 輸出: EffectModel實例
        - 說明: 本程序會創建一個EffectModel實例，並回傳實例。
        - 隱藏細節: 創建模板和EffectTable。
    - getTemplate
        - 輸入: 模板名稱
        - 輸出: 模板
        - 說明: 本程序會從模板庫中調用所需的模板並回傳。
        - 隱藏細節: 如果找不到模板會回傳空模板。
