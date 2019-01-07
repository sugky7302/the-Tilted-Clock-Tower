# 傾斜的時鐘塔
過去一直想要自己完成一張RPG地圖，但是每次都是半途而廢，為了提高自己的動力，特地在github上新建專案，強迫自己一定要更新，希冀能夠順利完成這個項目。

## 目標
用Lua和YDWE寫出自己用心設計以及讓玩家喜愛的地圖。
- 思維並撰寫遊戲專案文件
- 創建遊戲內所需物件，描繪遊戲地形
- 以業界工程師的標準撰寫程式碼
- 根據玩家的回饋修正遊戲

## 目錄
- docs:儲存相關文件或Markdown
- map:儲存地圖內部數據
- resource:儲存地圖美術資源
- sound:儲存地圖音訊資源
- src:程式碼目錄
    - data:儲存所有數據資料
    - lib:遊戲專用程式碼
    - test:測試碼
    - util:通用程式碼
    - war3:WE內部指令
- table:儲存地圖lni化後的物體數據
- tools:lua-debug配置
- w3x2lni:將地圖內部數據轉換成外部可讀寫的lni檔的程式
- 傷害模擬器:計算英雄傷害

## 未來可能會加入的想法
- [2018-12-01] 加入繩索系統。
- [2018-10-25] 暫時無法使用出售物品和強制按鍵模擬出充能施法，之後學習圖層混合再來考慮。

## 注意事項
### VS Code
- 可以在keyboard shortcut添加自定義快捷鍵，直接複製f5的設定就好，只要把args的值改成task.json裡的label的值，它就會呼叫。
### Git
- 如果push失敗，就直接到資料夾去pull跟push。
### Lua撰寫細則
- function、table、userdata、thread是call by reference，其它類型是call by value。
- local變量訪問速度比global變量快30%。所以被多次訪問的global變量，都應該存進local變量中。
- 給table添加元素時，tab[#tab + 1] = a比table.insert(tab, a)效率高，遠比table.insert(tab, 1, a)效率高。
- 4種循環方式(正序數值for循環、反序數值for循環、ipairs泛型for循環、pairs泛型for循環)根據習慣選擇就好，效率差別不大。
- 在循環內創建變數和循環外創建變數的效率取決於創建代價和跨域代價的對比，根據經驗選擇最合適的處理。
- 以局部變數代替多次使用的外部變數（xx.xx之類）。
- 若要調用外部函數，需直接在調用位置以局部變數獲得該函數，不要獲取該庫再 "." 函數，速度差5倍。
- 不要在for循環中創建表或閉包。
- 減少函數調用可以很大提高效率，但會降低代碼的可讀性，按需選擇。
- 因為創建空的table在插入數據時，會觸發容量重設，因此創建table時直接把參數直接寫在裡面可以很大提高效率，可以做到的情況盡量做到。
- string.format比..效率低很多，但可讀性大大提高，按需選擇。
- table.concat對記憶體的開銷較小，".."會一直產生一串新的字串。
- 判斷數組表是否為空時，一般情況用 #tab>0 即可，除非tab長度特別大，用next(tab)的效率才會更高。
- 因為require函數只能有一個返回值，如果想要多個返回值要弄成function()才行，詳見attributes。
- 有一個數組{[0] = 0, 1, 2, 3, 4, 5}，#、ipairs只會讀1-5，要pairs才會讀0-5。
- 如果table的數組段有元素要刪除，要使用table.remove，不要用nil去代替。另外，要由後往前刪除，或是返還一個新表，裡面儲存不想刪除的值。
- 如果table的string(hash)段有元素要刪除，使用nil即可。
- 判斷table是否為nil要寫next(tb) == 0。
- 使用string.gsub時，如果$在模式串的結尾，會有特殊的正則式作用，因此不要在結尾加$。
### 修改地圖
- 如果要修改地圖，請開啟TheTiltedClockTower.w3x，不要開啟.w3x。
- 修改後，請先用vscode執行Lni一次。
- 再使用vscode打開war3map.j，在InitGlobals輸入call Cheat("exec-lua: base")。
- 最後用vscode執行obj一次。
### 新增/修改/移除物編數據
- 打開table資料夾。
- 根據類型開啟相應的ini檔。
- 直接修改儲存。注意，可使用"[=["和"]=]"把內容包括在裏頭，它會將enter鍵視為換行，空格鍵就空幾格，顏色照樣可以染。
- 最後用vscode執行obj一次即可。
### 新增/修改mpq數據
- map的資料夾下根據原目錄名創建資料夾。
- 把檔案放入資料夾中。
### 導入檔案
- 先把檔案放入resource裡面，根據檔案的類型放入不同資料夾。
- 在imp.ini填入剛剛放入的資料夾的路徑。
### 導入音效
- 先把檔案放入sound\war3mapImported裡面。
- 在imp.ini填入路徑。
- 要在war3map.j的globals設定全域變量**sound gg_snd_檔案名 = null**。
- 再去找InitSound函數，根據格式來調用函數，將音效檔初始化。
### 通魔
- 如果要播施法動作，請把施法持續時間和動作持續時間設定超過施法動作播一次的時間。
### 技能
- 技能要做2個，一個是一般技能，另一個是暗圖標。
### 任務
- 觸發物品的前綴一定是"[任務] "。
### 漂浮文字
- 系統會自動刪除無法永久顯示的漂浮文字，且內建回收利用的機制。

## 資源
- [技能音效] Hero Of the Storm\mods\heros.stormmod\base.stormassets\assets\sounds\heros

## 感謝
- [lua：部分常用操作的效率对比及代码优化建议（附测试代码）][ref_url1]
- [Lua的CPU开销性能优化][ref_url2]
- [Lua -- 重写pairs方法（让字典访问有序）][ref_url3]
- [behaviourtree][ref_url4]

## 授權
本專案屬於 GPL License，更多資訊請看

[ref_url1]:https://blog.csdn.net/u013119612/article/details/78758253
[ref_url2]:https://blog.csdn.net/UWA4D/article/details/77988888
[ref_url3]:https://blog.csdn.net/honey199396/article/details/78816793
[ref_url4]:https://github.com/sugky7302/behaviourtree.lua