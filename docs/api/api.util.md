# API
此文件為記錄util資料夾的API，按照字母排序，方便日後使用時不再需要進入該模塊去尋找。

## 注意事項
- " . " 表示該函數沒有self關鍵字；" : " 表示該函數有self關鍵字。
- 稱呼XX對象，表示它是實例，而不是we內建的物編對象。
- XX...表示相同的東西重複填。
- 換行要加2個空格再enter才行。

## array
Array(): 建構函數，會生成一個空的陣列
:Remove(): 解構函數
print(陣列): 顯示所有元素
:push_back(資料): 在陣列末端添加新的元素
:erase(資料): 刪除所有與資料相符的元素
:clear(): 清空所有元素
:exist(資料): 檢查資料是否存在，有的話回傳索引
:empty(): 檢查陣列是否為空
:size(): 回傳陣列的元素個數

## class
Class(類別名, 委託對象(多個)): 建立一個委託類別

## color
Color(RGB or 顏色的英文名): 回傳256進位顏色字符串

## comparator
Comparator.Default(元素1, 元素2): 回傳哪個元素比較大

## greatest_common_factor
GreatestCommonFactor(數字1, 數字2): 回傳兩個數字的最大公因數

## hexadecimal
.I2S(16進位數字): 數字轉成字符串並回傳
.S2I(字符串): 字符串轉成數字並回傳

## is_nil
IsNil(表): 回傳表是否為空

## list
List(): 建構函數，會生成一個空的鏈表
:Remove(): 解構函數
print(鏈表): 顯示所有元素
:clear(): 清空所有元素
:erase(資料): 刪除所有與資料相符的元素
:pop_front(): 刪除第一個元素
:pop_back(): 刪除最後一個元素
:merge(另一個鏈表): 將兩個鏈表合併
:push_front(資料): 在鏈表前端添加新的元素
:push_back(資料): 在鏈表末端添加新的元素
:insert(資料, 節點): 在該節點的前面插入新的元素
:find(資料): 找尋與資料相符的元素，並回傳節點
:TraverseIterator(): 順序迭代器，可順向遍歷整個鏈表
:rTraverseIterator(): 逆序迭代器，可逆向遍歷整個鏈表
:empty(): 檢查鏈表是否為空
:size(): 回傳鏈表的元素個數
:getBegin(): 回傳第一個節點
:getEnd(): 回傳最後一個節點
:front(): 回傳第一個元素
:back(): 回傳最後一個元素

## math_lib
.round(數字): 四捨五入
.rand(最小範圍, 最大範圍): 在範圍內隨機一個數字
.bound(最小值, 數值, 最大值): 回傳被規範在範圍內的數值

## node
Node(資料): 建構函數，會生成一個節點
:Remove(): 解構函數
:getData(): 回傳節點的資料

## pairs_by_key
PairsByKey(表): 有序排列表的元素並回傳

## point
point(x, y, z) : 建構函數  
:Remove() : 解構函數  
:__tostring() : print(點對象)會調用此函數  
:__add(點對象) : 點對象A + 點對象B 會調用此函數  
:__sub(點對象) : 點對象A - 點對象B 會調用此函數  
:__mul(數字) : 點對象A * 數字 會調用此函數  
:__div(數字) : 點對象A / 數字 會調用此函數  
:copy() : 創建一個新的point對象，但值相同
:rotate(角度) : 假設一個向量從原點射向此點，旋轉此向量，獲得新的座標點  
.Deg(點對象, 點對象) : 假設有兩條分別從原點出發的向量，獲取兩個向量之間的夾角，返回角度  
.Rad(點對象, 點對象) : 假設有兩條分別從原點出發的向量，獲取兩個向量之間的夾角，返回弧度  
.Slope(點對象, 點對象) : 獲取兩平面點之間的斜率  
.SlopeInSpace(點對象, 點對象) : 獲取兩空間點之間的斜率  
.Distance(點對象, 點對象) : 獲取兩點之間的平面距離  
.DistanceInSpace(點對象, 點對象) : 獲取兩點之間的空間距離  

## queue
Queue(): 建構函數會生成一個空的隊列
:Remove(): 解構函數
print(隊列): 顯示所有元素
:push_back(資料): 在隊列末端添加新的元素
:pop_front(): 刪除第一個元素
:clear(): 清空所有元素
:empty(): 檢查隊列是否為空
:size(): 回傳隊列的元素個數
:front(): 回傳第一個元素
:back(): 回傳最後一個元素

## random_number_generator
RandomNumberGenerator(機率，名稱): 生成一個牌庫
:draw(): 抽牌
:reset(): 重置牌庫
:count(): 回傳牌數

## stack
Stack(): 建構函數會生成一個空的堆
:Remove(): 解構函數
print(堆): 顯示所有元素
:clear(): 清空所有元素
:push(資料): 添加元素到最上層
:pop(): 刪除最上層的元素
:empty(): 檢查堆是否為空
:size(): 回傳堆的元素個數
:top(): 回傳最上層的元素

## table_copy
Copy(項目): 複製表，連同metatable

## table_merge
Merge(表1, 表2): 合併兩個表，但表內的元素若有表不會合併

## task_tracker
TaskTracker(索引, 任務數量): 生成一個追蹤器
:remove(索引): 刪除該索引的追蹤器
:add(索引, 數量): 添加任務數量
:finish(索引, 數量): 設定完成的任務數量
:IsCompleted(索引): 檢查追蹤器是否全數完成

## try_catch
TryCatch(表): 第一個元素放try函數，第二個元素放catch函數

