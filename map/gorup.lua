        local cj = require 'jass.common'
        local Stack = require 'stack'
        local js = require 'jass_tool'
        local Array = require 'array'
        local setmetatable = setmetatable
        local math = math
        local Group = {}
        local mt = {}
        setmetatable(Group, Group)
        Group.__index = mt
        -- 本地變量
        Group.QUANTITY = 128
        Group.recycleGroup = Stack("array")
        function Group:__call(filter)
            local obj
            if self.recycleGroup:IsEmpty() then
                obj = Array("group")
                obj.object = cj.CreateGroup()
            else
                obj = self.recycleGroup:Top()
                self.recycleGroup:Pop()
            end
            obj.filter = filter or 0 -- 用於條件判定，如果filter沒有傳參，要設定成0才不會出問題
            return obj
        end
        function mt:Remove()
            mt.Clear(self)
            if Group.recycleGroup:GetSize() >= Group.QUANTITY then
                cj.DestroyGroup(self.object)
                self:Remove()
            else
                Group.recycleGroup:Push(self)
            end 
        end
        function mt:Clear()
            mt.Loop(self, function(self, i)
                mt.RemoveUnit(self, i)
                self[i] = nil
            end)
            cj.GroupClear(self.object)
            self:Clear()
        end
        function mt:Loop(action)
            for i = self.begin, self.terminus do
                action(self, i)
            end
        end
        function mt:RemoveUnit(i)
            cj.GroupRemoveUnit(self.object, self[i])
            self:Erase(self[i])
        end
        function mt:EnumUnitsInRange(x,y,r,cnd)
            local temp = cj.CreateGroup()
            cj.GroupEnumUnitsInRange(temp, x, y, r+10, nil) -- 選取比原先範圍大一些的區域，好讓有些處在範圍邊緣的單位能夠被正確選取
            local u = cj.FirstOfGroup(temp)
            while js.H2I(u) ~= 0 do
                if cnd(u,self.filter) then
                mt.AddUnit(self, u)
                end
                cj.GroupRemoveUnit(temp,u)
                u = cj.FirstOfGroup(temp)
            end
            cj.DestroyGroup(temp)
        end
        function mt:AddUnit(u)
            cj.GroupAddUnit(self.object,u)
            self.terminus = self.terminus + 1
            self[self.terminus] = u
        end
        function mt:UnitInArea(u)
            return self:Exist(u)
        end
        function Group.IsEnemy(u,filter)
            return cj.GetUnitState(u, cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitEnemy(u, cj.GetOwningPlayer(filter))
        end
        function Group.IsAlly(u,filter)
            return cj.GetUnitState(u, cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitAlly(u, cj.GetOwningPlayer(filter))
        end
        function Group.Nil(u,filter)
            return true
        end
        return Group
    