-- 此module為item的子類別，專門處理秘物
-- 依賴
--   item.core


-- package
local require = require
local Item = require 'item.core'


local Secrets = require 'class'("Secrets", Item)

-- assert
local _GenerateAttributes

-- 秘物的 生命值 為秘物等級
function Secrets:_new(item)
    Item._new(self, item)

    AddAttributesToSecrets(self)
end

-- assert
local SECRETS_LIB = require 'secrets_lib'

AddAttributesToSecrets = function(self)
    self.attribute_ = {}

    if not SECRETS_LIB[self.id_] then
        return false
    end

    for name, val in pairs(SECRETS_LIB[self.id_]) do
        self.attribute_[name] = val
    end
end

function Secrets:set(name, val)
    -- Lua是短路判斷，因此可以連續判斷資料是否已經存在
    if (not SECRETS_LIB[self.id_]) or (not SECRETS_LIB[self.id_][name]) then
        -- 使用self:set的話會無限循環調用當前函數，無法調用Item:set函數，要這種寫法才能調用
        Item.set(self, name, val)

        return false
    end

    if not self.attribute_[name] then
        self.attribute_[name] = SECRETS_LIB[self.id_][name]
    end

    self.attribute_[name] = val
end

function Secrets:get(name)
    if (not SECRETS_LIB[self.id_]) or (not SECRETS_LIB[self.id_][name]) then
        return Item.get(self, name) or nil
    end

    -- 下一次取值就不用再設定一次
    if not self.attribute_[name] then
        self.attribute_[name] = SECRETS_LIB[self.id_][name]
    end

    return self.attribute_[name]
end

return Secrets