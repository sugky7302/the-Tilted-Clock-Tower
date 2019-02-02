-- 擴展並簡易化we的dialog功能
-- 依賴
--   jass.common
-- API
--   Clear : 清空對話框所有按鈕
--   AddButton(text, label, hotkey) : 添加按鈕到對話框
--   FindButton(key) : 搜尋按鈕並返回它
--   Show(is_show) : 是否顯示對話框
--   SetTitle(title) : 設定標題

-- package
local require = require
local cj = require 'jass.common'

local Dialog = require 'class'("Dialog")
Dialog._VERSION = "1.0.0"

function Dialog:_new(player)
    self.object_ = cj.DialogCreate()
    self.owner_ = player
end

function Dialog:_delete()
    self:Clear()
    
    cj.DialogDestroy(self.object_)
end

function Dialog:Clear()
    cj.DialogClear(self.object_)
    
    for key, btn in pairs(self) do 
        if (key ~= 'object_') and (key ~= 'owner_') then
            btn = nil
            self[key] = nil
        end
    end
end

-- label是索引，不填會預設為按鈕文字
function Dialog:AddButton(text, label, hotkey)
    local key = label or text
    self[key] = cj.DialogAddButton(self.object_, text, hotkey or 0)
end

function Dialog:FindButton(key)
    return self[key]
end

function Dialog:Show(is_show)
    cj.DialogDisplay(self.owner_.object_, self.object_, is_show)
end

function Dialog:SetTitle(title)
    cj.DialogSetMessage(self.object_, title)
end

return Dialog