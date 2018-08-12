local cj = require 'jass.common'
local unit = require 'unit'
local texttag = require 'texttag'

local damage = {}
setmetatable(damage,damage)

local function DealDamage(v)
  if cj.GetUnitState(v.target,cj.UNIT_STATE_LIFE) <= v.damage then
     cj.KillUnit(v.target)
  else
    cj.SetUnitState(v.target,cj.UNIT_STATE_LIFE, cj.GetUnitState(v.target,cj.UNIT_STATE_LIFE) - v.damage)
  end
end

function damage:__call(v)
  local u = unit(v.source)
  local u1 = unit(v.target)
  v.damage = v.damage * v.bonus_a + v.bonus_b
  if v.type == '物理' then
    if u:pnt_rate() then -- 考慮穿透&閃避後的傷害判定
      if u:pnt() - u:dge() < 0 then -- 穿透後對閃避判定
        v.damage = v.damage * u:rst('物理') * u:blk() * u1:race_rst(u['種族']) - u:amr() -- 沒觸發穿透，因此計算減傷過後的傷害量
      end
    else -- 沒穿透後對閃避判定
      if u:dge_rate() then
        v.damage = 0 -- 觸發閃避後，傷害=0
      else
        v.damage = v.damage * u:rst('物理') * u:blk() * u1:race_rst(u['種族']) - u:amr()
      end
    end
    texttag:combat_word(v.target, v.damage, 1, '物理')
  elseif v.type == '法術' then
    u['額外法術傷害'] = 0 -- 清空額外傷害，以免二次使用
    if u:pnt_rate() then -- 考慮穿透&閃避後的傷害判定
      if u:pnt() - u:dge() < 0 then -- 穿透後對閃避判定
        v.damage = v.damage * u:rst(v.element_type) * u:blk() * u1:race_rst(u['種族']) -- 沒觸發穿透，因此計算減傷過後的傷害量
      end
    else -- 沒穿透後對閃避判定
      if u:dge_rate() then
        v.damage = 0 -- 觸發閃避後，傷害=0
      else
        v.damage = v.damage * u:rst(v.element_type) * u:blk() * u1:race_rst(u['種族'])
      end
    end
    texttag:combat_word(v.target, v.damage, 1, '法術')
  end
  -- print(v.damage)
  DealDamage(v)
end

return damage
