-- 此module是擴展並簡易化we的dialog功能

local setmetatable = setmetatable

local cj = require 'jass.common'

local Dialog, mt = {}, {}
setmetatable(Dialog, Dialog)
Dialog.__index = mt

function Dialog:__call(player)
    local instance = {
        object_ = cj.DialogCreate(),
        owner_ = player,
        buttons_ = {},
    }

    setmetatable(instance, self)

    return instance
end

function mt:Remove()
    self:Clear()
    
    cj.DialogDestroy(self.object_)

    self.object_ = nil
    self.owner_ = nil
    self.buttons = nil
    self = nil 
end

function mt:Clear()
    cj.DialogClear(self.object_)
    self.buttons_ = {}
end

-- label是索引，不填會預設為按鈕文字
function mt:AddButton(text, label, hotkey)
    local key = label or text
    self.buttons_[key] = cj.DialogAddButton(self.object_, text, hotkey or 0)
end

function mt:FindButton(key)
    return self.buttons_[key]
end

function mt:Show(is_show)
    cj.DialogDisplay(self.owner_.object, self.object_, is_show)
end

function mt:SetTitle(title)
    cj.DialogSetMessage(self.object_, title)
end

return Dialog