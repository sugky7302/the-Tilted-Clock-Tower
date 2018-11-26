# 傾斜的時鐘塔
## 前言
過去一直想要自己完成一張RPG地圖，但是每次都是半途而廢，為了提高自己的動力，特地在github上新建專案，強迫自己一定要更新，希冀能夠順利完成這個項目。

## 目標
用Lua和YDWE寫出自己用心設計以及讓玩家喜愛的地圖。
- 思維並撰寫遊戲專案文件
- 創建遊戲內所需物件，描繪遊戲地形
- 以業界工程師的標準撰寫程式碼
- 根據玩家的回饋修正遊戲

## 目錄
- data:儲存所有數據資料
    - buffs:增益效果資料
    - heros:英雄數據
        - skills:英雄技能
        - talents:英雄天賦
    - quests:任務
- lib:遊戲專用程式碼
- test:測試碼
- util:通用程式碼
- war3:WE內部指令

## 未來可能會加入的想法
- [2018-10-25] 暫時無法使用出售物品和強制按鍵模擬出充能施法，之後學習圖層混合再來考慮。

## 注意事項
### 修改地圖
- 如果要修改地圖，請開啟TheTiltedClockTower.w3x，不要開啟.w3x。
- 使用後，請先用vscode執行Lni一次。
- 再使用vscode打開war3map.j，在InitGlobals輸入call Cheat("exec-lua: base")。
- 最後用vscode執行obj一次。
### 新增/修改/移除物編數據
- 打開table資料夾。
- 根據類型開啟相應的ini檔。
- 直接修改儲存。注意，可使用"[=["和"]=]"把內容包括在裏頭，它會將enter鍵視為換行，空格鍵就空幾格，顏色照樣可以染。
- 最後用vscode執行obj一次即可。
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

## 資源
- [技能音效] Hero Of the Storm\mods\heros.stormmod\base.stormassets\assets\sounds\heros
