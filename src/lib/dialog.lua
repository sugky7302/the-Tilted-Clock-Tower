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
    }

    setmetatable(instance, self)

    return instance
end

function mt:Remove()
    self:Clear()
    
    cj.DialogDestroy(self.object_)

    self.object_ = nil
    self.owner_ = nil
    self = nil 
end

function mt:Clear()
    cj.DialogClear(self.object_)
    
    local pairs = pairs
    for key, btn in pairs(self) do 
        if (key ~= 'object_') and (key ~= 'owner_') then
            btn = nil
            self[key] = nil
        end
    end
end

-- label是索引，不填會預設為按鈕文字
function mt:AddButton(text, label, hotkey)
    local key = label or text
    self[key] = cj.DialogAddButton(self.object_, text, hotkey or 0)
end

function mt:FindButton(key)
    return self[key]
end

function mt:Show(is_show)
    cj.DialogDisplay(self.owner_.object_, self.object_, is_show)
end

function mt:SetTitle(title)
    cj.DialogSetMessage(self.object_, title)
end

return Dialog