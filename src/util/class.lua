-- 自定義類型 類別，使用javascript的方式--對象關聯或稱委託。
-- 新的類別能夠很好區分類別和實例的差別，不會像以往子類實際上也只是父類的一個實例。

-- 功能有__call、__index、Remove。鑒於Lua的特性，若有需要可直接重寫方法。
-- 保留setInstance、getInstance關鍵字，用來處理實例與類別的綁定。
-- 私有函數_new、_delete提供使用者自定義在建構和解構時想要執行的功能。
-- table、string、number、boolean:當前類別搜索不到會去搜尋原型鏈，找到的話就返回值，沒有就返回nil。不會複製一份給自己。
-- function:同樣會搜尋原型鏈，但是是將實例委託該函數處理。不會複製函數引用給自己。
-- 盡量在class設定預設值，不要用_new為每個實例創建值，等要用的時候再建就好，除非是一定會用到的、每個實例都不同的值。
local function Class(name, ...)
    local setmetatable, pairs, table_concat = setmetatable, pairs, table.concat

	local object = {
		_prototype = {...}, -- 原型，也就是委託的對象，只要該對象有你需要的東西，都可以填進去。排在最前面的原型為第一委託者。
        _VERSION = "1.0.0",
        
		type = name,

        -- TODO: 考慮怎麼解決不要容量重設且_new函數不要有創建實例的動作的問題
        -- HACK: 目前想不到這兩種矛盾的解決方法，先暫時不管容量重設，反正目前鍵值對少，還沒有太大的問題。 - 2019-01-25
        -- HACK: 因為Mover、Missile等類別會直接創建table傳參，因此解決了容量重設的問題以及不要創建實例的問題，
        --       只不過若沒有傳參table，系統會自動生成new table，這樣還是會有容量重設的問題。
        --       但目前看來，屬性少在容量重設上不會花太多時間。 - 2019-01-26
        -- NOTE: 根據參數data的類型，支援3種建構方式:
        --       - 無參數 : class()
        --       - 有參數但非創建實例 : class(var1, var2, ...)
        --       - 直接創建實例 : class{...}
        -- BUG: 現在有問題的是，第三種有可能會暴露內部成員變量，第二種有可能傳進去的是一個table，但是它不能被註冊成實例。
        -- 第三種在_new中會利用_copy把table裡的值賦給instance，這樣就能解決暴露的問題。
        -- 第二種的話按照原本的方式是不會有問題的。
        __call = function(self, ...)
            local instance = setmetatable({}, self)
            instance:_new(...)

			return instance
		end,

		-- 在self[key]找不到值時調用，如果沒有設定的話，self[key]是直接回傳nil。
		-- 搜索原型鏈，將對象委託給原型處理(function)或是返回原型的值(table、string、number、boolean)
		-- 根據原型鏈的排列順序決定優先度
        -- 不使用rawget的原因是需要搜索整個原型鏈，而不是只有當前原型鏈
        -- table會傳入呼叫此函式的對象，而不是getmetatable(對象)
        __index = function(table, key)
            -- 如果是實例，會獲取類別；如果是類別，會獲取自己
            local class = getmetatable(table)

            -- 只搜尋指定table有沒有key，不會一直搜索導致stack flow
            local value = rawget(class, key)
            
            if value then
                -- 如果類別有number、string、boolean、或table，賦值給實例
                -- NOTE: 考慮要不要用這個功能，或是單純的委託 - 2019-01-26
                -- if type(value) ~= "function" then
                --     rawset(table, key, value)
                -- end

                return value
            end

            for i = 1, #class._prototype do
                -- 這也會執行__index，只是table不同，直到原型鏈的頂端
				value = class._prototype[i][key]

				if value ~= nil then
					return value
				end
			end

			return nil
		end,

		-- __newindex是在對不存在的索引賦值時調用，我們不會拿來賦值，因為self[key] = value就會直接賦值了，
		-- __newindex存在則編譯器會調用它，而不會調用賦值。如果__newindex是一個table，則會賦值在table裡。
		-- 如果內部用self[key] = value，它又會因為對不存在的索引賦值而調用__newindex，導致無限循環因而報錯。
		-- __newindex = function(table, key, value)
		-- end,

		Remove = function(self)
			-- 使用者自訂的解構函數
			self:_delete()

			for key in pairs(self) do
				self[key] = nil
			end

			self = nil
		end,

		-- 使用者自訂的建構函數
		_new = function(self, this)
		end,

		-- 使用者自訂的解構函數
		_delete = function(self)
        end,
        
        -- 因應第三種建構方式，instance會把data複製一份給自己
        _copy = function(self, data)
            if data and type(data) == 'table' then
                for key, value in pairs(data) do 
                    self[key] = value
                end
            end
        end,

        -- key可以是number或string
        setInstance = function(self, key, instance)
            self[table_concat({"instance_", key})] = instance
        end,

        getInstance = function(self, key)
            local instance = self[table_concat({"instance_", key})]
            return instance
        end,
	}

	setmetatable(object, object)

	return object
end

return Class