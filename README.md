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

## 資源
- [技能音效] Hero Of the Storm\mods\heros.stormmod\base.stormassets\assets\sounds\heros

## 感謝
- [lua：部分常用操作的效率对比及代码优化建议（附测试代码）][ref_url1]
- [Lua的CPU开销性能优化][ref_url2]
- [Lua -- 重写pairs方法（让字典访问有序）][ref_url3]
- [behaviourtree][ref_url4]

## 授權
本專案屬於 GPL License，更多資訊請看 [LICENSE.md](LICENSE.md)

[ref_url1]:https://blog.csdn.net/u013119612/article/details/78758253
[ref_url2]:https://blog.csdn.net/UWA4D/article/details/77988888
[ref_url3]:https://blog.csdn.net/honey199396/article/details/78816793
[ref_url4]:https://github.com/sugky7302/behaviourtree.lua
