local setmetatable = setmetatable
local cj = require 'jass.common'

local Dialog, mt = {}, {}
setmetatable(Dialog, Dialog)
Dialog.__index = mt

function Dialog:__call(player)
    local obj = {
        object = cj.DialogCreate(),
        owner = player,
        buttons = {},
    }
    setmetatable(obj, self)
    return obj
end

function mt:Insert(text, label, hotkey)
    self.buttons[label or text] = cj.DialogAddButton(self.object, text, hotkey or 0)
end

function mt:Erase(text)
    self.buttons[text] = nil
end

function mt:Find(text)
    return self.buttons[text]
end

function mt:Clear()
    cj.DialogClear(self.object)
    self.buttons = {}
end

function mt:Remove()
    cj.DialogDestroy(self.object)
    self = nil 
end

function mt:Show(isShow)
    cj.DialogDisplay(self.owner.object, self.object, isShow)
end

function mt:SetTitle(str)
    cj.DialogSetMessage(self.object, str)
end

return Dialog