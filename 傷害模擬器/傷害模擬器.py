from tkinter import *
from tkinter import ttk
from tkinter import scrolledtext

_VERSION = '0.1.0'

# python無法先聲明後定義

# 創建主視窗
window = Tk()
window.title("傷害模擬器 " + _VERSION)

# 第一列 傷害類型
attackTypeLabel = ttk.Label(window, text = "傷害類型：")
attackTypeLabel.grid(column = 0, row = 0)
physicalAttackType = IntVar()
physicalAttack = Checkbutton(window, text = "物理", variable = physicalAttackType)
physicalAttack.deselect()
physicalAttack.grid(column = 1, row = 0)
magicAttackType = IntVar()
magicAttack = Checkbutton(window, text = "法術", variable = magicAttackType)
magicAttack.deselect()
magicAttack.grid(column = 2, row = 0)

# 第二列 基礎傷害
basicDamageLabel = ttk.Label(window, text = "基礎傷害：")
basicDamageLabel.grid(column = 0, row = 1)
minBasicDamageValue = StringVar()
minBasicDamage = ttk.Entry(window, width = 4, textvariable = minBasicDamageValue)
minBasicDamage.grid(column = 1, row = 1)
separationInBasicDamage = ttk.Label(window, text = "~")
separationInBasicDamage.grid(column = 2, row = 1)
maxBasicDamageValue = StringVar()
maxBasicDamage = ttk.Entry(window, width = 4, textvariable = maxBasicDamageValue)
maxBasicDamage.grid(column = 3, row = 1)

# 第三列 額外傷害
extraDamageLabel = ttk.Label(window, text = "額外傷害：")
extraDamageLabel.grid(column = 0, row = 2)
extraDamageValue = StringVar()
extraDamage = ttk.Entry(window, width = 4, textvariable = extraDamageValue)
extraDamage.grid(column = 1, row = 2)

# 第四行 分成兩部分標示
physicalAttributeLabel = ttk.Label(window, text = "物理", foreground = 'blue')
physicalAttributeLabel.grid(column = 0, row = 3)
magicAttributeLabel = ttk.Label(window, text = "法術", foreground = 'blue')
magicAttributeLabel.grid(column = 2, row = 3)

# 第五到六行 各傷害類型屬性
targetBodyTypeLabel = ttk.Label(window, text = "目標體型：")
targetBodyTypeLabel.grid(column = 0, row = 4)
targetBodyTypeValue = StringVar()
targetBodyType = ttk.Combobox(window, width = 4, textvariable = targetBodyTypeValue)
targetBodyType['values'] = ("小", "中", "大")
targetBodyType.grid(column = 1, row = 4)
targetBodyType.current(0)
attackerBodyTypeLabel = ttk.Label(window, text = "攻擊者體型：")
attackerBodyTypeLabel.grid(column = 0, row = 5)
attackerBodyTypeValue = StringVar()
attackerBodyType = ttk.Combobox(window, width = 4, textvariable = attackerBodyTypeValue)
attackerBodyType['values'] = ("小", "中", "大")
attackerBodyType.grid(column = 1, row = 5)
attackerBodyType.current(0)

skillCoefficientLabel = ttk.Label(window, text = "技能係數：")
skillCoefficientLabel.grid(column = 2, row = 4)
skillCoefficientValue = StringVar()
skillCoefficient = ttk.Entry(window, width = 4, textvariable = skillCoefficientValue)
skillCoefficient.grid(column = 3, row = 4)
spellPowerLabel = ttk.Label(window, text = "法術能量：")
spellPowerLabel.grid(column = 2, row = 5)
spellPowerValue = StringVar()
spellPower = ttk.Entry(window, width = 4, textvariable = spellPowerValue)
spellPower.grid(column = 3, row = 5)

# 第七行 各類增減傷

# 第七行 元素傷害
elementDamageLabel = ttk.Label(window, text = "元素傷害：")
elementDamageLabel.grid(column = 0, row = 6)
elementDamageValue = StringVar()
elementDamage = ttk.Entry(window, width = 4, textvariable = elementDamageValue)
elementDamage.grid(column = 1, row = 6)

# 第八行 元素增幅
elementRatioLabel = ttk.Label(window, text = "元素增幅：")
elementRatioLabel.grid(column = 0, row = 7)
elementRatioValue = StringVar()
elementRatio = ttk.Entry(window, width = 4, textvariable = elementRatioValue)
elementRatio.grid(column = 1, row = 7)

# 第九到十行 屬性修正
targetElementTypeLabel = ttk.Label(window, text = "目標屬性：")
targetElementTypeLabel.grid(column = 0, row = 8)
targetElementTypeValue = StringVar()
targetElementType = ttk.Combobox(window, width = 4, textvariable = targetElementTypeValue)
targetElementType['values'] = ("無", "地", "水", "火", "風")
targetElementType.grid(column = 1, row = 8)
targetElementType.current(0)
attackerElementTypeLabel = ttk.Label(window, text = "攻擊者屬性：")
attackerElementTypeLabel.grid(column = 0, row = 9)
attackerElementTypeValue = StringVar()
attackerElementType = ttk.Combobox(window, width = 4, textvariable = attackerElementTypeValue)
attackerElementType['values'] = ("無", "地", "水", "火", "風")
attackerElementType.grid(column = 1, row = 9)
attackerElementType.current(0)

# 第十行 計算結果
def CalculateAction():
    calculationLabel.config(text = "123")

calculationValue = StringVar()
calculation = ttk.Button(window, text = "計算", textvariable = calculationValue, command = CalculateAction)
calculation.grid(column = 3, row = 10)
calculationLabel = ttk.Label(window, text = "")
calculationLabel.grid(column = 1, row = 10)

# 顯示主視窗
window.mainloop()

# aLabel = ttk.Label(window, text = "abc")
# aLabel.grid(column = 0, row = 0)
# actionButton = ttk.Button(window, text = "Click Me!", command = ClickMe)
# actionButton.grid(column = 1, row = 1)
# name = StringVar()
# nameEntered = ttk.Entry(window, width = 12, textvariable = name)
# nameEntered.grid(column = 0, row = 1)