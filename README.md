### Unreleased - 2018-10-01 - 開發
>#### Added:
> - 新增node，用於list。[2018-09-29]
> - 新增list，用於texttag。[2018-09-29]
> - 新增array，用於group。[2018-09-29]
> - 新增texttag。[2018-09-29]
> - 新增combat，處理戰鬥相關的事件。[2018-10-01]
> - [timer] 新增Pause函數。[2018-09-29]
>#### Changed:
> - 將外部腳本寫進地圖內，防止YDWE讀不到。[2018-09-27]
> - [group] 用array重寫部分函數。[2018-09-29]
> - [texttag] 不再提供自訂字體大小，改為自訂縮放倍率。[2018-10-01]
>#### Removed:
> - [texttag] 移除可自訂顯示漂浮文字的功能，目前改為統一顯示。[2018-10-01]
>#### Fixed:
> - [custom_tool] 修正匿名函數內含 ']]' 導致遊戲無法執行的問題。[2018-09-29]
> - [point] 修正建構函數，使point作運算時，不會再出現遊戲當機的問題。[2018-09-29]
> - [timer] 修正對象無法呼叫Pause的問題。[2018-09-29]
> - [list] 修正Iterator()讀到tail.next時，會因為node的setmetatable(node).__index=node而產生錯誤的問題。[2018-10-01]
> - [texttag] 修正RunTimer內由於list:Iterator()而產生的問題。[2018-10-01]
> - [texttag] 修正由於SetTexttag設定錯誤導致漂浮文字無法顯示的問題。[2018-10-01]

### 0.0.0 - 2018-07-06 - 啟動ChangeLog
>#### Goal:
> - 將所有腳本的更新都集中撰寫，方便日後檢查、維護。
>#### Added:
> - 新增快速排序(quicksort)演算法。[2018-07-06]
