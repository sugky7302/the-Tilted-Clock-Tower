# 更新日誌
## 0.31.4 - 2018-12-01
### Changed:
- 替每個版本號添加git版本連結。
- 重構point。
- 重構event。
- 重構game。
- 重構polygon。
- 重構region。

## [0.31.3] - 2018-11-30
### Changed:
- 測試完timer。
- 重構並分離group。
- 重構dialog。
- 重構trigger。

## [0.31.2] - 2018-11-29
### Changed:
- 重構timer，並分離成兩個模組。

## [0.31.1] - 2018-11-28
### Changed:
- 重構list，分成core跟iterator。
- custom_tool，更名成pairs_by_key，目的是解決pairs無序的問題。
### Removed:
- quick_sort沒有使用到，因此刪除。

## [0.31.0] - 2018-11-26
### Added:
- 新增OUTLINE.md，記錄重構的文件有哪些。
### Changed:
- 按照python的package、module的分法，重新整理scripts，詳見README.md。
- 把更新日誌獨立成CHANGELOG.md，縮短README.md的長度。
- documents資料夾更名為docs。
- scripts資料夾更名為src。
### Removed:
- 刪除object。
- 刪除new.j。

## [0.30.0] - 2018-11-21
### Added:
- [base] 新增Map//quests路徑。
- [item] 添加週期刪除物品函數，對於書類及神符類都能正確刪除物品，不然這兩類只是模型縮小而已。
### Fixed:
- [attribute] 修正物理攻擊力的公式，使其顯示正確。
- [combine] 修正"單位-發動技能效果"事件會導致getUnitTypeId崩潰的問題。
- [damage] 修正添加物理攻擊力後，最小/最大物理攻擊力不會改變的問題。
- [dectect_recipe] 修正"玩家-對話框被點擊"事件無法獲取self的問題。
- [enchanted] 修正秘物附魔在無空的秘環的裝備上，不會返還次數的問題。
- [hero] 修正"單位-使用物品"事件會獲取不到單位而導致getUnitName崩潰的問題。
- [hero] 修正_StackItem函數在使用cj.RemoveItem無法徹底刪除物品的問題。
- [hero] 修正"單位-準備施放技能"事件，獲取技能的索引太繁雜的問題。
- [item] 修正對使用後消失的物品設定數量從0到1，不會創建物品的問題。
- [jass_tool] 修正觸發"單位-發動技能效果"事件時，lua會告知U2Id內的GetUnitTypeId崩潰。
- [math_lib] 修正Random函數遇到參數非整數時會報錯的問題。
- [player] 修正由於沒有require game，導致EventDispatch函數無法獲取self的問題。
- [polygon] 修正In的if-else函數沒有寫上end(L45)的問題。
- [region] 修正沒有require game，使得Init函數無法獲得game的問題。
- [timer] 修正SetRemaining會使exection一直註冊條件，使得exection會出現冗餘的if-else的問題。

## [0.29.0] - 2018-11-20
### Added:
- 新增drop_list庫，儲存單位掉落的物品類型。
- [unit] 新增"單位-掉落物品"事件。
### Fixed:
- [damage] 修正MathLib.Random()只產生{0, 1}，導致命中判定不正確的問題。
- [hero] 修正拾取裝備卻無法獲得屬性的問題。

## [0.28.0] - 2018-11-19
### Added:
- 新增polygon庫，用於處理多邊形，例如區域。
- [unit] 添加Event、EventDispatch函數。注意，Event的第一個參數self指的是"trigger"，不是EventDispatch呼叫的那個東西。
- [hero] 調整事件觸發。
### Fixed:
- [hero] 修正"單位-創建"，會註冊多個相同觸發，導致EventDispatch調用冗餘的問題。
- [hero] 修正'獲得物品'事件，string_sub有時會無法獲取itemName的問題。
- [quest] 修正檔名錯誤，導致無法讀取任務的問題。
- [quest] 修正還未達到要求數量，任務就會完成的問題。
### Bug:
- [jass_tool] 施放技能時，lua會告知U2Id內的GetUnitTypeId崩潰。
- [missile] 某些地形投射物的軌跡會變形。

## [0.27.0] - 2018-11-12
### Added:
- 完成**領取物資**3環任務。
### Changed:
- [equipment] 修改裝備顯示樣式。

## [0.26.0] - 2018-11-11
### Added:
- 新增**領取物資**任務。

## [0.25.0] - 2018-11-10
### Added:
- 完成訓練營地形。
- 新增equipment_database，用於儲存商店的裝備的數據。
- [attribute_database] 完善敘述。
- [equipment] 新增固定屬性及非固定屬性，後者可以被拆除，但前者無法。
- [quest] 添加搜尋型任務的功能。
### Changed:
- [damage] 修改元素傷害公式。
- [equipment] 修正固定屬性也會顯示詞綴的問題。
### Deprecated:
- intensify 或 extend_hole某個模塊會導致死亡面罩的屬性複製給能量之書。
### Fixed:
- [prefix] 修正沒有屬性時，也會設定前綴的問題。

## [0.24.0] - 2018-11-03
### Added:
- [buff] 新增冰凍效果。
- [item] 添加"單位-物品掉落'事件。
### Changed:
- [霜之環] 移除霜之環的定身效果的特效，以免和冰東效果衝突。
### Fixed:
- [buff] 修改暈眩效果。

## [0.23.0] - 2018-11-02
### Fixed:
- [quest] 完善庫。
- [quest] 修正無法正確完成任務的問題。
- [quest] 修正非任務單位死亡觸發"任務-更新"事件，會產生Nil的問題。
- [quest] 修正任務可能無法完成的問題。

## [0.22.0] - 2018-11-01
### Added:
- 新增quest庫，用於任務系統。
- [pet] 新增remove函數，用於刪除死亡的寵物。
- [unit] 添加IsAlive函數，判斷是否存活。
- [冰霜秘術師] 新增**天賦-冬之蕭瑟**，水元素現在會模仿英雄施放寒冰箭、暴風雪。
### Changed:
- 更改目錄，將talents、buffs放入maps目錄底下，item放入module目錄底下。
### Fixed:
- [hero] 修復英雄復活後，會被一擊必殺的問題。
- [冰霜秘術師] 修正冰霜長矛天賦無法觸發的問題。
- [冰霜秘術師] 修正寒冰箭施放時，冰晶不會消失的問題。

## [0.21.0] - 2018-10-31
### Added:
- [buff] 新增多層buff的說明。
- [unit] 新增event、eventdispatch、talentdispatch函數。
- [trace_lib] 新增環繞函數。
- [冰霜秘術師] 新增**天賦-嚴寒壓境**，寒冰箭的施放距離提高30%。
- [冰霜秘術師] 新增**天賦-冰晶**。
- [冰霜秘術師] 新增**天賦-冰雪壓境**，暴風雪的施放距離提高40%。
- [冰霜秘術師] 新增**天賦-霜雪暴**，暴風雪的施放距離提高30%。
### Changed:
- [talent] 將eventdispatch函數放進unit庫。
### Fixed:
- 修正由於嚴寒壓境和冰霜長矛的命令ID相同，導致學習寒冰碎片時，實際上是學習冰槍術的問題。
- [attribute] 修正add、set函數在獲取設定好初始值的屬性時，會因為無法讀到百分比屬性而發生錯誤的問題。
- [damage] 修正施放法術有機會觸發*傷害事件*，導致跳出2個傷害的問題。
- [damage] 修正造成傷害時會觸發*傷害事件*，導致跳出2個傷害的問題。
- [hero] 修正死亡後技能不會中斷的問題。
- [missile] 修正remove函數會導致計時器無法執行的問題。
- [skill] 修正updatetip函數只能更新有傷害值的技能數據的問題。

## [0.20.0] - 2018-10-30
### Added:
- 新增talent資料夾，儲存各個天賦。
- 新增talent庫，讓玩家能夠像heros of the storm一樣選擇自己想要的天賦。
- [冰霜秘術師] 新增**天賦-冰晶裂片**，寒冰箭現在會穿透擊中的第一名敵人並對其身後的額外一名敵人造成傷害。
- [冰霜秘術師] 新增**天賦-冰霜長矛**，寒冰箭擊中冰凍目標後，下一次的冷卻時間縮短2秒。
### Changed:
- [damage] 移除"必擊中"屬性。
- [group] 調整判斷忽略單位的生效位置，從*執行動作*函數改到*搜尋單位*函數。
- [霜之環] 移除模型。
- [召喚水元素] 更換模型。
### Fixed:
- [damage] 修正霜寒刺骨會加成普通攻擊的問題。
- [missile] 修正單位組不清空舊有單位，導致擊中判斷不正確的問題。

## [0.19.0] - 2018-10-29
### Added:
- 新增attribute，將unit內設定屬性的函數全部獨立成一個檔案管理，有效減少unit的結構大小。
- [buff資料夾] 新增init函數，用於初始化效果。
- [buff資料夾] 新增**定身**、**暈眩**、**減速**、**減攻速**、**沉默**、**繳械**、**束縛**效果。
- [hero] 新增專長技能函數。
- [unit] 新增removebuff函數，用於移除buff。
- [unit] 新增abilityEnable、abilityDisable函數，提供啟用/禁用單位的技能。
- [冰霜秘術師] 新增專長-霜寒刺骨。
### Changed:
- 更換寒冰箭和暴風雪的模型。
- [hero] 將屬性初始化放入attribute。
- [skill] 將callevent函數改成結構函數，使得skill對象在外部也能調用。
### Fixed:
- [buff] 修正獲取剩餘時間會獲取不到timer的問題。
- [buff] 修正remove函數內的invalid太早設定，導致_CallEvent無法執行on_remove函數的問題。
- [hero] 修正"單位-準備施放技能"函數若無目標單位，會使得結構判斷成未註冊的單位進行註冊，進而導致"專長"獲取不正確的問題。
- [unit] 根據上條，為防止空單位也會註冊，修正註冊函數，判定空單位直接跳出。
- [霜之環] 修正沒有定身效果的問題。

## [0.18.0] - 2018-10-28
### Added:
- 新增buff庫，可以設定/調用所有buff、debuff效果。
### Changed:
- [Effect資料夾] 更名為Buff資料夾，儲存遊戲內所有buff/debuff效果。

## [0.17.0] - 2018-10-26
### Added:
- 新增shield庫。
- 新增pet庫，專門對召喚物作處理。
- 新增技能熟練度系統。
- [jass_tool] 新增TimeEffect函數，用於延遲刪除效果。
- [skill] 新增UpdateName、UpdateTip函數，針對技能熟練度系統作準備。
- [skill] 新增技能熟練度提示。
- [冰霜秘術師] 開放技能-召喚水元素，專長-霜寒刺骨。
### Changed:
- [damage] 現在會自動捕捉技能傷害跟觸發係數。
### Fixed:
- [skill] 修正連續施放技能，前一個技能不會被打斷的問題。

## [0.16.0] - 2018-10-25
### Added:
- [group] 新增ignoreUnits變量，儲存已經被傷害過的單位。
- [group] 根據上條更新，loop現在會忽略ignoreUnits裡的單位。
- [jass_tool] 新增Sound函數，目前用於技能音效。
- [point] 新增angle函數，用於計算角度。
- [冰霜秘術師] 開放技能-寒冰箭、霜之環。
### Changed:
- [point] 原angle函數改名為rad函數，以符合它的功能。
### Fixed:
- [missile] 修正投射物出射方向只能水平的問題。
- [missile] 修正hitMode不起作用的問題。
- [point] 修正rotate函數換算錯誤的問題。
- [冰霜秘術師] 修正由於寒冰箭的**施法持續時間**及**動作持續時間**沒有超過施法動作播一次的時間，而導致動畫播放不出來的問題。

## [0.15.0] - 2018-10-24
### Added:
- 新增bar庫，將castbar的核心功能摘出來，為之後的狀態條作準備。
- [skill] 完善施法階段。
- [skill] 新增打斷階段。
- [skill] 新增定身施法，施法光環會隨秒數縮放。
- [skill] 新增多重施法。
### Fixed:
- [list] 修正erase函數的popback無參數的問題。
- [skill] 修正由於[座標誤差][coordinate_error]而導致施法光環模型無法正確顯示在施法者腳下的問題。
- [skill] 修正多重施法時，某次觸發可能會獲取到轉身速度設定為0的數值，而導致多重施法結束後，角色無法轉身的問題。
- [skill] 修正多重施法提示文字無法顯示的問題，但目前仍未解決文字會莫名跳動的問題。
- [timer] 修正計時器在失效後，依舊會調用動作的問題。

## [0.14.0] - 2018-10-23
### Added:
- 新增castbar庫，生成施法條。
- [damage] 考慮到某些技能需要必中，因此新增"mustHit"參數。
- [hero] 新增模板函數，用於解析英雄模板。
- [hero] 新增"準備施放技能"及"發布命令"事件、create函數。
- [point] 新增GetLoc函數，能獲取jass點結構的point。
- [skill] 將技能區分成cast、channel、shot、finish四個階段，實際功能還在實作。
- [texttag] 新增break函數，使漂浮文字在某些情況下可以主動消失。
### Changed:
- [珍娜] 修改成"冰霜秘術師"，使其能讓hero調用。
### Fixed:
- [damage] 修正獲取元素傷害錯誤的問題。
- [暴風雪] 修正暴風雪獲取單位組內單位錯誤的問題。

## [0.13.0] - 2018-10-22
### Added:
- 新增smallSecretOrder、bigSecretOrder庫，但秘物序列還沒進行測試。
- 新增combine庫，用於低級材料轉換成高級材料。
- [item] 新增set、get、add函數，並優化相關函數。
- [jass_tool] 新增item2id、item2str函數，讓物品能夠直接獲得整數或字串名。
### Changed:
- [damage] 優化造成傷害函數。
- [detect_recipe] 調整結構。
### Fixed:
- [enchanted] 修正相同屬性的秘物可以用在同一件裝備的問題。

## [0.12.0] - 2018-10-21
### Added:
- 新增attribute資料庫，儲存屬性、描述文字、裝備評分。
- 新增combine資料庫，儲存材料合成公式。
- 新增extend_hole、intensify庫，完善物品核心系統。
- 新增intensify資料庫，儲存精鍊後可提升的屬性。
- 新增prefix資料庫, 儲存詞綴。
- 新增recipe資料庫，儲存配方。
- 新增secret資料庫，儲存秘物屬性。
- [equipment] 新增獲取裝備評分的函數。
- [equipment] 對話框新增裝備評分。
- [Item資料夾] 新增init，將裝備的核心系統放在同個地方初始化。
- [Tool資料夾] 新增init，將類型的初始化函數合併調用。
- [Type資料夾] 新增init，將類型的初始化函數合併調用。
### Changed:
- [add_recipe] 配方的材料數量可設定成任意，不再侷限為1個。
- [detect_recipe] 根據add_recipe而做調整。
- [dialog] insert函數新增label參數，不再將標籤和按鈕文字綁定。
### Fixed:
- [enchanted] 修正顯示裝備框也會觸發附魔的使用物品事件。
- [equipment] 修正_RandRingCount函數只會生成最低孔數及最高孔數的問題。
- [player] 修正add函數算符錯誤，導致exten_hole扣除金額時變成增加的問題。
- [secrets] 修正_GenerateAttributes函數無法給secrets對象數據，導致附魔錯誤的問題。

## [0.11.0] - 2018-10-20
### Added:
- 新增database資料夾，儲存各類型需要的模板。
- 新增secrets_database、attribute_database庫，提供物品需要的數據。
- 新增item、enchanted、equipment、secrets庫，完成附魔功能。
- 新增player庫，設定玩家專有的函數。
- 新增order_id庫，用於將命令轉成編輯器認識的id編碼。
- 新增dialog庫，用於裝備顯示框。
- [damage] 新增混合傷害，可自行設定物法比例。
- [enchanted] 新增init函數，專門呼叫附魔函數。
- [hero] 新增物品、發動技能效果事件。
- [main] 新增部分初始化函數。
- [skill] 完善發布命令事件。
- [unit] 新增增強物理攻擊力來獲得面板的綠字攻擊。
- [unit] 修正set函數會根據 name 自動生成 name% 屬性的問題。
### Changed:
- [damage] 根據混合傷害的需要，調整獲取物理攻擊力、法術攻擊力、物理護甲、法術護甲的觸發。
- [equipment] 改成對話框顯示。
- [hero] 註冊事件改為map呼叫。
- [main] 調整初始化順序。
- [map] 調用模塊改由該函數呼叫。
- [unit] 註冊事件改為map呼叫。
- [Database資料夾] 調整所有database的呼叫方式，改為全域變量。
### Fixed:
- [combat] 修正復活後的怪物會無法扣除傷害觸發內的暫時生命值的問題。
- [damage] 修正傷害文字和實際傷害值不符的問題。
### Removed:
- [equipment] 由於物品數據是類型一起更改，無法達到單件物品專門修改的效果，因此刪除此功能。

## [0.10.0] - 2018-10-19
### Added:
- 新增damage庫。
- 新增unit庫，為單位註冊結構。
- 新增hero庫，繼承unit庫，並添加英雄特有屬性及函數。
- 新增math_lib庫，補充lua的math庫沒有的函數。
- [unit] 新增獲取物理攻擊力的函數。
### Changed:
- [map] "單位-創建"事件移動到unit庫統一執行。
### Fixed:
- 修改更新日誌日期錯誤的問題。
- [combat] 修正"顯示傷害"觸發無法正確獲得傷害值且無法對目標造成自定義傷害的問題。
- [unit] 修正存取物理攻擊力會出現錯誤的問題。
### Removed:
- 移除general_bonus_system庫，改用japi。

## [0.9.1] - 2018-10-18
### Added:
- 新增buff庫，執行所有增益/減益/持續傷害等效果。
- 新增skill庫，設計技能工具。
- 新增map庫，統籌執行遊戲內機制。
- 新增hero庫，設定英雄屬性或技能。
### Changed:
- [buff] icon更名為art。
- [combat] 移動到map庫統一執行。
- [game] 移動到map庫統一執行。
- [recipe] 修改product，能儲存多種產品。運用隨機數讀取隨機一種產品，用於材料賭博相關方面，由《超神機械師》參考而來。

## [0.9.0] - 2018-10-10
### Added:
- 新增trigger庫。參照moe-master 2.1和javascript的自定義事件，理解原理再根據需求修改。
- 新增event庫，同上理由。
- 新增game庫，用於註冊遊戲內所有系統、事件。
- [timer] 新增clock函數，獲取遊戲開始到調用的時間。
### Changed:
- System資料夾名改成Maps。
- [combat] 根據trigger和event庫，重寫觸發函數。
### Fixed:
- [combat] 修正漂浮文字與攻擊動畫不同步的問題。
- [event] 修正.__call無法讀取eventName的問題。
- [trigger] 修正沒有將回調函數添加進事件佇列的問題。

## [0.8.0] - 2018-10-09 - 重新更名回README
### Added:
- 新增queue。
- [base] 新增Debug模式。
- [combat] 添加單位被攻擊後顯示戰鬥文字的觸發。
- [group] 添加新的判斷條件IsHero、IsNonHero。
### Changed:
- [jass_tool] 調整debug函數只能在debug模式下才能顯示。
- [timer] 參照moe-master 2.1重寫timer，改成中心計時器。
### Fixed:
- 名字改回README，github才能顯示這個更新日誌。
- 原README改成lua使用說明。
- [api] timer重寫後，trigger能夠正確觸發。

## [0.7.0] - 2018-10-08
### Added:
- 新增missile_tool庫，將missile的工具獨立出來。
- 新增trace_lib庫，將missile的彈道庫獨立出來。
- [test] 新增missile的測試。
### Changed:
- [missile] 將missile_tool的angle改成初始設定，之後missile要做弧形軌跡，就直接更改obj.angle。
### Fixed:
- 在war3map.j的main函數內直接調用base.lua，防止使用YDWE的觸發編輯器後儲存，會無法調用base.lua的問題。
- [array] 修正由於array.__index=array會導致group的unitDetermined重複呼叫array的問題。
- [array] 修正Remove函數，使IsEmpty函數可以正確獲得self.size。
- [group] 修正Clear函數，使其功能單一化，不再和Remove重疊。
- [missile_tool] 由於SetUnitX、SetUnitY無法對移動速度=0的單位執行動作，因此改成SetUnitPosition。
- [missile_tool] 修正Move函數一直計算angle，導致Pass型投射物無法移動到最大距離的問題。
- [missile_tool] 根據下條錯誤，修正SetHeight獲取錯誤高度，導致條件判斷會使得missile還沒設定timer時就刪除timer的問題。
- [point] 修正+-*/會覆蓋舊point，使得Distance函數計算=0，進而導致missile_tool的_GetSlope函數會出現nan(ind)的問題。

## [0.6.1] - 2018-10-07
### Fixed:
- [timer] 修正Remove函數不會暫停計時器，可能會一直執行的問題。

## [0.6.0] - 2018-10-06
### Added:
- 新增add_recipe、detect_recipe(未測試)庫。
- [object] 新增Insert、Sort函數。
- [test] 新增group和add_recipe的測試。
### Changed:
- 根據**程式碼撰寫規則**重審所有程式碼，並測試部分程式碼。

## [0.5.0] - 2018-10-05 - 更名為CHANGELOG
### Added:
- 新增紅黑樹，但「刪除」動作尚未完成。

## [0.4.0] - 2018-10-04 - 純vscode作圖
### Added:
- 新增test，用於測試程式碼。
- [texttag] 將原先texttag的戰鬥漂浮文字獨立成text_to_attch_unit模塊。
### Changed:
- 利用[魔獸吧裡面有人提出的vscode問題][actboy168-lua-debug]完成了之前一直想用vscode直接作圖的功能。
- [texttag] 將原先的戰鬥漂浮文字功能拆解成獨立模塊，核心只提供固定漂浮文字功能。
### Fixed:
- [texttag] 修正由於字體過大導致遊戲內看不見漂浮文字的問題。

## [0.3.0] - 2018-10-01
### Added:
- 新增combat，處理戰鬥相關的事件。
### Changed:
- [texttag] 不再提供自訂字體大小，改為自訂縮放倍率。
### Removed:
- [texttag] 移除可自訂顯示漂浮文字的功能，目前改為統一顯示。
### Fixed:
- [list] 修正Iterator()讀到tail.next時，會因為node的setmetatable(node).__index=node而產生錯誤的問題。
- [texttag] 修正RunTimer內由於list:Iterator()而產生的問題。
- [texttag] 修正由於SetTexttag設定錯誤導致漂浮文字無法顯示的問題。

## [0.2.0] - 2018-09-29
### Added:
- 新增node，用於list。
- 新增list，用於texttag。
- 新增array，用於group。
- 新增texttag。
- [timer] 新增Pause函數。
### Changed:
- [group] 用array重寫部分函數。
### Fixed:
- [custom_tool] 修正匿名函數內含 ']]' 導致遊戲無法執行的問題。
- [point] 修正建構函數，使point作運算時，不會再出現遊戲當機的問題。
- [timer] 修正對象無法呼叫Pause的問題。

## [0.1.1] - 2018-09-27 - 開發
### Changed:
- 將外部腳本寫進地圖內，防止YDWE讀不到。

## [0.1.0] - 2018-07-06 - 啟動ChangeLog
### Goal:
- 將所有腳本的更新都集中撰寫，方便日後檢查、維護。
- 按日期降序排列，方便檢視最新的更新。
- 類別按照字母排列。
### Added:
- 新增快速排序(quicksort)演算法。

[actboy168-lua-debug]:https://tieba.baidu.com/p/5902146836
[coordinate_error]:https://tieba.baidu.com/p/5773334779?pid=120570865697&cid=0&red_tag=1133617129#120570865697

[0.31.3]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/8d705f75fa4bc0bba582ced04a63d009283706bf
[0.31.2]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/f7d7a595081d9f13b7d6630f727015d2325f8cd7
[0.31.1]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/0de580579a487d0cca89dbc3225c77c9f1d4edb5
[0.31.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/6ed8a7066393bf1b291d1901332ce6d669544f74
[0.30.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/547fdeb4d0184c8b433b19ab54a1e6cfe86adad8
[0.29.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/f67d293fc513ba9417d8d666e69861de0a4a8472
[0.28.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/c4b6584a08e6a096f29a8c4acefa98e395dc1f65
[0.27.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/6c0d41df8ea0e04f84384ef0a9e490653d78b536
[0.26.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/6c0d41df8ea0e04f84384ef0a9e490653d78b536
[0.25.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/6c0d41df8ea0e04f84384ef0a9e490653d78b536
[0.24.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/3bf9a3684adca59c50f93ecc6470c464a0b329fc
[0.23.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/4e1befe74a6436e71944b7ec175e345023cbc3de
[0.22.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/acb3702ba188aeeba4f561f0e0e9ecca212e61e8
[0.21.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/ec64bf30b9c8003b762142960fc0ec934cd88f41
[0.20.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/b7e0bbbe90aadf5033ef5946bc02a7ec56b03864
[0.19.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/b01a20b8cd1e173445e14542ecb83bbc5635e8e4
[0.18.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/e27001f178c3a32ea7cd6ac70b771da500e3f86c
[0.17.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/bd3c38a0e36d4902fcd55515dbfdd347b752eef1
[0.16.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/f296637a13ae98c3c261ea861eddbe4adf59dc28
[0.15.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/8200cdf854b6c157d54210413d565bbab91daee0
[0.14.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/24f37725119df7a75c1c70b7a4ff2506b1cbba1c
[0.13.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/5182e0747ee51b0d677acff1df2465f204bc6e13
[0.12.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/abadd348e45f3b5e962031a81c87524f6445171f
[0.11.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/a11b6d9647e589f7abe8974d15d2475377f8ff2a
[0.10.0]:https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/418eb1acb3add779ecb1d1d0a336a5087323ddac
[0.9.1] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/e9f9329e3de4de4c181048e1ac5eaf205d3e8bdb
[0.9.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/8802052739c32a80c48c5aa114ca29e7dc4f70b9
[0.8.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/f20b9948fc90b4514128a9154970869953adc34a
[0.7.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/59f0cd6dc685cd8419bd68c647d6d7ef21dbb2d8
[0.6.1] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/6f2da005e378697a095f33346ec7ba2af74cdd08
[0.6.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/6f2da005e378697a095f33346ec7ba2af74cdd08
[0.5.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/ec3e5a98dc8a5d6176fe39eeca3eb8a7985a9291
[0.4.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/af30d9215a7e0265cbb6562f0cff86c66868778a
[0.3.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/434371820ce88be522cd0b2f41a5a2cb97f887d8
[0.2.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/63c6f063208896d6ca19fccbefbc9b9d05aec106
[0.1.1] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/4ec8da80ac520ebd9d8a99a2ad768fdccc01c608
[0.1.0] :https://github.com/sugky7302/the-Tilted-Clock-Tower/commit/3171a30af526c25bd858956c8fbaa9c669115964
