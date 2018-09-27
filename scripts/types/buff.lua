local cj = require 'jass.common'
local js = require 'jass_tool'
local BuffLibrary = require 'buffLibrary '
local Timer = require 'timer'
local Unit = require 'unit'
local setmetatable = setmetatable

local Buff = {}
local mt = {}
setmetatable(Buff,Buff)
Buff.__index = mt 

local GetObject, GetPreviousObject, GetNewObject = nil, nil, nil

function Buff:__call(unit, buffName)
  object = GetObject(unit, buffName)
  setmetatable(object, self)
  newObject.__index = Object
end

local function GetObject(unit, buffName)
  object = Buff[js.H2I(unit) .. ""][buffName] -- 確認之前有沒有相同的buff
  object = (object and GetPreviousObject(object) or GetNewObject(unit, buffName))
  return object
end

local function GetPreviousObject(object)
  if object.coverMode == 1 then
  elseif object.coverMode == 2 then
  elseif object.coverMode == 3 then
  elseif object.coverMode == 4 then
  end
end

local function GetNewObject(unit, buffName)
  object = {
    remaining = BuffLibrary[buffName].duration,
    coverMode = BuffLibrary[buffName].coverMode,
    layer = 1
  }
  Buff[js.H2I(unit) .. ""][buffName] = object
  return object
end

return Buff
