### Unreleased - 2018-10-18
>#### Changed:
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