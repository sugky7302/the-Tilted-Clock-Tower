# API
此文件為記錄所有模塊的API，按照字母排序，方便日後使用時不再需要進入該模塊去尋找。

## 注意事項
- " . " 表示該函數沒有self關鍵字；" : " 表示該函數有self關鍵字。
- 稱呼XX對象，表示它是實例，而不是we內建的物編對象。

## trigger
trigger(事件列表, 回調函數) : 建構函數
:Run(自訂參數) : 執行觸發
:disable() : 禁止觸發執行
:enable() : 允許觸發執行
:isEnable() : 觸發是否允許執行

## unit.core
unit(單位) : 建構函數，可操作成員有object_->單位、id_->單位類型、handle_->單位在遊戲內的身分證字號、name_->單位的名字、owner_->單位的擁有者，為Player對象、revive_point_->復活點、is_spell_damaged_->當下是否受到法術傷害的旗幟
:Event(事件名稱, 事件函數) : 對單位註冊事件
:EventDispatch(事件名稱, 自訂參數) : 呼叫事件。如果找不到單位事件，會去搜尋玩家事件；如果找不到玩家事件會去搜尋遊戲事件
:add(屬性, 值) : 提高該屬性的數值
:set(屬性, 值) : 設定該屬性的數值
:get(屬性) : 獲取該屬性的數值
:IsAlive() : 回傳單位是否存活
.IsHero(單位) : 回傳單位是否為英雄單位
.Create(玩家對象, 單位類型, 點對象, 面相角度) : 創建一個在某點面向某角度的單位
:AbilityDisable(技能id) : 對該單位禁用某技能
:AbilityEnable(技能id) : 對該單位允許某技能
:AddAbility(技能id, 技能等級) : 對該單位添加某技能並設定等級
:RemoveAbility(技能id) : 對該單位刪除某技能
:HasAbility(技能id) : 判斷該單位有無某技能
:ResetAbility(技能id) : 重置某技能冷卻