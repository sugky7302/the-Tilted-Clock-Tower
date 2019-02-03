-- 擴展並簡易化we的multiboard功能
-- (0, 0)是多面板的第一格，在最左上角
-- 依賴
--   jass.common


-- package
local require = require
local cj = require 'jass.common'

local Mb = require 'class'("Multiboard")
Mb._VERSION = "1.0.0"

-- assert
local GetItemKey, BoundColorValue

function Mb:_new(player, row, column)
        self._column_ = column or 0
        self._row_    = row or 0

        self.object_  = cj.CreateMultiboard()
        self.owner_   = player

    -- 設定框體大小
    -- 不使用參數是因為怕參數 = nil
    self:SetRow(self._row_)
    self:SetColumn(self._column_)
end

function Mb:_delete()
    self:Clear()
    
    cj.DestroyMultiboard(self.object_)
end

function Mb:Clear()
    cj.MultiboardClear(self.object_)
    
    self:SetColumn(0)
    self:SetRow(0)
end

-- 操作框體
function Mb:Show(is_show)
    -- 多面板顯示是對所有玩家，因此要用本地玩家指定只對當前玩家顯示
    if cj.GetLocaclPlayer() == self.owner_.object_ then
        cj.MultiboardDisplay(self.object_, is_show)
    end
end

function Mb:Minimize(is_minimize)
    cj.MuitlboardMinimize(self.object_, is_minimize)
end

-- 設定框體
function Mb:GetColumn()
    return self._column_
end

function Mb:SetColumn(new_column)
    self._column_ = new_column
    cj.MultiboardSetColumnCount(self.object_, new_column)
end

function Mb:GetRow()
    return self._row_
end

function Mb:SetRow(new_row)
    self._row_ = new_row
    cj.MultiboardSetRowCount(self.object_, new_row)
end

function Mb:SetTitle(title)
    cj.MultiboardSetTitleText(self.object_, title)
end

function Mb:SetTitleColor(r, g, b, alpha)
    r, g, b, alpha = BoundColorValue(r, g, b, alpha)
    cj.MultiboardSetTitleTextColor(self.object_, r, g, b, alpha)
end

function Mb:SetStyle(show_text, show_icon)
    cj.MultiboardSetItemsStyle(self.object_, show_text, show_icon)
end

-- 根據螢幕寬度設定比例
function Mb:SetWidth(ratio_for_screen)
    cj.MultiboardSetItemsWidth(self.object_, ratio_for_screen)
end

function Mb:SetIcon(icon_path)
    cj.MultiboardSetItemsIcon(self.object_, icon_path)
end

-- 設定多面板項目
function Mb:AddItem(row, column, text, scale_for_screen)
    local item = cj.MultiboardGetItem(self.object_, row, column)
    
    local key = GetItemKey(row, column)
    self[key] = item

    cj.MultiboardSetItemValue(item, text)
    cj.MultiboardSetItemWidth(item, scale_for_screen)

    return self[key]
end

function Mb:RemoveItem(row, column)
    local key = GetItemKey(row, column)
    cj.MultiboardReleaseItem(self[key])
    self[key] = nil
end

function Mb:SetItemText(row, column, text)
    local key = GetItemKey(row, column)
    cj.MultiboardSetItemValue(self[key], text)
end

function Mb:SetItemWidth(row, column, scale_for_screen)
    local key = GetItemKey(row, column)
    cj.MultiboardSetItemWidth(self[key], scale_for_screen)
end

function Mb:SetItemColor(row, column, r, g, b, alpha)
    local key = GetItemKey(row, column)

    r, g, b, alpha = BoundColorValue(r, g, b, alpha)
    cj.MultiboardSetItemValueColor(self[key], r, g, b, alpha)
end

GetItemKey = function(row, column)
    return table.concat({row, "-", column})
end

BoundColorValue = function(r, g, b, alpha)
    -- 賦予初始值
    r, g, b, alpha = r or 0, g or 0, b or 0, alpha or 255
    
    -- 參數的值只在[0, 255]
    local BoundValue = require 'math_lib'.BoundValue
    r     = BoundValue(0,     r, 255)
    g     = BoundValue(0,     g, 255)
    b     = BoundValue(0,     b, 255)
    alpha = BoundValue(0, alpha, 255)

    return r, g, b, alpha
end

return Mb