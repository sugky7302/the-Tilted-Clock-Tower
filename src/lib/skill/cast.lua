local Cast = {}

function mt:_cast_start()
    if self.castStartTime > 0 then
        self.castbar = Castbar(self.owner.object, self.castStartTime, true)
        -- 是否定身施法
        if self.breakMove == 1 then
            self:RootCast(self.castStartTime)
        end
        -- 調用動作
        self:EventDispatch "施法開始"
        -- 看能不能被打斷
        self.castStartTimer = Timer(self.castStartTime, false, function(callback)
            self:_cast_channel()
        end)
        
    else
        self:EventDispatch "施法開始"
        self:_cast_channel()
    end
end

function mt:_cast_channel()
    if self.castChannelTime > 0 then
        self.castbar = Castbar(self.owner.object, self.castChannelTime, true)
        -- 是否定身施法
        if self.breakMove == 1 then
            self:RootCast(self.castChannelTime)
        end
        self.castChannelTimer = Timer(self.castPulse, self.castChannelTime / self.castPulse, function(callback)
            self:EventDispatch "施法引導"
            if callback.isPeriod == 0 then
                self:_cast_shot()
            end
        end)
    else
        self:EventDispatch "施法引導"
        self:_cast_shot()
    end
end

function mt:_cast_shot()
    if self.castShotTime > 0 then
        self.castbar = Castbar(self.owner.object, self.castShotTime)
        -- 是否定身施法
        if self.breakMove == 1 then
            self:RootCast(self.castShotTime)
        end
        -- 看能不能被打斷
        self.castShotTimer = Timer(self.castPulse, self.castShotTime / self.castPulse, function(callback)
            self:EventDispatch "施法出手"
            if callback.isPeriod < 1 then
                self:_cast_finish()
            end
        end)
    else
        self:EventDispatch "施法出手"
        self:_cast_finish()
    end
end

function mt:_cast_finish()
    self:EventDispatch "施法完成"
    _SetProficiency(self)
    self:Remove()
    self:MultiCast()
end

return Cast