Equipment : Item
需求:

- 可自定義行為
- 規範化顯示

單一職責: 處理裝備會用到的功能，如拾取、丟棄、使用會對英雄設定能力之類的事件。

成員:

- stackable_behavior: 堆疊效果
- level: 裝備等級
- prefix: 前綴
- attributes: 屬性表
- intensity: 精煉功能
- activate_behavior: 點擊效果
- extend_hole: 鑲環
- enchant: 附魔
- alchemy: 煉金術
- printer: 裝備資訊
- prefix: 詞綴

接口:

- getAttributes:
    - 輸入: X
    - 輸出: 屬性表
    - 說明: 本程序會回傳屬性表。
    - 隱藏細節: X
- getLevel:
    - 輸入: X
    - 輸出: 裝備等級
    - 說明: 本程序會回傳裝備的等級。
    - 隱藏細節: X
- getGearScore:
    - 輸入: X
    - 輸出: 裝備評分
    - 說明: 本程序會回傳計算後的評分。
    - 隱藏細節: X
- update:
    - 輸入: X
    - 輸出: X
    - 說明: 本程序會更新裝備資訊。
    - 隱藏細節:
        - 讓屬性排序
        - 重新設定詞綴
- print:
    - 輸入: X
    - 輸出: 裝備資訊
    - 說明: 本程序會回傳裝備的所有資訊文字。
    - 隱藏細節: 會使用printer規範格式。
- getName:
    - 輸入: X
    - 輸出: 裝備包含詞綴的名字
    - 說明: 本程序會回傳裝備的全名，並渲染顏色。
    - 隱藏細節: 會組合顏色、詞綴和名字。
- intensify:
    - 輸入: X
    - 輸出: 成功或失敗(布林值)
    - 說明: 本程序會調用intensity.invoke，最後會回傳成功或失敗。
    - 隱藏細節: intensity會做完整個動作，以解耦equipment和intensity。
- extendHole:
    - 輸入: X
    - 輸出: 成功或失敗(布林值)
    - 說明: 本程序會調用extend_hole.invoke，最後會回傳成功或失敗。
    - 隱藏細節: extend_hole會做完整個動作，以解耦equipment和extend_hole。
- enchanting:
    - 輸入: X
    - 輸出:  成功或失敗(布林值)
    - 說明: 本程序會調用enchant.invoke，最後會回傳成功或失敗。
    - 隱藏細節: enchent會做完整個動作，以解耦equipment和enchant。
- alcheming:
    - 輸入: X
    - 輸出: 成功或失敗(布林值)
    - 說明: 本程序會調用alchemy.invoke，最後會回傳成功或失敗。
    - 隱藏細節: alchemy會做完整個動作，以解耦equipment和alchemy。