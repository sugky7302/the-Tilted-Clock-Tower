# 傾斜的時鐘塔
## 前言
過去一直想要自己完成一張RPG地圖，但是每次都是半途而廢，為了提高自己的動力，特地在github上新建專案，強迫自己一定要更新，希冀能夠順利完成這個項目。

## 目標
用Lua和YDWE寫出自己用心設計以及讓玩家喜愛的地圖。
- 思維並撰寫遊戲專案文件
- 創建遊戲內所需物件，描繪遊戲地形
- 以業界工程師的標準撰寫程式碼
- 根據玩家的回饋修正遊戲

過程使**Evernote**來管理我的專案。

## 更新日誌
### 0.15.0 - 2018-10-24
>#### Added:
> - 新增bar庫，將castbar的核心功能摘出來，為之後的狀態條作準備。
> - [skill] 完善施法階段。
> - [skill] 新增打斷階段。
> - [skill] 新增定身施法，施法光環會隨秒數縮放。
> - [skill] 新增多重施法。
>#### Fixed:
> - [list] 修正erase函數的popack無參數的問題。
> - [skill] 修正由於[座標誤差][coordinate_error]而導致施法光環模型無法正確顯示在施法者腳下的問題。
> - [skill] 修正多重施法時，某次觸發可能會獲取到轉身速度設定為0的數值，而導致多重施法結束後，角色無法轉身的問題。
> - [skill] 修正多重施法提示文字無法顯示的問題，但目前仍未解決文字會莫名跳動的問題。
> - [timer] 修正計時器在失效後，依舊會調用動作的問題。

### 0.14.0 - 2018-10-23
>#### Added:
> - 新增castbar庫，生成施法條。
> - [damage] 考慮到某些技能需要必中，因此新增"mustHit"參數。
> - [hero] 新增模板函數，用於解析英雄模板。
> - [hero] 新增"準備施放技能"及"發布命令"事件、create函數。
> - [point] 新增GetLoc函數，能獲取jass點結構的point。
> - [skill] 將技能區分成cast、channel、shot、finish四個階段，實際功能還在實作。
> - [texttag] 新增break函數，使漂浮文字在某些情況下可以主動消失。
>#### Changed:
> - [珍娜] 修改成"冰霜秘術師"，使其能讓hero調用。
> >#### Fixed:
> - [damage] 修正獲取元素傷害錯誤的問題。
> - [暴風雪] 修正暴風雪獲取單位組內單位錯誤的問題。

### 0.13.0 - 2018-10-22
>#### Added:
> - 新增smallSecretOrder、bigSecretOrder庫，但秘物序列還沒進行測試。
> - 新增combine庫，用於低級材料轉換成高級材料。
> - [item] 新增set、get、add函數，並優化相關函數。
> - [jass_tool] 新增item2id、item2str函數，讓物品能夠直接獲得整數或字串名。
>#### Changed:
> - [damage] 優化造成傷害函數。
> - [detect_recipe] 調整結構。
>#### Fixed:
> - [enchanted] 修正相同屬性的秘物可以用在同一件裝備的問題。

### 0.12.0 - 2018-10-21
>#### Added:
> - 新增attribute資料庫，儲存屬性、描述文字、裝備評分。
> - 新增combine資料庫，儲存材料合成公式。
> - 新增extend_hole、intensify庫，完善物品核心系統。
> - 新增intensify資料庫，儲存精鍊後可提升的屬性。
> - 新增prefix資料庫, 儲存詞綴。
> - 新增recipe資料庫，儲存配方。
> -新增secret資料庫，儲存秘物屬性。
> - [equipment] 新增獲取裝備評分的函數。
> - [equipment] 對話框新增裝備評分。
> - [Item資料夾] 新增init，將裝備的核心系統放在同個地方初始化。
> - [Tool資料夾] 新增init，將類型的初始化函數合併調用。
> - [Type資料夾] 新增init，將類型的初始化函數合併調用。
>#### Changed:
> - [add_recipe] 配方的材料數量可設定成任意，不再侷限為1個。
> - [detect_recipe] 根據add_recipe而做調整。
> - [dialog] insert函數新增label參數，不再將標籤和按鈕文字綁定。
>#### Fixed:
> - [enchanted] 修正顯示裝備框也會觸發附魔的使用物品事件。
> - [equipment] 修正_RandRingCount函數只會生成最低孔數及最高孔數的問題。
> - [player] 修正add函數算符錯誤，導致exten_hole扣除金額時變成增加的問題。
> - [secrets] 修正_GenerateAttributes函數無法給secrets對象數據，導致附魔錯誤的問題。

### 0.11.0 - 2018-10-20
>#### Added:
> - 新增database資料夾，儲存各類型需要的模板。
> - 新增secrets_database、attribute_database庫，提供物品需要的數據。
> - 新增item、enchanted、equipment、secrets庫，完成附魔功能。
> - 新增player庫，設定玩家專有的函數。
> - 新增order_id庫，用於將命令轉成編輯器認識的id編碼。
> - 新增dialog庫，用於裝備顯示框。
> - [damage] 新增混合傷害，可自行設定物法比例。
> - [enchanted] 新增init函數，專門呼叫附魔函數。
> - [hero] 新增物品、發動技能效果事件。
> - [main] 新增部分初始化函數。
> - [skill] 完善發布命令事件。
> - [unit] 新增增強物理攻擊力來獲得面板的綠字攻擊。
> - [unit] 修正set函數會根據 name 自動生成 name% 屬性的問題。
>#### Changed:
> - [damage] 根據混合傷害的需要，調整獲取物理攻擊力、法術攻擊力、物理護甲、法術護甲的觸發。
> - [equipment] 改成對話框顯示。
> - [hero] 註冊事件改為map呼叫。
> - [main] 調整初始化順序。
> - [map] 調用模塊改由該函數呼叫。
> - [unit] 註冊事件改為map呼叫。
> - [Database資料夾] 調整所有database的呼叫方式，改為全域變量。
>#### Fixed:
> - [combat] 修正復活後的怪物會無法扣除傷害觸發內的暫時生命值的問題。
> - [damage] 修正傷害文字和實際傷害值不符的問題。
>#### Removed:
> - [equipment] 由於物品數據是類型一起更改，無法達到單件物品專門修改的效果，因此刪除此功能。

### 0.10.0 - 2018-10-19
>#### Added:
> - 新增damage庫。
> - 新增unit庫，為單位註冊結構。
> - 新增hero庫，繼承unit庫，並添加英雄特有屬性及函數。
> - 新增math_lib庫，補充lua的math庫沒有的函數。
> - [unit] 新增獲取物理攻擊力的函數。
>#### Changed:
> - [map] "單位-創建"事件移動到unit庫統一執行。
>#### Fixed:
> - 修改更新日誌日期錯誤的問題。
> - [combat] 修正"顯示傷害"觸發無法正確獲得傷害值且無法對目標造成自定義傷害的問題。
> - [unit] 修正存取物理攻擊力會出現錯誤的問題。
>#### Removed:
> - 移除general_bonus_system庫，改用japi。

### 0.9.1 - 2018-10-18
>#### Added:
> - 新增buff庫，執行所有增益/減益/持續傷害等效果。
> - 新增skill庫，設計技能工具。
> - 新增map庫，統籌執行遊戲內機制。
> - 新增hero庫，設定英雄屬性或技能。
>#### Changed:
> - [buff] icon更名為art。
> - [combat] 移動到map庫統一執行。
> - [game] 移動到map庫統一執行。
> - [recipe] 修改product，能儲存多種產品。運用隨機數讀取隨機一種產品，用於材料賭博相關方面，由《超神機械師》參考而來。

### 0.9.0 - 2018-10-10
>#### Added:
> - 新增trigger庫。參照moe-master 2.1和javascript的自定義事件，理解原理再根據需求修改。
> - 新增event庫，同上理由。
> - 新增game庫，用於註冊遊戲內所有系統、事件。
> - [timer] 新增clock函數，獲取遊戲開始到調用的時間。
>#### Changed:
> - System資料夾名改成Maps。
> - [combat] 根據trigger和event庫，重寫觸發函數。
>#### Fixed:
> - [combat] 修正漂浮文字與攻擊動畫不同步的問題。
> - [event] 修正.__call無法讀取eventName的問題。
> - [trigger] 修正沒有將回調函數添加進事件佇列的問題。

### 0.8.0 - 2018-10-09 - 重新更名回README
>#### Added:
> - 新增queue。
> - [base] 新增Debug模式。
> - [combat] 添加單位被攻擊後顯示戰鬥文字的觸發。
> - [group] 添加新的判斷條件IsHero、IsNonHero。
>#### Changed:
> - [jass_tool] 調整debug函數只能在debug模式下才能顯示。
> - [timer] 參照moe-master 2.1重寫timer，改成中心計時器。
>#### Fixed:
> - 名字改回README，github才能顯示這個更新日誌。
> - 原README改成lua使用說明。
> - [api] timer重寫後，trigger能夠正確觸發。

### 0.7.0 - 2018-10-08
>#### Added:
> - 新增missile_tool庫，將missile的工具獨立出來。
> - 新增trace_lib庫，將missile的彈道庫獨立出來。
> - [test] 新增missile的測試。
>#### Changed:
> - [missile] 將missile_tool的angle改成初始設定，之後missile要做弧形軌跡，就直接更改obj.angle。
>#### Fixed:
> - 在war3map.j的main函數內直接調用base.lua，防止使用YDWE的觸發編輯器後儲存，會無法調用base.lua的問題。
> - [array] 修正由於array.__index=array會導致group的unitDetermined重複呼叫array的問題。
> - [array] 修正Remove函數，使IsEmpty函數可以正確獲得self.size。
> - [group] 修正Clear函數，使其功能單一化，不再和Remove重疊。
> - [missile_tool] 由於SetUnitX、SetUnitY無法對移動速度=0的單位執行動作，因此改成SetUnitPosition。
> - [missile_tool] 修正Move函數一直計算angle，導致Pass型投射物無法移動到最大距離的問題。
> - [missile_tool] 根據下條錯誤，修正SetHeight獲取錯誤高度，導致條件判斷會使得missile還沒設定timer時就刪除timer的問題。
> - [point] 修正+-*/會覆蓋舊point，使得Distance函數計算=0，進而導致missile_tool的_GetSlope函數會出現nan(ind)的問題。

### 0.6.1 - 2018-10-07
>#### Fixed:
> - [timer] 修正Remove函數不會暫停計時器，可能會一直執行的問題。

### 0.6.0 - 2018-10-06
>#### Added:
> - 新增add_recipe、detect_recipe(未測試)庫。
> - [object] 新增Insert、Sort函數。
> - [test] 新增group和add_recipe的測試。
>#### Changed:
> - 根據**程式碼撰寫規則**重審所有程式碼，並測試部分程式碼。

### 0.5.0 - 2018-10-05 - 更名為CHANGELOG
>#### Added:
> - 新增紅黑樹，但「刪除」動作尚未完成。

### 0.4.0 - 2018-10-04 - 純vscode作圖
>#### Added:
> - 新增test，用於測試程式碼。
> - [texttag] 將原先texttag的戰鬥漂浮文字獨立成text_to_attch_unit模塊。
>#### Changed:
> - 利用[魔獸吧裡面有人提出的vscode問題][actboy168-lua-debug]完成了之前一直想用vscode直接作圖的功能。
> - [texttag] 將原先的戰鬥漂浮文字功能拆解成獨立模塊，核心只提供固定漂浮文字功能。
>#### Fixed:
> - [texttag] 修正由於字體過大導致遊戲內看不見漂浮文字的問題。

### 0.3.0 - 2018-10-01
>#### Added:
>- 新增combat，處理戰鬥相關的事件。
>#### Changed:
> - [texttag] 不再提供自訂字體大小，改為自訂縮放倍率。
>#### Removed:
> - [texttag] 移除可自訂顯示漂浮文字的功能，目前改為統一顯示。
>#### Fixed:
> - [list] 修正Iterator()讀到tail.next時，會因為node的setmetatable(node).__index=node而產生錯誤的問題。
> - [texttag] 修正RunTimer內由於list:Iterator()而產生的問題。
> - [texttag] 修正由於SetTexttag設定錯誤導致漂浮文字無法顯示的問題。

### 0.2.0 - 2018-09-29
>#### Added:
> - 新增node，用於list。
> - 新增list，用於texttag。
> - 新增array，用於group。
> - 新增texttag。
> - [timer] 新增Pause函數。
>#### Changed:
> - [group] 用array重寫部分函數。
>#### Fixed:
> - [custom_tool] 修正匿名函數內含 ']]' 導致遊戲無法執行的問題。
> - [point] 修正建構函數，使point作運算時，不會再出現遊戲當機的問題。
> - [timer] 修正對象無法呼叫Pause的問題。

### 0.1.1 - 2018-09-27 - 開發
>#### Changed:
> - 將外部腳本寫進地圖內，防止YDWE讀不到。

### 0.1.0 - 2018-07-06 - 啟動ChangeLog
>#### Goal:
> - 將所有腳本的更新都集中撰寫，方便日後檢查、維護。
> - 按日期降序排列，方便檢視最新的更新。
> - 類別按照字母排列。
>#### Added:
> - 新增快速排序(quicksort)演算法。[2018-07-06]

[actboy168-lua-debug]:https://tieba.baidu.com/p/5902146836
[coordinate_error]:https://tieba.baidu.com/p/5773334779?pid=120570865697&cid=0&red_tag=1133617129#120570865697