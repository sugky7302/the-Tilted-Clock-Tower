# API
此文件為記錄所有模塊的API，按照字母排序，方便日後使用時不再需要進入該模塊去尋找。

## 注意事項
- " . " 表示該函數沒有self關鍵字；" : " 表示該函數有self關鍵字。
- 稱呼XX對象，表示它是實例，而不是we內建的物編對象。
- XX...表示相同的東西重複填。
- 換行要加2個空格再enter才行。

## bar.castbar
castbar(單位對象, 持續時間, 是否反轉) : 建構函數

## bar.core
bar(單位對象, 最大值, 持續時間, 顏色, 是否反轉, 初始化函數, 更新函數) : 建構函數，可操作成員有_mst_ -> 文字、_loc_ -> 位置、_timeout_ -> 持續時間、_value_ -> 當前數值、_max_value_ -> 最大數值、_size_ -> 大小、_is_reverse_ -> 是否反轉、_color_ -> 顏色、_owner_ -> 擁有者、Initialize -> 初始化函數、Update -> 更新函數  
:Remove() : 解構函數  
.GetBarModel(當前比例, 總比例, 顏色, 是否反轉) : 創建一個狀態條

## bar.shield
shield(單位對象, 護盾最大值, 持續時間) : 建構函數

## buff.core
.Register(效果名, 設定、獲得函數)
:add(效果名, 數值) : 提升該屬性的值
:set(效果名, 數值) : 設定該屬性的值
:get(效果名) : 獲得該屬性的值
:Pause() : 暫停效果
:Resume() : 恢復效果
:EventDispatch(效果事件名, 預設返回值, 傳參參數)

## buff.operator
.Obtain(效果對象) : 添加效果給英雄
.Delete(效果對象) : 刪除英雄的效果

## buff.unit

## class
class(對象名, 委託對象...) : 創建一個類似類別的對象原型，委託對象可以無限個。可操作成員有_new -> 自訂的建構函數、_delete -> 自訂的解構函數、_copy -> 若建構函數傳入的是寫好的table，就可以用它把table的內容複製給實例、setInstance -> 將實例與對象關聯起來、getInstance -> 獲取實例、deleteInstance -> 刪除實例與對象的關聯

## dialog
dialog(玩家) : 建構函數  
:Remove() : 解構函數  
:Clear() : 清空對話框所有按鈕  
:AddButton(按鈕文字, 索引, 熱鍵) : 添加按鈕到對話框  
:FindButton(索引) : 搜尋按鈕並返回它  
:Show(is_show) : 是否顯示對話框  
:SetTitle(文字) : 設定標題

## event
event(註冊對象, 事件名稱)(觸發) : 建構函數，觸發的第一個參數為觸發自身，通常使用虛變量"_"代替，回傳的是trigger  
.Dispatch(對象, 事件名稱, 自訂參數) : 執行對象屬於該事件名稱的事件列表裡的所有事件，有回傳值

## game
:Event(事件名) : 註冊全域事件  
:EventDispatch(事件名, 自訂參數) : 調用全域事件，有回傳值

## group.condition
.IsEnemy(選取單位, 匹配單位) : 是否為敵人  
.IsAlly(選取單位, 匹配單位) : 是否為盟友  
.IsHero(選取單位, 匹配單位) : 是否為英雄  
.IsNonHero(選取單位, 匹配單位) : 是否為非英雄  
.Nil(選取單位, 匹配單位) : 無條件通過

## group.core
group(匹配單位) : 建構函數  
:Remove() : 解構函數  
:Clear() : 清空單位組  
:Loop(動作, 自訂參數) : 對單位組所有單位做動作  
:In(單位) : 確認單位有沒有在單位組裡，返回值為bool  
:getNum() : 獲取單位組內的單位總數  
:IsEmpty() : 回報單位組是否為空  
:Ignore(單位) : 使單位組不會對該單位執行動作  
:EnumUnitsInRange(x, y, 半徑, 條件名) : 選取範圍內的單位  
:AddUnit(單位) : 添加單位給單位組  
:RemoveUnit(單位) : 刪除單位組中的某單位

## intelligence
.Save(單位對象, 點對象) : 儲存該點儲存的情報到單位對象的資料庫內  
.Load(單位對象) : 讀取單位對象的所有情報

## item.add_recipe
AddRecipe(配方表) : 添加配方表到配方庫
.IsRecipeOverLimit(配方表) : 配方表是否超出上限

## item.big_secret_order
BigSecretOrder(英雄) : 偵測英雄有無組成大秘物序列

## item.combine
Combine(物品) : 檢測材料能否合成高級材料

## item.core
Item(物品) : 建構函數，可操作成員有name_ -> 名字、id_ -> 類型名、handle_ -> 唯一編號、owner_ -> 擁有單位、own_player_ -> 擁有玩家、level_ -> 物品等級、object_ -> 物品本身、perishable -> 使用完會不會消失
:Remove() : 解構函數
.IsEquipment(物品) : 是否為裝備
.IsSecrets(物品) : 是否為秘物
.IsMaterial(物品) : 是否為材料
.IsRecipe(物品) : 是否為配方
:add(屬性名, 數值) : 提高該屬性的值
:set(屬性名, 數值) : 設定該屬性的值
:get(屬性名) : 獲得該屬性的值
.Delete(物品) : 刪除物品
.Create(物品id, 位置) : 在該位置創建物品

## item.enchanted
Enchanted(裝備, 秘物) : 將秘物的效果附魔在裝備上

## item.equipment.core
Equipment(裝備) : 建構函數，可操作成員除了包含item的成員外，另有prefix_ -> 詞綴、big_secret_order_ -> 大秘物序列、small_secret_order_-> 小秘物序列、attribute_ -> 所有屬性、attribute_count -> 屬性總數量、attribute_count_limit_、屬性最大數量、additional_effect_ -> 額外效果、color_ -> 裝備名稱顏色、intensify_level_ ->精煉等級、intensify_fail_times_ -> 精煉失敗次數、stability_ -> 穩定度、intensify_ -> 強化度、fusion_ -> 融合度、uniqueness_ -> 珍稀度
:Update() : 更新裝備數據
:Sort() : 屬性排序
:Rand(怪物階級, 怪物強度) : 隨機鑲環數
:Display() : 顯示裝備敘述
:name(要不要換行) : 顯示裝備名字
:GetGearScore() : 顯示裝備評分
:IsAttributeFull() : 能不能附魔
:IsRingFull() : 能不能強化

## item.equipment.printer
.GetGearScore(裝備對象) : 顯示裝備評分
.name(裝備對象, 要不要換行) : 顯示裝備名字
.Display(裝備對象) : 顯示裝備敘述

## item.extend_hole
ExtendHole(裝備) : 對裝備鑲環

## item.intensify
Intensify(裝備) : 精煉裝備

## item.prefix
Prefix(裝備) : 設定裝備的詞綴

## item.produce_recipe
ProduceRecipe(單位) : 將身上的材料合成物品

## item.secrets
Secrets(物品) : 建構函數
:set(屬性名, 數值) : 設定該屬性的值
:get(屬性名) : 獲得該屬性的值

## item.small_secret_order
SmallSecretOrder(裝備) : 檢查裝備有無小秘物序列的效果

## mover.core
mover(data) : 建構函數，可操作成員有mover_ -> 單位對象、starting_point_ -> 起始點、max_dist_ -> 最遠距離、TraceMode -> 軌跡函數、Execute -> 每次移動都會執行的動作函數、End_Cnd -> 終止條件、target_point_ -> 終點、velocity_ -> 初速度、velocity_max_ -> 最高速度、acceleration_ -> 加速度、height_ -> 拋體運動最大高度、angle_ -> 射角、radius_ -> 半徑、starting_height_ -> 初始高度、dur_ -> 存在的時間、current_dist_ -> 走過的距離、motivation_ -> 位移量  
:Remove() : 解構函數

## mover.missile
missile(data) : 建構函數，除了mover的可操作成員外，另有owner_ -> 擁有者、model_name_ -> 投射物模型、hit_mode_ -> 數字表示擊中數達此值停止，inf表示到最大距離才停止、SetHeight -> 高度函數、GroupExecute -> 單位組的loop函數，格式一定要遵照 function(group, i, ...) 動作 end)

## mover.trace
:Line() : 直線軌跡  
:Surround() : 環繞軌跡

## mover.util
.Move(目標單位對象, 點對象, 距離, 角度) : 移動目標單位

## multiboard
multiboard(玩家) : 建構函數  
:Remove() : 解構函數  
:Clear() : 清空多面板  
:Show(is_show) : 是否顯示多面板  
:Minimize(is_minimize) : 是否最小化多面板  
:GetColumn() : 獲取欄長度  
:SetColumn(新長度) : 設定欄長度  
:GetRow() : 獲取列長度  
:SetRow(新長度) : 設定列長度  
:SetTitle(文字) : 設定標題  
:SetTitleColor(紅, 綠, 藍, 透明度) : 設定標題顏色  
:SetStyle(is_show_text, is_show_icon) : 設定多面板要顯示的元素有哪些  
:SetWidth(ratio_for_screen) : 根據螢幕寬度設定多面板大小  
:SetIcon(icon_path) : 設定圖標  
:AddItem(row, column, text, scale_for_screen) : 設定多面板項目  
:RemoveItem(row, column) : 刪除第(row, column)格的多面板項目  
:SetItemText(row, column, text) : 設定第(row, column)格的多面板項目的文字  
:SetItemWidth(row, column, scale_for_screen) : 設定第(row, column)格的多面板項目的寬度  
:SetItemColor(row, column, 紅, 綠, 藍, 透明度) : 設定第(row, column)格的多面板項目的顏色

## leaderboard
leaderboard(玩家) : 建構函數  
:Remove() : 解構函數  
:Clear() : 清空排行榜的內容  
:add(玩家, 名字, 分數) : 添加玩家數據到排行榜  
:Delete(玩家) : 刪除玩家數據  
:SetPlayerValue(玩家, 分數) : 設定玩家數據  
:SetPlayerName(玩家, 名字) : 設定玩家名字  
:Show(is_show) : 是否顯示排行榜  
:SetTitle(文字) : 設定標題  
:SetStyle(is_view_title, is_view_text, is_view_point, is_view_icon) : 設定顯示風格

## player
player(玩家) : 建構函數  
:Remove() : 解構函數  
.Init() : 初始化玩家對象事件  
:Event(事件名) : 註冊玩家事件  
:EventDispatch() : 調用玩家事件，有回傳值  
:add(屬性, 值) : 提高該屬性的值  
:set(屬性, 值) : 設定該屬性的值  
:get(屬性) : 獲取該屬性的值

## point
point(x, y, z) : 建構函數  
:Remove() : 解構函數  
:__tostring() : print(點對象)會調用此函數  
:__add(點對象) : 點對象A + 點對象B 會調用此函數  
:__sub(點對象) : 點對象A - 點對象B 會調用此函數  
:__mul(數字) : 點對象A * 數字 會調用此函數  
:__div(數字) : 點對象A / 數字 會調用此函數  
:copy() : 創建一個新的point對象，但值相同
:UpdateZ() : 更新z座標  
:Rotate(角度) : 假設一個向量從原點射向此點，旋轉此向量，獲得新的座標點  
.Deg(點對象, 點對象) : 假設有兩條分別從原點出發的向量，獲取兩個向量之間的夾角，返回角度  
.Rad(點對象, 點對象) : 假設有兩條分別從原點出發的向量，獲取兩個向量之間的夾角，返回弧度  
.Slope(點對象, 點對象) : 獲取兩平面點之間的斜率  
.SlopeInSpace(點對象, 點對象) : 獲取兩空間點之間的斜率  
.Distance(點對象, 點對象) : 獲取兩點之間的平面距離  
.DistanceInSpace(點對象, 點對象) : 獲取兩點之間的空間距離  
.GetUnitLoc(單位) : 獲取單位所在的點  
.GetLoc(點) : 轉換點為點對象

## polygon
polygon(點集合) : 建構函數  
:__tostring() : print(多邊形對象)會調用此函數  
:In(點對象) : 判斷點對象有無在多邊形內

## quest.core
quest(任務模板) : 建構函數，可操作成員有receiver_ -> 接受任務的人、demands_ -> 任務需求  
:Remove() : 解構函數  
:Update(任務id) : 更新任務

## quest.util
:Announce(訊息) : 播放任務訊息  
:GiveItem(物品類型id, 數量) : 創建物品給接受任務的人  
:Near(x, y) : 判斷接受任務的人有沒有在(x, y)附近200碼內  
:ActivePathIndicator(x, y) : 創建一個路徑指示器

## queue
queue() : 建構函數  
:Remove() : 解構函數  
:__tostring() : print(queue對象)會調用此函數  
:PushBack(data) : 將資料插入queue對象的最尾端  
:PopFront() : 將最前端的資料移除  
:Clear() : 清空queue對象的所有資料  
:IsEmpty() : 判斷是否為空  
:getLength() : 獲得queue對象的長度
:front() : 獲得最前端的資料

## region
region(區域名, 點集合) : 建構函數  
:Remove

## skill.cast
cast(技能對象) : 建構函數

## skill.core
skill(data) : 建構函數  
:Remove() : 解構函數  
:Cast() : 施放技能  
:Break() : 中止技能  
:EventDispatch(事件名, 是否強制執行, 自訂參數) : 調用技能事件函數(技能-施法開始、技能-施法引導、技能-施法出手、技能-施法完成、技能-造成傷害、技能-擊中單位)
:UpdateName() : 更新技能名稱  
:UpdateTip() : 更新技能說明

## skill.util
.ChangeModel(單位對象, 模型名) : 替換單位模型  
:RootCast(持續時間) : 施法時的效果  
.ChangeTurnRate(英雄對象, 移動類型id, 值) : 修改轉身速度  
:MultiCast() : 多重施法  
.PreWarn(半徑, 點對象, 持續時間) : 創建一個技能預警圈

## talent
talent(模板) : 建構函數

## texttag.arc
ArcText(文字, 點對象, 縮放尺寸) : 建構函數，可操作成員除了texttag的成員外，另有_offset_ -> 位移量、_size_ -> 文字大小

## texttag.core
texttag(文字, 點對象, 持續時間, 是否永久) : 建構函數，可操作成員有_msg_ -> 訊息、_loc_ -> 起始點、_timeout_ -> 持續時間、_is_permanant_ -> 是否永久、_timer_ -> 計時器、_texttag_ -> WE的漂浮文字、_invalid- -> 是否失效、Initialize -> 初始化函數、Update -> 更新函數  
:Remove() : 解構函數，順便回傳任務完成  
:Break() : 設定漂浮文字對象失效

## timer.core
timer(時間/週期, 單次(false) / 多次(數字) / 循環(true), 動作函數) : 建構函數  
:Remove() : 解構函數  
:SetRemaining(時間) : 設定剩餘時間  
:Pause() : 暫停計時器  
:GetRemaining : 獲取剩餘時間  
:Resume : 恢復計時器  
:Break : 終止計時器

## timer.init
.Init() : 啟動中心計時器  
.SetTimeout(回調函數, 要插入的幀) : 將計時器插入新的幀  
.clock() : 獲取當前時間(秒)  
.frame() : 獲取當前時間(幀)

## trigger
trigger(事件列表, 回調函數) : 建構函數  
:Run(自訂參數) : 執行觸發  
:disable() : 禁止觸發執行  
:enable() : 允許觸發執行  
:isEnable() : 觸發是否允許執行

## unit.core
unit(單位) : 建構函數，可操作成員有object_->單位、id_->單位類型、handle_->單位在遊戲內的身分證字號、name_->單位的名字、owner_->單位的擁有者，為Player對象、revive_point_->復活點、is_spell_damaged_->當下是否受到法術傷害的旗幟、mover_queue_ -> 存放移動器隊列  
:Remove() : 解構函數，會刪除該單位  
:getInstance(unit) : 獲取Unit對象的實例  
:Event(事件名稱)(觸發函數) : 對單位註冊事件觸發  
:EventDispatch(事件名稱, 自訂參數) : 呼叫事件。如果找不到單位事件，會去搜尋玩家事件；如果找不到玩家事件會去搜尋遊戲事件  
:add(屬性, 值) : 提高該屬性的數值，屬性尾符若是"%"，則值要 < 1  
:set(屬性, 值) : 設定該屬性的數值，屬性尾符若是"%"，則值要 < 1  
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
:LearnTalent(天賦id) : 學習天賦  
:TalentDispatch(天賦名, 事件名, 自訂參數) : 呼叫天賦函數  
:AcceptQuest(任務名) : 接取任務

## unit.hero
hero(英雄) : 建構函數，可操作成員除了包含unit的成員外，另有proper_name_ -> 英雄的稱謂、each_casting_ -> 英雄的施放技能隊列、pet_ -> 召喚物  
:Remove() : 解構函數，會刪除該單位  
.Template(英雄名字)(用table包裝的模板內容) : 創建英雄模板，之後所有的英雄單位都會套用這個模板  
:UpdateAttributes("+" / "-", 裝備) : 正負號表示是要對英雄添加裝備的屬性或是減少

## unit.operator
.Register(屬性, 調用table) : 對該屬性設定可使用的操作符，目前支援set、get、on_add、on_set、on_get，格式可參照unit.attribute底下的文件  
:add(屬性, 值) : 提高該屬性的數值，可修改數值、百分比，無法修改最大值、最小值。屬性尾符若是"%"，則值要 < 1  
:set(屬性, 值) : 設定該屬性的數值，可修改數值，無法修改百分比、最大值、最小值，修改後百分比歸零  
:setMax(屬性, 值) : 設定該屬性的最大值  
:setMin(屬性, 值) : 設定該屬性的最小值  
:get(屬性) : 獲取該屬性的值，該值會加總數值和百分比。屬性尾符不得加"_max"、"_min"，有加"%"跟沒加的數值都相同

## unit.pet
pet(召喚物, 英雄) : 建構函數，會將英雄和召喚物關聯  
.Create(單位類型, 擁有者, 點對象, 持續時間) : 創建一個pet實例，持續時間不填 = 永久