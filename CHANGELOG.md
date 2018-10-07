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