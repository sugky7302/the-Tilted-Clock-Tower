return {
    name = '測試1',
    time = 3,
    mode = 0,
    model = '',
    model_point = '',
    global = false,
    max = 1,
    keep_after_death = false,
    on_add = function(self)
        self.getTemplates("測試").on_add()
    end,
    on_remove = function(self)
        self.getTemplates("測試").on_remove()
    end,
    on_finish = function(self)
        self.getTemplates("測試").on_finish()
    end,
    on_cover = function(self)
        self.getTemplates("測試").on_cover()
    end,
    on_pulse = function(self)
        self.getTemplates("測試").on_pulse()
    end
}
